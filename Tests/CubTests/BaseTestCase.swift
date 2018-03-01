//
//  BaseTestCase.swift
//  Cub
//
//  Created by Louis D'hauwe on 22/10/2016.
//  Copyright © 2016 - 2018 Silver Fox. All rights reserved.
//

import Foundation
import XCTest
@testable import Cub

class BaseTestCase: XCTestCase {
	
	enum RunnerTestError: Error {
		case sourceNotFound
		case executionFailed
		case resultNotFound
	}
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func getFilePath(for fileName: String, extension: String) -> URL? {
		
		#if SWIFT_PACKAGE
		
			// Swift packages don't currently have a resources folder
			
			var url = URL(fileURLWithPath: #file)
			url.deleteLastPathComponent()
			url.appendPathComponent("Test source files")
			
			let resourcesPath = url.path
		
			let fullPath = "\(resourcesPath)/\(fileName).\(`extension`)"
		
			return URL(fileURLWithPath: fullPath)

		#else

			let bundle = Bundle(for: type(of: self))
			let fileURL = bundle.url(forResource: fileName, withExtension: `extension`)

			return fileURL

		#endif
	}
	
	func getSource(for fileName: String) -> String? {
		
		let fileURL = getFilePath(for: fileName, extension: "cub")
		
		return getSource(for: fileURL)
	}
	
	func getScorpionSource(for fileName: String) -> String? {
		
		let fileURL = getFilePath(for: fileName, extension: "scorp")
		
		return getSource(for: fileURL)
	}
	
	func getASTDescription(for fileName: String) -> String? {
		
		let fileURL = getFilePath(for: "\(fileName)-ast", extension: "txt")
		
		return getSource(for: fileURL)
	}
	
	@nonobjc func getSource(for fileURL: URL?) -> String? {
		
		guard let path = fileURL?.path else {
			return nil
		}
		
		guard let source = try? String(contentsOfFile: path, encoding: .utf8) else {
			return nil
		}
		
		return source
		
	}
	
	// MARK: - Boilerplate
	
	// TODO: Maybe set expectedValue in source file?
	func assert(in file: String, that `var`: String, equals expectedValue: ValueType, useStdLib: Bool = true) {
		
		guard let result = try? execute(file, get: `var`, useStdLib: useStdLib) else {
			
			let message = "[\(file).cub]: Expected \(expectedValue) as the value of \(`var`), but found: nil"
			
			XCTAssert(false, message)
			
			return
		}
		
		let message = "[\(file).cub]: Expected \(expectedValue) as the value of \(`var`), but found: \(result)"
		XCTAssert(result == expectedValue, message)
		
	}
	
	func assertInterpretError(in file: String, expectedError: InterpreterError, useStdLib: Bool = true) {

		guard let error = interpretAndExpectError(file, useStdLib: useStdLib) else {
			XCTAssert(false, "[\(file).cub]: Expected \(expectedError) as error, but found: nil")
			return
		}
		
		let message = "[\(file).cub]: Expected \(expectedError) as error, but found: \(error)"
		XCTAssert(error == expectedError, message)
	}
	
	func interpretAndExpectError(_ file: String, useStdLib: Bool = true) -> InterpreterError? {
		
		let runner = Runner(logDebug: false)
		
		let fileURL = getFilePath(for: file, extension: "cub")
		
		guard let path = fileURL?.path else {
			return nil
		}
		
		do {
			
			try runner.runSource(at: path)
			return nil
			
		} catch let error as InterpreterError {
			return error
			
		} catch {
			return nil
		}
		
	}
	
	func execute(_ file: String, get varName: String, useStdLib: Bool = true) throws -> ValueType {
		
		let runner = Runner(logDebug: false)
		
		let fileURL = getFilePath(for: file, extension: "cub")
		
		guard let path = fileURL?.path else {
			throw RunnerTestError.sourceNotFound
		}
		
		do {
			
			let result = try runner.runSource(at: path, get: varName, useStdLib: useStdLib)
			
			return result
			
		} catch {
			throw RunnerTestError.executionFailed
		}
		
	}
	
	func execute(_ file: String) throws -> BytecodeInterpreter {
		
		let runner = Runner(logDebug: false)
		
		let fileURL = getFilePath(for: file, extension: "cub")
		
		guard let path = fileURL?.path else {
			throw RunnerTestError.sourceNotFound
		}
		
		do {
			
			try runner.runSource(at: path)
			
			guard let interpreter = runner.interpreter else {
				throw RunnerTestError.executionFailed
			}
			
			return interpreter
			
		} catch {
			throw RunnerTestError.executionFailed
		}
		
	}
	
}

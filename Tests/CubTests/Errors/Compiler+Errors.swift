//
//  Compiler+Errors.swift
//  Cub
//
//  Created by Louis D'hauwe on 16/07/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import Foundation
import XCTest
@testable import Cub

class CompilerErrors: BaseTestCase {

	func testAssignFunctionToVar() {
		let error = "Cannot assign FunctionNode(prototype: FunctionPrototypeNode(name: bar, argumentNames: [], returns: false), \n    ) on line 4"
		assertCompileError(in: "AssignFunctionToVar", expectedError: error)
	}
	
	func testFunctionNotFound() {
		
		assertCompileError(in: "FunctionNotFound", expectedError: "Function \"test\" not found on line 3.")

	}

	func assertCompileError(in file: String, expectedError: String, useStdLib: Bool = false) {

		guard let error = compileAndExpectError(file, useStdLib: useStdLib) else {

			let message = "[\(file).cub]: Expected error \"\(expectedError)\" but found: nil"

			XCTFail(message)

			return
		}

		guard error == expectedError else {
			let message = "[\(file).cub]: Expected error \"\(expectedError)\""
			XCTFail(message)
			return
		}

	}

	func compileAndExpectError(_ file: String, useStdLib: Bool = true) -> String? {

		let runner = Runner(logDebug: false)

		let fileURL = getFilePath(for: file, extension: "cub")

		guard let path = fileURL?.path else {
			return nil
		}

		guard let source = try? String(contentsOfFile: path, encoding: .utf8) else {
			return nil
		}

		do {
			let _ = try runner.compileToBytecode(source)
			return nil
		} catch let error as DisplayableError {
			return error.description(inSource: source)
		} catch {
			return nil
		}

	}

}

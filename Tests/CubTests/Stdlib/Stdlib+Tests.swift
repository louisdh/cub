//
//  Stdlib+Tests.swift
//  Cub
//
//  Created by Louis D'hauwe on 06/01/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import XCTest
@testable import Cub

class Stdlib_Tests: BaseTestCase {
	
	enum StdlibTestError: Error {
		case sourceEmpty
		case sourceNotFound
	}
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testFloor() {
		assert(in: "Floor", that: "a", equals: .number(2))
		assert(in: "Floor", that: "b", equals: .number(-2))
		assert(in: "Floor", that: "c", equals: .number(0))
		assert(in: "Floor", that: "d", equals: .number(-3))
	}
	
	func testMinMax() {
		
		let file = "MinMax"
		
		assert(in: file, that: "a", equals: .number(10))
		assert(in: file, that: "b", equals: .number(10))
		assert(in: file, that: "c", equals: .number(10))
		assert(in: file, that: "d", equals: .number(-10))
		assert(in: file, that: "e", equals: .number(-10))

		assert(in: file, that: "f", equals: .number(12))
		assert(in: file, that: "g", equals: .number(12))
		assert(in: file, that: "h", equals: .number(10))
		assert(in: file, that: "i", equals: .number(10))
		assert(in: file, that: "j", equals: .number(10))
	}
	
	func testNumberSign() {
		
		let file = "NumberSign"
		
		assert(in: file, that: "a", equals: .bool(true))
		assert(in: file, that: "b", equals: .bool(false))
		assert(in: file, that: "c", equals: .bool(false))

		assert(in: file, that: "d", equals: .bool(false))
		assert(in: file, that: "e", equals: .bool(true))
		assert(in: file, that: "f", equals: .bool(false))
	
	}
	
	func testModulus() {
		
		let file = "Modulus"
		
		assert(in: file, that: "a", equals: .number(0))
		assert(in: file, that: "b", equals: .number(1))
		assert(in: file, that: "c", equals: .number(3))
		assert(in: file, that: "d", equals: .number(-5))
		assert(in: file, that: "e", equals: .number(5))
		
	}
	
	func getStdlibSource() throws -> String {
		
		let stdLib = StdLib()
		
		do {
			let source = try stdLib.stdLibCode()
			
			if source.isEmpty {
				throw StdlibTestError.sourceEmpty
			}
			
			return source
			
		} catch {
			throw StdlibTestError.sourceNotFound
		}
	
		
	}

	func testStdlibValidation() {
		
		do {
			_ = try getStdlibSource()
		} catch {
			XCTAssert(false, "Stdlib source error")
		}
		
	}
	
	func testStdlibCompilation() {

		guard let source = try? getStdlibSource() else {
			XCTAssert(false, "Stdlib source error")
			return
		}
		
		let runner = Runner()
		
		do {
			try runner.runWithoutStdlib(source)
		} catch {
			XCTAssert(false, "Stdlib run error")
		}
		
	}
	
}

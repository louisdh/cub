//
//  Runner+Log.swift
//  Cub macOS Tests
//
//  Created by Louis D'hauwe on 01/03/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import XCTest
@testable import Cub

class Runner_Log: BaseTestCase {
	
	var logOutput = ""
	
	func testLogInterpreter() {
		
		let runner = Runner(logDebug: false, logTime: false)
		runner.delegate = self
		
		let source = """
					a = 1
					b = 2
					c = a + b
					"""
		
		let expectedMessage = "Stack at end of execution:\n[]\nRegisters at end of execution:b (2) = 2.0c (3) = 3.0a (1) = 1.0"
		
		try! runner.runWithoutStdlib(source)
		
		runner.logInterpreter(runner.interpreter!)
		
		XCTAssertEqual(expectedMessage, logOutput)

	}
	
}

extension Runner_Log: RunnerDelegate {
	
	@nonobjc
	func log(_ message: String) {
		
		logOutput += message
		
	}
	
	@nonobjc
	func log(_ error: Error) {
		
	}
	
	@nonobjc
	func log(_ token: Token) {
		
	}

}

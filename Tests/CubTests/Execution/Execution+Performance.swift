//
//  Execution+Performance.swift
//  Cub
//
//  Created by Louis D'hauwe on 23/10/2016.
//  Copyright © 2016 - 2018 Silver Fox. All rights reserved.
//

import XCTest
@testable import Cub

/// Performance tests for execution.
/// (running of bytecode)
///
/// This will test the execution performance of compiled bytecode.
///
/// Compiler optimizations should be tested here.
class Execution_Performance: BaseTestCase {
	
	// MARK: - Tests

	func testModulusPerformance() {
		doExecutionTest(for: "ModulusPerf")
	}
	
	func testLargeMathPerformance() {
		doExecutionTest(for: "LargeMathOperation", repeatSource: 100)
	}
	
	func testComplexPerformance() {
		doExecutionTest(for: "Complex", repeatSource: 100)
	}
	
	// MARK: - Boilerplate
	
	func doExecutionTest(for fileName: String, repeatSource: Int = 1) {
		
		guard let bytecode = preparePerformanceTest(for: fileName) else {
			XCTFail("Failed to get source for \(fileName)")
			return
		}
		
		self.measure {
			for _ in 1...repeatSource {
				self.execute(bytecode)
			}
		}
		
	}
	
	func preparePerformanceTest(for file: String) -> [BytecodeExecutionInstruction]? {
		
		let runner = Runner()
		
		guard let stdLib = try? StdLib().stdLibCode() else {
			XCTFail("Failed to get stdlib")
			return nil
		}
		
		guard let compiledStdLib = try? runner.compileCubSourceCode(stdLib) else {
			XCTFail("Failed to compile stdlib")
			return nil
		}
		
		guard let source = getSource(for: file) else {
			XCTFail("Failed to get source")
			return nil
		}
		
		guard let compiledSource = try? runner.compileCubSourceCode(source) else {
			XCTFail("Failed to compile source code")
			return nil
		}
		
		let bytecode = compiledStdLib + compiledSource
		
		let executionBytecode = bytecode.map { $0.executionInstruction }

		return executionBytecode

	}
	
	func execute(_ bytecode: [BytecodeExecutionInstruction]) {
		
		let interpreter = try! BytecodeInterpreter(bytecode: bytecode)
		try! interpreter.interpret()
		
	}
	
}

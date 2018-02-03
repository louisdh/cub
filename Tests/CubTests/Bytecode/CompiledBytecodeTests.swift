//
//  CompiledBytecodeTests.swift
//  Cub
//
//  Created by Louis D'hauwe on 16/06/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import XCTest
@testable import Cub

class CompiledBytecodeTests: BaseTestCase {

	func testFibonacci() {
		
		let sourceFile = "Fibonacci"
		
		guard let source = getSource(for: sourceFile) else {
			assertionFailure("Expected source")
			return
		}
		
		guard let scorpionSource = getScorpionSource(for: sourceFile) else {
			assertionFailure("Expected Scorpion source to compare")
			return
		}
		
		let runner = Runner()
		guard let compiledBytecode = try? runner.compileToBytecode(source) else {
			assertionFailure("Compilation failed")
			return
		}
		
		let bytecodeDescriptor = BytecodeDescriptor(bytecode: compiledBytecode)
		
		let compiledDescription = bytecodeDescriptor.humanReadableDescription()
				
		XCTAssert(scorpionSource == compiledDescription)
	}

}

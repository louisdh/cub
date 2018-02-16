//
//  Lexer+Performance.swift
//  Cub
//
//  Created by Louis D'hauwe on 20/10/2016.
//  Copyright © 2016 - 2018 Silver Fox. All rights reserved.
//

import XCTest
@testable import Cub

class Lexer_Performance: BaseTestCase {

	// MARK: - Tests

    func testLargeMathPerformance() {
		runLexerTest(for: "LargeMathOperation")
    }

	func testComplexPerformance() {
		runLexerTest(for: "Complex")
	}
	
	func testLargeSource() {
		runLexerTest(for: "LargeSource")
	}
	
	// MARK: - Boilerplate

	func runLexerTest(for fileName: String) {
	
		guard let source = getSource(for: fileName) else {
			XCTFail("Failed to get source for \(fileName)")
			return
		}
		
		let preheatLexer = Lexer(input: source)
		_ = preheatLexer.tokenize()
		
		self.measure {
			
			let lexer = Lexer(input: source)
			
			_ = lexer.tokenize()
			
		}
		
	}
	
}

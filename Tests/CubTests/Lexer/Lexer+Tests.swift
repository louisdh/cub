//
//  Lexer+Tests.swift
//  Lexer Tests
//
//  Created by Louis D'hauwe on 14/10/2016.
//  Copyright © 2016 - 2018 Silver Fox. All rights reserved.
//

import XCTest
@testable import Cub

class Lexer_Tests: BaseTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testLexerAssignment() {
		
		// Test "a = 0.3" lexing in various number notations
		testLexerAssignment(withSource: "a = 0.3")
		testLexerAssignment(withSource: "a = .3")
		testLexerAssignment(withSource: "a = 3.0e-1")
		
	}
	
	func testNewLineLexing() {
		
		let source = """
					//t

					print(1)
					"""
		
		let lexer = Lexer(input: source)
		let tokens = lexer.tokenize()

		var expectedTokens = [Token]()
		
		expectedTokens.append(.init(type: .comment("//t"), range: 0..<3))
		expectedTokens.append(.init(type: .identifier("print"), range: 5..<10))
		expectedTokens.append(.init(type: .parensOpen, range: 10..<11))
		expectedTokens.append(.init(type: .number(1), range: 11..<12))
		expectedTokens.append(.init(type: .parensClose, range: 12..<13))

		XCTAssertEqual(expectedTokens, tokens)
		
	}
	
	func testSpaceInCommentLexing() {
		
		let source = """
					// test 123 hello

					print(1)
					"""
		
		let lexer = Lexer(input: source)
		let tokens = lexer.tokenize()
		
		var expectedTokens = [Token]()
		
		expectedTokens.append(.init(type: .comment("// test 123 hello"), range: 0..<17))
		expectedTokens.append(.init(type: .identifier("print"), range: 19..<24))
		expectedTokens.append(.init(type: .parensOpen, range: 24..<25))
		expectedTokens.append(.init(type: .number(1), range: 25..<26))
		expectedTokens.append(.init(type: .parensClose, range: 26..<27))
		
		XCTAssertEqual(expectedTokens, tokens)
		
	}
	
	func testNewLinesAfterStatementLexing() {
		
		let source = """
					a = myVar

					
					

					"""
		
		let lexer = Lexer(input: source)
		let tokens = lexer.tokenize()
		
		var expectedTokens = [Token]()
		
		expectedTokens.append(.init(type: .identifier("a"), range: 0..<1))
		expectedTokens.append(.init(type: .equals, range: 2..<3))
		expectedTokens.append(.init(type: .identifier("myVar"), range: 4..<9))

		XCTAssertEqual(expectedTokens, tokens)
		
	}
	
	func testLineComments() {
		
		let source = """
						// test
					    // hello
					    // world
					"""
		
		let lexer = Lexer(input: source)
		let tokens = lexer.tokenize()
		
		var expectedTokens = [Token]()
		
		expectedTokens.append(.init(type: .comment("// test"), range: 1..<8))
		expectedTokens.append(.init(type: .comment("// hello"), range: 13..<21))
		expectedTokens.append(.init(type: .comment("// world"), range: 26..<34))
		
		XCTAssertEqual(expectedTokens, tokens)
		
	}
	
	/// Test Lexer with input: "a = 0.3"
	func testLexerAssignment(withSource source: String) {
		
		let lexer = Lexer(input: source)
		let tokens = lexer.tokenize()

		Swift.assert(tokens.count == 3)
		
		let token1 = tokens[0]
		let token2 = tokens[1]
		let token3 = tokens[2]
		
		if case let TokenType.identifier(t1) = token1.type {
			XCTAssert(t1 == "a", "Expected identifier 'a'")
		} else {
			XCTAssert(false, "Expected identifier 'a'")
		}
		
		if case TokenType.equals = token2.type {

		} else {
			XCTAssert(false, "Expected equals")
		}
		
		if case let TokenType.number(t3) = token3.type {
			XCTAssert(t3 == 0.3, "Expected number '0.3'")
		} else {
			XCTAssert(false, "Expected number '0.3'")
		}
		
    }
    
}

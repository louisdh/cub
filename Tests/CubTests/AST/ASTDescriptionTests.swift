//
//  ASTDescriptionTests.swift
//  Cub
//
//  Created by Louis D'hauwe on 18/06/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import XCTest
@testable import Cub

class ASTDescriptionTests: BaseTestCase {
	
	func testFibonacci() {
		
		let sourceFile = "Fibonacci"
		
		guard let source = getSource(for: sourceFile) else {
			assertionFailure("Expected source")
			return
		}
		
		guard let astDescription = getASTDescription(for: sourceFile) else {
			assertionFailure("Expected AST description for comparison")
			return
		}

		let runner = Runner()
		guard let parsedAST = try? runner.parseAST(source) else {
			assertionFailure("Compilation failed")
			return
		}
		
		let bodyNode = BodyNode(nodes: parsedAST)
		
		XCTAssert(bodyNode.description == astDescription)
	}
	
}

//
//  DocumentationTestCase.swift
//  Cub macOS Tests
//
//  Created by Louis D'hauwe on 20/04/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation
import XCTest
@testable import Cub

class DocumentationTestCase: BaseTestCase {
	
	func testSimpleFunctionDoc() {
		
		let source = """
					/// This is a test
					func test() {
					
					}
					"""
		
		let docGenerator = DocumentationGenerator()
		
		let items = try! docGenerator.items(for: source)
		
		let expectedItem = DocumentationItem(definition: "func test()",
											 rawDocumentation: "/// This is a test",
											 type: .function,
											 functionDocumentation: FunctionDocumentation(description: "This is a test",
																						  argumentDescriptions: [:],
																						  returnDescription: nil),
											 variableDocumentation: nil,
											 title: "test()")
		
		XCTAssertEqual(items, [expectedItem])
	}
	
	func testReturningFunctionDoc() {
		
		let source = """
					/// This is a test
					/// - Returns: this returns something
					func test() returns {
						return 1
					}
					"""
		
		let docGenerator = DocumentationGenerator()
		
		let items = try! docGenerator.items(for: source)
		
		let expectedItem = DocumentationItem(definition: "func test() returns",
											 rawDocumentation: "/// This is a test\n/// - Returns: this returns something",
											 type: .function,
											 functionDocumentation: FunctionDocumentation(description: "This is a test",
																						  argumentDescriptions: [:],
																						  returnDescription: "this returns something"),
											 variableDocumentation: nil,
											 title: "test() returns")
		
		XCTAssertEqual(items, [expectedItem])
	}
	
	func testFunctionArgumentsDoc() {
		
		let source = """
					/// This is a test
					/// - Parameter a: the first argument
					/// - Parameter b: the second argument
					func test(a, b) {
						return 1
					}
					"""
		
		let docGenerator = DocumentationGenerator()
		
		let items = try! docGenerator.items(for: source)
		
		let expectedItem = DocumentationItem(definition: "func test(a, b)",
											 rawDocumentation: "/// This is a test\n/// - Parameter a: the first argument\n/// - Parameter b: the second argument",
											 type: .function,
											 functionDocumentation: FunctionDocumentation(description: "This is a test",
																						  argumentDescriptions: ["a": "the first argument",
																												 "b": "the second argument"],
																						  returnDescription: nil),
											 variableDocumentation: nil,
											 title: "test(a, b)")
		
		XCTAssertEqual(items, [expectedItem])
	}
	
	func testVariableDoc() {
		
		let source = """
					/// A magic number.
					a = 1
					"""
		
		let docGenerator = DocumentationGenerator()
		
		let items = try! docGenerator.items(for: source)
		
		let expectedItem = DocumentationItem(definition: "a",
											 rawDocumentation: "/// A magic number.",
											 type: .variable,
											 functionDocumentation: nil,
											 variableDocumentation: VariableDocumentation(description: "A magic number."),
											 title: "a")
		
		XCTAssertEqual(items, [expectedItem])
	}
	
}

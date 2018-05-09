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
		
		let funcDoc = FunctionDocumentation(name: "test",
											arguments: [],
											returns: false,
											description: "This is a test",
											argumentDescriptions: [:],
											returnDescription: nil)
		
		let expectedItem = DocumentationItem(definition: "func test()",
											 rawDocumentation: "/// This is a test",
											 type: .function(funcDoc),
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
		
		let funcDoc = FunctionDocumentation(name: "test",
											arguments: [],
											returns: true,
											description: "This is a test",
											argumentDescriptions: [:],
											returnDescription: "this returns something")
		
		let expectedItem = DocumentationItem(definition: "func test() returns",
											 rawDocumentation: "/// This is a test\n/// - Returns: this returns something",
											 type: .function(funcDoc),
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
		
		let funcDoc = FunctionDocumentation(name: "test",
											arguments: ["a", "b"],
											returns: false,
											description: "This is a test",
											argumentDescriptions: ["a": "the first argument",
																   "b": "the second argument"],
											returnDescription: nil)
		
		let expectedItem = DocumentationItem(definition: "func test(a, b)",
											 rawDocumentation: "/// This is a test\n/// - Parameter a: the first argument\n/// - Parameter b: the second argument",
											 type: .function(funcDoc),
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
		
		let varDoc = VariableDocumentation(name: "a",
										   description: "A magic number.")
		
		let expectedItem = DocumentationItem(definition: "a",
											 rawDocumentation: "/// A magic number.",
											 type: .variable(varDoc),
											 title: "a")
		
		XCTAssertEqual(items, [expectedItem])
	}
	
	func testStructDoc() {
		
		let source = """
					/// A point in 2D space.
					/// - x: the x coordinate
					/// - y: the y coordinate
					struct Point {
						x, y
					}
					"""
		
		let docGenerator = DocumentationGenerator()
		
		let items = try! docGenerator.items(for: source)
		
		let structDoc = StructDocumentation(name: "Point",
											description: "A point in 2D space.",
											members: ["x", "y"],
											memberDescriptions: ["x": "the x coordinate", "y": "the y coordinate"])
		
		let expectedItem = DocumentationItem(definition: "struct Point(x, y)",
											 rawDocumentation: "/// A point in 2D space.\n/// - x: the x coordinate\n/// - y: the y coordinate",
											 type: .struct(structDoc),
											 title: "Point(x, y)")
		
		XCTAssertEqual(items, [expectedItem])
	}
	
}

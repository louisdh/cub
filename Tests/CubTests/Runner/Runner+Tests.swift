//
//  Runner+Tests.swift
//  Cub
//
//  Created by Louis D'hauwe on 22/10/2016.
//  Copyright © 2016 - 2018 Silver Fox. All rights reserved.
//

import XCTest
@testable import Cub

class Runner_Tests: BaseTestCase {
	
	// MARK: - Tests
	
	func testArrayAdd1() {
		assert(in: "ArrayAdd1", that: "a", equals: .array([.number(1), .number(2), .number(3), .number(4)]), useStdLib: false)
	}
	
	func testArrayAdd2() {
		assert(in: "ArrayAdd2", that: "a", equals: .array([.number(1), .number(2), .number(3), .number(4), .number(5)]), useStdLib: false)
	}
	
	func testArrayAdd3() {
		assert(in: "ArrayAdd3", that: "a", equals: .array([.number(1), .number(2), .number(3)]), useStdLib: false)
	}
	
	func testCommentLineAndBlock() {
		assert(in: "CommentLineAndBlock", that: "a", equals: .number(2), useStdLib: false)
	}
	
	func testCommentEmptyOneLineComment() {
		assert(in: "EmptyOneLineComment", that: "a", equals: .number(2), useStdLib: false)
	}
	
	func testCommentAfterAssignment() {
		assert(in: "CommentAfterAssignment", that: "a", equals: .number(2), useStdLib: false)
	}
	
	func testCommentBlockAfterAssignment() {
		assert(in: "CommentBlockAfterAssignment", that: "a", equals: .number(2), useStdLib: false)
	}
	
	func testAssignBoolToVar() {
		assert(in: "AssignBoolToVar", that: "a", equals: .bool(true), useStdLib: false)
	}
	
	func testUnusedFunctionResult() {
		
		let interpreter = try? execute("UnusedFunctionResult")
		
		XCTAssert(interpreter?.stack.isEmpty == true, "Expected stack to be empty")
	}
	
	func testStructUpdate() {
		let expectedStruct = ValueType.struct(StructData(members: [1: .number(3), 2: .number(2), 3: .number(3)]))
		assert(in: "StructUpdate", that: "bar", equals: expectedStruct, useStdLib: false)
	}
	
	func testStructDeepUpdate() {
		let bStruct = ValueType.struct(StructData(members: [1: .number(3), 2: .number(2), 3: .number(3)]))
		let expectedStruct = ValueType.struct(StructData(members: [1: .number(1), 2: bStruct, 3: .number(3)]))
		assert(in: "StructDeepUpdate", that: "bar", equals: expectedStruct, useStdLib: false)
	}
	
	func testStructDeepAssign() {
		let bStruct = ValueType.struct(StructData(members: [1: .number(2), 2: .number(2), 3: .number(3)]))
		let expectedStruct = ValueType.struct(StructData(members: [1: .number(1), 2: bStruct, 3: .number(3)]))
		assert(in: "StructDeepAssign", that: "bar", equals: expectedStruct, useStdLib: false)
	}
	
	func testStructDeepGet() {
		assert(in: "StructDeepGet", that: "b", equals: .number(3), useStdLib: false)
	}
	
	func testArrayInit() {
		let expectedArr = ValueType.array([.number(1), .number(2), .number(3)])
		assert(in: "ArrayInit", that: "a", equals: expectedArr, useStdLib: false)
	}
	
	func testArrayGet() {
		assert(in: "ArrayGet", that: "b", equals: .number(1), useStdLib: false)
	}
	
	func testArrayUpdate() {
		let expectedArr = ValueType.array([.number(5), .number(2), .number(3)])
		assert(in: "ArrayUpdate", that: "a", equals: expectedArr, useStdLib: false)
	}
	
	func testUnicodeSumFunction() {
		assert(in: "UnicodeSumFunction", that: "😀", equals: .number(5))
	}
	
	func testStringInit() {
		assert(in: "StringInit", that: "a", equals: .string("hello world"))
	}
	
	func testStringConcat() {
		assert(in: "StringConcat", that: "b", equals: .string("hello there"))
	}
	
	func testStringSubscriptGet() {
		assert(in: "StringSubscriptGet", that: "b", equals: .string("H"))
	}
	
	func testStringSubscriptSet() {
		assert(in: "StringSubscriptSet", that: "a", equals: .string("Jello"))
	}
	
	func testStringSubscriptSetError() {
		let expectedError = InterpreterError(type: .arrayOutOfBounds(index: 10, arraySize: 5), range: 19..<20)
		assertInterpretError(in: "StringSubscriptSetError", expectedError: expectedError, useStdLib: false)
	}
	
	func testStringSubscriptGetError() {
		let expectedError = InterpreterError(type: .arrayOutOfBounds(index: 10, arraySize: 5), range: 18..<19)
		assertInterpretError(in: "StringSubscriptGetError", expectedError: expectedError, useStdLib: false)
	}
	
	func testFormat() {
		assert(in: "Format", that: "a", equals: .string("10"))
	}
	
	func testBinaryOp() {
		assert(in: "BinaryOp", that: "a", equals: .number(512.75))
	}
	
	func testInnerWhileLoops() {
		assert(in: "InnerWhileLoops", that: "sum", equals: .number(7_255_941_120))
	}
	
	func testGCD() {
		assert(in: "GreatestCommonDivisor", that: "a", equals: .number(4))
	}
	
	func testForInArray() {
		assert(in: "ForInArray", that: "sum", equals: .number(10))
	}
	
	func testFibonacci() {
		assert(in: "Fibonacci", that: "a", equals: .number(55))
	}
	
	func testFunctionGlobalVar() {
		assert(in: "FunctionGlobalVar", that: "a", equals: .number(12))
	}
	
	func testDoTimesLoops() {
		assert(in: "DoTimesLoops", that: "a", equals: .number(10000))
	}
	
	func testFunctionReturnGlobalVar() {
		assert(in: "FunctionReturnGlobalVar", that: "a", equals: .number(12))
	}
	
	func testFunctionInFunction() {
		assert(in: "FunctionInFunction", that: "a", equals: .number(100))
	}
	
	func testVarAssignAfterScopeLeave() {
		assert(in: "VarAssignAfterScopeLeave", that: "a", equals: .number(1))
	}
	
	func testRepeatWhileStatement() {
		assert(in: "RepeatWhileStatement", that: "i", equals: .number(16))
	}

	func testArraySubscriptInBinaryOp() {
		assert(in: "ArraySubscriptInBinaryOp", that: "b", equals: .number(5))
	}

	func testStringEscapeBackslash() {
		assert(in: "StringEscapeBackslash", that: "str", equals: .string("\\hello world\\"))
	}
	
	func testStringEscapeDoubleQuote() {
		assert(in: "StringEscapeDoubleQuote", that: "str", equals: .string("\"hello world\""))
	}
	
	func testStringEscapeNewLine() {
		assert(in: "StringEscapeNewLine", that: "str", equals: .string("\n"))
	}
	
	func testStringEscapeR() {
		assert(in: "StringEscapeR", that: "str", equals: .string("\r"))
	}
	
	func testStringEscapeSingleQuote() {
		assert(in: "StringEscapeSingleQuote", that: "str", equals: .string("\'hello world\'"))
	}
	
	func testStringEscapeT() {
		assert(in: "StringEscapeT", that: "str", equals: .string("\t"))
	}
	
	func testStringEscapeZero() {
		assert(in: "StringEscapeZero", that: "str", equals: .string("\0"))
	}
	
	func testHTMLRegex() {
		assert(in: "HTMLRegex", that: "h1Tag", equals: .string("<h1>hello world</h1>"), useStdLib: true)
	}
	
	func testFunctionCallAsLoopCondition() {
		assert(in: "FunctionCallAsLoopCondition", that: "y", equals: .number(0), useStdLib: false)
	}
	
	func testIfEqualsNil() {
		assert(in: "IfEqualsNil", that: "a", equals: .number(1), useStdLib: false)
	}
	
}

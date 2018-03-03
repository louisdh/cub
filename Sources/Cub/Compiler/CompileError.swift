//
//  CompileError.swift
//  Cub
//
//  Created by Louis D'hauwe on 04/11/2016.
//  Copyright © 2016 - 2018 Silver Fox. All rights reserved.
//

import Foundation

public enum CompileErrorType {
	case unexpectedCommand
	case emptyStruct
	case unexpectedBinaryOperator
	case functionNotFound
	case unbalancedScope
}

struct CompileError: Error {
	
	let type: CompileErrorType
	
	/// The range in the original source code where the error occurred.
	let range: Range<Int>?
	
}

extension CompileError: DisplayableError {

	public func description(inSource source: String) -> String {
		
		switch self.type {
		case .unexpectedCommand:
			return "Found an unexpected command while compiling."
			
		case .emptyStruct:
			return "Structs may not be empty."
			
		case .unexpectedBinaryOperator:
			return "Found an unexpected binary operation."
			
		case .functionNotFound:
			return "Function not found."
			
		case .unbalancedScope:
			return "Unbalanced scope."
			
		}
		
	}

}

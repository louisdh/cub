//
//  CompileError.swift
//  Cub
//
//  Created by Louis D'hauwe on 04/11/2016.
//  Copyright © 2016 - 2018 Silver Fox. All rights reserved.
//

import Foundation

public enum CompileError: Error {
	case unexpectedCommand
	case emptyStruct
	case unexpectedBinaryOperator
	case functionNotFound
	case unbalancedScope
}

extension CompileError: DisplayableError {

	public func description(inSource source: String) -> String {
		
		switch self {
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

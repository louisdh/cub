//
//  InterpreterError.swift
//  Cub
//
//  Created by Louis D'hauwe on 15/12/2016.
//  Copyright © 2016 - 2018 Silver Fox. All rights reserved.
//

import Foundation

/// Interpreter Error
public enum InterpreterError: Error {

	/// Unexpected argument
	case unexpectedArgument

	/// Illegal stack operation
	case illegalStackOperation

	/// Invalid register
	case invalidRegister

	/// Stack overflow occured
	case stackOverflow

	/// Underflow occured
	case underflow
	
	/// Array out of bounds
	case arrayOutOfBounds

}

extension InterpreterError: DisplayableError {
	
	public func description(inSource source: String) -> String {
		
		switch self {
		case .unexpectedArgument:
			return "An unexpected argument was found during interpretation."
			
		case .illegalStackOperation:
			return "An illegal stack operation was performed during interpretation."

		case .invalidRegister:
			return "An invalid register was accessed during interpretation."
			
		case .stackOverflow:
			return "A stack overflow occurred during interpretation."

		case .underflow:
			return "An underflow occurred during interpretation."
			
		case .arrayOutOfBounds:
			return "An array was accessed outside its bounds during interpretation."
			
		}
		
	}
	
}

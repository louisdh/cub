//
//  BytecodeExecutionInstruction.swift
//  Cub
//
//  Created by Louis D'hauwe on 08/02/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import Foundation

public extension BytecodeInstruction {

	var executionInstruction: BytecodeExecutionInstruction {
		return BytecodeExecutionInstruction(label: label, type: type, arguments: arguments, range: range)
	}

}

/// ```BytecodeExecutionInstruction``` is a simplified version of ```BytecodeInstruction```,
/// in that it has no string members, and is a struct.
/// This eliminates reference counting which leads to improved performance.
public struct BytecodeExecutionInstruction: Codable, Hashable {

	/// The range of the instruction in the original source code
	let range: Range<Int>?
	
	let label: Int

	let type: BytecodeInstructionType

	let arguments: [InstructionArgumentType]

	init(label: Int, type: BytecodeInstructionType, arguments: [InstructionArgumentType] = [], range: Range<Int>?) {
		self.label = label
		self.type = type
		self.arguments = arguments
		self.range = range
	}

}

extension Range: Codable where Bound: Codable {
	
	enum CodingKeys: String, CodingKey {
		case lowerBound, upperBound
	}
	
	public init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		let lowerBound = try container.decode(Bound.self, forKey: .lowerBound)
		let upperBound = try container.decode(Bound.self, forKey: .upperBound)
		
		self = lowerBound..<upperBound

	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(upperBound, forKey: .upperBound)
		try container.encode(lowerBound, forKey: .lowerBound)
	}
	
}

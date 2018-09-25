//
//  InstructionArgumentType.swift
//  Cub
//
//  Created by Louis D'hauwe on 02/02/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import Foundation

enum InstructionArgumentTypeCodingError: Error {
	case invalidValue
}

public enum InstructionArgumentType: Hashable {

	case value(ValueType)
	case index(Int)

	var encoded: String {

		switch self {
		case let .value(v):
			return "v\(v)"
		case let .index(i):
			return "i\(i)"
		}

	}

}

extension InstructionArgumentType: Codable {
	
	enum CodingKeys: String, CodingKey {
		case value, index
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		if let value = try container.decodeIfPresent(ValueType.self, forKey: .value) {
			self = .value(value)
		} else if let index = try container.decodeIfPresent(Int.self, forKey: .index) {
			self = .index(index)
		} else {
			throw InstructionArgumentTypeCodingError.invalidValue
		}
		
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		switch self {
		case .value(let value):
			try container.encode(value, forKey: .value)
		case .index(let index):
			try container.encode(index, forKey: .index)
		}
	}
	
}

//
//  ValueType.swift
//  Cub
//
//  Created by Louis D'hauwe on 19/01/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import Foundation

public struct StructData: Hashable, Codable {
	
	var members: [Int: ValueType]
	
}

public enum ValueType: Hashable {

	case number(NumberType)
	case `struct`(StructData)
	case bool(Bool)
	case string(String)
	case array([ValueType])
	case `nil`

}

extension ValueType: Codable {
	
	enum CodingKeys: String, CodingKey {
		case number, `struct`, bool, string, array, `nil`
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		if let number = try container.decodeIfPresent(NumberType.self, forKey: .number) {
			self = .number(number)
		} else if let `struct` = try container.decodeIfPresent(StructData.self, forKey: .struct) {
			self = .struct(`struct`)
		} else if let bool = try container.decodeIfPresent(Bool.self, forKey: .bool) {
			self = .bool(bool)
		} else if let string = try container.decodeIfPresent(String.self, forKey: .string) {
			self = .string(string)
		} else if let array = try container.decodeIfPresent([ValueType].self, forKey: .array) {
			self = .array(array)
		} else if (try? container.decodeNil(forKey: .nil)) == true {
			self = .nil
		} else {
			throw InstructionArgumentTypeCodingError.invalidValue
		}
		
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		switch self {
		case .number(let number):
			try container.encode(number, forKey: .number)
		case .struct(let `struct`):
			try container.encode(`struct`, forKey: .struct)
		case .bool(let bool):
			try container.encode(bool, forKey: .bool)
		case .string(let string):
			try container.encode(string, forKey: .string)
		case .array(let array):
			try container.encode(array, forKey: .array)
		case .nil:
			try container.encodeNil(forKey: .nil)
		}
	}
	
}

public extension ValueType {

	func description(with ctx: BytecodeCompiler) -> String {

		switch self {
		case let .number(val):

			return "\(val)"

		case let .struct(val):

			var descr = "{ "

			for (k, v) in val.members {

				if let memberName = ctx.getStructMemberName(for: k) {
					descr += "\(memberName) = "
				} else {
					descr += "\(k) = "
				}

				descr += "\(v.description(with: ctx)); "

			}

			descr += " }"

			return descr

		case let .bool(val):
			if val == true {
				return "true"
			} else {
				return "false"
			}
		
		case let .string(val):
			return val
			
		case let .array(val):
			
			var descr = "["

			descr += val.map({ $0.description(with: ctx) }).joined(separator: ", ")
			
			descr += "]"
			
			return descr
			
		case .nil:
			return "nil"

		}

	}

}

extension ValueType {
	
	var isNumber: Bool {
		if case .number = self {
			return true
		} else {
			return false
		}
	}
	
	var isString: Bool {
		if case .string = self {
			return true
		} else {
			return false
		}
	}
	
	var isBool: Bool {
		if case .bool = self {
			return true
		} else {
			return false
		}
	}
	
	var isArray: Bool {
		if case .array = self {
			return true
		} else {
			return false
		}
	}
	
	var isStruct: Bool {
		if case .struct = self {
			return true
		} else {
			return false
		}
	}
	
	var isNil: Bool {
		if case .nil = self {
			return true
		} else {
			return false
		}
	}
	
}

extension ValueType {

	var size: NumberType {
		
		switch self {
		case .array(let array):
			return NumberType(array.count)
			
		case .bool:
			return 1
			
		case .number(let number):
			return number
			
		case .string(let string):
			return NumberType(string.count)
			
		case .struct(let stru):
			return NumberType(stru.members.count)
			
		case .nil:
			return 0
			
		}
	}
	
}

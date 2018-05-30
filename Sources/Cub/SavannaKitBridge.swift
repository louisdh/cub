//
//  SavannaKitBridge.swift
//  Cub
//
//  Created by Louis D'hauwe on 10/05/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation

#if canImport(SavannaKit)

public enum SyntaxColorType {
	case plain
	case number
	case string
	case identifier
	case keyword
	case comment
	case editorPlaceholder
}

import SavannaKit

extension Cub.TokenType {
	
	public var syntaxColorType: SyntaxColorType {
		
		switch self {
		case .booleanAnd, .booleanNot, .booleanOr:
			return .plain
			
		case .shortHandAdd, .shortHandDiv, .shortHandMul, .shortHandPow, .shortHandSub:
			return .plain
			
		case .equals, .notEqual, .dot, .ignoreableToken, .parensOpen, .parensClose, .curlyOpen, .curlyClose, .comma:
			return .plain
			
		case .comparatorEqual, .comparatorLessThan, .comparatorGreaterThan, .comparatorLessThanEqual, .comparatorGreaterThanEqual:
			return .plain
			
		case .string:
			return .string
			
		case .other:
			return .plain
			
		case .break, .continue, .function, .if, .else, .while, .for, .do, .times, .return, .returns, .repeat, .true, .false, .struct, .guard, .in, .nil:
			return .keyword
			
		case .comment:
			return .comment
			
		case .number:
			return .number
			
		case .identifier:
			return .identifier
			
		case .squareBracketOpen:
			return .plain
			
		case .squareBracketClose:
			return .plain
			
		case .editorPlaceholder(_):
			return .editorPlaceholder
			
		}
		
	}
	
}

public struct SavannaCubToken: SavannaKit.Token {
	
	public let type: SyntaxColorType
	
	public let cubToken: Cub.Token
	public let range: Range<String.Index>
	
	public var isEditorPlaceholder: Bool
	
	public var isPlain: Bool
	
	public init?(cubToken: Cub.Token, in source: String) {
		self.cubToken = cubToken
		
		self.type = cubToken.type.syntaxColorType
		
		if let range = cubToken.range {
			let lowerBound = source.index(source.startIndex, offsetBy: range.lowerBound)
			let upperBound = source.index(source.startIndex, offsetBy: range.upperBound)
			
			self.range = lowerBound..<upperBound
			
		} else {
			return nil
		}
		
		isPlain = self.type == .plain
		isEditorPlaceholder = self.type == .editorPlaceholder
		
	}

}

extension Cub.Lexer: SavannaKit.Lexer {
	
	public func lexerForInput(_ input: String) -> SavannaKit.Lexer {
		return Cub.Lexer(input: input)
	}
	
	public func getSavannaTokens() -> [SavannaKit.Token] {
		return self.tokenize().compactMap({ SavannaCubToken(cubToken: $0, in: input) })
	}
	
}

public struct DefaultTheme: SyntaxColorTheme {
	
	public init() {
		
	}
	
	private static var lineNumbersColor: Color {
		return Color(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
	}
	
	public let lineNumbersStyle: LineNumbersStyle? = LineNumbersStyle(font: Font(name: "Menlo", size: 16)!, textColor: lineNumbersColor)
	
	public let gutterStyle: GutterStyle = GutterStyle(backgroundColor: Color(red: 21/255.0, green: 22/255, blue: 31/255, alpha: 1.0), minimumWidth: 32)

	public let font = Font(name: "Menlo", size: 15)!
	
	public let backgroundColor = Color(red: 31/255.0, green: 32/255, blue: 41/255, alpha: 1.0)
	
	public func color(for syntaxColorType: SyntaxColorType) -> Color {
		
		switch syntaxColorType {
		case .plain:
			return .white
			
		case .number:
			return Color(red: 116/255, green: 109/255, blue: 176/255, alpha: 1.0)
			
		case .string:
			return .red
			
		case .identifier:
			return Color(red: 20/255, green: 156/255, blue: 146/255, alpha: 1.0)
			
		case .keyword:
			return Color(red: 215/255, green: 0, blue: 143/255, alpha: 1.0)
			
		case .comment:
			return Color(red: 69.0/255.0, green: 187.0/255.0, blue: 62.0/255.0, alpha: 1.0)
			
		case .editorPlaceholder:
			return backgroundColor
		}
		
	}
	
	public func globalAttributes() -> [NSAttributedStringKey: Any] {
		
		var attributes = [NSAttributedStringKey: Any]()
		
		attributes[.font] = font
		attributes[.foregroundColor] = Color.white

		return attributes
	}
	
	public func attributes(for token: SavannaKit.Token) -> [NSAttributedStringKey: Any] {
		var attributes = [NSAttributedStringKey: Any]()
		
		guard let savannaToken = token as? SavannaCubToken else {
			return attributes
		}
		
		attributes[.foregroundColor] = color(for: savannaToken.type)
		
		return attributes
	}
	
}

#endif

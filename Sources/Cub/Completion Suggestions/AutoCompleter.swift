//
//  AutoCompleter.swift
//  Cub
//
//  Created by Louis D'hauwe on 17/02/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation

public struct CompletionSuggestion {
	
	public let title: String
	public let content: String
	public let insertionIndex: Int
	
}

extension CompletionSuggestion: Equatable {
	
	public static func ==(lhs: CompletionSuggestion, rhs: CompletionSuggestion) -> Bool {
		return lhs.content == rhs.content && lhs.insertionIndex == rhs.insertionIndex && lhs.title == rhs.title
	}
	
}

public class AutoCompleter {
	
	public init() {
		
	}
	
	public func completionSuggestions(for source: String, cursor: Int) -> [CompletionSuggestion] {
		
		var suggestions = [CompletionSuggestion]()
		
		let lexer = Lexer(input: source)
		
		let tokens = lexer.tokenize()
		
//		var previousToken: Token?
		var currentToken: Token?
		
		for token in tokens {
			
			guard let range = token.range else {
				continue
			}
			
			if range.contains(cursor) {
				currentToken = token
			}
			
		}
		
		if let currentToken = currentToken {
			
			switch currentToken.type {
				
			case .identifier(let identifier):
				
				for keyword in Lexer.keywordTokens.keys {
					
					if keyword.hasPrefix(identifier) {
						
						let startIndex = keyword.index(keyword.startIndex, offsetBy: identifier.count)
						let content = String(keyword[startIndex...])
						
						let suggestion = CompletionSuggestion(title: keyword, content: content, insertionIndex: cursor)
						suggestions.append(suggestion)
						
					}
					
				}
				
			default:
				break
			}
			
		}
		
		var ifContent = ""
		ifContent += "if <#condition"
		ifContent += "#> {\n"
		ifContent += "\t<#body"
		ifContent += "#>\n"
		ifContent += "}"

		let ifStatement = CompletionSuggestion(title: "if ...", content: ifContent, insertionIndex: cursor)
		suggestions.append(ifStatement)

		return suggestions
	}

}

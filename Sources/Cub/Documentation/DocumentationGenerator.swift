//
//  DocumentationGenerator.swift
//  Cub
//
//  Created by Louis D'hauwe on 19/04/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation

public enum DocumentationItemType {
	case function
	case variable
}

public struct DocumentationItem {
	
	let definition: String
	let documentation: String?
	let type: DocumentationItemType
	
}

public class DocumentationGenerator {
	
	public init() {
		
	}
	
	public func items(runner: Runner) -> [DocumentationItem] {
		
		var items = [DocumentationItem]()
		
		let stdLib = StdLib()
		if let stbLibSource = try? stdLib.stdLibCode() {
			
			if let sourceItems = try? self.items(for: stbLibSource) {
				items.append(contentsOf: sourceItems)
			}
			
		}
		
		return items
	}
	
	func items(for source: String) throws -> [DocumentationItem] {
		
		var items = [DocumentationItem]()

		let tokens = Lexer(input: source).tokenize()

		let parser = Parser(tokens: tokens)
		let ast = try parser.parse()
		
		for node in ast {
			
			if let functionNode = node as? FunctionNode {
				
				let args = functionNode.prototype.argumentNames.joined(separator: ", ")
				var definition = "func \(functionNode.prototype.name)(\(args))"
				
				if functionNode.prototype.returns {
					definition += " returns"
				}
				
				let functionItem = DocumentationItem(definition: definition, documentation: functionNode.documentation, type: .function)
				
				items.append(functionItem)
			}
			
		}
		
		return items

	}
	
}

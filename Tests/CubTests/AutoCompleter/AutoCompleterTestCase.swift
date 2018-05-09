//
//  AutoCompleter.swift
//  Cub macOS Tests
//
//  Created by Louis D'hauwe on 02/03/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation
import XCTest
@testable import Cub

class AutoCompleterTestCase: BaseTestCase {
	
	func testIdentifier() {
		
		let source = """
					foo = 1
					bar = 2
					
					f
					"""
		
		let completer = AutoCompleter()
		let suggestions = completer.completionSuggestions(for: source, cursor: 18)
		
		var forContent = ""
		forContent += "or <#initialization"
		forContent += "#>, <#condition"
		forContent += "#>, <#increment"
		forContent += "#> {\n"
		forContent += "\t<#body"
		forContent += "#>\n}"
		
		let expectedSuggestions = [CompletionSuggestion(title: "for ...", content: forContent, insertionIndex: 18, cursorAfterInsertion: 4)]

		print(suggestions)
		
		XCTAssertEqual(expectedSuggestions, suggestions)
	}
	
}

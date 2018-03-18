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
		
		let expectedSuggestions = [CompletionSuggestion(title: "func", content: "unc", insertionIndex: 18, cursorAfterInsertion: 3),
								   CompletionSuggestion(title: "false", content: "alse", insertionIndex: 18, cursorAfterInsertion: 4),
								   CompletionSuggestion(title: "for", content: "or", insertionIndex: 18, cursorAfterInsertion: 2)]

		
		// CompletionSuggestion(title: "if ...", content: "if <#condition#> {\n\t<#body#>\n}", insertionIndex: 18, cursorAfterInsertion: 4),
		// CompletionSuggestion(title: "while ...", content: "while <#condition#> {\n\t<#body#>\n}", insertionIndex: 18, cursorAfterInsertion: 6)
		
		print(suggestions)
		
		XCTAssertEqual(expectedSuggestions, suggestions)
	}
	
}

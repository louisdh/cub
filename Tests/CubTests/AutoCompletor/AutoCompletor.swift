//
//  AutoCompletor.swift
//  Cub macOS Tests
//
//  Created by Louis D'hauwe on 02/03/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation
import XCTest
@testable import Cub

class AutoCompletorTestCase: BaseTestCase {
	
	func testIdentifier() {
		
		let source = """
					foo = 1
					bar = 2
					
					f
					"""
		
		let completor = AutoCompletor()
		let suggestions = completor.completionSuggestions(for: source, cursor: 17)
		
		let expectedSuggestions = [CompletionSuggestion(title: "func", content: "unc", insertionIndex: 17),
								   CompletionSuggestion(title: "false", content: "alse", insertionIndex: 17),
								   CompletionSuggestion(title: "for", content: "or", insertionIndex: 17)]
		
		print(suggestions)
		
		XCTAssertEqual(expectedSuggestions, suggestions)
	}
	
}

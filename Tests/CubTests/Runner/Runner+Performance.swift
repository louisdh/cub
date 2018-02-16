//
//  FullRun+Performance.swift
//  Cub
//
//  Created by Louis D'hauwe on 20/10/2016.
//  Copyright © 2016 - 2018 Silver Fox. All rights reserved.
//

import XCTest
@testable import Cub

/// Performance tests for full run (from lexer to interpreter)
class FullRun_Performance: BaseTestCase {

	// MARK: - Tests

    func testLargeMathPerformance() {
		doFullRunTest(for: "LargeMathOperation")
    }

	func testComplexPerformance() {
		doFullRunTest(for: "Complex")
	}
	
	// MARK: - Boilerplate

	func doFullRunTest(for fileName: String) {
		
		guard let source = getSource(for: fileName) else {
			XCTFail("Failed to get source for \(fileName)")
			return
		}
		
		self.measure {
			
			let runner = Runner(logDebug: false)
			
			do {
				try runner.run(source)
			} catch {
				XCTFail(error.localizedDescription)
			}
			
		}
		
	}
	
}

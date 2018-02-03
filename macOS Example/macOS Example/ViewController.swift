//
//  ViewController.swift
//  macOS Example
//
//  Created by Louis D'hauwe on 15/10/2016.
//  Copyright © 2016 - 2017 Silver Fox. All rights reserved.
//

import Cocoa
import Cub

class ViewController: NSViewController, RunnerDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()

		let runner = Runner(logDebug: true, logTime: false)
		runner.delegate = self
		
		runner.registerExternalFunction(name: "print", argumentNames: ["input"], returns: true) { (arguments) in
			
			for (name, arg) in arguments {
				print(arg)
			}
			
			return ValueType.number(5)
		}

		guard let path = stringPath(for: "A") else {
			return
		}

		print(path)

		do {

			try runner.runSource(at: path)

		} catch {
			print("error: \(error)")
			return
		}

//		drawASTGraph(for: "A")
	}

	func drawASTGraph(for testFile: String) {

		guard let path = stringPath(for: testFile) else {
			return
		}

		let source = try! String(contentsOfFile: path, encoding: .utf8)

		let lexer = Lexer(input: source)
		let tokens = lexer.tokenize()

		let parser = Parser(tokens: tokens)
		let ast = try! parser.parse()

		let visualizer = ASTVisualizer(body: BodyNode(nodes: ast))

		if let image = visualizer.draw() {
			print(image)
		}

	}

	/// Load .cub file in resources of "macOS Example" target
	fileprivate func stringPath(for fileName: String) -> String? {

		guard let resourcePath = Bundle.main.resourcePath else {
			return nil
		}

		let path = "\(resourcePath)/\(fileName).cub"

		return path
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

	// MARK: -
	// MARK: Cub Runner Delegate

	@nonobjc func log(_ message: String) {
		print(message)
	}

	@nonobjc func log(_ error: Error) {

		print(error)
	}

	@nonobjc func log(_ token: Token) {
		print(token)
	}

}

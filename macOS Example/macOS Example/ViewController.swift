//
//  ViewController.swift
//  macOS Example
//
//  Created by Louis D'hauwe on 15/10/2016.
//  Copyright © 2016 - 2018 Silver Fox. All rights reserved.
//

import Cocoa
import Cub

class ViewController: NSViewController, RunnerDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()

		guard let path = stringPath(for: "A") else {
			return
		}
		
		print(path)
		
		guard let source = try? String(contentsOfFile: path, encoding: .utf8) else {
			return
		}
		
		let lexer = Lexer(input: source)
		let tokens = lexer.tokenize()
		
//		print(tokens)
//		
//		return;
		
		let runner = Runner(logDebug: true, logTime: true)
		runner.delegate = self
		
		let docGen = DocumentationGenerator()
		let items = docGen.items(runner: runner)
		print(items)
		
		runner.registerExternalFunction(documentation: nil, name: "print", argumentNames: ["input"], returns: true) { (arguments, callback) in
			
			for (_, arg) in arguments {
				
				print(arg.description(with: runner.compiler))
				
			}
			
			_ = callback(.number(0))
		}
		
		do {

//			try runner.runWithoutStdlib(source)
			try runner.run(source)

		} catch {
			
			if let displayableError = error as? DisplayableError {
				
				print(displayableError.description(inSource: source))
				
			} else {
				
				print("Unknown error: \(error)")

			}
			
			return
		}

//		drawASTGraph(for: "A")
	}
	
	func encodeInterpreterToJSON(_ interpreter: BytecodeInterpreter) throws -> Data {
		
		let encoder = JSONEncoder()
		
		let data = try encoder.encode(interpreter)
		
		return data
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

		let visualizer = ASTVisualizer(body: BodyNode(nodes: ast, range: nil))

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

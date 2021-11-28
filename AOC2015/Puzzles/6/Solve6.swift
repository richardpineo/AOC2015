
import AOCLib
import Foundation
import SwiftUI

class Solve6: PuzzleSolver {
	func solveAExamples() -> Bool {
		examplesA.allSatisfy { solveA(input: [$0.input]) == $0.answer }
	}

	func solveBExamples() -> Bool {
		examplesB.allSatisfy { solveB(input: [$0.input]) == $0.answer }
	}

	var answerA = "569999"
	var answerB = ""

	func solveA() -> String {
		guard let file = FileHelper.load("Input6") else {
			return ""
		}
		return solveA(input: file).description
	}

	func solveB() -> String {
		guard let file = FileHelper.load("Input6") else {
			return ""
		}
		return "" // solveB(input: file.filter { !$0.isEmpty }).description
	}
	
	enum Verb {
		case turnOn
		case toggle
		case turnOff
	}
	
	struct Command {
		var verb: Verb
		var start: Position2D
		var end: Position2D
		
		func apply( lights: inout Set<Position2D>) {
			for x in start.x...end.x {
				for y in start.y...end.y {
					let cur = Position2D(x, y)
					switch verb {
					case .turnOn:
						lights.insert(cur)
					case .turnOff:
						lights.remove(cur)
					case .toggle:
						if lights.contains(cur) {
							lights.remove(cur)
						} else {
							lights.insert(cur)
						}
					}
				}
			}
		}
	}
	
	func parsePosition(_ s: String) -> Position2D {
		let tokens = s.components(separatedBy: ",")
		return .init(Int(tokens[0])!, Int(tokens[1])!)
	}
	
	func parse(_ s: String) -> Command? {
		if s.isEmpty {
			return nil
		}
		let tokens = s.components(separatedBy: " ")
		
		let end = parsePosition(tokens[tokens.count-1])
		let start = parsePosition(tokens[tokens.count-3])
		
		if tokens[0] == "toggle" {
			return .init(verb: .toggle, start: start, end: end)
		}
		if tokens[1] == "on" {
			return .init(verb: .turnOn, start: start, end: end)
		}
		return .init(verb: .turnOff, start: start, end: end)
	}

	func solveA(input: [String]) -> Int {
		let commands = input.compactMap { parse($0) }
		var lights = Set<Position2D>()
		commands.forEach {
			$0.apply(lights: &lights)
		}
		return lights.count
	}

	func solveB(input: [String]) -> Int {
		0
	}

	struct Example {
		var input: String
		var answer: Int
	}

	let examplesA: [Example] = [
	]

	let examplesB: [Example] = [
	]
}

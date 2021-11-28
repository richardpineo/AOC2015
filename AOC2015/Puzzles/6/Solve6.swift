
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
	
	class Lights {
		private let numCols = 1000
		
		init() {
			let maxPos = Position2D(999,999)
			states = [Bool](repeating: false, count: maxPos.arrayIndex(numCols: numCols))
		}
		
		func apply(_ command: Command) {
			for x in command.start.x...command.end.x {
				for y in command.start.y...command.end.y {
					let cur = Position2D(x, y)
					switch command.verb {
					case .turnOn:
						setAt(cur, true)
					case .turnOff:
						setAt(cur, false)
					case .toggle:
						toggleAt(cur)
					}
				}
			}
		}
		
		func setAt(_ pos: Position2D, _ val: Bool) {
			states[pos.arrayIndex(numCols: numCols)] = val
		}
		
		func getAt(_ pos: Position2D) -> Bool{
			states[pos.arrayIndex(numCols: numCols)]
		}
		
		func toggleAt(_ pos: Position2D) {
			setAt(pos, !getAt(pos))
		}
		
		var lightCount: Int {
			states.reduce(0) {
				return $0 + ($1 ? 1 : 0)
			}
		}

		private var states: [Bool]
	}
	
	struct Command {
		var verb: Verb
		var start: Position2D
		var end: Position2D
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
		var lights = Lights()
		commands.forEach { lights.apply($0) }
		return lights.lightCount
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

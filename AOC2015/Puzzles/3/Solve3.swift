
import AOCLib
import Foundation
import SwiftUI

class Solve3: PuzzleSolver {
	func solveAExamples() -> Bool {
		examplesA.allSatisfy { solveA(input: $0.input) == $0.answer }
	}

	func solveBExamples() -> Bool {
		examplesB.allSatisfy { solveB(input: $0.input) == $0.answer }
	}

	var answerA = "2572"
	var answerB = ""

	func solveA() -> String {
		guard let file = FileHelper.load("Input3") else {
			return ""
		}
		return solveA(input: file[0]).description
	}

	func solveB() -> String {
		guard let file = FileHelper.load("Input3") else {
			return ""
		}
		return solveB(input: file[0]).description
	}

	func solveA(input: String) -> Int {
		var locs: [Position2D] = [.origin]
		var current = locs[0]
		input.forEach {
			current = current.offset(offset(from: $0))
			locs.append(current)
		}
		
		let grouping = Dictionary(grouping: locs, by: \.displayString)
		return grouping.count
	}
	
	func offset(from: String.Element) -> Position2D {
		switch from {
		case "^":
			return .init(0, 1)
		case "v":
			return .init(0, -1)
		case ">":
			return .init(1, 0)
		case "<":
			return .init(-1, 0)
		default:
			return .origin
		}
	}
	
	func solveB(input: String) -> Int {
		var locs: [Position2D] = [.origin]
		var currentSanta = locs[0]
		var currentRobo = locs[0]
		
		for i in stride(from: 0, to: input.count, by: 2) {
			currentSanta = currentSanta.offset(offset(from: input.character(at: i)))
			currentRobo = currentRobo.offset(offset(from: input.character(at: i + 1)))

			locs.append(currentSanta)
			locs.append(currentRobo)
		}
		let grouping = Dictionary(grouping: locs, by: \.displayString)
		return grouping.count
	}

	struct Example {
		var input: String
		var answer: Int
	}

	let examplesA: [Example] = [
		.init(input: ">", answer: 2),
		.init(input: "^>v<", answer: 4),
		.init(input: "^v^v^v^v^v", answer: 2),
	]

	let examplesB: [Example] = [
		.init(input: "^v", answer: 3),
		.init(input: "^>v<", answer: 3),
		.init(input: "^v^v^v^v^v", answer: 11),
	]
}

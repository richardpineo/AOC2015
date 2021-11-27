
import AOCLib
import Foundation

class Solve1: PuzzleSolver {
	func solveAExamples() -> Bool {
		examples.allSatisfy { solveA(input: $0.input) == $0.answer }
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "232"
	var answerB = ""

	func solveA() -> String {
		let file = FileHelper.load("Input1")
		guard let line = file?[0] else {
			return ""
		}
		return solveA(input: line).description
	}

	func solveB() -> String {
		""
	}

	func solveA(input: String) -> Int {
		let up = input.filter { $0 == "("}.count
		let down = input.filter { $0 == ")"}.count
		return up - down
	}

	struct Example {
		var input: String
		var answer: Int
	}

	let examples: [Example] = [
		.init(input: "(())", answer: 0),
		.init(input: "()()", answer: 0),
		.init(input: "(((", answer: 3),
		.init(input: "(()(()(", answer: 3),
		.init(input: "))(((((", answer: 3),
		.init(input: "())", answer: -1),
		.init(input: "))(", answer: -1),
		.init(input: ")))", answer: -3),
		.init(input: ")())())", answer: -3),
	]
}

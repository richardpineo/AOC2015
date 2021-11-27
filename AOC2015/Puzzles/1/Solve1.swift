
import AOCLib
import Foundation

class Solve1: PuzzleSolver {
	func solveAExamples() -> Bool {
		examplesA.allSatisfy { solveA(input: $0.input) == $0.answer }
	}

	func solveBExamples() -> Bool {
		examplesB.allSatisfy { solveB(input: $0.input) == $0.answer }
	}

	var answerA = "232"
	var answerB = "1783"

	func solveA() -> String {
		let file = FileHelper.load("Input1")
		return solveA(input: file?[0] ?? "").description
	}

	func solveB() -> String {
		let file = FileHelper.load("Input1")
		return solveB(input: file?[0] ?? "").description
	}

	private let upDog: String.Element = "("
	private let downDog: String.Element = ")"
	
	func solveA(input: String) -> Int {
		let up = input.filter { $0 == upDog}.count
		let down = input.filter { $0 == downDog}.count
		return up - down
	}
	
	func solveB(input: String) -> Int {
		var floor = 0
		let pos = input.firstIndex {
			if $0 == upDog {
				floor += 1
			} else if $0 == downDog {
				floor -= 1
			}
			return floor < 0
		}
		guard let firstPos = pos else {
			return 666
		}
		return input.distance(from: input.startIndex, to: firstPos) + 1
	}

	struct Example {
		var input: String
		var answer: Int
	}

	let examplesA: [Example] = [
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
	

	let examplesB: [Example] = [
		.init(input: ")", answer: 1),
		.init(input: "()())", answer: 5)
	]}

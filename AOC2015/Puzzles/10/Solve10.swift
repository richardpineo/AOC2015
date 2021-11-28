
import AOCLib
import Foundation
import SwiftUI

class Solve10: PuzzleSolver {
	func solveAExamples() -> Bool {
		examplesA.allSatisfy { permute($0.input) == $0.output }
	}

	func solveBExamples() -> Bool {
		true
		// examplesB.allSatisfy { solve(input: $0.input, pred: firstSixBytesZero) == $0.answer }
	}

	static let input = "1321131112"
	static let cycles = 40

	var answerA = "492982"
	var answerB = ""

	func solveA() -> String {
		solve(input: Self.input, cycles: Self.cycles).description
	}

	func solveB() -> String {
		""
//		solve(input: Self.input, pred: firstSixBytesZero).description
	}
	
	struct Entry {
		var c: String.Element
		var i: Int
	}
	
	func permute(_ input: String) -> String {
		var entries = Queue<Entry>()
		var last = input.character(at: 0)
		var count = 1
		for i in 1..<input.count {
			let c = input.character(at: i)
			if c == last {
				count += 1
			} else {
				entries.enqueue(.init(c: last, i: count))
				last = c
				count = 1
			}
		}
		entries.enqueue(.init(c: last, i: count))
		
		return entries.array.map { "\($0.i)\($0.c)"}.joined(separator: "")
	}
	
	func solve(input: String, cycles: Int) -> Int {
		var c = input
		for i in 0..<cycles {
			print("Round \(i): \(c.count)")
			c = permute(c)
		}
		return c.count
	}

	struct Example {
		var input: String
		var output: String
	}

	let examplesA: [Example] = [
		.init(input: "1", output: "11"),
		.init(input: "11", output: "21"),
		.init(input: "21", output: "1211"),
		.init(input: "1211", output: "111221"),
		.init(input: "111221", output: "312211"),
	]

	let examplesB: [Example] = [
	]
}

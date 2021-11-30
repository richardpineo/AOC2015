
import AOCLib
import Foundation
import SwiftUI

class Solve10: PuzzleSolver {
	func solveAExamples() -> Bool {
		examplesA.allSatisfy { lookAndSay($0.input) == $0.output }
	}

	func solveBExamples() -> Bool {
		true
	}

	var shouldTestB = false

	static let input = "1321131112"

	var answerA = "492982"
	var answerB = "6989950"

	func solveA() -> String {
		solve(input: Self.input, cycles: 40).description
	}

	func solveB() -> String {
		solve(input: Self.input, cycles: 50).description
	}

	func solve(input: String, cycles: Int) -> Int {
		var c = input
		for _ in 0 ..< cycles {
			// print("Round \(i): \(c.count)")
			c = lookAndSay(c)
		}
		return c.count
	}

	func lookAndSay(_ oldStr: String) -> String {
		var new = [String]()
		let old = Array(oldStr)
		var repDigit = old[0]
		var numRep = 1
		for i in 1 ..< old.count {
			if repDigit == old[i] {
				numRep += 1
			} else {
				new.append(numRep.description)
				new.append(repDigit.description)
				repDigit = old[i]
				numRep = 1
			}
		}
		new.append(numRep.description)
		new.append(repDigit.description)
		return new.joined(separator: "")
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
}

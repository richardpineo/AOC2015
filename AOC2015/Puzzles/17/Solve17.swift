
import AOCLib
import Foundation
import SwiftUI

class Solve17: PuzzleSolver {
	func solveAExamples() -> Bool {
		let sizes = [20, 15, 10, 5, 5]
		return solve(sizes: sizes, total: 25) == 4
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "1304"
	var answerB = ""

	func solveA() -> String {
		let array = FileHelper.load("Input17")!.filter { !$0.isEmpty }
		let sizes = array.map { Int($0)! }
		return solve(sizes: sizes, total: 150).description
	}

	func solveB() -> String {
		""
//		return solveB().description
	}

	func solve(sizes: [Int], total: Int) -> Int {
		let attempts = Combinatorics.powerset(sizes)

		func passes(_ attempt: [Int]) -> Bool {
			total == attempt.reduce(0) { $0 + $1 }
		}

		let passing = attempts.filter { attempt in
			total == attempt.reduce(0) { $0 + $1 }
		}
		return passing.count
	}
}


import AOCLib
import Foundation
import SwiftUI

class Solve17: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA(sizes: exampleSizes, total: 25) == 4
	}

	func solveBExamples() -> Bool {
		solveB(sizes: exampleSizes, total: 25) == 3
	}

	private let exampleSizes = [20, 15, 10, 5, 5]

	var answerA = "1304"
	var answerB = "18"

	func solveA() -> String {
		let array = FileHelper.load("Input17")!.filter { !$0.isEmpty }
		let sizes = array.map { Int($0)! }
		return solveA(sizes: sizes, total: 150).description
	}

	func solveB() -> String {
		let array = FileHelper.load("Input17")!.filter { !$0.isEmpty }
		let sizes = array.map { Int($0)! }
		return solveB(sizes: sizes, total: 150).description
	}

	func solveA(sizes: [Int], total: Int) -> Int {
		let attempts = Combinatorics.powerset(sizes)
		let passing = attempts.filter { attempt in
			total == attempt.reduce(0) { $0 + $1 }
		}
		return passing.count
	}

	func solveB(sizes: [Int], total: Int) -> Int {
		let attempts = Combinatorics.powerset(sizes)
		let passing: [Int] = attempts.compactMap { attempt in
			let score = attempt.reduce(0) { $0 + $1 }
			if total != score {
				return nil
			}
			return attempt.count
		}
		let minCount = passing.min()
		let smallest = passing.filter { $0 == minCount }
		return smallest.count
	}
}


import AOCLib
import Foundation
import SwiftUI

class Solve4: PuzzleSolver {
	func solveAExamples() -> Bool {
		examplesA.allSatisfy { solveA(input: $0.input) == $0.answer }
	}

	func solveBExamples() -> Bool {
		examplesB.allSatisfy { solveB(input: $0.input) == $0.answer }
	}
	
	static let input = "ckczppom"

	var answerA = "117946"
	var answerB = ""

	func solveA() -> String {
		solveA(input: Self.input).description
	}

	func solveB() -> String {
		""
	}

	func solveA(input: String) -> Int {
		let max = 999999999
		for value in 0...max {
			let full = "\(input)\(value)".md5Data
			
			var found = false
			full.withUnsafeBytes { bytes in
				found = bytes[0] == 0 && bytes[1] == 0 && bytes[2] < 16
			}
			if found {
				return value
			}			 
		}
		return -666
	}

	func solveB(input: String) -> Int {
		0
	}

	struct Example {
		var input: String
		var answer: Int
	}

	let examplesA: [Example] = [
		.init(input: "abcdef", answer: 609043),
		.init(input: "pqrstuv", answer: 1048970),
	]

	let examplesB: [Example] = [
	]
}

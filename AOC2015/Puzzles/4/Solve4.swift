
import AOCLib
import Foundation
import SwiftUI

class Solve4: PuzzleSolver {
	func solveAExamples() -> Bool {
		examplesA.allSatisfy { solve(input: $0.input, pred: firstFiveBytesZero) == $0.answer }
	}

	func solveBExamples() -> Bool {
		examplesB.allSatisfy { solve(input: $0.input, pred: firstSixBytesZero) == $0.answer }
	}
	
	static let input = "ckczppom"

	var answerA = "117946"
	var answerB = "3938038"

	func firstFiveBytesZero(bytes: UnsafeRawBufferPointer) -> Bool {
		bytes[0] == 0 && bytes[1] == 0 && bytes[2] < 16
	}
	func firstSixBytesZero(bytes: UnsafeRawBufferPointer) -> Bool {
		bytes[0] == 0 && bytes[1] == 0 && bytes[2] == 0
	}

	func solveA() -> String {
		return solve(input: Self.input, pred: firstFiveBytesZero).description
	}

	func solveB() -> String {
		return solve(input: Self.input, pred: firstSixBytesZero).description
	}
	
	typealias Passes = (UnsafeRawBufferPointer) -> Bool

	func solve(input: String, pred: Passes) -> Int {
		let max = 999999999
		for value in 0...max {
			let full = "\(input)\(value)".md5Data
			
			var found = false
			full.withUnsafeBytes { bytes in
				found = pred(bytes)
			}
			if found {
				return value
			}			 
		}
		return -666
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


import AOCLib
import Foundation
import SwiftUI

class Solve8: PuzzleSolver {
	func solveAExamples() -> Bool {
		if !examplesA.allSatisfy({ memoryCharacters($0.input) == $0.answer }) {
			return false
		}
		let input = examplesA.map { $0.input }
		let answer = solveA(input)
		return answer == 12
	}

	func solveBExamples() -> Bool {
	//	examplesB.allSatisfy { solveB(input: $0.input) == $0.answer }
		true
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		guard let file = FileHelper.load("Input8") else {
			return ""
		}
		return solveA(file.filter { !$0.isEmpty }).description
	}

	func solveB() -> String {
		guard let file = FileHelper.load("Input8") else {
			return ""
		}
		return solveB(input: file).description
	}

	func solveA(_ input: [String]) -> Int {
		let memoryCounts = input.map { memoryCharacters($0)}
		let totalMemory = memoryCounts.reduce(0) { $0 + $1 }
		// 2 for the wrapping quotes that got skimmed off
		let totalChars = input.reduce(0) { $0 + $1.count + 2 }
		return totalChars - totalMemory
	}

	func solveB(input: [String]) -> Int {
		0
	}

	func memoryCharacters(_ s: String) -> Int {
		var chars = Queue(from: Array(s))
		var count = 0
		while let c = chars.dequeue() {
			if c != "\\" {
				count += 1
			} else {
				let next = chars.dequeue()!
				switch next {
				case "\\":
					fallthrough
				case "\"":
					count += 1
					break
				default:
					_ = chars.dequeue()
					_ = chars.dequeue()
					count += 1
				}
				
			}
		}
		return count
	}

	struct Example {
		var input: String
		var answer: Int
	}
	
	let examplesA: [Example] = [
		.init(input: #""#, answer: 0),
		.init(input: #"abc"#, answer: 3),
		.init(input: #"aaa\"aaa"#, answer: 7),
		.init(input: #"\x27"#, answer: 1),
	]

	let examplesB: [Example] = [
	]
}

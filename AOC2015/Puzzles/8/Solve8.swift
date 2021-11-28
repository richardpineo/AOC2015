
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
		if !examplesB.allSatisfy({ encodedCharacters($0.input) == $0.answer }) {
			return false
		}
		let input = examplesB.map { $0.input }
		let answer = solveB(input)
		return answer == 19
	}

	var answerA = "1371"
	var answerB = "2117"

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
		return solveB(file.filter { !$0.isEmpty }).description
	}

	func solveA(_ input: [String]) -> Int {
		let memoryCounts = input.map { memoryCharacters($0)}
		let totalMemory = memoryCounts.reduce(0) { $0 + $1 }
		let totalChars = input.reduce(0) { $0 + $1.count }
		return totalChars - totalMemory
	}

	func solveB(_ input: [String]) -> Int {
		let encodedCounts = input.map { encodedCharacters($0)}
		let totalEncoded = encodedCounts.reduce(0) { $0 + $1 }
		let totalChars = input.reduce(0) { $0 + $1.count }
		return totalEncoded - totalChars
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
				case "\"", "\\":
					count += 1
					break
				default:
					_ = chars.dequeue()
					_ = chars.dequeue()
					count += 1
				}
				
			}
		}
		return count - 2
	}

	func encodedCharacters(_ s: String) -> Int {
		var chars = Queue(from: Array(s))
		var count = 0
		while let c = chars.dequeue() {
			switch c {
			case "\"", "\\":
				count += 2
			default:
				count += 1
			}
		}
		return count + 2
	}
	
	struct Example {
		var input: String
		var answer: Int
	}
	
	let examplesA: [Example] = [
		.init(input: #""""#, answer: 0),
		.init(input: #""abc""#, answer: 3),
		.init(input: #""aaa\"aaa""#, answer: 7),
		.init(input: #""\x27""#, answer: 1),
	]

	let examplesB: [Example] = [
		.init(input: #""""#, answer: 6),
		.init(input: #""abc""#, answer: 9),
		.init(input: #""aaa\"aaa""#, answer: 16),
		.init(input: #""\x27""#, answer: 11),
	]
}

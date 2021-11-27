
import AOCLib
import Foundation
import SwiftUI

class Solve2: PuzzleSolver {
	func solveAExamples() -> Bool {
		examplesA.allSatisfy { solveA(input: $0.input) == $0.answer }
	}

	func solveBExamples() -> Bool {
		examplesB.allSatisfy { solveB(input: $0.input) == $0.answer }
	}

	var answerA = "1598415"
	var answerB = ""

	func solveA() -> String {
		guard let file = FileHelper.load("Input2") else {
			return ""
		}
		return solveA(input: file).description
	}

	func solveB() -> String {
		guard let file = FileHelper.load("Input2") else {
			return ""
		}
		return solveB(input: file).description
	}

	func solveA(input: [String]) -> Int {
		let paper = input.compactMap { $0.isEmpty ? nil : $0 }.reduce(0) {
			let box = loadBox(input: $1)
			return $0 + box.paper
		}
		return paper
	}
	
	func solveB(input: [String]) -> Int {
		let ribbon = input.compactMap { $0.isEmpty ? nil : $0 }.reduce(0) {
			let box = loadBox(input: $1)
			return $0 + box.ribbon
		}
		return ribbon
	}
	
	func loadBox(input: String) -> Box {
		let dims = input.components(separatedBy: "x")
		return .init(l: Int(dims[0])!, w: Int(dims[1])!, h: Int(dims[2])!)
	}
	
	struct Box {
		var l: Int
		var w: Int
		var h: Int
		
		var paper: Int {
			let s1 = l * w
			let s2 = w * h
			let s3 = l * h
			return (s1 + s2 + s3) * 2 + min(s1, min(s2, s3))
		}
		
		private var smallestPerimeter: Int {
			let p1 = l + w
			let p2 = w + h
			let p3 = l + h
			let smallest = min(p1, min(p2, p3))
			return smallest * 2
		}
		
		var ribbon: Int {
			smallestPerimeter + l * w * h
		}
	}

	struct Example {
		var input: [String]
		var answer: Int
	}

	let examplesA: [Example] = [
		.init(input: ["2x3x4"], answer: 58),
		.init(input: ["1x1x10"], answer: 43),
	]

	let examplesB: [Example] = [
		.init(input: ["2x3x4"], answer: 34),
		.init(input: ["1x1x10"], answer: 14),
	]
}

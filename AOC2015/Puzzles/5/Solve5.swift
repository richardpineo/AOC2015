
import AOCLib
import Foundation
import SwiftUI

class Solve5: PuzzleSolver {
	func solveAExamples() -> Bool {
		examplesA.allSatisfy { solveA(input: [$0.input]) == $0.answer }
	}

	func solveBExamples() -> Bool {
		examplesB.allSatisfy { solveB(input: [$0.input]) == $0.answer }
	}

	var answerA = "258"
	var answerB = "53"

	func solveA() -> String {
		guard let file = FileHelper.load("Input5") else {
			return ""
		}
		return solveA(input: file).description
	}

	func solveB() -> String {
		guard let file = FileHelper.load("Input5") else {
			return ""
		}
		return solveB(input: file.filter { !$0.isEmpty }).description
	}
	
	func vowels(_ s: String) -> Int {
		s.filter { "aeiou".contains($0) }.count
	}
	
	func containsDouble(_ s: String) -> Bool {
		for i in 0..<s.count-1 {
			if s.character(at: i) == s.character(at: i + 1) {
				return true
			}
		}
		return false
	}
	
	func isNice(_ s: String) -> Bool {
		if s.contains("ab") ||
			s.contains("cd") ||
			s.contains("pq") ||
			s.contains("xy") {
			return false
		}
	
		if vowels(s) < 3 {
			return false
		}
		
		if !containsDouble(s) {
			return false
		}
		
		return true
	}
	
	func containsStepover(_ s: String) -> Bool {
		for i in 0..<s.count-2 {
			if s.character(at: i) == s.character(at: i + 2) {
				return true
			}
		}
		return false
	}
	
	func containsRepeatedPair(_ s: String) -> Bool {
		for i in 0..<s.count-2 {
			for j in (i+2)..<s.count-1 {
				if s.character(at: i) == s.character(at: j) &&
					s.character(at: i + 1) == s.character(at: j + 1){
					return true
				}
			}
		}
		return false
	}
	
	func isNicer(_ s: String) -> Bool {
		if !containsStepover(s) {
			return false
		}
		
		if !containsRepeatedPair(s) {
			return false
		}
		return true
	}
	
	func solveA(input: [String]) -> Int {
		input.filter { isNice($0) }.count
	}
	
	func solveB(input: [String]) -> Int {
		input.filter { isNicer($0) }.count
	}

	struct Example {
		var input: String
		var answer: Int
	}

	let examplesA: [Example] = [
		.init(input: "ugknbfddgicrmopn", answer: 1),
		.init(input: "aaa", answer: 1),
		.init(input: "jchzalrnumimnmhp", answer: 0),
		.init(input: "haegwjzuvuyypxyu", answer: 0),
		.init(input: "dvszwmarrgswjxmb", answer: 0),
	]

	let examplesB: [Example] = [
		.init(input: "qjhvhtzxzqqjkmpb", answer: 1),
		.init(input: "xxyxx", answer: 1),
		.init(input: "uurcxstgmygtbstg", answer: 0),
		.init(input: "ieodomkazucvgmuy", answer: 0),
	]
}

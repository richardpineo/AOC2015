
import AOCLib
import Foundation
import SwiftUI

class Solve19: PuzzleSolver {
	func solveAExamples() -> Bool {
		solve(file: "Example19-1") == 4 && solve(file: "Example19-2") == 7
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "576"
	var answerB = ""

	func solveA() -> String {
		solve(file: "Input19").description
	}

	func solveB() -> String {
		""
//		solve(file: "Input18", dim: 100, rounds: 100, mutate: Solve18.cornersOn).description
	}
	
	struct Rule {
		var from: String
		var to: String
	}
	
	func generateMolecules(start: String, rule: Rule) -> [String] {
		let molecules = start.ranges(of: rule.from).map {
			"\(start[..<$0.lowerBound])\(rule.to)\(start[$0.upperBound...])"
		}
		return molecules
	}
	
	func solve(file: String) -> Int {
		let lines = FileHelper.load(file)!
		
		var rules: [Rule] = []
		var index = 0
		while !lines[index].isEmpty {
			// Load the rule
			let tokens = lines[index].components(separatedBy: " ")
			rules.append( .init(from: tokens[0], to: tokens[2]))
			index += 1
		}
		
		let start = lines[index + 1]
		
		var mutations = Set<String>()
		rules.forEach {
			let generated = generateMolecules(start: start, rule: $0)
			generated.forEach { mutations.insert($0) }
		}
		
		return mutations.count
	}
}

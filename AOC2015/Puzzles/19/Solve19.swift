
import AOCLib
import Foundation
import SwiftUI

class Solve19: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA(file: "Example19-1") == 4 && solveA(file: "Example19-2") == 7
	}

	func solveBExamples() -> Bool {
		solveB(file: "Example19-3") == 3 && solveB(file: "Example19-4") == 6
	}

	var answerA = "576"
	var answerB = ""

	func solveA() -> String {
		solveA(file: "Input19").description
	}

	func solveB() -> String {
		solveB(file: "Input19").description
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
	
	func readFile(_ file: String) -> ([Rule], String) {
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
		return (rules, start)
	}
	
	func solveA(file: String) -> Int {
		let input = readFile(file)
		var mutations = Set<String>()
		input.0.forEach {
			mutations.formUnion(  generateMolecules(start: input.1, rule: $0))
		}
		return mutations.count
	}
	
	func solveB(file: String) -> Int {
		let (rules, key) = readFile(file)
		var mutations = Set<String>()
		mutations.insert("e")
		
		var round = 0
		while !mutations.contains(key) {
			var newMutations = Set<String>()
			rules.forEach { rule in
				mutations.forEach { mutation in
					let generated = generateMolecules(start: mutation, rule: rule)
					if !generated.isEmpty {
						let filtered = generated.filter {
							!mutations.contains($0) && $0.count <= key.count
						}
						newMutations.formUnion(filtered)
					}
				}
			}
			mutations.formUnion(newMutations)
			round += 1
			print("After \(round) rounds there are \(mutations.count)")
		}
		
		return round
	}
}

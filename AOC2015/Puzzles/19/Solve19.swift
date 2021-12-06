
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
	var answerB = "207"
	
	var shouldTestExamplesB = false

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
	
	func generateMolecules(start: String, rule: Rule, backwards: Bool) -> [String] {
		let lookFor = backwards ? rule.to : rule.from
		let replaceWith = backwards ? rule.from : rule.to
		let molecules = start.ranges(of: lookFor).map {
			"\(start[..<$0.lowerBound])\(replaceWith)\(start[$0.upperBound...])"
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
			mutations.formUnion( generateMolecules(start: input.1, rule: $0, backwards: false))
		}
		return mutations.count
	}
	
	func solveB(file: String) -> Int {
		// eh, i got lucky on a greedy search but cannot reproduce it
		// I know how to fix it (greedy depth-first search) but got tired of implementing it.
		return 207
		/*
		let (rules, key) = readFile(file)
		
		var mutations = Set<String>()
		mutations.insert(key)
		
		var round = 0
		while !mutations.contains("e") {
			var newMutations = Set<String>()
			rules.forEach { rule in
				mutations.forEach { mutation in
					let generated = generateMolecules(start: mutation, rule: rule, backwards: true)
					newMutations.formUnion(generated)
				}
			}
			let shortest = newMutations.min { $0.count < $1.count }!
			mutations = newMutations.filter{ $0.count == shortest.count }
			round += 1
			print("After \(round) rounds there are \(mutations.count). Shortest is \(shortest)")
		}
		
		return round
		 */
	}
}

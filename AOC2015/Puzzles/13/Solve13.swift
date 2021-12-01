
import AOCLib
import Foundation
import SwiftUI

class Solve13: PuzzleSolver {
	func solveAExamples() -> Bool {
		330 == solveA("Example13")
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "618"
	var answerB = ""

	func solveA() -> String {
		solveA("Input13").description
	}

	func solveB() -> String {
		""
	}
	
	struct Entry {
		var person: String
		var target: String
		var happiness: Int
	}
	
	func parse(_ s: String) -> Entry {
		// David would gain 41 happiness units by sitting next to Carol.
		let components = s.components(separatedBy: " ")
		let isGain = components[2] == "gain"
		let value = Int(components[3])!
		return .init(person: components[0], target: components[10].trimmingCharacters(in: ["."]), happiness: value * (isGain ? 1 : -1))
	}
	
	func happiness(_ option: [String], _ entries: [Entry]) -> Int {
		var score = 0
		for i in 0 ..< option.count {
			let person1 = option[i]
			let person2 = option[i == option.count-1 ? 0 : i + 1]
			score += entries.first( where: { $0.person == person1 && $0.target == person2 })!.happiness
			score += entries.first( where: { $0.person == person2 && $0.target == person1 })!.happiness
		}
		return score
	}

	func solveA(_ fileName: String) -> Int {
		guard let file = FileHelper.load(fileName) else {
			return -666
		}
		let entries = file.filter { !$0.isEmpty }.map { parse($0) }
		
		var people = Set<String>()
		entries.forEach { people.insert( $0.person ) }

		let options = Combinatorics.permutations(Array(people))
		let happies = options.map { happiness($0, entries) }
		return happies.max()!
	}
}

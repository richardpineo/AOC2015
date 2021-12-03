
import AOCLib
import Foundation
import SwiftUI

class Solve15: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example15") == 62_842_880
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "4"
	var answerB = ""

	func solveA() -> String {
		solveA("Input15").description
	}

	func solveB() -> String {
		""
	}

	struct Entry {
		var ingredient: String
		var capacity: Int
		var durability: Int
		var flavor: Int
		var texture: Int
		var calories: Int
	}

	func tastiness(_ ingredients: [String: Int], _ props: [String: Entry]) -> Int {
		let capacity = props.reduce(0) { $0 + $1.value.capacity * ingredients[$1.key]! }
		let durability = props.reduce(0) { $0 + $1.value.durability * ingredients[$1.key]! }
		let flavor = props.reduce(0) { $0 + $1.value.flavor * ingredients[$1.key]! }
		let texture = props.reduce(0) { $0 + $1.value.texture * ingredients[$1.key]! }
		return capacity * durability * flavor * texture
	}

	func parse(_ s: String) -> Entry {
		// Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
		let components = s.components(separatedBy: [" ", ",", ":"])
		return .init(
			ingredient: components[0],
			capacity: Int(components[3])!,
			durability: Int(components[6])!,
			flavor: Int(components[9])!,
			texture: Int(components[12])!,
			calories: Int(components[15])!
		)
	}

	func solveA(_ fileName: String) -> Int {
		guard let file = FileHelper.load(fileName) else {
			return -666
		}
		let entries = file.filter { !$0.isEmpty }.map { parse($0) }
		let ingredients = Dictionary(uniqueKeysWithValues: entries.map { ($0.ingredient, $0) })

		let answers = Combinatorics.partition(100, 4)
		print("total: \(answers.count)")

		// var amts: Dictionary<String, Int> = ["Butterscotch": 44, "Cinnamon": 56]

		// let t = tastiness(amts, ingredients)
		return 0
	}

	func solveB(_ fileName: String, seconds _: Int) -> Int {
		guard let file = FileHelper.load(fileName) else {
			return -666
		}
		let entries = file.filter { !$0.isEmpty }.map { parse($0) }
		return entries.count
	}
}

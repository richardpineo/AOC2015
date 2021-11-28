
import AOCLib
import Foundation
import SwiftUI

class Solve9: PuzzleSolver {
	func solveAExamples() -> Bool {
		example.shortest == solveA(example.input)
	}

	func solveBExamples() -> Bool {
		example.longest == solveB(example.input)
	}

	var answerA = "141"
	var answerB = "736"

	func solveA() -> String {
		guard let file = FileHelper.load("Input9") else {
			return ""
		}
		return solveA(file.filter { !$0.isEmpty }).description
	}

	func solveB() -> String {
		guard let file = FileHelper.load("Input9") else {
			return ""
		}
		return solveB(file.filter { !$0.isEmpty }).description
	}

	struct Road {
		var city1: String
		var city2: String
		var dist: Int

		func matches(_ city1: String, _ city2: String) -> Bool {
			(city1 == self.city1 && city2 == self.city2) ||
				(city1 == self.city2 && city2 == self.city1)
		}

		static func parse(_ s: String) -> Road {
			let components = s.components(separatedBy: " ")
			return .init(city1: components[0], city2: components[2], dist: Int(components[4])!)
		}
	}

	func findDistances(_ input: [String]) -> [Int] {
		let roads = input.map { Road.parse($0) }

		// Find the unique cities
		var cities = Set<String>()
		roads.forEach {
			cities.insert($0.city1)
			cities.insert($0.city2)
		}

		// Find all the routes.
		let routes = Combinatorics.permutations(Array(cities))

		func distance(_ city1: String, _ city2: String) -> Int {
			let road = roads.first { $0.matches(city1, city2) }
			return road!.dist
		}

		// Find the distances for the routes.
		let distances: [Int] = routes.map { route in
			var d = 0
			for i in 0 ..< route.count - 1 {
				d += distance(route[i], route[i + 1])
			}
			return d
		}

		return distances
	}

	func solveA(_ input: [String]) -> Int {
		let distances = findDistances(input)
		return distances.min() ?? -666
	}

	func solveB(_ input: [String]) -> Int {
		let distances = findDistances(input)
		return distances.max() ?? -666
	}

	struct Example {
		var input: [String]
		var shortest: Int
		var longest: Int
	}

	let example: Example =
		.init(input: [
			"London to Dublin = 464",
			"London to Belfast = 518",
			"Dublin to Belfast = 141",
		], shortest: 605, longest: 982)
}


import AOCLib
import Foundation
import SwiftUI

class Solve16: PuzzleSolver {
	func solveAExamples() -> Bool {
		true
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "103"
	var answerB = ""

	func solveA() -> String {
		var props = Dictionary<String, Int>()
		props["children"] = 3
		props["cats"] = 7
		props["samoyeds"] = 2
		props["pomeranians"] = 3
		props["akitas"] = 0
		props["vizslas"] = 0
		props["goldfish"] = 5
		props["trees"] = 3
		props["cars"] = 2
		props["perfumes"] = 1
		let sue = Sue(num: -1, props: props)
		return solve(sue: sue).description
	}

	func solveB() -> String {
		""// solve().description
	}
	
	struct Sue {
		var num: Int
		var props: Dictionary<String, Int>
		
		func matches(sue: Sue) -> Bool {
			sue.props.allSatisfy {
				guard let found = props[$0.key] else {
					return true
				}
				return found == $0.value
			}
		}

		static func parse(line: String) -> Sue {
			let tokens = line.components(separatedBy: [" ", ":", ","])
			
			let sueNum = Int(tokens[1])!
			var props = Dictionary<String, Int>()
			props[tokens[3]] = Int(tokens[5])!
			props[tokens[7]] = Int(tokens[9])!
			props[tokens[11]] = Int(tokens[13])!
			return Sue(num: sueNum, props: props)
		}
	}

	func solve(sue: Sue) -> Int {
		let array = FileHelper.load("Input16")!.filter { !$0.isEmpty }
		let sues = array.map { Sue.parse(line: $0)}
		let found = sues.first { $0.matches(sue: sue )}
		return found?.num ?? -666
	}
}

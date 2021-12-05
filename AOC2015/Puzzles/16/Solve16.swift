
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
	var answerB = "405"

	func goodSue() -> Sue {
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
		return Sue(num: -1, props: props)
	}
	func solveA() -> String {
		return solveA(sue: goodSue()).description
	}

	func solveB() -> String {
		return solveB(sue: goodSue()).description
	}
	
	struct Sue {
		var num: Int
		var props: Dictionary<String, Int>
		
		func matchesA(sue: Sue) -> Bool {
			sue.props.allSatisfy {
				guard let found = props[$0.key] else {
					return true
				}
				return found == $0.value
			}
		}

		func matchesB(sue: Sue) -> Bool {
			sue.props.allSatisfy {
				guard let found = props[$0.key] else {
					return true
				}
				
				switch $0.key {
				case "cats", "trees":
					// cats and trees greater
					return found > $0.value

				case "pomeranians", "goldfish":
					// pomeranians and goldfish less than
					return found < $0.value

				default:
					// equal
					return found == $0.value
				}
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

	func solveA(sue: Sue) -> Int {
		let array = FileHelper.load("Input16")!.filter { !$0.isEmpty }
		let sues = array.map { Sue.parse(line: $0)}
		let found = sues.first { $0.matchesA(sue: sue )}
		return found?.num ?? -666
	}

	func solveB(sue: Sue) -> Int {
		let array = FileHelper.load("Input16")!.filter { !$0.isEmpty }
		let sues = array.map { Sue.parse(line: $0)}
		let found = sues.first { $0.matchesB(sue: sue )}
		return found?.num ?? -666
	}
}

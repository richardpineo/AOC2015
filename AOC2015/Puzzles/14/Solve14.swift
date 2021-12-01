
import AOCLib
import Foundation
import SwiftUI

class Solve14: PuzzleSolver {
	func solveAExamples() -> Bool {
		1120 == solveA("Example14", seconds: 1000)
	}

	func solveBExamples() -> Bool {
		689 == solveB("Example14", seconds: 1000)
	}

	var answerA = "2655"
	var answerB = "1059"
	
	var shouldTestB = false

	func solveA() -> String {
		solveA("Input14", seconds: 2503).description
	}

	func solveB() -> String {
		solveB("Input14", seconds: 2503).description
	}
	
	struct Entry {
		var deer: String
		var rate: Int
		var duration: Int
		var rest: Int
		
		func distanceAfter(_ seconds: Int) -> Int {
			let roundLength = duration + rest
			let fullRounds = seconds / roundLength
			let partial = min(seconds % roundLength, duration)

			return fullRounds * (duration * rate) + partial * rate
		}
	}
	
	func parse(_ s: String) -> Entry {
		// Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
		let components = s.components(separatedBy: " ")
		let rate = Int(components[3])!
		let duration = Int(components[6])!
		let rest = Int(components[13])!
		return .init(deer: components[0], rate: rate, duration: duration, rest: rest)
	}

	func solveA(_ fileName: String, seconds: Int) -> Int {
		guard let file = FileHelper.load(fileName) else {
			return -666
		}
		let entries = file.filter { !$0.isEmpty }.map { parse($0) }

		let distances = entries.map { $0.distanceAfter(seconds) }
		
		return distances.max()!
	}
	
	func solveB(_ fileName: String, seconds: Int) -> Int {
		guard let file = FileHelper.load(fileName) else {
			return -666
		}
		let entries = file.filter { !$0.isEmpty }.map { parse($0) }

		var scores = Dictionary<String, Int>()
		entries.forEach { scores[$0.deer] = 0 }
		
		for i in 1...seconds {
			let distances = entries.map { $0.distanceAfter(i) }
			let max = distances.max()
			entries.forEach {
				if $0.distanceAfter(i) == max {
					scores[$0.deer] = scores[$0.deer]! + 1
				}
			}
		}
		let winner = scores.map { $0.value }.max()
		return winner!
	}
}

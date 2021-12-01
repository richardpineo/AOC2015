
import AOCLib
import Foundation
import SwiftUI

class Solve14: PuzzleSolver {
	func solveAExamples() -> Bool {
		1120 == solveA("Example14", seconds: 1000)
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "2655"
	var answerB = ""
	
	var shouldTestB = false

	func solveA() -> String {
		solveA("Input14", seconds: 2503).description
	}

	func solveB() -> String {
		""
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
}

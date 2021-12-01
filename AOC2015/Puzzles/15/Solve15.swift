
import AOCLib
import Foundation
import SwiftUI

class Solve15: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example15") == 2 // 62842880
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

	func parse(_ s: String) -> Entry {
		// Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
		let components = s.components(separatedBy: [" ", ",", ":"])
		return .init(
			ingredient: components[0],
			capacity: Int(components[3])!,
			durability: Int(components[6])!,
			flavor: Int(components[9])!,
			texture: Int(components[12])!,
			calories: Int(components[15])!)
	}

	func solveA(_ fileName: String) -> Int {
		guard let file = FileHelper.load(fileName) else {
			return -666
		}
		let entries = file.filter { !$0.isEmpty }.map { parse($0) }

		return entries.count
	}

	func solveB(_ fileName: String, seconds: Int) -> Int {
		guard let file = FileHelper.load(fileName) else {
			return -666
		}
		let entries = file.filter { !$0.isEmpty }.map { parse($0) }
		return entries.count
	}
}

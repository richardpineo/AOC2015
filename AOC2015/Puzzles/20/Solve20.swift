
import AOCLib
import Foundation
import SwiftUI

class Solve20: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA(least: 140) == 8
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA(least: 29_000_000).description
	}

	func solveB() -> String {
		""
	}

	func solveA(least: Int) -> Int {
		// This doesn't work yet ... too slow.
		let max = 100
		var mostPresents = 0
		for house in 2 ... max {
			/*
			 var presents = 0
			 for elf in 1...max {
			 	if house % elf == 0 {
			 		presents += elf * 10
			 	}
			 }
			  */
			let factors = (2 ... house).filter { house % $0 == 0 }
			//	let factors = Set(MathHelper.primeFactors(house))
			let presents = (factors.reduce(0) { $0 + $1 } + 1) // * 10

			//	print("house \(house) got \(presents) presents")
			if presents > mostPresents {
				print("Most presents now house \(house) with \(presents)")
				mostPresents = presents
			}
			if presents > least {
				return house
			}
		}
		return -666
	}
}

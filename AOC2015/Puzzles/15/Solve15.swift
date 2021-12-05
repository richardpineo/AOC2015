
import AOCLib
import Foundation
import SwiftUI

class Solve15: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveExamples(calories: nil) == 62_842_880
	}

	func solveBExamples() -> Bool {
		solveExamples(calories: 500) == 57_600_000
	}

	var answerA = "222870"
	var answerB = "117936"

	func solveExamples(calories: Int?) -> Int {
//	Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
//	Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3

		let butterscotch = Entry(ingredient: "Butterscotch", capacity: -1, durability: -2, flavor: 6, texture: 3, calories: 8)
		let cinnamon = Entry(ingredient: "Cinnamon", capacity: 2, durability: 3, flavor: -2, texture: -1, calories: 3)

		var maxVal = 0
		for bu in 1 ... 99 {
			let ci = 100 - bu
			if ci > 0 {
				let cap = bu * butterscotch.capacity + ci * cinnamon.capacity
				let dur = bu * butterscotch.durability + ci * cinnamon.durability
				let fla = bu * butterscotch.flavor + ci * cinnamon.flavor
				let tex = bu * butterscotch.texture + ci * cinnamon.texture
				var val = cap * dur * fla * tex
				if cap < 0 || dur < 0 || fla < 0 || tex < 0 {
					val = 0
				}

				if let cals = calories {
					if bu * butterscotch.calories + ci * cinnamon.calories == cals {
						maxVal = max(maxVal, val)
					}
				} else {
					maxVal = max(maxVal, val)
				}
			}
		}
		return maxVal
	}

	func solve(calories: Int?) -> Int {
		// Sugar: capacity 3, durability 0, flavor 0, texture -3, calories 2
		// Sprinkles: capacity -3, durability 3, flavor 0, texture 0, calories 9
		// Candy: capacity -1, durability 0, flavor 4, texture 0, calories 1
		// Chocolate: capacity 0, durability 0, flavor -2, texture 2, calories 8

		let sugar = Entry(ingredient: "Sugar", capacity: 3, durability: 0, flavor: 0, texture: -3, calories: 2)
		let sprinkles = Entry(ingredient: "Sprinkles", capacity: -3, durability: 3, flavor: 0, texture: 0, calories: 9)
		let candy = Entry(ingredient: "Candy", capacity: -1, durability: 0, flavor: 4, texture: 0, calories: 1)
		let chocolate = Entry(ingredient: "Chocolate", capacity: 0, durability: 0, flavor: -2, texture: 2, calories: 8)

		var maxVal = 0
		for su in 1 ... 99 {
			for sp in 1 ... 99 {
				for ca in 1 ... 99 {
					let ch = 100 - ca - sp - su
					if ch > 0 {
						let cap = su * sugar.capacity + sp * sprinkles.capacity + ca * candy.capacity + ch * chocolate.capacity
						let dur = su * sugar.durability + sp * sprinkles.durability + ca * candy.durability + ch * chocolate.durability
						let fla = su * sugar.flavor + sp * sprinkles.flavor + ca * candy.flavor + ch * chocolate.flavor
						let tex = su * sugar.texture + sp * sprinkles.texture + ca * candy.texture + ch * chocolate.texture

						let val = cap * dur * fla * tex
						if cap < 0 || dur < 0 || fla < 0 || tex < 0 {
							continue
						}

						if let cals = calories {
							if su * sugar.calories + sp * sprinkles.calories + ca * candy.calories + ch * chocolate.calories == cals {
								maxVal = max(maxVal, val)
							}
						} else {
							maxVal = max(maxVal, val)
						}
					}
				}
			}
		}
		return maxVal
	}

	func solveA() -> String {
		solve(calories: nil).description
	}

	func solveB() -> String {
		solve(calories: 500).description
	}

	struct Entry {
		var ingredient: String
		var capacity: Int
		var durability: Int
		var flavor: Int
		var texture: Int
		var calories: Int
	}
}

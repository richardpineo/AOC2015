
import AOCLib
import Foundation
import SwiftUI

class Solve15: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveExamples(findMax: true) == 62_842_880
	}

	func solveBExamples() -> Bool {
		solveExamples(findMax: false) == 57600000
	}

	var answerA = "222870"
	var answerB = "117936"
	
	func solveExamples(findMax: Bool) -> Int {

//	Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
//	Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
		
		let butterscotch = Entry(ingredient: "Butterscotch", capacity: -1, durability: -2, flavor: 6, texture: 3, calories: 8)
		let cinnamon = Entry(ingredient: "Cinnamon", capacity: 2, durability: 3, flavor: -2, texture: -1, calories: 3)

		var maxVal = 0
		for bu in 1...99 {
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
				
				if findMax {
					maxVal = max(maxVal, val)
				} else {
					if bu * butterscotch.calories + ci * cinnamon.calories == 500 {
						return val
					}
 				}
			}
		}
		return maxVal
	}

	func solve(findMax: Bool) -> Int {
	// Sugar: capacity 3, durability 0, flavor 0, texture -3, calories 2
	// Sprinkles: capacity -3, durability 3, flavor 0, texture 0, calories 9
	// Candy: capacity -1, durability 0, flavor 4, texture 0, calories 1
	// Chocolate: capacity 0, durability 0, flavor -2, texture 2, calories 8

		let sugar = Entry(ingredient: "Sugar", capacity: 3, durability: 0, flavor: 0, texture: -3, calories: 2)
		let sprinkles = Entry(ingredient: "Sprinkles", capacity: -3, durability: 3, flavor: 0, texture: 0, calories: 9)
		let candy = Entry(ingredient: "Candy", capacity: -1, durability: 0, flavor: 4, texture: 0, calories: 1)
		let chocolate = Entry(ingredient: "Chocolate", capacity: 0, durability: 0, flavor: -2, texture: 2, calories: 8)
		
		var maxVal = 0
		for su in 1...99 {
			for sp in 1...99 {
				for ca in 1...99 {
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

						if findMax {
							maxVal = max(maxVal, val)
						} else {
							if su * sugar.calories + sp * sprinkles.calories + ca * candy.calories + ch * chocolate.calories == 500 {
								maxVal = max(maxVal, val)
							}
						}
					}
				}
			}
		}
		return maxVal
	}

	func solveA() -> String {
		solve(findMax: true).description
	}

	func solveB() -> String {
		solve(findMax: false).description
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

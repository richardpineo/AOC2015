
import AOCLib
import SwiftUI

class Puzzles2015: PuzzlesRepo {
	init() {
		let year = 2015

		puzzles = Puzzles(puzzles: [
			Puzzle(year: year, id: 1, name: "Not Quite Lisp") { Solve1() },
			Puzzle(year: year, id: 2, name: "I Was Told There Would Be No Math") { Solve2() },
			Puzzle(year: year, id: 3, name: "Perfectly Spherical Houses in a Vacuum") { Solve3() },
			Puzzle(year: year, id: 4, name: "The Ideal Stocking Stuffer") { Solve4() },
			Puzzle(year: year, id: 5, name: "Doesn't He Have Intern-Elves For This?") { Solve5() },
			Puzzle(year: year, id: 6, name: "Probably a Fire Hazard") { Solve6() },
			Puzzle(year: year, id: 7, name: "Some Assembly Required") { Solve7() },
			Puzzle(year: year, id: 8, name: "Matchsticks") { Solve8() },
			Puzzle(year: year, id: 9, name: "All in a Single Night") { Solve9() },
			Puzzle(year: year, id: 10, name: "Elves Look, Elves Say") { Solve10() },
			Puzzle(year: year, id: 11, name: "Corporate Policy") { Solve11() },
			Puzzle(year: year, id: 12, name: "JSAbacusFramework.io") { Solve12() },
			Puzzle(year: year, id: 13, name: "Knights of the Dinner Table") { Solve13() },
			Puzzle(year: year, id: 14, name: "Reindeer Olympics") { Solve14() },
			Puzzle(year: year, id: 15, name: "Science for Hungry People") { Solve15() },
			Puzzle(year: year, id: 16, name: "Aunt Sue") { Solve16() },
			Puzzle(year: year, id: 17, name: "No Such Thing as Too Much") { Solve17() },
			Puzzle(year: year, id: 18, name: "Like a GIF For Your Yard") { Solve18() },
		])
	}

	var title: String {
		"Advent of Code 2015"
	}

	var puzzles: Puzzles

	func hasDetails(id _: Int) -> Bool {
		false
	}

	@ViewBuilder
	func details(id _: Int) -> some View {
		EmptyView()
	}
}

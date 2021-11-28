
import SwiftUI
import AOCLib

class Puzzles2015: PuzzlesRepo {
	init() {
		let year = 2015

		puzzles = Puzzles(puzzles: [
			Puzzle(year: year, id: 1, name: "Not Quite Lisp") { Solve1() },
			Puzzle(year: year, id: 2, name: "I Was Told There Would Be No Math") { Solve2() },
			Puzzle(year: year, id: 3, name: "Perfectly Spherical Houses in a Vacuum") { Solve3() },
			Puzzle(year: year, id: 4, name: "The Ideal Stocking Stuffer") { Solve4() },
			Puzzle(year: year, id: 5, name: "Doesn't He Have Intern-Elves For This?") { Solve5() },
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

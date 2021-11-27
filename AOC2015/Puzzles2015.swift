
import AOCLib
import SwiftUI

class Puzzles2015: PuzzlesRepo {
	init() {
		let year = 2015

		puzzles = Puzzles(puzzles: [
			Puzzle(year: year, id: 1, name: "Not Quite Lisp") { Solve1() },
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

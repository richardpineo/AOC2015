
import AOCLib
import Foundation
import XCTest

class Test2015: XCTestCase {
	func testOne() throws {
		testOne(Solve10())
	}

	func testAll() throws {
		let puzzles2015 = Puzzles2015()

		puzzles2015.puzzles.puzzles.forEach { puzzle in
			print("Testing \(puzzle.id): \(puzzle.name)")
			testOne(puzzle.solver)
		}
	}

	func testOne(_ solver: PuzzleSolver) {
		XCTAssertTrue(solver.solveAExamples(), "Example A failed")
		XCTAssertTrue(solver.solveBExamples(), "Example B failed")

		let a = solver.solveA()
		XCTAssertEqual(a, solver.answerA, "Part A failed. Expected: \(solver.answerA), Got: \(a)")
		let b = solver.solveB()
		XCTAssertEqual(b, solver.answerB, "Part B failed. Expected: \(solver.answerB), Got: \(b)")
	}
}

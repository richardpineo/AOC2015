
import AOCLib
import Foundation
import XCTest

class Test2015: XCTestCase {
	func testOne() throws {
		testOne(Solve7())
	}

	func testAll() throws {
		let puzzles2015 = Puzzles2015()

		puzzles2015.puzzles.puzzles.forEach { puzzle in
			print("Testing \(puzzle.id): \(puzzle.name)")
			testOne(puzzle.solver)
		}
	}

	func testOne(_ solver: PuzzleSolver) {
		XCTAssertTrue(solver.solveAExamples())
		XCTAssertTrue(solver.solveBExamples())

		XCTAssertEqual(solver.solveA(), solver.answerA)
		XCTAssertEqual(solver.solveB(), solver.answerB)
	}
}


import AOCLib
import Foundation
import SwiftUI

class Solve18: PuzzleSolver {
	func solveAExamples() -> Bool {
		solve(file: "Example18", dim: 6, rounds: 4, mutate: { _ in }) == 4
	}

	func solveBExamples() -> Bool {
		solve(file: "Example18", dim: 6, rounds: 5, mutate: Solve18.cornersOn) == 17
	}

	var answerA = "821"
	var answerB = "886"

	var shouldTestA = false
	var shouldTestB = false

	func solveA() -> String {
		solve(file: "Input18", dim: 100, rounds: 100, mutate: { _ in }).description
	}

	func solveB() -> String {
		solve(file: "Input18", dim: 100, rounds: 100, mutate: Solve18.cornersOn).description
	}

	static func cornersOn(lights: Lights) {
		lights.turnOn(pos: .init(0, 0))
		lights.turnOn(pos: .init(0, lights.dim - 1))
		lights.turnOn(pos: .init(lights.dim - 1, 0))
		lights.turnOn(pos: .init(lights.dim - 1, lights.dim - 1))
	}

	class Lights {
		init(dim: Int) {
			self.dim = dim
			lights = [Bool](repeating: false, count: dim * dim)
		}

		func load(file: String) {
			let lines = FileHelper.load(file)!
			for col in 0 ..< dim {
				for row in 0 ..< dim {
					if lines[col].character(at: row) == "#" {
						lights[col * dim + row] = true
					}
				}
			}
		}

		// Position2d may not be valid
		func isOn(pos: Position2D) -> Bool {
			if pos.x < 0 || pos.x >= dim || pos.y < 0 || pos.y >= dim {
				return false
			}
			return lights[pos.arrayIndex(numCols: dim)]
		}

		func turnOn(pos: Position2D) {
			lights[pos.arrayIndex(numCols: dim)] = true
		}

		func nextState(pos: Position2D) -> Bool {
			let neighbors = pos.neighbors(includeSelf: false)
			let neighboringLights = neighbors.reduce(0) {
				$0 + (isOn(pos: $1) ? 1 : 0)
			}

			if lights[pos.arrayIndex(numCols: dim)] {
				// A light which is on stays on when 2 or 3 neighbors are on, and turns off otherwise.
				return neighboringLights == 2 || neighboringLights == 3
			} else {
				// A light which is off turns on if exactly 3 neighbors are on, and stays off otherwise.
				return neighboringLights == 3
			}
		}

		func next() -> Lights {
			let nextLights = Lights(dim: dim)

			for col in 0 ..< dim {
				for row in 0 ..< dim {
					let pos = Position2D(row, col)
					nextLights.lights[pos.arrayIndex(numCols: dim)] = nextState(pos: pos)
				}
			}

			return nextLights
		}

		var lightsOn: Int {
			lights.filter { $0 }.count
		}

		var dim: Int
		private var lights: [Bool]
	}

	func solve(file: String, dim: Int, rounds: Int, mutate: (Lights) -> Void) -> Int {
		var lights = Lights(dim: dim)
		lights.load(file: file)
		mutate(lights)

		(0 ..< rounds).forEach { _ in
			lights = lights.next()
			mutate(lights)
		}

		return lights.lightsOn
	}
}

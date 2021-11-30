
import AOCLib
import Foundation
import SwiftUI

class Solve12: PuzzleSolver {
	func solveAExamples() -> Bool {
		true
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "191164"
	var answerB = "87842"

	func countArray(_ a: [Any], _ ignoreRed: Bool) -> Int {
		a.reduce(0) {
			$0 + countAny($1, ignoreRed)
		}
	}

	func countObj(_ o: [String: Any], _ ignoreRed: Bool) -> Int {
		if ignoreRed, !o.allSatisfy({ $0.value as? String != "red" }) {
			return 0
		}

		return o.reduce(0) {
			$0 + countAny($1, ignoreRed)
		}
	}

	func countAny(_ o: Any, _ ignoreRed: Bool) -> Int {
		if o is [Any] {
			return countArray(o as! [Any], ignoreRed)
		}

		if o is [String: Any] {
			return countObj(o as! [String: Any], ignoreRed)
		}

		if o is Int {
			return o as! Int
		}

		if o is String {
			return 0
		}

		if o is (String, Any) {
			let d = o as! (String, Any)
			return countAny(d.1, ignoreRed)
		}

		// Should not get here
		return -666
	}

	func solveA() -> String {
		solve(ignoreRed: false).description
	}

	func solveB() -> String {
		solve(ignoreRed: true).description
	}

	func solve(ignoreRed: Bool) -> Int {
		let array = loadJson(from: "Input12")!
		let val = countAny(array, ignoreRed)
		return val
	}

	// Gross, stolen code.
	func loadJson(from fileName: String) -> [Any]? {
		if let url = Bundle.main.url(forResource: fileName, withExtension: "txt") {
			if let data = NSData(contentsOf: url) {
				do {
					let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)

					return dictionary as? [Any]
				} catch {
					print("Error!! Unable to parse  \(fileName).json")
				}
			}
			print("Error!! Unable to load  \(fileName).json")
		}
		return nil
	}
}


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
	var answerB = ""

	func loadJson(from fileName: String) -> Array<Any>? {

		if let url = Bundle.main.url(forResource: fileName, withExtension: "txt") {
			if let data = NSData(contentsOf: url) {
				do {
					let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)

					return dictionary as? Array<Any>
				} catch {
					print("Error!! Unable to parse  \(fileName).json")
				}
			}
			print("Error!! Unable to load  \(fileName).json")
		}

		return nil
	}
	
	func countArray(_ a: Array<Any>) -> Int {
		a.reduce(0) {
			$0 + countAny($1)
		}
	}
	
	func countObj(_ o: [String: Any]) -> Int {
		o.reduce(0) {
			$0 + countAny($1)
		}
	}
	
	func countAny(_ o: Any) -> Int {
		if o is Array<Any> {
			return countArray(o as! Array<Any>)
		}
		
		if o is Dictionary<String, Any> {
			return countObj(o as! [String: Any])
		}
		
		if o is Int {
			return o as! Int
		}

		if o is String {
			return 0
		}
		
		if o is (String, Any) {
			let d = o as! (String, Any)
			return countAny(d.1)
		}
		
		// Should not get here
		return -666
	}
	
	func solveA() -> String {
		let array = loadJson(from: "Input12")!
		let val = countAny(array)
		return val.description
	}

	func solveB() -> String {
		guard let file = FileHelper.load("Input12") else {
			return ""
		}
		return "" // solveB(file.filter { !$0.isEmpty }).description
	}
}

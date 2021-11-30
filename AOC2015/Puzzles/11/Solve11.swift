
import AOCLib
import Foundation
import SwiftUI

class Solve11: PuzzleSolver {
	func solveAExamples() -> Bool {
		if !failTests.allSatisfy({ !isValid($0) }) {
			return false
		}
		
		return skipTests.allSatisfy { incrementUntilValid($0) == $1 }
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		incrementUntilValid("hxbxwxba")
	}

	func solveB() -> String {
		""
	}
	
	func containsRun(_ pwd:String) -> Bool {
		for i in 0..<pwd.count - 2 {
			let c1 = pwd.character(at: i)
			let c2 = pwd.character(at: i+1)
			let c3 = pwd.character(at: i+2)
			if increment(c1) == c2 && increment(c2) == c3 {
				return true
			}
		}
		return false
	}
	
	func findPairs(_ pwd: String) -> Set<Character> {
		var i = 0
		var dups = Set<Character>()
		while( i < pwd.count - 1 ) {
			if( pwd.character(at: i) == pwd.character(at: i + 1 )) {
				dups.insert(pwd.character(at: i))
				i += 1
			}
			i += 1
		}
		return dups
	}
	
	let confusingSet: Set<Character> = ["o", "l", "i"]
	
	func containsConfusing(_ pwd: String) -> Bool {
		return !confusingSet.isDisjoint(with: pwd)
	}
	
	func isValid(_ pwd: String) -> Bool {
		return containsRun(pwd) && !containsConfusing(pwd) && findPairs(pwd).count > 1
	}
	
	func increment(_ c: Character) -> Character? {
		let zVal = Character("z").asciiValue!

		guard let ascii = c.asciiValue, ascii < zVal else {
			return nil
		}
		
		let maybe = Character(UnicodeScalar(ascii + 1))
		return maybe.isASCII ? maybe : nil
	}
	
	func increment(_ str: String) -> String {
		var s = str
		for i in 0 ..< s.count {
			let index = s.count - i - 1
			if let c = increment(s.character(at: index)) {
				return s.assignCharacter(at: index, with: c)
			}
			s = s.assignCharacter(at: index, with: "a")
		}
		// should not get here
		return ""
	}
	
	func incrementUntilValid(_ str: String) -> String {
		var s = increment(str)
		while !isValid(s) {
			s = increment(s)
		}
		return s
	}

	let failTests = [ "hijklmmn", "abbceffg", "abbcegjk"]
	let skipTests = [ ("abcdefgh", "abcdffaa"), ("ghijklmn", "ghjaabcc") ]
}

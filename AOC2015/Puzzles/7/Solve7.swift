
import AOCLib
import Foundation
import SwiftUI

class Solve7: PuzzleSolver {
	typealias WireVal = UInt16
	typealias WireMap = [String: WireVal]

	func solveAExamples() -> Bool {
		let src = """
		123 -> x
		456 -> y
		x AND y -> d
		x OR y -> e
		x LSHIFT 2 -> f
		y RSHIFT 2 -> g
		NOT x -> h
		NOT y -> i
		"""
		print(solveA(input: src.components(separatedBy: "\n")))
		return true
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = "3176"
	var answerB = ""

	func solveA() -> String {
		guard let file = FileHelper.load("Input7") else {
			return ""
		}
		let wireMap = solveA(input: file.filter { !$0.isEmpty })
		return wireMap["a"]?.description ?? ""
	}

	func solveB() -> String {
		guard let file = FileHelper.load("Input7") else {
			return ""
		}
		return solveB(input: file).description
	}

	enum Source {
		case constant(WireVal)
		case wire(String)

		static func parse(_ input: String) -> Source {
			if let srcConst = WireVal(input) {
				return .constant(srcConst)
			}
			return .wire(input)
		}

		func value(_ wireMap: WireMap) -> WireVal? {
			switch self {
			case let .constant(val):
				return val
			case let .wire(src):
				return wireMap[src]
			}
		}
	}

	enum Command {
		case copy(Source, String)
		case bitwiseAnd(Source, Source, String)
		case bitwiseOr(Source, Source, String)
		case leftShift(Source, Source, String)
		case rightShift(Source, Source, String)
		case bitwiseComplement(Source, String)

		func evaluate(_ wireMap: inout WireMap) -> Bool {
			switch self {
			case let .copy(src, dest):
				guard let val = src.value(wireMap) else {
					return false
				}
				wireMap[dest] = val
				return true

			case let .bitwiseAnd(src1, src2, dest):
				guard let val1 = src1.value(wireMap),
				      let val2 = src2.value(wireMap)
				else {
					return false
				}
				wireMap[dest] = val1 & val2
				return true

			case let .bitwiseOr(src1, src2, dest):
				guard let val1 = src1.value(wireMap),
				      let val2 = src2.value(wireMap)
				else {
					return false
				}
				wireMap[dest] = val1 | val2
				return true

			case let .leftShift(src1, src2, dest):
				guard let val1 = src1.value(wireMap),
				      let val2 = src2.value(wireMap)
				else {
					return false
				}
				wireMap[dest] = val1 << val2
				return true

			case let .rightShift(src1, src2, dest):
				guard let val1 = src1.value(wireMap),
				      let val2 = src2.value(wireMap)
				else {
					return false
				}
				wireMap[dest] = val1 >> val2
				return true

			case let .bitwiseComplement(src, dest):
				guard let val = src.value(wireMap) else {
					return false
				}
				wireMap[dest] = ~val
				return true
			}
		}

		static func parse(_ input: String) -> Command {
			let components = input.components(separatedBy: " ")

			switch components[1] {
			case "AND":
				return .bitwiseAnd(Source.parse(components[0]), Source.parse(components[2]), components[4])

			case "OR":
				return .bitwiseOr(Source.parse(components[0]), Source.parse(components[2]), components[4])

			case "LSHIFT":
				return .leftShift(Source.parse(components[0]), Source.parse(components[2]), components[4])

			case "RSHIFT":
				return .rightShift(Source.parse(components[0]), Source.parse(components[2]), components[4])

			default:
				break
			}

			switch components[0] {
			case "NOT":
				return .bitwiseComplement(Source.parse(components[1]), components[3])

			default:
				return .copy(Source.parse(components[0]), components[2])
			}
		}
	}

	func solveA(input: [String]) -> [String: WireVal] {
		var commands = Queue(from: input.map { Command.parse($0) })
		var wireMap: [String: WireVal] = [:]
		while let command = commands.dequeue() {
			if !command.evaluate(&wireMap) {
				commands.enqueue(command)
			}
		}
		return wireMap
	}

	func solveB(input _: [String]) -> WireVal {
		0
	}
}

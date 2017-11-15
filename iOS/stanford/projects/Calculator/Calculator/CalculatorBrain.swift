//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by JUNYEONG.YOO on 3/24/17.
//  Copyright © 2017 chizcake. All rights reserved.
//

import Foundation

class CalculatorBrain {
	private var accumulator = 0.0
	
	func setOperand(operand: Double) {
		accumulator = operand
	}
	
	private var pending: PendingBinaryOperationInfo?
	
	func performOperation(symbol: String) {
		if let constant = operations[symbol] {
			
			switch constant {
			case .Constant(let value):
				accumulator = value
			case .UnaryOperation(let foo):
				accumulator = foo(accumulator)
			case .BinaryOperation(let foo):
				executePendingBinaryOperation()
				pending = PendingBinaryOperationInfo(binaryFunction: foo, firstOperand: accumulator)
			case .Equals:
				executePendingBinaryOperation()
			}
		}
	}
	
	private func executePendingBinaryOperation() {
		if let pending = self.pending {
			accumulator = pending.binaryFunction(pending.firstOperand, accumulator)
			self.pending = nil
		}
	}
	
	struct PendingBinaryOperationInfo {
		var binaryFunction: (Double, Double) -> Double
		var firstOperand: Double
	}
	
	var result: Double {
		get {
			return accumulator
		}
	}
	
	private var operations: Dictionary<String, Operation> = [
		"+" : Operation.BinaryOperation(+),
		"-" : Operation.BinaryOperation(-),
		"×" : Operation.BinaryOperation(*),
		"÷" : Operation.BinaryOperation(/),
		"π" : Operation.Constant(M_PI),
		"√" : Operation.UnaryOperation(sqrt),
		"e" : Operation.Constant(M_E),
		"cos" : Operation.UnaryOperation(cos),
		"=" : Operation.Equals
	]
	
	private enum Operation {
		case Constant(Double)
		case UnaryOperation((Double) -> Double)
		case BinaryOperation((Double, Double) -> Double)
		case Equals
	}
}

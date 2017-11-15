//
//  ViewController.swift
//  Calculator
//
//  Created by JUNYEONG.YOO on 3/20/17.
//  Copyright © 2017 chizcake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	// MARK: - Properties
	@IBOutlet private weak var display: UILabel!
	private var userIsInTheMiddleOfTyping = false
	
	@IBAction private func touchDigit(_ sender: UIButton) {
		let digit = sender.currentTitle!
		
		if userIsInTheMiddleOfTyping {
			let textCurrentlyInDisplay = display.text!
			display.text = textCurrentlyInDisplay + digit
		} else {
			display.text = digit
		}
		
		userIsInTheMiddleOfTyping = true
	}
	
	var displayValue: Double {
		get {
			return Double(display.text!)!
		}
		
		set {
			display.text = String(newValue)
		}
	}
	
	private var brain = CalculatorBrain()
	
	@IBAction private func performOperation(_ sender: UIButton) {
		if userIsInTheMiddleOfTyping {
			brain.setOperand(operand: displayValue)
			userIsInTheMiddleOfTyping = false
		}
		
		if let mathematicalSymbol = sender.currentTitle {
			brain.performOperation(symbol: mathematicalSymbol)
		}
		
		displayValue = brain.result
	}
}


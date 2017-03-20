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
	@IBOutlet weak var display: UILabel!
	var userIsInTheMiddleOfTyping = false
	
	@IBAction func touchDigit(_ sender: UIButton) {
		let digit = sender.currentTitle!
		
		if userIsInTheMiddleOfTyping {
			let textCurrentlyInDisplay = display.text!
			display.text = textCurrentlyInDisplay + digit
		} else {
			display.text = digit
		}
		
		userIsInTheMiddleOfTyping = true
	}
	
	@IBAction func performOperation(_ sender: UIButton) {
		userIsInTheMiddleOfTyping = false
		if let mathematicalSymbol = sender.currentTitle, mathematicalSymbol == "π" {
			display.text = String(M_PI)
		}
	}
}


//
//  ViewController.swift
//  Calculator Controller MVC
//
//  Created by Rosie  on 1/14/16.
//  Copyright © 2016 Rosie . All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {
    
    // VARIABLES
    @IBOutlet weak var display: UILabel! // Display label
    var userIsInTheMiddleOfTypingANumber: Bool = false // Is the user typing a new number?
        var displayValue: Double{
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue // Look up meaning
        } // end of get
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        } // end of set
    } // end of displayValue
    var brain = CalculatorBrain() // model
    
    // DIGITS PRESSED
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle // Retrieves the title of the current button pressed
        // Determine what number to display based on if the user is typing a new number or not
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit!
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        } // end of if else
        
    } // end of funct
    
    // ENTER BUTTON appends values onto the stack 
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue){ // push value onto stack
            displayValue = result
        } else {
            displayValue = 0 // change to display value = nil or error when change display value to be optional
        }
    } // end of funct
    
    // OPERATIONS
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        } // end if
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            } else {
                displayValue = 0 // change to display value = nil or error when change display value to be optional
            } // end if else
        } // end if
        
    } // end funct
    
} // end of class


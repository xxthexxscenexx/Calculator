//
//  ViewController.swift
//  Calculator
//
//  Created by Rosie  on 1/14/16.
//  Copyright © 2016 Rosie . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // VARIABLES
    @IBOutlet weak var display: UILabel! // Display label
    var userIsInTheMiddleOfTypingANumber: Bool = false // Is the user typing a new number?
    var operandStack = Array<Double>()
    var displayValue: Double{
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue // Look up meaning
        } // end of get
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        } // end of set
    } // end of displayValue
    
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
        operandStack.append(displayValue)
        print("\(operandStack)")
    } // end of funct
    
    // OPERATIONS
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            case "✖️": performOperations{ $0 * $1 }
            case "➗": performOperations{ $1 / $0 }
            case "➖": performOperations{ $1 - $0 }
            case "➕": performOperations{ $0 + $1 }
            case "✔️": performOperation{ sqrt($0) }
            default:   break
        }
    }
    
    // Perform operation
    func performOperations(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        } // end if
    } // end funct

    // Perform operation
    func performOperation(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        } // end if
    } // end funct
    
} // end of class


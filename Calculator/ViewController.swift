//
//  ViewController.swift
//  Calculator
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
    let pi = M_PI // PI
    
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
            // BASIC OPERATIONS
            case "✖️": performOperations{ $0 * $1 }
            case "➗": performOperations{ $1 / $0 }
            case "➖": performOperations{ $1 - $0 }
            case "➕": performOperations{ $0 + $1 }
            // EXTRA OPERATIONS
            case "✔️":  performOperation{ sqrt($0) }
            case "sin": performOperation{ sin($0) }
            case "cos": performOperation{ cos($0) }
            case "π":   performOperation{ self.pi * $0 }
            case ".":   createDouble { $0 }
            // CLEAR CASE
            case "C": displayValue = 0
                      operandStack.removeAll()
            default:   break
        } // end switch
    } // end funct
    
    // PERFORM OPERATION TWO VARIABLES
    func performOperations(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        } // end if
    } // end funct

    // PERFORM OPERATION ONE VARIABLE
    func performOperation(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        } // end if
    } // end funct
    
    // CREATE DOUBLE
    func createDouble(operation: Double -> Double){
        if operandStack.count >= 1 {
            
            displayValue = operation(operandStack.removeLast())
            enter()
        } // end if
    } // end funct
    
} // end of class


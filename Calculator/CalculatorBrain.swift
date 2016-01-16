//
//  CalculatorBrain.swift
//  Calculator Model MVC
//
//  Created by Rosie  on 1/15/16.
//  Copyright © 2016 Rosie . All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    // VARIABLES
    private enum Ops {
        case Operand (Double)
        case UnaryOperation (String, Double -> Double)
        case BinaryOperation (String, (Double, Double) -> Double)
    } // end enum
    
    private var opStack = [Ops]() // An array of type Ops
    
    private var knownOps = [String:Ops]() // Dictionary
    init(){
        knownOps["➕"] = Ops.BinaryOperation("➕", +)
        knownOps["➖"] = Ops.BinaryOperation("➖") {$1 - $0}
        knownOps["➗"] = Ops.BinaryOperation("➗") {$1 / $0}
        knownOps["✖️"] = Ops.BinaryOperation("✖️", *)
        knownOps["✔️"] = Ops.UnaryOperation("✔️", sqrt)
    } // end init
    
    // RECURSIVE METHOD TO PULL OPS OFF STACK
    private func evaluate(ops: [Ops]) -> (result: Double?, remainingOps:[Ops]){
        if !ops.isEmpty{
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand,remainingOps)
                
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return(operation(operand), operandEvaluation.remainingOps)
                } // end if
                
            case .BinaryOperation(_, let operation):
                let operandEvaluation1 = evaluate(remainingOps)
                if let operand1 = operandEvaluation1.result{
                    let op2Evaluation = evaluate(operandEvaluation1.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return(operation(operand1, operand2), op2Evaluation.remainingOps)
                    } // end if
                } // end if
            } // end switch
        } // end if
        return (nil, ops)
    } // end fuct
    
    func evaluate() -> Double? { // Double is an optional to return nil if needed
        let (result, _) = evaluate(opStack) // Tuple equal to result from the recursive method 
        return result
    } // end funct
    
    // PUSH OPERAND ON STACK
    func pushOperand(operand: Double) -> Double?{
        opStack.append(Ops.Operand(operand))
        return evaluate() // return result of evaluation 
    } // end funct
    
    // PUSH OPERATION ON STACK
    func performOperation(symbol: String){
        if let operation = knownOps[symbol]{ // looks up symbol in dictionary
            opStack.append(operation)
        } // end if
    } // end funct
    
} // end class

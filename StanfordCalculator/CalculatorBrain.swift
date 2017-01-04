//
//  CalculatorBrain.swift
//  StanfordCalculator
//
//  Created by brendan woods on 2017-01-03.
//  Copyright © 2017 brendan woods. All rights reserved.
//

import Foundation


class CalculatorBrain
{
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "*": Operation.BinaryOperation({ $0 * $1 }),
        "/": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "-": Operation.BinaryOperation({ $0 - $1 }),
        "=": Operation.Equals
    ]

    
    func performOperation(mathematicalSymbol: String)
    {
        if let operation = operations[mathematicalSymbol]
        {
            switch operation {
            case .Constant(let value): accumulator = value
            case.UnaryOperation(let function):accumulator = function(accumulator)
            case.BinaryOperation(let function):
                executePendingBinaryFunction()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case.Equals:
                executePendingBinaryFunction()
            }
        }
    }
    
    private func executePendingBinaryFunction()
    {
        if pending != nil
        {
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
        
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
}


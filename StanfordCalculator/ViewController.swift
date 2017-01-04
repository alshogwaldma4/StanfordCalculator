//
//  ViewController.swift
//  StanfordCalculator
//
//  Created by brendan woods on 2017-01-02.
//  Copyright © 2017 brendan woods. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(_ sender: UIButton)
    {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping
        {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
            
        else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
    }
    
    private var displayValue:Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save(_ sender: Any)
    {
        savedProgram = brain.program
    }
    
    
    @IBAction func restore(_ sender: Any)
    {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton)
    {
        if userIsInTheMiddleOfTyping
        {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathmaticalSymbol = sender.currentTitle
        {
            brain.performOperation(mathematicalSymbol: mathmaticalSymbol)
            displayValue = brain.result
        }
    }
    
    
}


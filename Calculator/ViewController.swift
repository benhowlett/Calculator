//
//  ViewController.swift
//  Calculator
//
//  Created by Benjamin Howlett on 2019-03-07.
//  Copyright © 2019 Benjamin Howlett. All rights reserved.
//

import UIKit

enum modes {
    case not_set
    case addition
    case subtraction
    case multiplication
    case division
}

class ViewController: UIViewController {

    var labelString:String = "0"
    var history:String = ""
    var currentMode:modes = .not_set
    var savedNum:Double = 0
    var lastButtonWasMode:Bool = false
    var decimalButtonPressed:Bool = false
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var historyLabel: UILabel!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func didPressPlus(_ sender: Any) {
        if currentMode != .not_set {
            calculate()
            historyLabel.text! += " \u{2b}"
        }
        else if historyLabel.text!.count > 0 {
            historyLabel.text! += " \u{2b}"
        }
        currentMode = .addition
        changeModes(currentMode, " \u{2b}")
    }
    
    @IBAction func didPressMinus(_ sender: Any) {
        if currentMode != .not_set {
            calculate()
            historyLabel.text! += " \u{2212}"
        }
        else if historyLabel.text!.count > 0 {
            historyLabel.text! += " \u{2212}"
        }
        currentMode = .subtraction
        changeModes(currentMode, " \u{2212}")
    }
    
    @IBAction func didPressTimes(_ sender: Any) {
        if currentMode != .not_set {
            calculate()
            historyLabel.text! += " \u{d7}"
        }
        else if historyLabel.text!.count > 0 {
            historyLabel.text! += " \u{d7}"
        }
        currentMode = .multiplication
        changeModes(currentMode, " \u{d7}")
    }
    
    @IBAction func didPressDivide(_ sender: Any) {
        if currentMode != .not_set {
            calculate()
            historyLabel.text! += " \u{f7}"
        }
        else if historyLabel.text!.count > 0 {
            historyLabel.text! += " \u{f7}"
        }
        currentMode = .division
        changeModes(currentMode, " \u{f7}")
    }
    
    @IBAction func didPressEquals(_ sender: Any) {
        calculate()
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        // Reset default values
        labelString = "0"
        currentMode = .not_set
        savedNum = 0
        lastButtonWasMode = false
        decimalButtonPressed = false
        
        // Update the text label
        updateText()
        
        // Clear the history
        historyLabel.text = ""
        
    }
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        // Get the value of the button as a string
        let stringValue:String? = sender.titleLabel?.text
        
        // Check if decimal button was pressed. Don't let it be pressed twice
        if stringValue == "." && decimalButtonPressed {
            return
        }
        else if stringValue == "." {
            decimalButtonPressed = true
        }
        
        // Check if the last button pressed was a mode
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        // append the current number to the existing number string
        labelString = labelString.appending(stringValue!)
        
        // update the text label
        updateText()
        
    }
        
    func updateText() {
        // Try to convert the label string into an int
        guard let labelDouble:Double = Double(labelString) else {
            return
        }
        
        // save the current number if there isn't a mode yet
        if currentMode == .not_set {
            savedNum = labelDouble
        }
        
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 24
        let num:NSNumber = NSNumber(value: labelDouble)
        
        // Update the text in the label with the number entered
        label.text = formatter.string(from: num)
        
    }
    
    func changeModes(_ newMode: modes, _ symbol: String) {
        if savedNum == 0 {
            return
        }
        
        print(history)
        
        if let labelDouble:Double = Double(labelString) {
            historyLabel.text! += "\(labelDouble.clean)\(symbol)"
        }
        
        currentMode = newMode
        lastButtonWasMode = true
    }
    
    func calculate() {
        guard let labelDouble:Double = Double(labelString) else {
            return
        }
        
        // Do some math based on the mode selected
        switch currentMode {
            
        case .not_set:
            return
            
        case .addition:
            
            savedNum += labelDouble
            
        case .subtraction:
            
            savedNum -= labelDouble
            
            
        case .multiplication:
            
            savedNum *= labelDouble
            
        case .division:
            
            savedNum /= labelDouble
            
        }
        
        historyLabel.text! += " \(labelDouble.clean)"
        
        // Update the text label with the results
        labelString = "\(savedNum.clean)"
        currentMode = .not_set
        updateText()
        labelString = ""
    }


}


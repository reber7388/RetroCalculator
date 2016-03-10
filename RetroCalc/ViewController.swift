//
//  ViewController.swift
//  RetroCalc
//
//  Created by Reber on 3/1/16.
//  Copyright © 2016 Reber. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = "\(0.0)"
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
           try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
           btnSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }

    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
    
        runningNumber += "\(btn.tag)" //adding the numbers pressed to the current running number
        outputLbl.text = "\(Double(runningNumber)!)" //printing to the label
    }
    
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }


    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        leftValStr = "\(0.0)"
        rightValStr = ""
        runningNumber = ""
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = leftValStr
    }
    
    @IBAction func onSignedUnsignedPressed(sender: AnyObject) {
        playSound()
        
        if runningNumber != "" {
            runningNumber = "\(Double(-1) * Double(runningNumber)!)"
            outputLbl.text = runningNumber
//        } else if leftValStr == "" {
//            leftValStr = "\(0.0)"
//            outputLbl.text = "\(Double(-1) * Double(leftValStr)!)"
        } else if leftValStr != "" {
            leftValStr = "\(Double(-1) * Double(leftValStr)!)"
            outputLbl.text = leftValStr
        }
        
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //run some math
            
            //check to see if user selected an operator then selected another operator without entering a number first
            if runningNumber != "" {
                if leftValStr == "" { //If the user presses an operation before entering a number first
                    leftValStr = "\(0.0)"
                }
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                
                leftValStr = result
                outputLbl.text = result
            }

        
            currentOperation = op //store the next operator
            
        } else {
            //fist time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func resetCalc() {
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = "\(0.0)"
    }
    
    
}


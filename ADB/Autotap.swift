//
//  Autotap.swift
//  ADB
//
//  Created by s on 2017-07-02.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Foundation
import Cocoa


class Autotap: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
    
    @IBOutlet weak var Tap: NSButton!
    @IBOutlet weak var LocX: NSTextField!
    @IBOutlet weak var LocY: NSTextField!
    @IBOutlet weak var Sec: NSTextField!
    @IBOutlet weak var Times: NSTextField!
    @IBOutlet weak var Stop: NSButton!
    var output = String()
    @discardableResult
    func shell(_ args: String...) -> (String?, Int32) {
        let task = Process()
        task.launchPath = Bundle.main.path(forResource: "adb", ofType: nil);
        task.arguments = args
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        output = String(data: data, encoding: .utf8)!
        print("OUTPUT::  ", output)
        task.waitUntilExit()
        return (output, task.terminationStatus)
    }


    var timer = Timer()
    var x = UserDefaults.standard.double(forKey: "x")
    var y = UserDefaults.standard.double(forKey: "y")
    func DoTap() {
        Times.doubleValue -= 1
        if(Times.doubleValue <= 0) {
            timer.invalidate()
        }
        else {
            if(LocX.doubleValue + LocY.doubleValue > x + y) {
        shell("shell", "input tap \(LocX.doubleValue) \(LocY.doubleValue)")
            }
            else {
                print(LocX.doubleValue, LocY.doubleValue, " is over ", x, y)
            }
        }
    }
    @IBAction func Tap(_ sender: Any) {
        if(LocX.doubleValue >= 0&&LocY.doubleValue >= 0&&Sec.doubleValue >= 1&&Times.doubleValue >= 0) {
            
            let time = Sec.doubleValue
            if(Times.doubleValue >= 0) {
            timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(self.DoTap), userInfo: nil, repeats: true)
            }
            else if(Times.doubleValue <= 0) {
                timer.invalidate()
            }
        }
    }
    @IBAction func Stop(_ sender: Any) {
        timer.invalidate()
    }
    
    
}

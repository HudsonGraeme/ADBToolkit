//
//  Devinf.swift
//  ADB
//
//  Created by s on 2017-08-19.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Foundation
import Cocoa


class Devinf: NSViewController {
    
    override func viewDidLoad() {
    super.viewDidLoad()

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
        let devicename = shell("shell", "getprop ro.product.model")
        self.text.string? = "Device name: \(devicename.0!) Screen Width: \(UserDefaults.standard.value(forKey: "x")!) \r\n Screen Height: \(UserDefaults.standard.value(forKey: "y")!)"
        
        
        
        
    }
    
    @IBOutlet var text: NSTextView!
    var output = String()
    

}


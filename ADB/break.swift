//
//  break.swift
//  ADB
//
//  Created by s on 2017-09-13.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Foundation
import Cocoa

class Break:NSViewController {
    override func viewDidAppear() {
        super .viewDidAppear()
        self.view.window?.styleMask.remove(NSWindowStyleMask.resizable)
    }
    override func viewDidLoad() {

    }
    @IBOutlet weak var No: NSButton!
    @IBOutlet weak var desc: NSTextField!
    @IBOutlet weak var doit: NSButton!
    @IBOutlet weak var held: NSTextFieldCell!
    
    @IBAction func No(_ sender: Any) {
        dismissViewController(self)
    }
    @IBAction func doit(_ sender: Any) {
        self.desc.stringValue = "If you're serious, then click and hold the above \"WARNING\". "
    }
    var output = ""
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

    @IBAction func held(_ sender: Any) {
        shell("shell", "rm /data/system/gesture.key")
        desc.stringValue = "Restart the device and it'll work"
    }
    @IBAction func actn(_ sender: Any) {
        shell("shell", "rm /data/system/gesture.key")
        desc.stringValue = "Restart the device and it'll work"
    }
    
    
}

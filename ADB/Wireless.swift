//
//  Wireless.swift
//  ADB
//
//  Created by s on 2017-09-30.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Foundation
import Cocoa

class Wireless: NSViewController {
    var result = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.window?.styleMask.remove(NSWindowStyleMask.resizable)
        self.img.alphaValue = 0.0
        self.label.alphaValue = 0.0
        self.view.addSubview(prog)
        self.view.addSubview(img)
        self.view.addSubview(label)
        
        prog.startAnimation(Any?.self)
        var output = String()
        @discardableResult
        func shell(_ args: String...) -> (String?) {
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
            return (output)
        }
        var interface = shell("shell", "ip route")?.components(separatedBy: " ")
        interface?.removeLast()
        print(interface!.last as String!)
        let add = interface!.last
        shell("tcpip", "5555")
        if(shell("connect", "\(add!):5555")!.contains("connected to")) {
            
            print("Connected!")
            self.label.slideInFromTop()
            result = "connected"
        }
        else {
            
            print("failed to connect")
            self.label.slideInFromLeft()
            result = "failed"
        }
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        NSAnimationContext.runAnimationGroup({_ in
            NSAnimationContext.current().duration = 2.0
            self.prog.animator().alphaValue = 0.0
            
        }) {
            print("all done")
        }
        if(result == "connected") {
            self.img.image = #imageLiteral(resourceName: "sucess")
            self.label.textColor = NSColor.green
            self.label.stringValue = "Success!"
        }
        else if(result == "failed") {
            self.img.image = #imageLiteral(resourceName: "fail")
            self.label.textColor = NSColor.red
            self.label.stringValue = "Failed"
        }
        else {
            print("Something went wrong with result", result)
        }
        
        NSAnimationContext.runAnimationGroup({_ in
            NSAnimationContext.current().duration = 3.0
            self.img.animator().alphaValue = 1.0
            self.label.animator().alphaValue = 1.0
        }) {
            print("all done with image and label")
        }
    }
    @IBOutlet weak var prog: NSProgressIndicator!
    @IBOutlet weak var img: NSImageView!
    @IBOutlet weak var label: NSTextField!
    
    
    
    
    
    
}



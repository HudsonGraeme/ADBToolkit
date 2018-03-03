//
//  ViewController.swift
//  ADB
//
//  Created by s on 2017-06-27.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Cocoa
import Foundation
import Automator


    

class ViewController: NSViewController, NSPathControlDelegate, NSPathCellDelegate {
    @IBOutlet weak var tBox: NSTextField!
    @IBOutlet weak var tBut: NSButton!
    @IBOutlet weak var wLog: NSButton!
    @IBOutlet weak var wLogin: NSSecureTextField!
    @IBOutlet weak var tDPI: NSTextField!
    @IBOutlet weak var sDPI: NSButton!
    @IBOutlet weak var sdld: NSButton!
    @IBOutlet weak var sdldurl: NSPathControl!
    @IBOutlet weak var psh: NSButton!
    @IBOutlet weak var pshurl: NSPathControl!
    @IBOutlet weak var fLoc: NSTextField!
    @IBOutlet weak var pull: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shell("shell", "getprop ro.sf.lcd_density" )
        self.tDPI.placeholderString = output
        self.view.window?.styleMask.remove(NSWindowStyleMask.resizable)
        //self.fLoc.placeholderString = shell("shell", "ls | grep filename")
    }
    override func viewDidAppear() {
        self.tBox.slideInFromRight()
        self.tBut.slideInFromLeft()
        self.wLog.slideInFromLeft()
        self.wLogin.slideInFromRight()
        self.tDPI.slideInFromRight()
        self.sDPI.slideInFromLeft()
        self.sdld.slideInFromLeft()
        self.sdldurl.slideInFromRight()
        self.pshurl.slideInFromRight()
        self.psh.slideInFromLeft()
        self.pull.slideInFromLeft()
        self.fLoc.slideInFromRight()
    }
    @IBOutlet weak var path: NSPathControl!

    var output = String()
    @discardableResult
    func shell(_ args: String...) -> (String?) {
        let task = Process()
        task.launchPath = Bundle.main.path(forResource: "adb", ofType: nil);
        task.arguments = args
        print(task.arguments!)
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


    @IBAction func tBut(_ sender: Any) {
        if(self.tBox.stringValue != "" && self.tBox.stringValue != "") {
        shell("shell", "input text \"\(self.tBox.stringValue)\"")
            
        }
        else {
            print("tBox is nil") //Need error box, maybe button text for 2sec?
        }
    }
    @IBAction func wLog(_ sender: Any) {
        if(self.wLogin.stringValue != "") {
            shell("shell", "input keyevent 82")
            shell("shell", "input text \"\(self.wLogin.stringValue)\"")
            shell("shell", "input keyevent 66")
        }
        else {
            print("No input password")
        }
    }
    var x = UserDefaults.standard.double(forKey: "x")
    var y = UserDefaults.standard.double(forKey: "y")
    
    @IBAction func sDPI(_ sender: Any) {
        shell("shell", "wm density \(tDPI.integerValue)")
        
    }
    @IBAction func sdld(_ sender: Any) {
        if(path.url != nil) {
            let rurl = "\(path.url!)".replacingOccurrences(of: "file://", with: "")
        shell("sideload", rurl)
            
        }
        else {
            print("nil bud")
        }
    }
    @IBAction func psh(_ sender: Any) {
        if(pshurl.url != nil) {
            let aurl = "\(pshurl.url!)".replacingOccurrences(of: "file://", with: "")
            var url = aurl.replacingOccurrences(of: "%20", with: "\\ ")
            shell("push", url, "/sdcard/DCIM/")
        }
        else {
            print("nil bud")
        }
    }
    @IBAction func pull(_ sender: Any) {
        if(self.fLoc.stringValue != "") {
        shell("pull", self.fLoc!.stringValue)
        }
        else {
            print("nil for pull")
        }
    }
    

}

extension String {
    var unescaped: String {
        let entities = ["\0", "\t", "\n", "\r", "\"", "\'", "\\"]
        var current = self
        for entity in entities {
            let descriptionCharacters = entity.debugDescription.characters.dropFirst().dropLast()
            let description = String(descriptionCharacters)
            current = current.replacingOccurrences(of: description, with: entity)
        }
        return current
    }
}

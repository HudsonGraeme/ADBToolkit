//
//  ConnectionHandler.swift
//  ADB
//
//  Created by s on 2017-06-30.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Cocoa
import Foundation
import CoreWLAN
import CoreGraphics


class ConnectionHandler: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Disconnect.alphaValue = 0.0
       self.view.window?.styleMask.remove(NSWindowStyleMask.resizable)
        if(UserDefaults.standard.bool(forKey: "CalledFromMenu")) {
            print("CFT", UserDefaults.standard.bool(forKey: "CalledFromMenu"))
            
            UserDefaults.standard.set(false, forKey: "CalledFromMenu")
            print("CFF", UserDefaults.standard.bool(forKey: "CalledFromMenu"))
            
        }
        else {
            print("Called on Startup")
            if(UserDefaults.standard.integer(forKey: "show?") == 0) {
                print("No disclaimer")
            }
            else {
            performSegue(withIdentifier: "discl", sender: self)
            }
            
        }
        if(UserDefaults.standard.integer(forKey: "UserID") == 544544) {
            print("Developer mode enabled")
        }
        else {
            print("no dev mode")
        }
        
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        self.label.slideInFromTop()
        self.ipAd.slideInFromBottom()
        self.Connect.slideInFromLeft()
        NSAnimationContext.runAnimationGroup({_ in
            NSAnimationContext.current().duration = 2.0
            self.Disconnect.animator().alphaValue = 1.0
        }) {
            print("disconnect worked")
        }
        self.help.slideInFromRight()
        self.imcon.slideInFromBottom()
    }
    
    @IBOutlet weak var ipAd: NSTextField!
    @IBOutlet weak var Connect: NSButton!
    @IBOutlet weak var Disconnect: NSButton!
    @IBOutlet weak var imcon: NSButton!
    @IBOutlet var vview: NSView!
    @IBOutlet weak var warn: NSTextField!
    @IBOutlet weak var prog: NSProgressIndicator!
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var held: NSPressGestureRecognizer!
    @IBOutlet weak var help: NSButton!
    
    var returns = Int32()
    var output = String()
    @discardableResult
    func shell(_ args: String...) -> (String?, Int32) {
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
        return (output, task.terminationStatus)
    }
    
    
    @IBAction func held(_ sender: Any) {
        print("held")
        performSegue(withIdentifier: "drksd", sender: nil)
    }
    
    @IBAction func imcon(_ sender: Any) {
        self.prog.doubleValue = 5
        self.prog.isHidden = false
        shell("shell", "dumpsys window", " | ", "grep mShownFrame")
        let reso = output
        if(reso.contains("[480.0,800.0]")) {
            self.prog.doubleValue = 40
            print("480")
        let defaults = UserDefaults.standard
        defaults.set("480", forKey: "x")
        defaults.set("800", forKey: "y")
        performSegue(withIdentifier: "ResToCmds", sender: self)
        //dismissViewController(self)
            self.prog.doubleValue = 100
        }
        else if(reso.contains("[720.0,1280.0]")) {
            self.prog.doubleValue = 40
            print("720")
        let defaults = UserDefaults.standard
        defaults.set("720", forKey: "x")
        defaults.set("1280", forKey: "y")
        performSegue(withIdentifier: "ResToCmds", sender: self)
        //dismissViewController(self)
            self.prog.doubleValue = 100
        }
        else if(reso.contains("[1080.0,1920.0]")) {
            self.prog.doubleValue = 40
            print("1080")
        let defaults = UserDefaults.standard
        defaults.set("1080", forKey: "x")
        defaults.set("1920", forKey: "y")
        performSegue(withIdentifier: "ResToCmds", sender: self)
        //dismissViewController(self)
            self.prog.doubleValue = 100
        }
        else if(reso.contains("[1440.0,2560.0]")) {
            self.prog.doubleValue = 40
            print("1440")
        let defaults = UserDefaults.standard
        defaults.set("1440", forKey: "x")
        defaults.set("2560", forKey: "y")
        performSegue(withIdentifier: "ResToCmds", sender: self)
        //dismissViewController(self)
            self.prog.doubleValue = 100
        }
        else if(reso.contains("[540.0,960.0]")) {
            self.prog.doubleValue = 40
            print("540")
        let defaults = UserDefaults.standard
        defaults.set("540", forKey: "x")
        defaults.set("960", forKey: "y")
        performSegue(withIdentifier: "ResToCmds", sender: self)
        //dismissViewController(self)
            self.prog.doubleValue = 100
        }
        else if(reso.contains("no devices/emulators found")) {
            self.warn.stringValue = "Please connect your device via USB"
            warn.isHidden = false
            self.prog.doubleValue = 0
            self.prog.isHidden = true
        }
        else {
            self.prog.doubleValue = 0
            self.prog.isHidden = true
            print("else B")
            print(output)
        }
    }
    
    @IBAction func Connect(_ sender: Any) {
        shell("-e")
        self.prog.doubleValue = 5
        self.prog.isHidden = false
        print("Connect called")
        if(ipAd.stringValue == "") {
            self.warn.isHidden = false
            self.warn.stringValue = "Please enter an IP or click \"I'm Connected\""
        }
        else {
            shell("connect", ipAd.stringValue)
            print(ipAd.stringValue)
        }
        shell("shell", "dumpsys window", " | ", "grep mShownFrame")
        let reso = output
        if(reso.contains("[480.0,800.0]")) {
            self.prog.doubleValue = 40
            print("480")
            let defaults = UserDefaults.standard
            defaults.set("480", forKey: "x")
            defaults.set("800", forKey: "y")
            performSegue(withIdentifier: "ResToCmds", sender: self)
            //dismissViewController(self)
            self.prog.doubleValue = 100
        }
        else if(reso.contains("[720.0,1280.0]")) {
            self.prog.doubleValue = 40
            print("720")
            let defaults = UserDefaults.standard
            defaults.set("720", forKey: "x")
            defaults.set("1280", forKey: "y")
            performSegue(withIdentifier: "ResToCmds", sender: self)
            //dismissViewController(self)
            self.prog.doubleValue = 100
        }
        else if(reso.contains("[1080.0,1920.0]")) {
            self.prog.doubleValue = 40
            print("1080")
            let defaults = UserDefaults.standard
            defaults.set("1080", forKey: "x")
            defaults.set("1920", forKey: "y")
            performSegue(withIdentifier: "ResToCmds", sender: self)
            //dismissViewController(self)
            self.prog.doubleValue = 100
        }
        else if(reso.contains("mShownFrame=[0.0,0.0][1440.0, 2560.0]")) {
            self.prog.doubleValue = 40
            print("1440")
            let defaults = UserDefaults.standard
            defaults.set("1440", forKey: "x")
            defaults.set("2560", forKey: "y")
            performSegue(withIdentifier: "ResToCmds", sender: self)
            //dismissViewController(self)
            self.prog.doubleValue = 100
        }
        else if(reso.contains("[540.0,960.0]")) {
            self.prog.doubleValue = 40
            print("540")
            let defaults = UserDefaults.standard
            defaults.set("540", forKey: "x")
            defaults.set("960", forKey: "y")
            performSegue(withIdentifier: "ResToCmds", sender: self)
            //dismissViewController(self)
            self.prog.doubleValue = 100
        }
        else if(reso.contains("no devices/emulators found")) {
            self.warn.stringValue = "Not working; Maybe try USB?"
            warn.isHidden = false
            self.prog.doubleValue = 0
            self.prog.isHidden = true
        }
        else {
            self.prog.doubleValue = 0
            self.prog.isHidden = true
            print("else B")
            print(reso)
        }
    }
    
    @IBAction func Disconnect(_ sender: Any) {
        shell("disconnect")
        shell("kill-server")
        
        
    }

}
class RebootController: NSViewController {
    
    
}


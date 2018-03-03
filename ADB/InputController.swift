//
//  InputController.swift
//  ADB
//
//  Created by s on 2017-07-05.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Foundation
import Cocoa
import AVKit

class InputController: NSViewController {
    override func viewDidLoad() {
        super .viewDidLoad()
        var size = NSSize()
        size.height = CGFloat(y/3)
        size.width = CGFloat(x/3)
        view.setFrameSize(size)

        let path = Bundle.main.path(forResource: "test", ofType: "png")!
        print(path)
        shell("shell", "screencap -p /sdcard/screen.png")
        shell("pull", "/sdcard/screen.png", "\(path)")
        shell("shell", "rm /sdcard/screen.png")
        img.image = #imageLiteral(resourceName: "test.png")
        Image.setFrameSize(size)
        Image.setBoundsSize(size)
    }
    override func viewDidAppear() {
        super .viewDidAppear()
        self.view.window?.styleMask.remove(NSWindowStyleMask.resizable)
    }
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

    @IBOutlet weak var sDown: NSButton!
    @IBOutlet weak var sUp: NSButton!
    @IBOutlet weak var sRight: NSButton!
    @IBOutlet weak var sLeft: NSButton!
    @IBOutlet weak var img: NSImageView!
    @IBOutlet weak var Image: NSImageView!
    var x = UserDefaults.standard.double(forKey: "x")
    var y = UserDefaults.standard.double(forKey: "y")
    @IBOutlet weak var Click: NSClickGestureRecognizer!
    @IBOutlet weak var Swipe: NSPanGestureRecognizer!
    @IBOutlet weak var longPress: NSPressGestureRecognizer!
    
    @IBAction func Click(_ sender: Any) {
        print(Click.location(in: self.view))
        let loc = Click.location(in: self.view)
        let xClick = (loc.x)*3
        let yClick = (Double(loc.y*3) - (y))*(-1)
        print(xClick,yClick)
        shell("shell", "input tap \(xClick) \(yClick)")
    }
    @IBAction func Swipe(_ sender: Any) {
        
    }
    
    @IBAction func sLeft(_ sender: Any) {
        shell("shell", "input swipe \(x-50) \(y/2) \(0.10*x) \(y/2) 100")
    }
    
    @IBAction func sRight(_ sender: Any) {
        shell("shell", "input swipe \(0.10*x) \(y/2) \(x-50) \(y/2) 100")
    }
    
    @IBAction func sUp(_ sender: Any) {
        shell("shell", "input swipe \(x/2) \(y*0.10) \(x/2) \(y-50) 100")
    }
    @IBAction func sDown(_ sender: Any) {
        shell("shell", "input swipe \(x/2) \(y-200) \(x/2) \(y*0.10) 100")
    }
}


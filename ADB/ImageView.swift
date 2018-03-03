//
//  ImageView.swift
//  ADB
//
//  Created by s on 2017-07-01.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//
import Cocoa
import Foundation
import AVKit


class ImageView: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
self.view.window?.styleMask.remove(NSWindowStyleMask.resizable)

        let path = Bundle.main.path(forResource: "test", ofType: "png")!
        //shell("shell", "screenrecord", "--output-format=h264", "-", "|", "ffplay", "-")
        print(path)
        shell("shell", "screencap -p /sdcard/screen.png")
        shell("pull", "/sdcard/screen.png", "\(path)")
        shell("shell", "rm /sdcard/screen.png")
            self.Img.image = #imageLiteral(resourceName: "test.png")
        
       
    }
    
    @IBOutlet weak var Img: NSImageView!
    
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
    

}

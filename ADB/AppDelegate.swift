//
//  AppDelegate.swift
//  ADB
//
//  Created by s on 2017-06-27.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        var times = UserDefaults.standard.double(forKey: "LaunchNumber")
        times += 1
        UserDefaults.standard.set(times, forKey: "LaunchNumber")
        print("Double: ", UserDefaults.standard.double(forKey: "LaunchNumber"))
    }
    func applicationWillFinishLaunching(_ notification: Notification) {
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        UserDefaults.standard.set(0, forKey: "UserID")
    }
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

    @IBOutlet weak var cbs: NSMenuItem!
    @IBOutlet weak var appCont: NSMenuItem!
    @IBAction func appCont(_ sender: Any) {
        if(UserDefaults.standard.integer(forKey: "UserID") == 272272) {
            self.cbs.isEnabled = true
        }
        else {
            print("UserID failed")
        }
    }

    
}


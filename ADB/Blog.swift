//
//  Blog.swift
//  ADB
//
//  Created by s on 2017-09-06.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Foundation
import Cocoa

class Blog: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("||", UserDefaults.standard.integer(forKey: "UserID"), "||")
        if(UserDefaults.standard.integer(forKey: "UserID") != 0 || UserDefaults.standard.integer(forKey: "UserID") == 544544) {
            print("notzero")
            self.Code.isHidden = true
            self.go.isHidden = true
            self.logt.isHidden = false
            self.label.stringValue = "\(UserDefaults.standard.integer(forKey: "UserID"))"
            self.label.isHidden = false
        }
        else {
            print("zero I guess", "\(UserDefaults.standard.integer(forKey: "UserID"))")
        }
    }
    override func viewDidAppear() {
        super .viewDidAppear()
        self.view.window?.styleMask.remove(NSWindowStyleMask.resizable)

    }
    @IBOutlet weak var Code: NSSecureTextField!
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var cls: NSButton!
    @IBOutlet weak var logt: NSButton!
    @IBOutlet weak var go: NSButton!
    @IBAction func go(_ sender: Any) {
        let code = self.Code!.integerValue
        switch code {
        case 272272:
            print("You're good")
            UserDefaults.standard.set(code * 2, forKey: "UserID")
            self.label.isHidden = false
            self.label.stringValue = "You're In"
            self.label.animator().alphaValue = 1
            dismissViewController(self)
        default:
            print("Nope, sorry!")
            dismissViewController(self)
        }
    }
 
    @IBAction func cls(_ sender: Any) {
        dismissViewController(self)
    }
    @IBAction func logt(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "UserID")
        dismissViewController(self)
    }
    
}

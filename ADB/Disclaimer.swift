//
//  Disclaimer.swift
//  ADB
//
//  Created by s on 2017-09-06.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Foundation
import Cocoa

class Disclaimer: NSViewController {
    @IBOutlet weak var show: NSButton!
    @IBOutlet weak var close: NSButton!
    
    @IBAction func show(_ sender: Any) {
        
        
    }
    
    @IBAction func close(_ sender: Any) {
        UserDefaults.standard.set(self.show.state, forKey: "show?")
        dismiss(self)
    }
    
}

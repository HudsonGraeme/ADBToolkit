//
//  Chat.swift
//  ADB
//
//  Created by s on 2017-09-16.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Foundation
import Cocoa

class Chat: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.window?.styleMask.remove(NSWindowStyleMask.resizable)
    }

}

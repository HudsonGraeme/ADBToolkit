//
//  TabController.swift
//  ADB
//
//  Created by s on 2017-10-02.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Foundation
import Cocoa

class TabController: NSTabViewController {
    
    
}
class General: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.path.url = URL(string: ("file://" + FileManager.documentsDir()))!
        print(self.path.url!)
    }
    @IBOutlet weak var path: NSPathControl!
    
}

class Advanced: NSViewController {
    
}



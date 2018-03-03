//
//  SetupHelp.swift
//  ADB
//
//  Created by s on 2017-07-04.
//  Copyright © 2017 Hudson Graeme. All rights reserved.
//

import Foundation
import Cocoa
import WebKit

class SetupHelp: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    @IBOutlet weak var WebView: WKWebView!
    func load() {
        let urlpath = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "web");
        do {
            let contents =  try String(contentsOfFile: urlpath!, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: urlpath!)
            WebView.loadHTMLString(contents as String, baseURL: baseUrl)
        }
        catch {
            print ("File HTML error")
        }
    }
}

//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Jordan Harvey-Morgan on 5/25/16.
//  Copyright © 2016 Jordan Harvey-Morgan. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // load HTML file to webView
        if let htmlFile = Bundle.main.path(forResource: "BullsEye", ofType: "html") {
            if let htmlData = try? Data(contentsOf: URL(fileURLWithPath: htmlFile)) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webView.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
        
        // title
        title = "About View Controller"
    }

    // 'Close' button
    @IBAction func close() {
        // get rid of 'About' screen
        dismiss(animated: true, completion: nil)
    }
    
    // About page wording 
    @IBOutlet weak var webView: UIWebView!

}

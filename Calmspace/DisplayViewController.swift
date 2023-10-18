//
//  DisplayViewController.swift
//  Calmspace
//
//  Created by Admin on 17/10/2023.
//

import UIKit
import WebKit

class DisplayViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var actInt: UIActivityIndicatorView!
    
    
    @IBAction func refresh(_ sender: Any) {
    }
    
    @IBAction func stop(_ sender: Any) {
    }
    
    
    @IBAction func rewind(_ sender: Any) {
    }
    
    
    @IBAction func forward(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

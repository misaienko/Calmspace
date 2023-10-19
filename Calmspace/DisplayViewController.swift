//
//  DisplayViewController.swift
//  Calmspace
//
//  Created by Admin on 17/10/2023.
//

import UIKit
import WebKit

class DisplayViewController: UIViewController, WKNavigationDelegate {
    
    
    var webView: WKWebView!
   
    var urlString: String?
    
    
    
    @IBOutlet weak var actInt: UIActivityIndicatorView!
    
    @IBAction func refresh(_ sender: Any) {
    }
    
    @IBAction func stop(_ sender: Any) {
    }
    
    @IBAction func rewind(_ sender: Any) {
    }
    
    @IBAction func forward(_ sender: Any) {
    }
    
    
    override func loadView() {
            
        }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        webView = WKWebView()
                webView.navigationDelegate = self
                view = webView

                // Load the URL
        if let urlString = urlString, let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
            }
        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("Web view failed to load with error: \(error.localizedDescription)")
        }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



//
//  DisplayViewController.swift
//  Calmspace
//
//  Created by Admin on 17/10/2023.
//

import UIKit
import WebKit

class DisplayViewController: UIViewController, WKNavigationDelegate {
    
    var url: URL?
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var actInt: UIActivityIndicatorView!
    
    @IBAction func refresh(_ sender: Any) {
        
        webView.reload()
    }
    
    @IBAction func stop(_ sender: Any) {
        
        webView.stopLoading()
    }
    
    @IBAction func rewind(_ sender: Any) {
        
        if webView.canGoBack {
            webView.goBack() }
    }
    
    @IBAction func forward(_ sender: Any) {
        
        if webView.canGoForward {
            webView.goForward() }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView?.navigationDelegate = self
        
        // Check if webView is not nil before attempting to load a request
            if  let url = url {
                print("Received URL: \(url)")
                let request = URLRequest(url: url)
                webView.load(request)
            } else {
                print("URL is nil")
            }
            
        // Load the URL
     if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // Do any additional setup after loading the view.
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            actInt.startAnimating()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            actInt.stopAnimating()
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
}

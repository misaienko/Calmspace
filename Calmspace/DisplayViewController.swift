//
//  DisplayViewController.swift
//  Calmspace
//
//  Created by Admin on 17/10/2023.
//

import UIKit
import WebKit

class DisplayViewController: UIViewController, WKNavigationDelegate {
    
    var link: URL?
    
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
        
        print("DisplayViewController - View Did Load")
        print("DisplayViewController - link: \(String(describing: link))")
        
        webView?.navigationDelegate = self
        if let url = link {
            print("Received URL: \(url)")
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            print("URL is nil")
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            actInt.startAnimating()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            actInt.stopAnimating()
        }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Web view failed to load with error: \(error.localizedDescription)")
    }
}

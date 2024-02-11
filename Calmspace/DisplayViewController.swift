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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    @IBAction func refresh(_ sender: Any) {
        webView.reload()
    }
    
    override func viewDidLoad() {
        print("DisplayViewController viewDidLoad() called")
        super.viewDidLoad()
        setupWebView()
        loadInitialURL()
        webView.accessibilityIdentifier = "webViewIdentifier"
        refreshButton.accessibilityIdentifier = "refreshButtonIdentifier"
    }
    
    private func setupWebView() {
        webView?.navigationDelegate = self
    }
    
    private func loadInitialURL() {
        if let url = link {
            print("Received URL: \(url)")
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            print("URL is nil")
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Web view failed to load with error: \(error.localizedDescription)")
    }
}

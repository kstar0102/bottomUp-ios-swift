//
//  BottomUpViewController.swift
//  ASPAppIos
//
//  Created by ADV on 2020/03/07.
//  Copyright © 2020 ADV. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class BottomUpViewController: UIViewController {


        @IBOutlet weak var webView: WKWebView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.isNavigationBarHidden = true
            
            let url = URL(string: Config.BASEURL)
            webView.navigationDelegate = self
            webView.load(URLRequest(url: url!))
            SVProgressHUD.show()
        }
        
        override func viewWillAppear(_ animated: Bool) {
        }

        override func viewWillDisappear(_ animated: Bool) {
        }

    @IBAction func refreshBtnClicked(_ sender: Any) {
        let url = URL(string: Config.BASEURL)
        webView.load(URLRequest(url: url!))
        SVProgressHUD.show()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }

    @IBAction func menuBtnClicked(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
}
    extension BottomUpViewController: WKNavigationDelegate {

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            let url = URL(string: Config.BASEURL)
            if webView.url?.absoluteString == Config.FACEBOOK_URL {
                self.tabBarController?.selectedIndex = 1
                webView.load(URLRequest(url: url!))
                return
            }else if webView.url?.absoluteString == Config.BASEURL + Config.BOOKS {
                self.tabBarController?.selectedIndex = 2
                webView.load(URLRequest(url: url!))
                return
            }else if webView.url?.absoluteString == Config.BASEURL + Config.SCHEDULE {
                self.tabBarController?.selectedIndex = 3
                webView.load(URLRequest(url: url!))
                return
            }else if webView.url?.absoluteString == Config.BASEURL + Config.PROFILE {
                self.tabBarController?.selectedIndex = 4
                webView.load(URLRequest(url: url!))
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
               SVProgressHUD.dismiss()
            }
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("Finished loading")
            webView.scrollView.setContentOffset(CGPoint.zero, animated: true)
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
            print(error.localizedDescription)
        }
        
        // WKNavigationDelegate
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated  {
                if let newURL = navigationAction.request.url,
                    let host = newURL.host , !host.hasPrefix("www.google.com"){
                    webView.load(URLRequest(url: newURL))
                }
            }
            decisionHandler(.allow)
        }
    }

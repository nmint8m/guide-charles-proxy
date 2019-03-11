//
//  ViewController.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 3/11/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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

class IndicatorView: UIView {
    func startAnimating(){}

    func stopAnimating(){}
}

protocol SetUpWebviewVCProtocol: UIWebViewDelegate {
    var vc: UIViewController? { get }

    var indicatorView: IndicatorView? { get }
}

extension SetUpWebviewVCProtocol {
    func webView(_ webView: UIWebView,
                 shouldStartLoadWith request: URLRequest,
                 navigationType: UIWebView.NavigationType) -> Bool {
        /*
        guard let urlString = request.url?.absoluteString else { return true }
        if urlString.range(of: "about:blank?weight") != nil {
            guard let components = URLComponents(string: urlString),
                let queryItems = components.queryItems else { return true }
            let smokeText = queryItems.filter({ $0.name == "smoke_text" }).first?.value
            let smoke = queryItems.filter({ $0.name == "smoke" }).first?.value
            let waistline = queryItems.filter({ $0.name == "waistline" }).first?.value
            let weight = queryItems.filter({ $0.name == "weight" }).first?.value

            let info = FinalReportPopupViewController.ReportInfo(weight: weight,
                                                                 waistline: waistline,
                                                                 smoke: smoke,
                                                                 smokeText: smokeText)

            let vc = FinalReportPopupViewController.vc()
            vc.info = info
            vc.delegate = self
            present(vc, animated: true, completion: nil)
            return false
        }
         */

        return true
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        indicatorView?.startAnimating()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        indicatorView?.stopAnimating()
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        indicatorView?.stopAnimating()
    }
}

class TypicalVC: UIViewController, SetUpWebviewVCProtocol {

    var vc: UIViewController? { return self }

    var indicatorView: IndicatorView? { return IndicatorView() }
}


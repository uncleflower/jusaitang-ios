//
//  WebBrowser.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/10.
//

import UIKit
import WebKit

class WebBrowser: BaseViewController , WKScriptMessageHandler {
    
    let dismissBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dismiss_arrow"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    var progressView:UIProgressView = UIProgressView();
    
    var webView = WKWebView(frame: CGRect(x: 0, y: App.naviStatusHeight, width: App.screenWidth, height: App.screenHeight-App.naviStatusHeight))
    
    var viewModel:WebBrowserVM
    
    init(viewModel:WebBrowserVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        
        // MARK: --添加H5交互.  IosPay 与下面接收js调用方法对应
        // H5在js事件中的代码是 window.webkit.messageHandlers.IosPay.postMessage(参数)
        webView.configuration.userContentController.add(self, name: "IosPay")
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        
        self.view.addSubview(self.webView)
        self.view.addSubview(self.dismissBtn)
        self.navigationView.leftView = dismissBtn
        dismissBtn.addTarget(self, action: #selector(popView), for: .touchUpInside)
        
        self.webView.navigationDelegate = self
        
        progressView.tintColor = UIColor.default
        progressView.frame.size.width = App.screenWidth
        progressView.frame.origin.y = self.webView.frame.origin.y
        progressView.frame.size.height = 2
        self.view.addSubview(progressView)
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func bindViewModel() {
        guard let url = URL.init(string: viewModel.url) else {return}
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if let newprogress = change?[NSKeyValueChangeKey.newKey] as? Double{
                if (newprogress == 1) {
                    self.progressView.isHidden = true;
                    self.progressView.setProgress(0, animated: true)
                }else {
                    self.progressView.isHidden = false;
                    self.progressView.setProgress(Float(newprogress), animated: true)
                }
            }
        }
    }
    
}
extension WebBrowser: WKNavigationDelegate{
    
    // MARK: --实现WKNavigationDelegate委托协议
    //开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        NSLog("开始加载")
        
    }
    
    //当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }
    
    //加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if title == nil || title!.isEmpty {
            self.title = webView.title
        }
        //        webView.evaluateJavaScript("document.body.scrollHeight") { (result, error) in
        //            if let height = result as? Double{
        //                self.webView.frame.size.height = CGFloat(height)
        //            }
        //        }
    }
    
    //加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        NSLog("加载失败 error :  ", error.localizedDescription)
        //        print("加载失败 error :  " + (webView.url?.absoluteString ?? urls))
    }
    
    //接收js调用方法
    func userContentController(_ userContentController: WKUserContentController,didReceive message: WKScriptMessage) {
        print("--------"+"\(message.name)")
        //        switch message.name {
        //        case "IosPay":
        //            //多个参数
        ////            let dcit2:[String : NSObject] = message.body as! [String : NSObject]
        //            //单个参数
        ////            let content:String = message.body
        //        default: break
        //        }
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        decisionHandler(.allow)
    }
    
}


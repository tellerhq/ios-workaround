//
//  ConnectViewController.swift
//
//  Copyright (c) 2020 Teller, Inc. All rights reserved.
//

import UIKit
import WebKit

extension Teller {
    class ConnectViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
        struct ConnectMessage: Decodable {
            struct Data: Decodable {
                var accessToken: String
                var enrollment: Teller.Enrollment
                var user: Teller.User
            }
            
            enum Event: String, Decodable {
                case exit = "exit"
                case success = "success"
                case ready = "ready"
            }
            
            var name: Event
            var data: Data?
            
            private enum CodingKeys : String, CodingKey {
                case name = "event", data
            }
        }
        
        let webView = WKWebView()
        let configuration: Teller.Configuration
        let completion: (Teller.Registration?, Error?) -> ()
        
        init(configuration: Teller.Configuration, completion: @escaping (Teller.Registration?, Error?) -> Void) {
            self.completion = completion
            self.configuration = configuration
            
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            self.configuration = coder.decodeObject(forKey: "configuration") as! Teller.Configuration
            self.completion    = coder.decodeObject(forKey: "completion") as! (Teller.Registration?, Error?) -> ()
            
            super.init(coder: coder)
        }
        
        override func encode(with coder: NSCoder) {
            coder.encode(self.configuration, forKey: "configuration")
            coder.encode(self.completion, forKey: "completion")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let request = URLRequest(url: connectURL())

            webView.navigationDelegate = self
            webView.allowsBackForwardNavigationGestures = false
            
            let js = """
            window.postMessage = function(message, origin, transfer) {
                window.webkit.messageHandlers.teller.postMessage(message);
            }
            """
            let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
            
            webView.configuration.userContentController.add(self, name: "teller")
            webView.configuration.preferences.javaScriptEnabled = true
            webView.configuration.userContentController.addUserScript(script)

            webView.scrollView.bounces = false
            
            webView.load(request)
            
            if #available(iOS 11.0, *) {
                webView.scrollView.contentInsetAdjustmentBehavior = .never
            }

            self.view.addSubview(webView)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            webView.frame = view.frame
        }


        override var prefersStatusBarHidden : Bool {
            return true
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }

        func connectURL(config: [String: String] = [:]) -> URL {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "teller.io"
            components.path = "/connect/\(self.configuration.appId)"
            components.queryItems = config.map { URLQueryItem(name: $0, value: $1) }
            
            return URL(string: components.string!)!
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            let string   = message.body as! String
            let json     = string.data(using: .utf8)!
            let decoder  = JSONDecoder()
            let event    = try! decoder.decode(ConnectMessage.self, from: json)
            
            print("Data: \(event)")
            
            switch event.name {
            case .exit:
                print("User bounced")
                
                self.completion(nil, nil)
            case .success:
                print("User success: \(event)")
                
                let data = event.data!
                                
                let registration = Teller.Registration(accessToken: data.accessToken, user: data.user, enrollment: data.enrollment)
                
                print("registration: \(registration)")
                
                self.completion(registration, nil)
            default:
                print("Event received: \(event.name.rawValue)")
                
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }

}

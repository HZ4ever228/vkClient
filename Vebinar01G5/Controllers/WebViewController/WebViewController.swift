//
//  WebViewController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 08/08/2021.
//

import UIKit
import WebKit

//MARK:- TableViewController
class TableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        newsRequest()

    }

}

//MARK:- VKLoginController
class VKLoginController: UIViewController {

    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7922523"), // индивидуальные айди приложения
            URLQueryItem(name: "scope", value: "262150"), // Доступы друзья фото и тд
            URLQueryItem(name: "display", value: "mobile"), // Стиль отображения
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"), //
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.81")
        ]

        let request = URLRequest(url: components.url!)

        webView.load(request)

    }

}

extension VKLoginController: WKNavigationDelegate {
//MARK: -func webView
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard navigationResponse.response.url?.path == "/blank.html",
              let fragment = navigationResponse.response.url?.fragment else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        Session.instance.token = params["access_token"] ?? ""
        Session.instance.userId = params["user_id"] ?? ""

        let vc = TableViewController()
        present(vc, animated: true)
        decisionHandler(.cancel)

    }
    
}

func newsRequest() {

    guard let url = URL(string: "https://api.vk.com/method/newsfeed.getLists?extended=1&v=5.81&access_token=\(Session.instance.token)") else { return }

    let request = URLRequest(url: url)

    let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in

        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print("newsRequst \(json)")
            } catch {
                print(error)
            }
        }
    }
    dataTask.resume()

}

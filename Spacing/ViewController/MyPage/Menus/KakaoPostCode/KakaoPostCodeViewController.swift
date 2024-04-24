import UIKit
import WebKit
import SnapKit


protocol AddressDelegate{
    func dataReceived(address: String)
}
class KakaoPostCodeViewController: UIViewController {
    
    var webView: WKWebView?
    
    let indicator = UIActivityIndicatorView(style: .medium)
    var address = ""
    let contentController = WKUserContentController()
    var addressDelegate : AddressDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureWebView()
    }
    
    func configure() {
        self.navigationItem.title = "주소 등록"
        let backButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(dismissButtonClicked))
        backButton.tintColor = .red
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func dismissButtonClicked() {
        self.dismiss(animated: true)
    }
    
    func configureWebView() {
        self.contentController.add(self, name: "callBackHandler")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        
        webView = WKWebView(frame: .zero, configuration: configuration)
        self.webView?.navigationDelegate = self
        
        guard let url = URL(string: "https://group3333.github.io/Kakao-PostCode/"),
              let webView = webView
        else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        indicator.startAnimating()
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        webView.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
    }
}

extension KakaoPostCodeViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let data = message.body as? [String: Any] {
            address = data["roadAddress"] as? String ?? ""
        }
        self.addressDelegate?.dataReceived(address: address)
        self.dismiss(animated: true)
    }
}

extension KakaoPostCodeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}

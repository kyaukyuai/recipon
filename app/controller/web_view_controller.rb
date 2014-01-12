class WebViewController < UIViewController
        attr_accessor :recipe

        def viewDidLoad
                super

                self.navigationItem.title = self.recipe[:title]

                @webview = UIWebView.new.tap do |v|
                        v.frame = self.view.bounds
                        v.scalesPageToFit = true
                        v.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(self.recipe[:url])))
                        v.delegate = self
                        view.addSubview(v)
                end
        end
end

/*
 This second view controller contains the webview that opens google maps. It is supplied
 with the url that is created in the first view controller.
 */

import WebKit
import UIKit

class SecondViewController: UIViewController {
    
    var fvc:ViewController?
    @IBOutlet var wv:WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fvc = tabBarController!.viewControllers![0] as? ViewController
        _ = fvc!.view

    }

}

import UIKit

final class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        leaveReviewOutlet.layer.cornerRadius = 15
        shareOutlet.layer.cornerRadius = 15
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        if (UIDevice.current.orientation == .landscapeLeft) {
            backOutlet.isHidden = false
        }
        if (UIDevice.current.orientation == .landscapeRight) {
            backOutlet.isHidden = false
        }
        if (UIDevice.current.orientation == .portrait) {
            backOutlet.isHidden = true
        }
        if (UIDevice.current.orientation == .portraitUpsideDown) {
            backOutlet.isHidden = true
        }
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func rotated() {
        if (UIDevice.current.orientation == .landscapeLeft) {
            backOutlet.isHidden = false
        }
        if (UIDevice.current.orientation == .landscapeRight) {
            backOutlet.isHidden = false
        }
        if (UIDevice.current.orientation == .portrait) {
            backOutlet.isHidden = true
        }
        if (UIDevice.current.orientation == .portraitUpsideDown) {
            backOutlet.isHidden = true
        }
    }
    
    @IBOutlet weak var backOutlet: UIButton!
    
    @IBOutlet weak var leaveReviewOutlet: UIButton!
    @IBOutlet weak var shareOutlet: UIButton!
    
    @IBAction func leaveReview(_ sender: Any) {
        writeReview()
    }
    
    @IBAction func shareButton(_ sender: Any) {
        share()
    }
    private let productURL = URL(string: "https://apps.apple.com/us/app/music-hop-daily-throwbacks/id1494063897")!

  private func writeReview() {
    var components = URLComponents(url: productURL, resolvingAgainstBaseURL: false)
    components?.queryItems = [
      URLQueryItem(name: "action", value: "write-review")
    ]

    guard let writeReviewURL = components?.url else {
      return
    }

    UIApplication.shared.open(writeReviewURL)
  }

  private func share() {
    let activityViewController = UIActivityViewController(activityItems: [productURL],
                                                          applicationActivities: nil)

    present(activityViewController, animated: true, completion: nil)
  }
}

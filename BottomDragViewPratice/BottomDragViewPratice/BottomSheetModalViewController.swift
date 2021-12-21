import UIKit

class BottomSheetModalViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var dragView: DragView!
    private var isDragActive = false
    private var dragOffSetY: CGFloat = 0
    private var minY: CGFloat = 64

    override func viewDidLoad() {
       
        topConstraint.constant = view.bounds.height
    }

    override func viewDidAppear(_ animated: Bool) {
        topConstraint.constant = 320
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.view.layoutIfNeeded()
        })
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if dragView.frame.contains(touch.location(in: view)) {
                dragOffSetY = touch.location(in: dragView).y
                isDragActive = true
                dragView.isDragActive = true
            } else if navigationBar.frame.contains(touch.location(in: view)) {
                dragOffSetY = touch.location(in: navigationBar).y + dragView.bounds.height
                isDragActive = true
                dragView.isDragActive = true
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragActive,
           let touch = touches.first {
            topConstraint.constant = max(touch.location(in: view).y - dragOffSetY, minY)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragActive {
            if view.bounds.height - cancelView.bounds.height < 198 {
                dismiss(animated: true)
            } else {
                isDragActive = false
                dragView.isDragActive = false
            }
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragActive {
            if view.bounds.height - cancelView.bounds.height < 198 {
                dismiss(animated: true)
            } else {
                isDragActive = false
                dragView.isDragActive = false
            }
        }
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if flag {
            topConstraint.constant = view.bounds.height
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.view.backgroundColor = .clear
                self.view.layoutIfNeeded()
            }) {
                finished in
                super.dismiss(animated: false, completion: completion)
            }
        } else {
            super.dismiss(animated: false, completion: completion)
        }
    }
}

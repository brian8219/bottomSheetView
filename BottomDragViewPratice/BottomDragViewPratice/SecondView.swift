
import UIKit

class SecondViewController : BottomSheetModalViewController  {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func done(_ sender: Any) {
        dismiss(animated: true)
    }
}

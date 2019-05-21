import UIKit

let redMarker = UIColor(red: 0.995292, green: 0.188943, blue: 0, alpha: 1)
let noColor = UIColor(red: 1, green: 0.958754, blue: 0.833166, alpha: 1)

class GradeTextController: UIViewController {
    var code: String!
    @IBOutlet var textTitle: UITextView!
    @IBOutlet var textBody: UITextView!
    var index = 0
    @IBOutlet var colorSwitch: UIButton!
    
    @IBAction func next(_ sender: UIButton) {
        if index == 2 {
            performSegue(withIdentifier: "debatesegue", sender: self)
        } else {
            index += 1
            textBody.text = sampleTexts[index]
            textTitle.text = sampleTitles[index]
            setToTestText()
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textBody.isScrollEnabled = false
        textBody.text = sampleTexts[0]
        textTitle.text = sampleTitles[0]
        setToTestText()
        colorSwitch.setTitleColor(redMarker, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textBody.isScrollEnabled = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let room = segue.destination as? ThirdPhaseRoomController {
            room.code = code
        }
    }

    @IBAction func switchColor(_ sender: UIButton) {
        if colorSwitch.currentTitleColor == redMarker {
            colorSwitch.setTitleColor(noColor, for: .normal)
        } else {
            colorSwitch.setTitleColor(redMarker, for: .normal)
        }
    }
    
    @IBAction func finger(_ sender: UIGestureRecognizer) {
        let storage = NSTextStorage(attributedString: textBody.attributedText!)
        let textContainer = NSTextContainer(size: textBody.contentSize)
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        storage.addLayoutManager(layoutManager)
//        textContainer.lineFragmentPadding = 0.0
//        textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
//        textContainer.maximumNumberOfLines = 0
        let location = sender.location(in: textBody)
        let characterIndex = layoutManager.characterIndex(
            for: location,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )
        
        if characterIndex < storage.length {
            let string = NSMutableAttributedString(attributedString: textBody.attributedText!)
            if colorSwitch.currentTitleColor == redMarker {
                string.addAttribute(
                    NSAttributedString.Key.backgroundColor,
                    value: colorSwitch.currentTitleColor,
                    range: NSRange(location: characterIndex, length: 1)
                )
            } else {
                string.removeAttribute(NSAttributedString.Key.backgroundColor, range: NSRange(location: characterIndex, length: 1))
            }
        
            
            textBody.attributedText = string
        }
    }
    
    
    private func setToTestText() {
        let mutableString = NSMutableAttributedString(
            string: textBody.text,
            attributes: [NSAttributedString.Key.font: UIFont(name: "Rockwell", size: 32.0)!]
        )
        textBody.attributedText = mutableString
        textBody.updateConstraints()
        textBody.setContentOffset(.zero, animated: true)
    }
}

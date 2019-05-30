import UIKit

let redMarker = UIColor(red: 0.995292, green: 0.188943, blue: 0, alpha: 1)
let greenMarker = UIColor(red: 0.73, green: 0.82, blue: 0.29, alpha: 1)
let noColor = UIColor(red: 1, green: 0.958754, blue: 0.833166, alpha: 1)

class GradeTextController: UIViewController {
    var code: String!
    @IBOutlet var textTitle: UITextView!
    @IBOutlet var textBody: UITextView!
    @IBOutlet var colorSwitch: UIButton!
    var texts: [Text]!
    var index = 0
    
    @IBAction func next(_ sender: UIButton) {
        
        sendHighlighted()
        index += 1
        
        if index >= texts.count {
            performSegue(withIdentifier: "debatesegue", sender: self)
        } else {
            textBody.text = texts[index].body
            textTitle.text = texts[index].theme
            //
            
            setToTestText()
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
    presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // integrar isso
        FirebaseHelper.shared().getClassroom(
            id: AppSingleton.shared().loggedRoom!.code,
            onError: {(error) in
                print("erro")
                
            },
            onSuccess: { classroom in
                    AppSingleton.shared().loggedRoom = classroom
                
                    print(classroom.texts)
                
                self.texts = classroom.texts.values.shuffled().filter({ text -> Bool in
                    guard let userId = AppSingleton.shared().loggedUser?.uid else {return false}
                    return text.authorId != userId
                })
                    self.textBody.isScrollEnabled = false
                    // Coloca info do primeiro texto recebido
                    self.textBody.text = self.texts[0].body
                    self.textTitle.text = self.texts[0].theme
                    self.setToTestText()
            }
        )
        
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
    
    
    func getColorArrayToSend(_ attributedString: NSAttributedString) -> [Int] {
        let words = attributedString.string.components(separatedBy: CharacterSet.init(charactersIn: " ,;;:.!?")).filter({(string) in string != ""})
        var colors: [Int] = []
        for i in 0..<attributedString.string.count {
//        for i in 0..<words.count {
            var key = 0
            
            if let color = attributedString.attributes(at: i, effectiveRange: nil)[NSAttributedString.Key.backgroundColor] as? UIColor {
                if color == redMarker {key = -1}
                else if color == greenMarker {key = 1}
            }
            colors.append(key)
        }
        
        var i = 0
        var colorsByWord: [Int] = []
        for word in words {
            colorsByWord.append(colors[i])
            i += word.count + 1
        }
        return colorsByWord
    }
    
    func sendHighlighted() {
        guard let username = AppSingleton.shared().loggedUser?.displayName,
            let roomId = AppSingleton.shared().loggedRoom?.code else { return }
        
        let array = getColorArrayToSend(textBody.attributedText)
        let highlighted = Highlighted(id: username, content: array)
        
        FirebaseHelper.shared().sendHighlighted(highlighted: highlighted, textId: texts[index].id, roomId: roomId, onError: { error in
            
        }) {
            // highlighted enviado com sucesso
        }
        
    }

    @IBAction func switchColor(_ sender: UIButton) {
        if colorSwitch.currentTitleColor == redMarker {
            colorSwitch.setTitleColor(greenMarker, for: .normal)
        } else if colorSwitch.currentTitleColor == greenMarker {
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
            if colorSwitch.currentTitleColor == redMarker ||
                colorSwitch.currentTitleColor == greenMarker {
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

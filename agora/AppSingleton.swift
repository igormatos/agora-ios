import Foundation
import FirebaseAuth

class AppSingleton {
    
    private static let appSingleton = AppSingleton()
    var activeUser: String?
    var loggedUser: User?
    
    class func shared() -> AppSingleton {
        return appSingleton
    }
    
    private init() {
        
    }
}



let sampleTheme = "Should a second referendum be held for Brexit?"
let sampleHotTake = "the implications for the north/south Irish border and Northern Ireland peace process weren't even considered during the first referendum"

var sampleTexts = [
    "A second referendum must absolutely be held. The referendum did not spell out the nature of the future relationship with the EU nor the consequences of Brexit. Voters will have a clearer idea of what is on offer at the end of the negotiating process. The complexities and consequences of not being in the EU are becoming more known now by everyday people, the British public are now far more informed about how complex the issue actually is and so know more about what a future deal may look like.",
    "Yes, a second referendum must be held. It cannot be made clearer that the implications for the north/south Irish border and Northern Ireland peace process weren't even considered during the first referendum. Even if the British still decide to leave, they must do so with full knowledge of what that brings to Britain, Northern Ireland and the republic of Ireland, and be prepared to deal with it.",
    "If there was a second referendum, and Britain voted this time to remain, it would not dissolve UK eurosceptism or solve the divisions in the UK. Although the first referendum was very seriously flawed, a second referendum will server only to further divide people. Further delay means a continued political vacuum which will be filled by those wishing to exploit a confused and frustated people. There is a serious danger of civil unrest, and the protacted delay would create space for the voices of extremists to gain further legitimacy.",
]
var sampleTitles = [
    "Unbrexiteing",
    "Irexit",
    "There is no time!",
]

//
var rooms:
    [String: Room] =
    ["ax1453": Room(code: "AX1453", authorId: "id", author: "tcm", theme: sampleTheme, texts: [], users: [:], canJoin: true) ]

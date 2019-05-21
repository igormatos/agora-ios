import Foundation


var activeUser: String?

var users: [String: User] = ["tcm": User(handle: "tcm", password: "abc", email: "tcm@gmail.com")]


struct User {
    var handle: String
    var password: String
    var email: String
}

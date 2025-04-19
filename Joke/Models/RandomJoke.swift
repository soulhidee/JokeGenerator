import Foundation

struct RandomJoke: Codable {
    let question: String
    let punchline: String
    
    private enum CodingKeys: String, CodingKey {
        case question = "setup"
        case punchline = "punchline"
    }
}

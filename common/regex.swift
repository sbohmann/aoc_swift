import Foundation

func firstMatch(text: String, pattern: NSRegularExpression) -> NSTextCheckingResult? {
    let range = NSRange(location: 0, length: text.utf16.count)
    return pattern.firstMatch(in: text, range: range)
}

struct Match {
    private let text: String
    private let match: NSTextCheckingResult

    init(text: String, pattern: NSRegularExpression) {
        self.text = text
        let range = NSRange(location: 0, length: text.utf16.count)
        if let match = pattern.firstMatch(in: text, range: range) {
            self.match = match
        } else {
            fatalError("Text [\(text)] does not match pattern [\(pattern.pattern)]")
        }
    }

    func group() -> String {
        String(text[Range(match.range, in: text)!])
    }

    func group(_ n: Int) -> String {
        String(text[Range(match.range(at: n), in: text)!])
    }

    subscript (n: Int) -> String {
        group(n)
    }
}

import Foundation

func solve2B() {
    // let result = ['1-3 a: abcde', '1-3 b: cdefg', '2-9 c: ccccccccc']
    let result = readLines(path: "2/input.txt")
        .map(parse)
        .reduce(0) { count, line in
            line.rule(line.password)
                ? count + 1
                : count
        }
    print("2.B:", result)
}

private struct ParsedLine {
    let rule: (String) -> Bool
    let password: String
}

private func parse(line: String) -> ParsedLine {
    let regex = try! NSRegularExpression(pattern: #"(\d+)-(\d+) ([a-z]): ([a-z]+)"#)
    let match = Match(text: line, pattern: regex)

    let firstIndex = Int(match[1])!
    let secondIndex = Int(match[2])!
    let character = singleCodePoint(text: match[3])
    let password = match[4]

    func count(_ text: String, _ character: Unicode.Scalar) -> Int64 {
        (codePointAt(text: text, index: firstIndex - 1) == character ? 1 : 0) +
            (codePointAt(text: text, index: secondIndex - 1) == character ? 1 : 0)
    }

    return ParsedLine(
        rule: { text in count(text, character) == 1 },
        password: password)
}

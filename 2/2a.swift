import Foundation

func solve2A() {
    // let result = ['1-3 a: abcde', '1-3 b: cdefg', '2-9 c: ccccccccc']
    let result = readLines(path: "2/input.txt")
        .map(parse)
        .reduce(0) {
            count, line in
                line.rule(line.password)
                    ? count + 1
                    : count}
    print("2.A:", result)
}

private struct ParsedLine {
    let rule : (String) -> Bool
    let password: String
}

private func parse(line: String) -> ParsedLine {
    let pattern = try! NSRegularExpression(pattern: #"(\d+)-(\d+) ([a-z]): ([a-z]+)"#)
    let match = Match(text: line, pattern: pattern)

    let minimum = Int64(match.group(1))!
    let maximum = Int64(match.group(2))!
    let character = singleCodePoint(text: match.group(3))
    let password = match.group(4)

    if (maximum < minimum) {
        fatalError("Corrupt input: [\(line)]")
    }

    func count(_ text: String, _ character: Unicode.Scalar) -> Int {
        text.unicodeScalars
            .reduce(0) { count, candidate in
                (candidate == character)
                    ? count + 1
                    : count
            }
    }

    return ParsedLine(
        rule: { text in
            let numberOfOccurrences = count(text, character)
            return numberOfOccurrences >= minimum && numberOfOccurrences <= maximum
        },
        password: password
    )
}

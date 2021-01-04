func readLines(path: String) -> [String] {
    readUnfilteredLines(path: path)
        .filter { line in line.count > 0 }
}

func readUnfilteredLines(path: String) -> [String] {
    try! String(contentsOfFile: path, encoding: .utf8)
        .split(separator: "\n")
        .map(trim)
}

func readRawLines(path: String) -> [String] {
    try! String(contentsOfFile: path, encoding: .utf8)
        .split(separator: "\n")
        .map(trim)
}

func readLineGroups(path: String) -> [[String]] {
    let lines = readUnfilteredLines(path: path)
    var groups = Groups()
    lines.forEach { line in groups.processLine(line) }
    return groups.result()
}

private func trim<T: StringProtocol>(text: T) -> String {
    text.trimmingCharacters(in: .whitespacesAndNewlines)
}

private struct Groups {
    var currentGroup = [String]()
    var resultBuffer = [[String]]()

    mutating func processLine(_ line: String) {
        if (line.count == 0) {
            addNonEmptyCurrentGroup()
        } else {
            currentGroup.append(line)
        }
    }

    mutating func result() -> [[String]] {
        addNonEmptyCurrentGroup()
        return resultBuffer
    }

    mutating private func addNonEmptyCurrentGroup() {
        if (currentGroup.count > 0) {
            addCurrentGroup()
        }
    }

    mutating private func addCurrentGroup() {
        resultBuffer.append(currentGroup)
        currentGroup = []
    }
}

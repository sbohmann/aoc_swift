
struct Map {
    let width, height: Int
    private let rows: [[Bool]]

    init(lines: [String]) {
        rows = lines
            .map(readRow)
        let lengths = rowLengths(rows)
        if (lengths.count != 1) {
            fatalError("Rows have different lengths")
        }
        width = lengths.first!
        height = rows.count
    }

    func tree(_ x: Int, _ y: Int) -> Bool {
        rows[y][normalize(x)]
    }

    private func normalize(_ x: Int) -> Int {
        ((x % width) + width) % width
    }
}

private func rowLengths(_ rows: [[Bool]]) -> Set<Int> {
    Set(rows.map{row in row.count})
}

private func readRow(line: String) -> [Bool] {
    line.map(interpretCharacter)
}

private func interpretCharacter(value: Character) -> Bool {
    switch (value) {
    case ".":
        return false
    case "#":
        return true
    default:
        fatalError("Unsupported map character [\(value)]")
    }
}

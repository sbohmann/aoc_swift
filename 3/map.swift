
struct Map {
    let tree: (Int, Int) -> Bool
    let width, height: Int
}

func createMap(lines: [String]) -> Map {
    var width: Int!
    var rows: [[Bool]]!

    func initialize() {
        rows = lines
            .map(readRow)
        let lengths = rowLengths(rows)
        if (lengths.count != 1) {
            fatalError("Rows have different lengths")
        }
        width = lengths.first!
    }

    func readRow(line: String) -> [Bool] {
        line.map(interpretCharacter)
    }

    func interpretCharacter(value: Character) -> Bool {
        switch (value) {
            case ".":
                return false
            case "#":
                return true
            default:
                fatalError("Unsupported map character [\(value)]")
        }
    }

    func rowLengths(_ rows: [[Bool]]) -> Set<Int> {
        Set(rows.map{row in row.count})
    }

    func normalize(_ x: Int) -> Int {
        ((x % width) + width) % width
    }

    initialize()

    return Map(
        tree: { x, y in
            rows[y][normalize(x)]
        },
        width: width,
        height: rows.count
    )
}

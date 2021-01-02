import Foundation

let input = try! String(contentsOfFile: "1/input.txt", encoding: .utf8)
    .split(separator: "\n")
    .map { line in Int64(line)! }

func solve1A() {
    forEachPair(data: input) { lhs, rhs in
        if lhs + rhs == 2020 {
            print("1.A:", lhs * rhs)
        }
    }
}

func forEachPair<E>(data: [E], _ action: (E, E) -> Void) {
    for lhsIndex in 0..<data.count - 1 {
        let lhs = data[lhsIndex]
        for rhsIndex in lhsIndex + 1..<data.count {
            let rhs = data[rhsIndex]
            action(lhs, rhs)
        }
    }
}

func solve1B() {
    var result: Int64? = nil
    forEachGroup(groupSize: 3, data: input) { group in
        let sum = group.reduce(0) { lhs, rhs in lhs + rhs }
        if (sum == 2020) {
            if (result != nil) {
                fatalError("Found multiple results")
            }
            result = group.reduce(1) {lhs, rhs in lhs * rhs }
        }
    }
    print("B:", result ?? "no result found")
}

func forEachGroup<E>(groupSize: Int, data: [E], action: ([E]) -> Void) {
    let iterator = GroupIterator(data: data, groupSize: groupSize)
    repeat {
        action(iterator.get())
    } while (iterator.next())
}

class GroupIterator<E> {
    let data: [E]
    let groupSize: Int
    var indices: [Int]

    init(data: [E], groupSize: Int) {
        self.data = data
        self.groupSize = groupSize
        indices = initialIndices(groupSize: groupSize)
    }

    func next() -> Bool {
        incrementIndicesOrReturnFalse()
    }

    func get() -> [E] {
        indices.map { index in data[index] }
    }

    private func incrementIndicesOrReturnFalse() -> Bool {
        for groupIndex in stride(from: groupSize - 1, through: 0, by: -1) {
            if (canIncrement(groupIndex)) {
                increment(groupIndex)
                return true
            }
        }
        return false
    }


    private func canIncrement(_ groupIndex: Int) -> Bool {
        let numberOfSubGroupIndices = groupSize - groupIndex
        return indices[groupIndex] < data.count - numberOfSubGroupIndices
    }

    private func increment(_ groupIndex: Int) {
        indices[groupIndex] += 1
        let newValueForGroupIndex = indices[groupIndex]
        resetSubGroupIndices(groupIndex, newValueForGroupIndex)
    }

    private func resetSubGroupIndices(_ groupIndex: Int, _ newValueForGroupIndex: Int) {
        var newValueForSubGroup = newValueForGroupIndex
        for subGroupIndex in (groupIndex + 1)..<groupSize {
            newValueForSubGroup += 1
            indices[subGroupIndex] = newValueForSubGroup
        }
    }
}

func initialIndices(groupSize: Int) -> [Int] {
    var result = [Int](repeating: 0, count: groupSize)
    for index in 0..<groupSize {
        result[index] = index
    }
    return result
}

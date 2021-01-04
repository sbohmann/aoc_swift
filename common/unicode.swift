func singleCodePoint(text: String) -> Unicode.Scalar {
    let result = Array(text.unicodeScalars) // TODO remove conversion
    if (result.count != 1) {
        fatalError("Not a single unicode code point [\(text)] - code points contained: [\(result)]")
    }
    return result.first!
}

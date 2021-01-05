func singleCodePoint(text: String) -> Unicode.Scalar {
    let result = text.unicodeScalars
    if (result.count != 1) {
        fatalError("Not a single unicode code point: [\(text)] - \(result.count) code points contained: \(Array(result))")
    }
    return result.first!
}

func codePointAt(text: String, index: Int) -> Unicode.Scalar {
    let unicodeView = text.unicodeScalars
    return unicodeView[
        unicodeView.index(
            unicodeView.startIndex,
            offsetBy: index)]
}

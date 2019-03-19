import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Freelance_botTests.allTests),
    ]
}
#endif
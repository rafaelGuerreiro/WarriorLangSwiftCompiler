//
//  StringCharacterExtensionsTests.swift
//  WarriorLangSwiftCompilerTests
//
//  Created by Rafael Guerreiro on 2018-10-02.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import XCTest

class StringCharacterExtensionsTests: XCTestCase {
}
// MARK: - Starts with
extension StringCharacterExtensionsTests {
    func test_endsWith() {
        XCTAssertTrue("".ends(with: ""))
        XCTAssertTrue("t".ends(with: "t"))
        XCTAssertTrue("test 123".ends(with: "123"))
        XCTAssertTrue("family emoji 👨‍👨‍👧‍👦a".ends(with: "👨‍👨‍👧‍👦a"))

        XCTAssertFalse("".ends(with: "something"))
        XCTAssertFalse("t".ends(with: "test"))
        XCTAssertFalse("test 123".ends(with: "test"))
        XCTAssertFalse("family emoji 👨‍👨‍👧‍👦a".ends(with: "👨‍👨‍👧‍👦"))
    }
}

// MARK: - Symbol
extension StringCharacterExtensionsTests {
    func test_isSymbolCharacter() {
        let validCharacters = [
            "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
            "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "_", "$"
        ]

        for valid in validCharacters {
            XCTAssertTrue(valid.isSymbolCharacter, "'\(valid)' is a valid symbol character.")
            XCTAssertTrue(valid.uppercased().isSymbolCharacter, "'\(valid.uppercased())' is a valid symbol character.")
        }

        let invalidCharacters = [
            "á", "", "&", "Á", "ä", "â",
            ";", ":", "-", "*", "#", "@", "~",
            "00", "11", "22", "33", "44", "55",
            "66", "77", "88", "99", "Some long text"
        ]

        for invalid in invalidCharacters {
            XCTAssertFalse(invalid.isSymbolCharacter, "Text '\(invalid)' is not a symbol character.")
        }
    }
}

// MARK: - Whitespace
extension StringCharacterExtensionsTests {
    func test_isWhiteSpaceCharacter() {
        XCTAssertTrue("\n".isWhiteSpaceCharacter, "\\n is whitespace character.")
        XCTAssertTrue(" ".isWhiteSpaceCharacter, "' ' is whitespace character.")
        XCTAssertTrue("\r".isWhiteSpaceCharacter, "\\r is whitespace character.")

        XCTAssertFalse("0".isWhiteSpaceCharacter, "'0' is not a whitespace character.")
        XCTAssertFalse("a".isWhiteSpaceCharacter, "'a' is not a whitespace character.")
        XCTAssertFalse("_".isWhiteSpaceCharacter, "'_' is not a whitespace character.")
    }
}

// MARK: - Line feed
extension StringCharacterExtensionsTests {
    func test_isLineFeedCharacter() {
        XCTAssertTrue("\n".isLineFeedCharacter, "\\n is line feed character.")
        XCTAssertTrue("\r".isLineFeedCharacter, "\\r is line feed character.")
        XCTAssertTrue("\r\n".isLineFeedCharacter, "\\r\\n is line feed character.")

        let invalids = [
            "\n\r", "a\n", "c",
            "d", "e", "f",
            "A", "B", "C",
            "D", "E", "F",
            "á", "z", "Z",
            "Á", "ä", "â",
            "00", "11", "22",
            "33", "44", "55",
            "66", "77", "88",
            "99", "Some long text"
        ]

        for invalid in invalids {
            XCTAssertFalse(invalid.isBinaryDigitCharacter, "Text '\(invalid)' is not line feed character.")
        }
    }
}

// MARK: - Numbers
extension StringCharacterExtensionsTests {
    func test_isBinaryDigitCharacter() {
        for digit in 0...1 {
            let digitString = String(digit)
            XCTAssertTrue(digitString.isBinaryDigitCharacter, "Digit '\(digit)' is a binary digit.")
            XCTAssertTrue(digitString.isValidDigitCharacter(radix: 2), "Digit '\(digit)' is a binary digit.")
        }

        for digit in 2...9 {
            let digitString = String(digit)
            XCTAssertFalse(digitString.isBinaryDigitCharacter, "Digit '\(digit)' is not a binary digit.")
            XCTAssertFalse(digitString.isValidDigitCharacter(radix: 2), "Digit '\(digit)' is not a binary digit.")
        }

        let invalidCharacters = [
            "a", "b", "c",
            "d", "e", "f",
            "A", "B", "C",
            "D", "E", "F",
            "á", "z", "Z",
            "Á", "ä", "â",
            "00", "11", "22",
            "33", "44", "55",
            "66", "77", "88",
            "99", "Some long text"
        ]

        for invalid in invalidCharacters {
            XCTAssertFalse(invalid.isBinaryDigitCharacter, "Text '\(invalid)' is not a binary digit.")
            XCTAssertFalse(invalid.isValidDigitCharacter(radix: 2), "Text '\(invalid)' is not a binary digit.")
        }
    }

    func test_isOctalDigitCharacter() {
        for digit in 0...7 {
            let digitString = String(digit)
            XCTAssertTrue(digitString.isOctalDigitCharacter, "Digit '\(digit)' is an octal digit.")
            XCTAssertTrue(digitString.isValidDigitCharacter(radix: 8), "Digit '\(digit)' is an octal digit.")
        }

        for digit in 8...9 {
            let digitString = String(digit)
            XCTAssertFalse(digitString.isOctalDigitCharacter, "Digit '\(digit)' is not an octal digit.")
            XCTAssertFalse(digitString.isValidDigitCharacter(radix: 8), "Digit '\(digit)' is not an octal digit.")
        }

        let invalidCharacters = [
            "a", "b", "c",
            "d", "e", "f",
            "A", "B", "C",
            "D", "E", "F",
            "á", "z", "Z",
            "Á", "ä", "â",
            "00", "11", "22",
            "33", "44", "55",
            "66", "77", "88",
            "99", "Some long text"
        ]

        for invalid in invalidCharacters {
            XCTAssertFalse(invalid.isOctalDigitCharacter, "Text '\(invalid)' is not an octal digit.")
            XCTAssertFalse(invalid.isValidDigitCharacter(radix: 8), "Text '\(invalid)' is not an octal digit.")
        }
    }

    func test_isDecimalDigitCharacter() {
        for digit in 0...9 {
            let digitString = String(digit)
            XCTAssertTrue(digitString.isDigitCharacter, "Digit '\(digit)' is a digit.")
            XCTAssertTrue(digitString.isDecimalDigitCharacter, "Digit '\(digit)' is a decimal digit.")
            XCTAssertTrue(digitString.isValidDigitCharacter(radix: 10), "Digit '\(digit)' is a decimal digit.")
        }

        let invalidCharacters = [
            "a", "b", "c",
            "d", "e", "f",
            "A", "B", "C",
            "D", "E", "F",
            "á", "z", "Z",
            "Á", "ä", "â",
            "00", "11", "22",
            "33", "44", "55",
            "66", "77", "88",
            "99", "Some long text"
        ]

        for invalid in invalidCharacters {
            XCTAssertFalse(invalid.isDigitCharacter, "Text '\(invalid)' is not a digit.")
            XCTAssertFalse(invalid.isDecimalDigitCharacter, "Text '\(invalid)' is not a decimal digit.")
            XCTAssertFalse(invalid.isValidDigitCharacter(radix: 10), "Text '\(invalid)' is not a decimal digit.")
        }
    }

    func test_isHexdecimalDigitCharacter() {
        for digit in 0...9 {
            let digitString = String(digit)
            XCTAssertTrue(digitString.isHexdecimalDigitCharacter, "Digit '\(digit)' is a hexdecimal digit.")
            XCTAssertTrue(digitString.isValidDigitCharacter(radix: 16), "Digit '\(digit)' is a hexdecimal digit.")
        }

        for digitString in [ "a", "b", "c", "d", "e", "f",
                       "A", "B", "C", "D", "E", "F" ]
        {
            XCTAssertTrue(digitString.isHexdecimalDigitCharacter, "Digit '\(digitString)' is a hexdecimal digit.")
            XCTAssertTrue(digitString.isValidDigitCharacter(radix: 16), "Digit '\(digitString)' is a hexdecimal digit.")
        }

        let invalidCharacters = [
            "á", "z", "Z",
            "Á", "ä", "â",
            "00", "11", "22",
            "33", "44", "55",
            "66", "77", "88",
            "99", "Some long text"
        ]

        for invalid in invalidCharacters {
            XCTAssertFalse(invalid.isHexdecimalDigitCharacter, "Text '\(invalid)' is not a hexdecimal digit.")
            XCTAssertFalse(invalid.isValidDigitCharacter(radix: 16), "Text '\(invalid)' is not a hexdecimal digit.")
        }
    }

    func test_isValidDigitCharacter() {
        let valid: [UInt8] = [2, 8, 10, 16]

        for radix in 0...UInt8.max {
            if valid.contains(radix) {
                XCTAssertTrue("0".isValidDigitCharacter(radix: radix), "Radix '\(radix)' is should be valid for digit '0'.")
            } else {
                XCTAssertFalse("0".isValidDigitCharacter(radix: radix), "Radix '\(radix)' is not supported.")
            }
        }
    }

    func test_isExponentialIdentifierCharacter() {
        let valid: [UInt8 : (other: UInt8, chars: [String])] = [
            10 : (other: 16, chars: ["e", "E"]),
            16 : (other: 10, chars: ["p", "P"])
        ]

        for radix in 0...UInt8.max {
            if let tuple = valid[radix] {
                for char in tuple.chars {
                    XCTAssertTrue(char.isExponentialIdentifierCharacter(radix: radix), "Radix '\(radix)' is should be valid for char '\(char)'.")
                }

                if let invalidCharsForRadix = valid[tuple.other]?.chars {
                    for char in invalidCharsForRadix {
                        XCTAssertFalse(char.isExponentialIdentifierCharacter(radix: radix), "Radix '\(radix)' is not supported for char '\(char)'.")
                    }
                }
            } else {
                XCTAssertFalse("e".isExponentialIdentifierCharacter(radix: radix), "Radix '\(radix)' is not supported for char 'e'.")
                XCTAssertFalse("p".isExponentialIdentifierCharacter(radix: radix), "Radix '\(radix)' is not supported for char 'p'.")
            }
        }
    }
}

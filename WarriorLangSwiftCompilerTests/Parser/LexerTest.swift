//
//  LexerTest.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-27.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import XCTest

class LexerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: - Numbers
extension LexerTest {
    func test_isBinaryDigit() {
        for digit in 0...1 {
            XCTAssertTrue(Lexer.isBinaryDigit(String(digit)), "Digit '\(digit)' is a binary digit.")
            XCTAssertTrue(Lexer.isValidDigit(String(digit), radix: 2), "Digit '\(digit)' is a binary digit.")
        }

        for digit in 2...9 {
            XCTAssertFalse(Lexer.isBinaryDigit(String(digit)), "Digit '\(digit)' is not a binary digit.")
            XCTAssertFalse(Lexer.isValidDigit(String(digit), radix: 2), "Digit '\(digit)' is not a binary digit.")
        }

        let invalids = [
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

        for invalid in invalids {
            XCTAssertFalse(Lexer.isBinaryDigit(invalid), "Text '\(invalid)' is not a binary digit.")
            XCTAssertFalse(Lexer.isValidDigit(invalid, radix: 2), "Text '\(invalid)' is not a binary digit.")
        }
    }

    func test_isOctalDigit() {
        for digit in 0...7 {
            XCTAssertTrue(Lexer.isOctalDigit(String(digit)), "Digit '\(digit)' is an octal digit.")
            XCTAssertTrue(Lexer.isValidDigit(String(digit), radix: 8), "Digit '\(digit)' is an octal digit.")
        }

        for digit in 8...9 {
            XCTAssertFalse(Lexer.isOctalDigit(String(digit)), "Digit '\(digit)' is not an octal digit.")
            XCTAssertFalse(Lexer.isValidDigit(String(digit), radix: 8), "Digit '\(digit)' is not an octal digit.")
        }

        let invalids = [
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

        for invalid in invalids {
            XCTAssertFalse(Lexer.isOctalDigit(invalid), "Text '\(invalid)' is not an octal digit.")
            XCTAssertFalse(Lexer.isValidDigit(invalid, radix: 8), "Text '\(invalid)' is not an octal digit.")
        }
    }

    func test_isDecimalDigit() {
        for digit in 0...9 {
            XCTAssertTrue(Lexer.isDecimalDigit(String(digit)), "Digit '\(digit)' is a decimal digit.")
            XCTAssertTrue(Lexer.isValidDigit(String(digit), radix: 10), "Digit '\(digit)' is a decimal digit.")
        }

        let invalids = [
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

        for invalid in invalids {
            XCTAssertFalse(Lexer.isDecimalDigit(invalid), "Text '\(invalid)' is not a decimal digit.")
            XCTAssertFalse(Lexer.isValidDigit(invalid, radix: 10), "Text '\(invalid)' is not a decimal digit.")
        }
    }

    func test_isHexdecimalDigit() {
        for digit in 0...9 {
            XCTAssertTrue(Lexer.isHexdecimalDigit(String(digit)), "Digit '\(digit)' is a hexdecimal digit.")
            XCTAssertTrue(Lexer.isValidDigit(String(digit), radix: 16), "Digit '\(digit)' is a hexdecimal digit.")
        }

        for digit in [ "a", "b", "c", "d", "e", "f",
                       "A", "B", "C", "D", "E", "F" ]
        {
            XCTAssertTrue(Lexer.isHexdecimalDigit(String(digit)), "Digit '\(digit)' is a hexdecimal digit.")
            XCTAssertTrue(Lexer.isValidDigit(String(digit), radix: 16), "Digit '\(digit)' is a hexdecimal digit.")
        }

        let invalids = [
            "á", "z", "Z",
            "Á", "ä", "â",
            "00", "11", "22",
            "33", "44", "55",
            "66", "77", "88",
            "99", "Some long text"
        ]

        for invalid in invalids {
            XCTAssertFalse(Lexer.isHexdecimalDigit(invalid), "Text '\(invalid)' is not a hexdecimal digit.")
            XCTAssertFalse(Lexer.isValidDigit(invalid, radix: 16), "Text '\(invalid)' is not a hexdecimal digit.")
        }
    }

    func test_isValidDigit() {
        let valid: [UInt8] = [2, 8, 10, 16]

        for radix in 0...UInt8.max {
            if valid.contains(radix) {
                XCTAssertTrue(Lexer.isValidDigit("0", radix: radix), "Radix '\(radix)' is should be valid for digit '0'.")
            } else {
                XCTAssertFalse(Lexer.isValidDigit("0", radix: radix), "Radix '\(radix)' is not supported.")
            }
        }
    }

    func test_isExponentialIdentifier() {
        let valid: [UInt8 : (other: UInt8, chars: [String])] = [
            10 : (other: 16, chars: ["e", "E"]),
            16 : (other: 10, chars: ["p", "P"])
        ]

        for radix in 0...UInt8.max {
            if let tuple = valid[radix] {
                for char in tuple.chars {
                    XCTAssertTrue(Lexer.isExponentialIdentifier(char, radix: radix), "Radix '\(radix)' is should be valid for char '\(char)'.")
                }

                if let invalidCharsForRadix = valid[tuple.other]?.chars {
                    for char in invalidCharsForRadix {
                        XCTAssertFalse(Lexer.isExponentialIdentifier(char, radix: radix), "Radix '\(radix)' is not supported for char '\(char)'.")
                    }
                }
            } else {
                XCTAssertFalse(Lexer.isExponentialIdentifier("e", radix: radix), "Radix '\(radix)' is not supported for char 'e'.")
                XCTAssertFalse(Lexer.isExponentialIdentifier("p", radix: radix), "Radix '\(radix)' is not supported for char 'p'.")
            }
        }
    }
}

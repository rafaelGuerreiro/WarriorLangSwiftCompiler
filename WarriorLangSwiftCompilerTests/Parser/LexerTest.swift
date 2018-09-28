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

    func testIsBinaryNumber() {
        XCTAssert(Lexer.isBinaryDigit("0") == true)
        XCTAssert(Lexer.isBinaryDigit("1") == true)

        XCTAssert(Lexer.isBinaryDigit("2") == false)
        XCTAssert(Lexer.isBinaryDigit("a") == false)
        XCTAssert(Lexer.isBinaryDigit("F") == false)
        XCTAssert(Lexer.isBinaryDigit("Some long value") == false)
    }

}

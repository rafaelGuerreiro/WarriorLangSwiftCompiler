//
//  LexerTest.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-27.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import XCTest

class LexerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    public func asInputStream(_ string: String) throws -> InputStream {
        guard let data = string.data(using: .utf8) else {
            throw LexerTestsError(message: "Unable to extract utf8 data from string \"\(string)\"")
        }

        return InputStream(data: data)
    }
}

struct LexerTestsError: Error {
    var message: String
}

extension LexerTests {
    func test_parseSimpleClass() throws {
        let inputStream = try asInputStream("""
        class SimpleClass {
            function fn() -> String {
                return "Hello world.";
            }
        }
        """)

        let lexer = try Lexer(reading: inputStream)
        for token in lexer.tokens {
            print(token.category)
        }
    }
}

//
//  Token.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-27.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import Foundation

public class Token {
    public let category: TokenCategory
    public let value: String
    public let file: String
    public let range: TokenRange

    init(category: TokenCategory,
         value: String,
         file: String,
         range: TokenRange)
    {
        self.category = category
        self.value = value
        self.file = file
        self.range = range
    }

    public func isCategory(_ category: TokenCategory) -> Bool {
        return self.category == category
    }
}

extension Token: CustomStringConvertible {
    public var description: String {
        return "\(category): \(range) => '\(value)'";
    }
}

public class NumberLiteralToken: Token {
    public let radix: UInt8 // 2, 8, 10, 16
    public let isFloatingPoint: Bool // [digit]\.[digit]

    init(token: Token, radix: UInt8, isFloatingPoint: Bool) {
        self.radix = radix
        self.isFloatingPoint = isFloatingPoint

        super.init(category: token.category,
                   value: token.value,
                   file: token.file,
                   range: token.range)
    }
}


class TokenBuilder: CustomStringConvertible {
    let file: String

    private(set) var value: String = ""
    private(set) var range: TokenRange
    private(set) var radix: UInt8?
    private var floatingPoint: Bool?

    init(file: String) {
        self.file = file
        self.range = TokenRange(file: file)
    }

    func reset() {
        self.value = ""
        self.range = TokenRange(file: file, index: range.endIndex, line: range.endLine, column: range.endColumn)
        self.radix = nil
        self.floatingPoint = nil
    }

    func increment(char: String) {
        self.value += char
        self.range.increment(char: char)
    }

    func radix(_ radix: UInt8) {
        self.radix = radix
    }

    var isFloatingPoint: Bool {
        return self.floatingPoint ?? false
    }

    func isFloatingPoint(_ floatingPoint: Bool) {
        self.floatingPoint = floatingPoint
    }

    func build(category: TokenCategory) -> Token {
        let token = Token(category: category,
                          value: value,
                          file: file,
                          range: range)

        if let radix = self.radix,
            let floatingPoint = self.floatingPoint
        {
            return NumberLiteralToken(token: token, radix: radix, isFloatingPoint: floatingPoint)
        }

        return token
    }

    var description: String {
        return "file: \(file), value: \"\(value)\", range: \(range), radix: \(String(describing: radix)), isFloatingPoint: \(String(describing: floatingPoint))"
    }
}

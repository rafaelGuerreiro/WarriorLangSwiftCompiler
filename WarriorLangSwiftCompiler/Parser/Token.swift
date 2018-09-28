//
//  Token.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-27.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import Foundation

public class Token {
    public let token: TokenCategory
    public let value: String
    public let file: String
    public let indices: Range<UInt64>
    public let lines: Range<UInt64>
    public let columns: Range<UInt64>

    init(token: TokenCategory,
         value: String,
         file: String,
         indices: Range<UInt64>,
         lines: Range<UInt64>,
         columns: Range<UInt64>)
    {
        self.token = token
        self.value = value
        self.file = file
        self.indices = indices
        self.lines = lines
        self.columns = columns
    }
}

public class NumberLiteralToken: Token {
    public let radix: UInt8 // 2, 8, 10, 16
    public let isFloatingPoint: Bool // [digit]\.[digit]

    init(token: TokenCategory,
         value: String,
         file: String,
         indices: Range<UInt64>,
         lines: Range<UInt64>,
         columns: Range<UInt64>,
         radix: UInt8,
         isFloatingPoint: Bool)
    {
        self.radix = radix
        self.isFloatingPoint = isFloatingPoint

        super.init(token: token, value: value, file: file, indices: indices, lines: lines, columns: columns)
    }
}


class TokenBuilder {
    private var token: TokenCategory?
    private var value: String?
    private var file: String?
    private var indices: Range<UInt64>?
    private var lines: Range<UInt64>?
    private var columns: Range<UInt64>?
    private var radix: UInt8?
    private var isFloatingPoint: Bool?

    func reset() -> TokenBuilder {
        self.token = nil
        self.value = nil
        self.file = nil
        self.indices = nil
        self.lines = nil
        self.columns = nil
        self.radix = nil
        self.isFloatingPoint = nil
        return self
    }

    func token(_ token: TokenCategory) -> TokenBuilder {
        self.token = token
        return self
    }

    func value(_ value: String) -> TokenBuilder {
        self.value = value
        return self
    }

    func file(_ file: String) -> TokenBuilder {
        self.file = file
        return self
    }

    func indices(_ indices: Range<UInt64>) -> TokenBuilder {
        self.indices = indices
        return self
    }

    func lines(_ lines: Range<UInt64>) -> TokenBuilder {
        self.lines = lines
        return self
    }

    func columns(_ columns: Range<UInt64>) -> TokenBuilder {
        self.columns = columns
        return self
    }

    func radix(_ radix: UInt8) -> TokenBuilder {
        self.radix = radix
        return self
    }

    func isFloatingPoint(_ isFloatingPoint: Bool) -> TokenBuilder {
        self.isFloatingPoint = isFloatingPoint
        return self
    }

    func build() -> Token? {
        guard let token = self.token,
            let value = self.value,
            let file = self.file,
            let indices = self.indices,
            let lines = self.lines,
            let columns = self.columns else
        {
            return nil
        }

        if let radix = self.radix,
            let isFloatingPoint = self.isFloatingPoint
        {
            return NumberLiteralToken(token: token,
                                      value: value,
                                      file: file,
                                      indices: indices,
                                      lines: lines,
                                      columns: columns,
                                      radix: radix,
                                      isFloatingPoint: isFloatingPoint)
        }

        return Token(token: token,
                     value: value,
                     file: file,
                     indices: indices,
                     lines: lines,
                     columns: columns)
    }
}

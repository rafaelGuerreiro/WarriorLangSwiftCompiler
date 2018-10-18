//
//  TokenRange.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-28.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import Foundation

public struct TokenRange: CustomStringConvertible {
    public let file: String

    public private(set) var startIndex: UInt64
    public private(set) var endIndex: UInt64

    public private(set) var startLine: UInt64
    public private(set) var endLine: UInt64

    public private(set) var startColumn: UInt64
    public private(set) var endColumn: UInt64

    public init(file: String) {
        self.file = file
        self.startIndex = 0
        self.endIndex = 0
        self.startLine = 0
        self.endLine = 0
        self.startColumn = 0
        self.endColumn = 0
    }

    public init(file: String, index: UInt64, line: UInt64, column: UInt64) {
        self.file = file
        self.startIndex = index
        self.endIndex = index
        self.startLine = line
        self.endLine = line
        self.startColumn = column
        self.endColumn = column
    }

    public var description: String {
        return "\(file)@(\(startLine):\(startColumn), \(endLine):\(endColumn)) \(startIndex):\(endIndex)"
    }

    public mutating func increment(char: String) {
        let unicodeScalars = UInt64(char.unicodeScalars.count)

        if (char.isLineFeedCharacter) {
            endColumn = 0
            endLine += 1
        } else {
            endColumn += unicodeScalars
        }

        endIndex += unicodeScalars
    }
}

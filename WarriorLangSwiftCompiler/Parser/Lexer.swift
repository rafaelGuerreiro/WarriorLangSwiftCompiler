//
//  Lexer.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-27.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import Foundation

public class Lexer {
    private static let BUFFER_SIZE: Int = 8.kilobyte
    private static let TOKENS_CAPACITY: Int = 1024

    private let inputStream: InputStream
    public private(set) var tokens: [Token]

    init(reading inputStream: InputStream) {
        self.inputStream = inputStream
        self.tokens = [Token]()
        tokens.reserveCapacity(Lexer.TOKENS_CAPACITY)
    }

    public func parse() throws {
        try read { utf8BufferString in
            //
        }
    }
}

// MARK: - Numbers
extension Lexer {
    private static func singleUnicode(_ string: String) -> UInt32? {
        let unicode = string.unicodeScalars
        guard unicode.count == 1 else { return nil }
        return unicode[unicode.startIndex].value
    }

    private static func unicodeRange(_ from: String, _ to: String) -> Range<UInt32> {
        guard let from = singleUnicode(from),
            let to = singleUnicode(to)
        else { return 0..<0 }

        return from..<(to + 1)
    }

    static func isBinaryDigit(_ char: String) -> Bool {
        guard let charUnicode = singleUnicode(char) else { return false }
        return unicodeRange("0", "1").contains(charUnicode)
    }

    static func isOctalDigit(_ char: String) -> Bool {
        guard let charUnicode = singleUnicode(char) else { return false }
        return unicodeRange("0", "7").contains(charUnicode)
    }

    static func isDecimalDigit(_ char: String) -> Bool {
        guard let charUnicode = singleUnicode(char) else { return false }
        return unicodeRange("0", "9").contains(charUnicode)
    }

    static func isHexdecimalDigit(_ char: String) -> Bool {
        guard let charUnicode = singleUnicode(char) else { return false }
        return isDecimalDigit(char) ||
            unicodeRange("a", "f").contains(charUnicode) ||
            unicodeRange("A", "F").contains(charUnicode)
    }

    static func isValidDigit(_ char: String, radix: UInt8) -> Bool {
        switch radix {
        case 2:  return isBinaryDigit(char)
        case 8:  return isOctalDigit(char)
        case 10: return isDecimalDigit(char)
        case 16: return isHexdecimalDigit(char)
        default: return false
        }
    }

    static func isExponentialIdentifier(_ char: String, radix: UInt8) -> Bool {
        switch radix {
        case 10: return char == "e" || char == "E"
        case 16: return char == "p" || char == "P"
        default: return false
        }
    }
}
// MARK: - InputStream reader
fileprivate extension Lexer {
    private func read(consumer: (String) -> Void) throws {
        inputStream.open()
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Lexer.BUFFER_SIZE)
        while inputStream.hasBytesAvailable {
            let read = inputStream.read(buffer, maxLength: Lexer.BUFFER_SIZE)

            guard read > 0 else { throw LexerError.unableToReadInputStream(streamError: inputStream.streamError) }

            var data = Data.init(capacity: Lexer.BUFFER_SIZE)
            data.append(buffer, count: read)

            guard let string = String(data: data, encoding: .utf8) else { throw LexerError.unableToConvertDataToString(data: data) }
            consumer(string);
        }
        buffer.deallocate()
        inputStream.close()
    }
}

// MARK: -
public enum LexerError: Error {
    case unableToReadInputStream(streamError: Error?)
    case unableToConvertDataToString(data: Data)
}

//
//  StringExtensions.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-27.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import Foundation

// MARK: - Character verification
public extension String {
    // MARK: - Ends with
    public func ends<PossibleSuffix>(with possibleSuffix: PossibleSuffix, by areEquivalent: (Character, PossibleSuffix.Element) throws -> Bool) rethrows -> Bool where PossibleSuffix : Sequence {
        return try reversed().starts(with: possibleSuffix.reversed(), by: areEquivalent)
    }

    public func ends<PossibleSuffix>(with possibleSuffix: PossibleSuffix) -> Bool where PossibleSuffix : Sequence, Character == PossibleSuffix.Element {
        return ends(with: possibleSuffix) { char, suffix in
            return char == suffix
        }
    }

    // MARK: - Symbol
    // Anything that could be part of a name: [a-zA-Z0-9_$]
    public var isSymbolCharacter: Bool {
        guard let charUnicode = singleUnicode else { return false }
        return self == "_" ||
            self == "$" ||
            isDigitCharacter ||
            String.unicodeRange("a", "z").contains(charUnicode) ||
            String.unicodeRange("A", "Z").contains(charUnicode)
    }

    // MARK: - Whitespace
    public var isWhiteSpaceCharacter: Bool {
        let whitespaces: [String] = [
            "\u{0009}",
            "\u{000A}",
            "\u{000B}",
            "\u{000C}",
            "\u{000D}",
            "\u{0020}",
            "\u{0085}",
            "\u{00A0}",
            "\u{2000}",
            "\u{2001}",
            "\u{2002}",
            "\u{2003}",
            "\u{2004}",
            "\u{2005}",
            "\u{2006}",
            "\u{2007}",
            "\u{2008}",
            "\u{2009}",
            "\u{200A}",
            "\u{2028}",
            "\u{2029}",
            "\u{202F}",
            "\u{205F}",
            "\u{3000}"
        ]

        return whitespaces.contains(self)
    }

    // MARK: - Line feed
    public var isLineFeedCharacter: Bool {
        return self == "\n" || self == "\r" || self == "\r\n"
    }

    // MARK: - Numbers
    private var singleUnicode: UInt32? {
        let unicode = unicodeScalars
        guard unicode.count == 1 else { return nil }
        return unicode[unicode.startIndex].value
    }

    private static func unicodeRange(_ from: String, _ to: String) -> Range<UInt32> {
        guard let from = from.singleUnicode,
            let to = to.singleUnicode
            else { return 0..<0 }

        return from..<(to + 1)
    }

    public var isBinaryDigitCharacter: Bool {
        guard let charUnicode = singleUnicode else { return false }
        return String.unicodeRange("0", "1").contains(charUnicode)
    }

    public var isOctalDigitCharacter: Bool {
        guard let charUnicode = singleUnicode else { return false }
        return String.unicodeRange("0", "7").contains(charUnicode)
    }

    public var isDecimalDigitCharacter: Bool {
        return isDigitCharacter
    }

    public var isDigitCharacter: Bool {
        guard let charUnicode = singleUnicode else { return false }
        return String.unicodeRange("0", "9").contains(charUnicode)
    }

    public var isHexdecimalDigitCharacter: Bool {
        guard let charUnicode = singleUnicode else { return false }
        return isDecimalDigitCharacter ||
            String.unicodeRange("a", "f").contains(charUnicode) ||
            String.unicodeRange("A", "F").contains(charUnicode)
    }

    public func isValidDigitCharacter(radix: UInt8) -> Bool {
        switch radix {
        case 2:  return isBinaryDigitCharacter
        case 8:  return isOctalDigitCharacter
        case 10: return isDecimalDigitCharacter
        case 16: return isHexdecimalDigitCharacter
        default: return false
        }
    }

    public func isExponentialIdentifierCharacter(radix: UInt8) -> Bool {
        switch radix {
        case 10: return self == "e" || self == "E"
        case 16: return self == "p" || self == "P"
        default: return false
        }
    }
}

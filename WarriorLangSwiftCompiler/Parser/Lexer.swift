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

    private let builder: TokenBuilder

    private var currentCharacter: String = ""
    private var states: [LexerState] = [.start]

    init(reading inputStream: InputStream) throws {
        self.inputStream = inputStream
        self.builder = TokenBuilder(file: "file-name.wl")
        self.tokens = [Token]()
        tokens.reserveCapacity(Lexer.TOKENS_CAPACITY)

        try parse()
    }
}

// MARK: - Parser
public extension Lexer {
    private func parse() throws {
        try read { utf8BufferString in
            let endIndex = utf8BufferString.endIndex
            var index = utf8BufferString.startIndex
            var readNextCharacter = true

            while true {
                if readNextCharacter {
                    if index == endIndex { break; }
                    currentCharacter = String(utf8BufferString[index])
                }

                guard let state = self.state else { break; }
                parseState(state, &readNextCharacter)
                index = utf8BufferString.index(after: index)
            }
        }

        appendEndOfFileToken()
    }

    private func parseState(_ state: LexerState, _ readNextCharacter: inout Bool) {
        switch state {
        case .stringLiteralInterpolation: lexerStateStart(&readNextCharacter)
        case .openParenthesis: lexerStateStart(&readNextCharacter)
        case .start: lexerStateStart(&readNextCharacter)
        case .symbol: lexerStateSymbol(&readNextCharacter)
        case .identifier: lexerStateIdentifier(&readNextCharacter)
        case .numberLiteralZero: lexerStateZero(&readNextCharacter)
        case .numberLiteral: lexerStateNumber(&readNextCharacter)
        case .numberLiteralExponential: lexerStateNumberExponential(&readNextCharacter)
        case .compilerDirective: lexerStateCompilerDirective(&readNextCharacter)
        case .slash: lexerStateSlash(&readNextCharacter)
        case .inlineComment: lexerStateInlineComment(&readNextCharacter)
        case .blockComment: lexerStateBlockComment(&readNextCharacter)
        case .dot: lexerStateDot(&readNextCharacter)
        case .dash: lexerStateDash(&readNextCharacter)
        case .stringLiteral: lexerStateStringLiteral(&readNextCharacter)
        case .stringLiteralEscape: lexerStateStringLiteralEscape(&readNextCharacter)
        case .characterLiteral: lexerStateCharacterLiteral(&readNextCharacter)
        case .characterLiteralEscape: lexerStateCharacterLiteralEscape(&readNextCharacter)
        }
    }
}

// MARK: - Lexer state methods
fileprivate extension Lexer {
    private func lexerStateStart(_ readNextCharacter: inout Bool) {
        readNextCharacter = true

        if currentCharacter.isWhiteSpaceCharacter {
            if !isLastToken(category: .space) {
                appendSingleCharacterToken(category: .space)
            }
        } else if currentCharacter == "0" {
            tokenStart(state: .numberLiteralZero)
        } else if currentCharacter.isDigitCharacter {
            tokenStart(state: .numberLiteral)
        } else if currentCharacter.isSymbolCharacter {
            tokenStart(state: .symbol)
        } else if currentCharacter == "\"" {
            tokenStart(state: .stringLiteral, appendCurrentCharacter: false)
        } else if currentCharacter == "'" {
            tokenStart(state: .characterLiteral, appendCurrentCharacter: false)
        } else if currentCharacter == "/" {
            tokenStart(state: .slash)
        } else if currentCharacter == "-" {
            tokenStart(state: .dash)
        } else if currentCharacter == "#" {
            tokenStart(state: .compilerDirective)
        } else if currentCharacter == "`" {
            tokenStart(state: .identifier, appendCurrentCharacter: false)
        } else if currentCharacter == "(" {
            appendSingleCharacterToken(category: .punctuationLeftParenthesis)
            tokenStart(state: .openParenthesis)
        } else if currentCharacter == ")" {
            let oldState: LexerState? = leaveState()
            if oldState == nil || oldState == .openParenthesis {
                appendSingleCharacterToken(category: .punctuationRightParenthesis)
            }
        } else if currentCharacter == "." {
            tokenStart(state: .dot)
        }

        // Single char tokens
        else if currentCharacter == "{" {
            appendSingleCharacterToken(category: .punctuationLeftCurlyBrace);
        } else if currentCharacter == "}" {
            appendSingleCharacterToken(category: .punctuationRightCurlyBrace);
        } else if currentCharacter == "[" {
            appendSingleCharacterToken(category: .punctuationLeftSquareBrackets);
        } else if currentCharacter == "]" {
            appendSingleCharacterToken(category: .punctuationRightSquareBrackets);
        } else if currentCharacter == "<" {
            appendSingleCharacterToken(category: .punctuationLeftAngleBrackets);
        } else if currentCharacter == ">" {
            appendSingleCharacterToken(category: .punctuationRightAngleBrackets);
        } else if currentCharacter == "," {
            appendSingleCharacterToken(category: .punctuationComma);
        } else if currentCharacter == ":" {
            appendSingleCharacterToken(category: .punctuationColon);
        } else if currentCharacter == ";" {
            appendSingleCharacterToken(category: .punctuationSemicolon);
        } else if currentCharacter == "+" {
            appendSingleCharacterToken(category: .punctuationPlus);
        } else if currentCharacter == "*" {
            appendSingleCharacterToken(category: .punctuationAsterisk);
        } else if currentCharacter == "^" {
            appendSingleCharacterToken(category: .punctuationXor);
        } else if currentCharacter == "|" {
            appendSingleCharacterToken(category: .punctuationPipe);
        } else if currentCharacter == "%" {
            appendSingleCharacterToken(category: .punctuationPercent);
        } else if currentCharacter == "~" {
            appendSingleCharacterToken(category: .punctuationTilde);
        } else if currentCharacter == "=" {
            appendSingleCharacterToken(category: .punctuationEqual);
        } else if currentCharacter == "@" {
            appendSingleCharacterToken(category: .punctuationAt);
        } else if currentCharacter == "&" {
            appendSingleCharacterToken(category: .punctuationAmpersand);
        } else if currentCharacter == "\\" {
            appendSingleCharacterToken(category: .punctuationBackslash);
        } else if currentCharacter == "!" {
            appendSingleCharacterToken(category: .punctuationExclamation);
        } else if currentCharacter == "?" {
            appendSingleCharacterToken(category: .punctuationQuestion);
        } else {
            #warning("Add more details on this error. Don't make it a fatalError, but a diagnostic reporter.")
            fatalError("Unknown character: \(currentCharacter)")
        }
    }

    private func lexerStateSymbol(_ readNextCharacter: inout Bool) {
        // First char is alpha.
        if currentCharacter.isSymbolCharacter {
            builder.increment(char: currentCharacter)
        } else {
            if let category = Keyword.keywords[builder.value] {
                tokenEnd(category: category)
            } else {
                tokenEnd(category: .identifier)
            }
            readNextCharacter = false
        }
    }

    private func lexerStateIdentifier(_ readNextCharacter: inout Bool) {
        // First char is `.
        readNextCharacter = true
        if currentCharacter.isSymbolCharacter {
            builder.increment(char: currentCharacter)
        } else if !builder.value.isEmpty && currentCharacter.isDigitCharacter {
            builder.increment(char: currentCharacter)
        } else if currentCharacter == "`" {
            tokenEnd(category: .identifier)
        } else {
            #warning("Add more details on this error. Don't make it a fatalError, but a diagnostic reporter.")
            fatalError("Invalid token currentCharacter: \"\(currentCharacter)\", builder: \(builder)")
        }
    }

    private func lexerEndNumberToken(_ readNextCharacter: inout Bool) {
        let category: TokenCategory = builder.isFloatingPoint == true ? .literalFloat : .literalInteger
        tokenEnd(category: category)

        readNextCharacter = false
    }

    private func lexerStateZero(_ readNextCharacter: inout Bool) {
        // First char is 0.
        readNextCharacter = true
        switchState(.numberLiteral)

        if currentCharacter == "x" {
            builder.radix(16)
            builder.increment(char: currentCharacter)
        } else if currentCharacter == "o" {
            builder.radix(8)
            builder.increment(char: currentCharacter)
        } else if currentCharacter == "b" {
            builder.radix(2)
            builder.increment(char: currentCharacter)
        } else if !builder.isFloatingPoint && currentCharacter == "." {
            builder.isFloatingPoint(true)
            builder.increment(char: currentCharacter)
        } else if currentCharacter == "_" || currentCharacter.isDigitCharacter {
            builder.increment(char: currentCharacter)
        } else {
            readNextCharacter = false

            builder.radix(10)
            builder.isFloatingPoint(false)
            tokenEnd(category: .literalInteger)
        }
    }

    private func lexerStateNumber(_ readNextCharacter: inout Bool) {
        // First char is a digit different than zero.
        let radix = builder.radix ?? 10
        builder.radix(radix)

        readNextCharacter = true

        if currentCharacter == "_" {
            builder.increment(char: currentCharacter)
        } else if !builder.isFloatingPoint && currentCharacter == "." {
            #warning("implement here: this->tryToReadNextCharacter();")

            if currentCharacter.isDigitCharacter || currentCharacter == "_" {
                builder.isFloatingPoint(true)
                builder.increment(char: ".")
                builder.increment(char: currentCharacter)
                readNextCharacter = true
            } else {
                lexerEndNumberToken(&readNextCharacter)
                readNextCharacter = false
                tokenStart(state: .dot, appendCurrentCharacter: false)
                builder.increment(char: ".")
            }
        } else if currentCharacter.isValidDigitCharacter(radix: radix) {
            builder.increment(char: currentCharacter)
        } else if currentCharacter.isExponentialIdentifierCharacter(radix: radix) {
            builder.increment(char: currentCharacter)
            builder.isFloatingPoint(true)
            enterState(.numberLiteralExponential)
        } else {
            lexerEndNumberToken(&readNextCharacter)
        }
    }

    private func lexerStateNumberExponential(_ readNextCharacter: inout Bool) {
        // last digit was e or p.
        readNextCharacter = true
        if currentCharacter.isValidDigitCharacter(radix: builder.radix ?? 10) ||
            currentCharacter == "+" ||
            currentCharacter == "-" {
            builder.increment(char: currentCharacter)
            leaveState()
        } else {
            lexerEndNumberToken(&readNextCharacter)
        }
    }

    private func lexerStateCompilerDirective(_ readNextCharacter: inout Bool) {
        // First char is #
        readNextCharacter = true
        if currentCharacter.isSymbolCharacter {
            builder.increment(char: currentCharacter)
        } else {
            if let category = Keyword.compilerDirectiveKeywords[builder.value] {
                tokenEnd(category: category)
            } else {
                if builder.value == "#" {
                    tokenEnd(category: .punctuationPound)
                } else {
                    tokenEnd(category: .identifier)
                }
            }

            readNextCharacter = false;
        }
    }

    private func lexerStateSlash(_ readNextCharacter: inout Bool) {
        // First char is /
        // This could be an inline comment, a block comment or a slash.
        readNextCharacter = true
        if currentCharacter == "/" {
            switchState(.inlineComment)
            builder.increment(char: currentCharacter)
        } else if currentCharacter == "*" {
            switchState(.blockComment)
            builder.increment(char: currentCharacter)
        } else {
            tokenEnd(category: .punctuationSlash)
            readNextCharacter = false
        }
    }

    private func lexerStateInlineComment(_ readNextCharacter: inout Bool) {
        readNextCharacter = true
        if currentCharacter.isLineFeedCharacter {
            tokenEnd(category: .comment)
            readNextCharacter = false
        } else {
            builder.increment(char: currentCharacter)
        }
    }

    private func lexerStateBlockComment(_ readNextCharacter: inout Bool) {
        readNextCharacter = true

        if builder.value.ends(with: "*/") {
            tokenEnd(category: .comment)
            readNextCharacter = false
        } else {
            builder.increment(char: currentCharacter)
        }
    }

    private func lexerStateDot(_ readNextCharacter: inout Bool) {
        // First char is . not part of a number.

        // ...
        // ..<
        // .method | .variable

        readNextCharacter = true
        if currentCharacter == "." &&
            (builder.value == "." || builder.value == "..") {
            builder.increment(char: currentCharacter)
            if builder.value == "..." {
                tokenEnd(category: .composedClosedRange)
            }
        } else if currentCharacter == "<" && builder.value == ".." {
            builder.increment(char: currentCharacter)
            if builder.value == "..<" {
                tokenEnd(category: .composedHalfOpenRange)
            }
        } else {
            tokenEnd(category: .punctuationDot)
            readNextCharacter = false
        }
    }

    private func lexerStateDash(_ readNextCharacter: inout Bool) {
        // First char is -
        readNextCharacter = true
        if currentCharacter == ">" {
            builder.increment(char: currentCharacter)
            tokenEnd(category: .composedPunctuationArrow)
        } else {
            tokenEnd(category: .punctuationMinus)
            readNextCharacter = false
        }
    }

    private func lexerStateStringLiteral(_ readNextCharacter: inout Bool) {
        readNextCharacter = true
        if currentCharacter == "\\" {
            enterState(.stringLiteralEscape)
        } else if currentCharacter == "\"" {
            tokenEnd(category: .literalString)
        } else {
            builder.increment(char: currentCharacter)
        }
    }

    private func lexerStateStringLiteralEscape(_ readNextCharacter: inout Bool) {
        // Previous character was a \ .
        readNextCharacter = true
        leaveState()

        if currentCharacter == "(" {
            tokenEnd(category: .literalString)
            enterState(.stringLiteral)
            enterState(.stringLiteralInterpolation)
        }
        else if currentCharacter == "n" { builder.increment(char: "\n") }
        else if currentCharacter == "\"" { builder.increment(char: "\"") }
        else if currentCharacter == "'" { builder.increment(char: "'") }
        else if currentCharacter == "t" { builder.increment(char: "\t") }
        else if currentCharacter == "r" { builder.increment(char: "\r") }
        else if currentCharacter == "\\" { builder.increment(char: "\\") }
        else {
            #warning("Add more details on this error. Don't make it a fatalError, but a diagnostic reporter.")
            fatalError("Unkown escaping character: '\\\(currentCharacter)'")
        }
    }

    private func lexerStateCharacterLiteral(_ readNextCharacter: inout Bool) {
        readNextCharacter = true
        if currentCharacter == "\\" {
            enterState(.characterLiteralEscape)
        } else if currentCharacter == "'" {
            tokenEnd(category: .literalCharacter)
        } else {
            builder.increment(char: currentCharacter)
        }
    }

    private func lexerStateCharacterLiteralEscape(_ readNextCharacter: inout Bool) {
        // Previous character was a \ .
        readNextCharacter = true
        leaveState()

        if currentCharacter == "n" { builder.increment(char: "\n") }
        else if currentCharacter == "\"" { builder.increment(char: "\"") }
        else if currentCharacter == "'" { builder.increment(char: "'") }
        else if currentCharacter == "t" { builder.increment(char: "\t") }
        else if currentCharacter == "r" { builder.increment(char: "\r") }
        else if currentCharacter == "\\" { builder.increment(char: "\\") }
        else {
            #warning("Add more details on this error. Don't make it a fatalError, but a diagnostic reporter.")
            fatalError("Unkown escaping character: '\\\(currentCharacter)'")
        }
    }

    private func enterState(_ state: LexerState) {
        states.append(state)
    }

    private func switchState(_ state: LexerState) {
        leaveState()
        enterState(state)
    }

    private var state: LexerState? {
        return states.last
    }

    @discardableResult
    private func leaveState() -> LexerState? {
        return states.popLast()
    }
}

// MARK: - Append tokens
fileprivate extension Lexer {
    private func isLastToken(category: TokenCategory) -> Bool {
        guard let last = tokens.last else { return false }
        return last.isCategory(category)
    }

    private func append(token: Token) {
        if isLastToken(category: .endOfFile) { return }
        tokens.append(token)
    }

    private func appendSingleCharacterToken(category: TokenCategory) {
        appendSingleCharacterToken(character: currentCharacter, category: category)
    }

    private func appendSingleCharacterToken(character: String, category: TokenCategory) {
        builder.reset()
        builder.increment(char: character)
        append(token: builder.build(category: category))
        builder.reset()
    }

    private func appendEndOfFileToken() {
        builder.reset()
        append(token: builder.build(category: .endOfFile))
    }

    private func tokenStart(state: LexerState, appendCurrentCharacter: Bool = true) {
        builder.reset()
        if appendCurrentCharacter {
            builder.increment(char: currentCharacter)
        }
        enterState(state)
    }

    private func tokenEnd(category: TokenCategory) {
        leaveState()
        append(token: builder.build(category: category))
        builder.reset()
    }
}

// MARK: - InputStream reader
fileprivate extension Lexer {
    private func read(consumer: (String) -> Void) throws {
        inputStream.open()
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Lexer.BUFFER_SIZE)

        defer {
            buffer.deallocate()
            inputStream.close()
        }

        while inputStream.hasBytesAvailable {
            let read = inputStream.read(buffer, maxLength: Lexer.BUFFER_SIZE)

            guard read > 0 else { throw LexerError.unableToReadInputStream(streamError: inputStream.streamError) }

            var data = Data.init(capacity: Lexer.BUFFER_SIZE)
            data.append(buffer, count: read)

            guard let string = String(data: data, encoding: .utf8) else { throw LexerError.unableToConvertDataToString(data: data) }
            consumer(string);
        }
    }
}

// MARK: -
public enum LexerError: Error {
    case unableToReadInputStream(streamError: Error?)
    case unableToConvertDataToString(data: Data)
}

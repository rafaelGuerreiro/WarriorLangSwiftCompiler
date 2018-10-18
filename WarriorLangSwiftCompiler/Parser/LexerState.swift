//
//  LexerState.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-27.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import Foundation

public enum LexerState: String, CaseIterable {
    case start
    case symbol
    case identifier
    case numberLiteral
    case numberLiteralZero
    case numberLiteralExponential
    case compilerDirective
    case dot
    case dash
    case slash
    case stringLiteral
    case stringLiteralEscape
    case stringLiteralInterpolation
    case characterLiteral
    case characterLiteralEscape
    case inlineComment
    case blockComment
    case openParenthesis
}

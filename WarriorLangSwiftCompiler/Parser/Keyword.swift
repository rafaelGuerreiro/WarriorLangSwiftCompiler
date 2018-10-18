//
//  Keyword.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-27.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import Foundation

public struct Keyword {
    public static let keywords: Dictionary<String, TokenCategory> = [
        "class" : .declarationClass,
        "interface" : .declarationInterface,
        "enum" : .declarationEnum,
        "annotation" : .declarationAnnotation,
        "module" : .declarationModule,
        "extension" : .declarationExtension,
        "operator" : .declarationOperator,
        "higherThan" : .declarationOperatorHigherThan,
        "lowerThan" : .declarationOperatorLowerThan,
        "infix" : .declarationOperatorInfix,
        "prefix" : .declarationOperatorPrefix,
        "postfix" : .declarationOperatorPostfix,
        "associativity" : .declarationOperatorAssociativitty,
        "left" : .declarationOperatorAssociativittyLeft,
        "right" : .declarationOperatorAssociativittyRight,
        "none" : .declarationOperatorAssociativittyNone,
        "var" : .declarationVar,
        "let" : .declarationLet,
        "get" : .declarationGet,
        "set" : .declarationSet,
        "function" : .declarationFunction,
        "init" : .declarationInit,
        //    "init?" : .declarationInitOptional,
        "deinit" : .declarationDeinit,
        "lazy" : .declarationLazy,
        "postconstruct" : .declarationPostconstruct,
        "include" : .declarationInclude,
        "typealias" : .declarationTypealias,
        "public" : .declarationPublic,
        "internal" : .declarationInternal,
        "private" : .declarationPrivate,
        "publicset" : .declarationPublicset,
        "internalset" : .declarationInternalset,
        "privateset" : .declarationPrivateset,
        "overridable" : .declarationOverridable,
        "override" : .declarationOverride,
        "required" : .declarationRequired,
        "mutating" : .declarationMutating,
        //    "mutable" : .modifierMutable,
        "inout" : .modifierInout,
        "where" : .modifierWhere,
        "throws" : .modifierThrows,
        "rethrows" : .modifierRethrows,
        "async" : .modifierAsync,
        "default" : .modifierDefault,
        "null" : .expressionNull,
        "self" : .expressionSelf,
        "super" : .expressionSuper,
        "type" : .expressionType,
        "includes" : .expressionIncludes,
        "new" : .expressionNew,
        "throw" : .expressionThrow,
        "try" : .expressionTry,
        //    "try?" : .expressionTryOptional,
        "catch" : .expressionCatch,
        "finally" : .expressionFinally,
        "defer" : .expressionDefer,
        "as" : .expressionAs,
        //    "as?" : .expressionAsOptional,
        "is" : .expressionIs,
        "await" : .expressionAwait,
        "if" : .expressionIf,
        //    "else if" : .expressionElseIf,
        "else" : .expressionElse,
        "unless" : .expressionUnless,
        "guard" : .expressionGuard,
        "while" : .expressionWhile,
        "for" : .expressionFor,
        "in" : .expressionIn,
        "do" : .expressionDo,
        "break" : .expressionBreak,
        "continue" : .expressionContinue,
        "return" : .expressionReturn,
        "_" : .underscore,
    ]

    public static let compilerDirectiveKeywords: Dictionary<String, TokenCategory> = [
        "#if" : .compileDirectiveIf,
        "#else" : .compileDirectiveElse,
        "#elseif" : .compileDirectiveElseif,
        "#endif" : .compileDirectiveEndif,
        "#line" : .compileDirectiveLine,
        "#function" : .compileDirectiveFunction,
        "#error" : .compileDirectiveError,
        "#warning" : .compileDirectiveWarning
    ]

    private init() {}
}

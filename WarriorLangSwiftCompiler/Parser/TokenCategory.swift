//
//  TokenCategory.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-27.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import Foundation

public enum TokenCategory: String, CaseIterable {
    case endOfFile
    case space // Used to separate tokens that don't necessarily correlate

    // Types
    case declarationClass // class
    case declarationInterface // interface
    case declarationEnum // enum
    case declarationAnnotation // annotation
    case declarationModule // module         // Modules can be used to automatically insert common methods.
    case declarationExtension // extension
    case declarationOperator // operator

    case declarationOperatorHigherThan // higherThan
    case declarationOperatorLowerThan // lowerThan
    case declarationOperatorInfix // infix
    case declarationOperatorPrefix // prefix
    case declarationOperatorPostfix // postfix
    case declarationOperatorAssociativitty // associativity
    case declarationOperatorAssociativittyLeft // left
    case declarationOperatorAssociativittyRight // right
    case declarationOperatorAssociativittyNone // none

    case declarationVar // var
    case declarationLet // let
    case declarationGet // get
    case declarationSet // set
    case declarationFunction // function
    case declarationLazy // lazy

    case declarationInit // init           // Init methods can't read from self. Developers should use postconstruct methods.
    // case declarationInitOptional // init?          // Init method that can return null.
    case declarationDeinit // deinit         // When this object is going to be removed from memory, this method is called.
    case declarationPostconstruct // postconstruct  // A private method that is called after the complete initialization of the object. Child first.

    case declarationInclude // include        // used to include a module in this class and all implementations.
    case declarationTypealias // typealias

    // Modifiers
    case declarationPublic // public,
    case declarationInternal // internal,       // internal allows access to the same module
    case declarationPrivate // private,        // private allows access to extensions and inheritance
    case declarationPublicset // publicset,
    case declarationInternalset // internalset,    // internalset allows access to the same module
    case declarationPrivateset // privateset,     // privateset allows access to extensions and inheritance

    case declarationOverridable // overridable,    // all classes and functions are final. Use overridable to mark them as overridable.
    case declarationOverride // override,       // when overriding a super function
    case declarationRequired // required,       // Forces sub-implementation to override this method. Implies it's also overridable. Therefore, it can't call any self mutating methods.
    case declarationMutating // mutating,       // mutating functions allows this function to modify the underlying object

    // case modifierMutable // mutable,        // mutable returns allows the returned instance to be assigned to `var` and be modified.
    case modifierInout // inout,          // Makes an argument mutable, which also reflects on the caller instance. `let` variables can't be passed to inout.
    case modifierWhere // where,          // Used to refine generics in functions and extensions.
    case modifierThrows // throws,
    case modifierRethrows // rethrows,     // Used to allow both throwing / non-throwning implementation. A method can be declared with the rethrows keyword to indicate that it throws an error only if one of it’s function parameters throws an error. These functions and methods are known as rethrowing functions and rethrowing methods. Rethrowing functions and methods must have at least one throwing function parameter.
    case modifierAsync // async,
    case modifierDefault // default,

    // Expressions
    case expressionNull // null,           // Same as Optional<T>.none
    case expressionSelf // self,
    case expressionSuper // super,
    case expressionType // type,           // Like Swift's Self
    case expressionIncludes // includes,       // check if this instance or class includes this module.
    case expressionNew // new,            // new Class(argument: "test") -> syntax-sugar to Class.init(argument: "test");
    case expressionThrow // throw,
    case expressionTry // try,
    // case expressionTryOptional // try?,
    case expressionCatch // catch,
    case expressionFinally // finally,        // Is garanteed to be invoked, even when errors happened. This block can't return, but it can throw.
    case expressionDefer // defer,          // Is garanteed to be invoked, even when errors happened. This block can't return, but it can throw.
    case expressionAs // as,
    // case expressionAsOptional, // as?,
    case expressionIs // is,             // same as instanceof in Java: return true if variable is String;
    case expressionAwait // await,
    case expressionIf // if, // if let, // if var,
    // case expressionElseIf // else if
    case expressionElse // else
    case expressionUnless // unless
    case expressionGuard // guard // guard let // guard var
    case expressionWhile // while
    case expressionFor // for
    case expressionIn // in
    case expressionDo // do
    case expressionBreak // break
    case expressionContinue // continue
    case expressionReturn // return

    // Compile directives
    case compileDirectiveIf // #if
    case compileDirectiveElse // #else
    case compileDirectiveElseif // #elseif
    case compileDirectiveEndif // #endif
    case compileDirectiveLine // #line
    case compileDirectiveFunction // #function
    case compileDirectiveError // #error
    case compileDirectiveWarning // #warning

    // Literals

    /*
     [0-9][0-9_]*
     0b[0-1][0-1_]*
     0o[0-7][0-7_]*
     0x[0-9a-fA-F][0-9a-fA-F_]*
     */
    case literalInteger

    /*
     [0-9][0-9_]*\.[0-9_]+
     [0-9][0-9_]*\.?[0-9_]*[eE][+-]?[0-9_]+
     */
    case literalFloat
    /*
     Strings are double-quoted.
     "text \"escaping using \\ and \"."
     - It allows common escaping:
     \"  // " character
     \\  // \ character
     \n  // new line
     \t  // tab
     \$  // $ character that escapes the interpolation
     \b  // backspace
     \r  // carriage return
     \f  // formfeed

     - It allows interpolation:
     "regular string"
     "regular string, value: ${singleNamedVariable}"
     "regular string, value: ${1 + 2 / 4 * 7}"
     */
    case literalString
    case literalStringInterpolation

    /*
     Characters are single quoted and single value.

     var char: Character = 'a';

     - It allows common escaping:
     \'  // ' character
     \\  // \ character
     \n  // new line
     \t  // tab
     \b  // backspace
     \r  // carriage return
     \f  // formfeed
     */
    case literalCharacter

    /*
     Block comment
     */
    case comment // Inline comment

    case underscore // _      Used to ignore variables.

    case composedPunctuationArrow // ->
    case composedClosedRange // ...
    case composedHalfOpenRange // ..<
    // case composedPunctuationInterpolationStart // ${
    // case composedPunctuationInterpolationEnd // }

    case punctuationLeftParenthesis // (
    case punctuationRightParenthesis // )
    case punctuationLeftSquareBrackets // [
    case punctuationRightSquareBrackets // ]
    case punctuationLeftCurlyBrace // {
    case punctuationRightCurlyBrace // }
    case punctuationLeftAngleBrackets // <
    case punctuationRightAngleBrackets // >
    case punctuationDot // .
    case punctuationComma //
    case punctuationColon // :
    case punctuationSemicolon // ;
    case punctuationPlus // +
    case punctuationMinus // -
    case punctuationAsterisk // *
    case punctuationSlash // /
    case punctuationXor // ^
    case punctuationPipe // |
    case punctuationPercent // %
    case punctuationTilde // ~
    case punctuationBacktick // `
    case punctuationEqual // =
    case punctuationAt // @
    case punctuationPound // #
    case punctuationAmpersand // &
    case punctuationBackslash // "\"
    case punctuationExclamation // !
    case punctuationQuestion // ?
    case identifier // [a-zA-Z_$][a-zA-Z0-9_$]*
}

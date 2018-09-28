//
//  FixedWidthIntegerExtensions.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-27.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import Foundation

public extension FixedWidthInteger {
    public var byte: Self {
        return self
    }

    public var kilobyte: Self {
        return byte * 1024
    }

    public var megabyte: Self {
        return kilobyte * 1024
    }

    public var gigabyte: Self {
        return megabyte * 1024
    }
}

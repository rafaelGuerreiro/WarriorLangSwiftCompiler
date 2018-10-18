//
//  FixedWidthIntegerExtensions.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-27.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import Foundation

// MARK: - UInt8 Byte conversions
public extension UInt8 {
    public var byte: UInt8 {
        return self
    }
}

// MARK: - UInt16 Byte conversions
public extension UInt16 {
    public var byte: UInt16 {
        return self
    }

    public var kilobyte: UInt16 {
        return byte * 1024
    }
}

// MARK: - UInt32 Byte conversions
public extension UInt32 {
    public var byte: UInt32 {
        return self
    }

    public var kilobyte: UInt32 {
        return byte * 1024
    }

    public var megabyte: UInt32 {
        return kilobyte * 1024
    }
}

// MARK: - UInt64 Byte conversions
public extension UInt64 {
    public var byte: UInt64 {
        return self
    }

    public var kilobyte: UInt64 {
        return byte * 1024
    }

    public var megabyte: UInt64 {
        return kilobyte * 1024
    }

    public var gigabyte: UInt64 {
        return megabyte * 1024
    }
}

// MARK: - Int8 Byte conversions
public extension Int8 {
    public var byte: Int8 {
        return self
    }
}

// MARK: - Int16 Byte conversions
public extension Int16 {
    public var byte: Int16 {
        return self
    }

    public var kilobyte: Int16 {
        return byte * 1024
    }
}

// MARK: - Int32 Byte conversions
public extension Int32 {
    public var byte: Int32 {
        return self
    }

    public var kilobyte: Int32 {
        return byte * 1024
    }

    public var megabyte: Int32 {
        return kilobyte * 1024
    }
}

// MARK: - Int64 Byte conversions
public extension Int64 {
    public var byte: Int64 {
        return self
    }

    public var kilobyte: Int64 {
        return byte * 1024
    }

    public var megabyte: Int64 {
        return kilobyte * 1024
    }

    public var gigabyte: Int64 {
        return megabyte * 1024
    }
}

#if (arch(x86_64) || arch(arm64))
// MARK: - UInt Byte conversions for 64bit
public extension UInt {
    public var byte: UInt {
        return self
    }

    public var kilobyte: UInt {
        return byte * 1024
    }

    public var megabyte: UInt {
        return kilobyte * 1024
    }

    public var gigabyte: UInt {
        return megabyte * 1024
    }
}

// MARK: - Int Byte conversions for 64bit
public extension Int {
    public var byte: Int {
        return self
    }

    public var kilobyte: Int {
        return byte * 1024
    }

    public var megabyte: Int {
        return kilobyte * 1024
    }

    public var gigabyte: Int {
        return megabyte * 1024
    }
}
#else
// MARK: - UInt Byte conversions for 32bit
public extension UInt {
    public var byte: UInt {
        return self
    }

    public var kilobyte: UInt {
        return byte * 1024
    }

    public var megabyte: UInt {
        return kilobyte * 1024
    }
}

// MARK: - Int Byte conversions for 32bit
public extension Int {
    public var byte: Int {
        return self
    }

    public var kilobyte: Int {
        return byte * 1024
    }

    public var megabyte: Int {
        return kilobyte * 1024
    }
}
#endif

//
//  FixedWidthIntegerExtensionsTests.swift
//  WarriorLangSwiftCompilerTests
//
//  Created by Rafael Guerreiro on 2018-10-02.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import XCTest

class FixedWidthIntegerExtensionsTests: XCTestCase {
}

// MARK: - Byte conversions
extension FixedWidthIntegerExtensionsTests {
    func test_byte() {
        for number in UInt8.min...UInt8.max {
            XCTAssertEqual(UInt8(number).byte, UInt8(number))
        }

        for number in Int8.min...Int8.max {
            XCTAssertEqual(Int8(number).byte, Int8(number))
        }

        let positive: [Int64 : Int64] = [
            1:     1,
            10:    10,
            1_024: 1_024
        ]

        let negative: [Int64 : Int64] = [
            -1:     -1,
            -10:    -10,
            -1_024: -1_024
        ]

        for (lhs, rhs) in positive {
            XCTAssertEqual(UInt16(lhs).byte, UInt16(rhs))
            XCTAssertEqual(UInt32(lhs).byte, UInt32(rhs))
            XCTAssertEqual(UInt64(lhs).byte, UInt64(rhs))
            XCTAssertEqual(Int16(lhs).byte, Int16(rhs))
            XCTAssertEqual(Int32(lhs).byte, Int32(rhs))
            XCTAssertEqual(Int64(lhs).byte, Int64(rhs))
        }

        for (lhs, rhs) in negative {
            XCTAssertEqual(Int16(lhs).byte, Int16(rhs))
            XCTAssertEqual(Int32(lhs).byte, Int32(rhs))
            XCTAssertEqual(Int64(lhs).byte, Int64(rhs))
        }
    }

    func test_kilobyte() {
        for number in UInt16.min..<64 {
            XCTAssertEqual(UInt16(number).kilobyte, UInt16(number * 1024))
        }

        for number in -32..<32 {
            XCTAssertEqual(Int16(number).kilobyte, Int16(number * 1024))
        }

        let positive: [Int64 : Int64] = [
            1:     1_024,
            10:    10_240,
            1_024: 1_048_576
        ]

        let negative: [Int64 : Int64] = [
            -1:     -1_024,
            -10:    -10_240,
            -1_024: -1_048_576
        ]

        for (lhs, rhs) in positive {
            XCTAssertEqual(UInt32(lhs).kilobyte, UInt32(rhs))
            XCTAssertEqual(UInt64(lhs).kilobyte, UInt64(rhs))
            XCTAssertEqual(Int32(lhs).kilobyte, Int32(rhs))
            XCTAssertEqual(Int64(lhs).kilobyte, Int64(rhs))
        }

        for (lhs, rhs) in negative {
            XCTAssertEqual(Int32(lhs).kilobyte, Int32(rhs))
            XCTAssertEqual(Int64(lhs).kilobyte, Int64(rhs))
        }
    }

    func test_megabyte() {
        for number in UInt32.min..<4096 {
            XCTAssertEqual(UInt32(number).megabyte, UInt32(number * 1024 * 1024))
            #if !(arch(x86_64) || arch(arm64))
                XCTAssertEqual(UInt(number).megabyte, UInt(number * 1024 * 1024))
            #endif
        }

        for number in -2048..<2048 {
            XCTAssertEqual(Int32(number).megabyte, Int32(number * 1024 * 1024))
            #if !(arch(x86_64) || arch(arm64))
                XCTAssertEqual(Int(number).megabyte, Int(number * 1024 * 1024))
            #endif
        }

        let positive: [Int64 : Int64] = [
            1:     1_048_576,
            10:    10_485_760,
            1_024: 1_073_741_824
        ]

        let negative: [Int64 : Int64] = [
            -1:     -1_048_576,
            -10:    -10_485_760,
            -1_024: -1_073_741_824
        ]

        for (lhs, rhs) in positive {
            XCTAssertEqual(UInt64(lhs).megabyte, UInt64(rhs))
            XCTAssertEqual(Int64(lhs).megabyte, Int64(rhs))
        }

        for (lhs, rhs) in negative {
            XCTAssertEqual(Int64(lhs).megabyte, Int64(rhs))
        }
    }

    func test_gigabyte() {
        for number in UInt64.min...131_072 {
            XCTAssertEqual(UInt64(number).gigabyte, UInt64(number) * 1024 * 1024 * 1024)
            XCTAssertEqual(Int64(number).gigabyte, Int64(number) * 1024 * 1024 * 1024)
            #if (arch(x86_64) || arch(arm64))
                XCTAssertEqual(UInt(number).gigabyte, UInt(number) * 1024 * 1024 * 1024)
                XCTAssertEqual(Int(number).gigabyte, Int(number) * 1024 * 1024 * 1024)
            #endif
        }

        for number in -131_072...0 {
            XCTAssertEqual(Int64(number).gigabyte, Int64(number) * 1024 * 1024 * 1024)
            #if (arch(x86_64) || arch(arm64))
                XCTAssertEqual(Int(number).gigabyte, Int(number) * 1024 * 1024 * 1024)
            #endif
        }
    }
}

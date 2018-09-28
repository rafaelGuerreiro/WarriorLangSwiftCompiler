//
//  FileStreamReader.swift
//  WarriorLangSwiftCompiler
//
//  Created by Rafael Guerreiro on 2018-09-27.
//  Copyright © 2018 Rafael Rubem Rossi Souza Guerreiro. All rights reserved.
//

import Foundation

class FileStreamReader: StreamReader {
    private let path: String

    init(_ path: String) {
        self.path = path
    }
}

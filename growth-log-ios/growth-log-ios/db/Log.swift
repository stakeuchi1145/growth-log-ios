//
//  Log.swift
//  growth-log-ios
//
//  Created by shin takeuchi on 2026/01/02.
//

import Foundation
import SwiftData

@Model
class Log {
    @Attribute(.unique) var id: String
    var title: String
    var done: String
    var learn: String
    var block: String
    var next: String
    var createdAt: String
    var updatedAt: String

    init(id: String = UUID().uuidString, title: String, done: String, learn: String, block: String, next: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.title = title
        self.done = done
        self.learn = learn
        self.block = block
        self.next = next
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

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
    var content: String
    var createdAt: String
    var updatedAt: String

    init(id: String = UUID().uuidString, title: String, content: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

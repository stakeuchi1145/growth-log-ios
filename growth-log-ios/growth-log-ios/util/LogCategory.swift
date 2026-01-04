//
//  LogCategory.swift
//  growth-log-ios
//
//  Created by shin takeuchi on 2026/01/03.
//

import SwiftUI
import Foundation

enum LogCategory: String, CaseIterable, Identifiable {
    case daily = "日常"
    case work = "仕事"
    case study = "勉強"
    case health = "健康"
    case hobby = "趣味"
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .daily: return .blue
        case .work: return .green
        case .study: return .orange
        case .health: return .pink
        case .hobby: return .purple
        }
    }

    func allCategories() -> [LogCategory] {
        return [.daily, .work, .study, .health, .hobby]
    }
}

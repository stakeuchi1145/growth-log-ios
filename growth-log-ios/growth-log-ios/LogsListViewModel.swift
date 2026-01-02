//
//  LogsListViewModel.swift
//  growth-log-ios
//
//  Created by shin takeuchi on 2026/01/02.
//

import SwiftUI
import Foundation
internal import Combine

class LogsListViewModel: ObservableObject {
    static let shared = LogsListViewModel()
    
    @Published var logs: [Log] = []
    
    func getLogs() {
        logs.append(Log(date: DateHelper.convertDate(date: "2025-12-30 12:40:00"), content: "今日の記録"))
        logs.append(Log(date: DateHelper.convertDate(date: "2025-12-31 23:20:00"), content: "今日の記録"))
    }
}

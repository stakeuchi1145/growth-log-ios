//
//  LogsListViewModel.swift
//  growth-log-ios
//
//  Created by shin takeuchi on 2026/01/02.
//

import SwiftUI
import SwiftData
import Foundation
import Combine

class LogsListViewModel: ObservableObject {
    static let shared = LogsListViewModel()
    
    func getLogs(context: ModelContext) {
        add(
            context: context,
            log: Log(
                title: "2026年1月2日　振り返り",
                done: "なし",
                learn: "なし",
                block: "なし",
                next: "なし",
                createdAt: DateHelper.toDay(date: DateHelper.convertDate(date: "2026-01-02 11:30:00"), format: "yyyy-MM-dd hh:mm:ss"),
                updatedAt: DateHelper.toDay(date: DateHelper.convertDate(date: "2026-01-02 11:30:00"), format: "yyyy-MM-dd hh:mm:ss")
            )
        )
    }
    
    func calculateStreak(logs: [Log], calendar: Calendar = .current) -> Int {
        // 1) ログの日付を「日単位」にしてSet化
        let logDays: Set<Date> = Set(
            logs.map {
                DateHelper.startOfDay(date: DateHelper.convertDate(date: $0.createdAt), calendar: calendar)
            }
        )
        
        guard !logDays.isEmpty else { return 0 }
        
        // 2) 今日を起点にする（※ 昨日からでもOK）
        var streak = 0
        var currentDay = calendar.date(
            byAdding: .day,
            value: -1,
            to: DateHelper.startOfDay(date: Date(), calendar: calendar)
        )!
        
        // 3) 連続チェック
        while logDays.contains(currentDay) {
            streak += 1
            currentDay = calendar.date(byAdding: .day, value: -1, to: currentDay)!
        }
        
        return streak
    }
    
    func hasLogForToday(logs: [Log], calendar: Calendar = .current) -> Bool {
        let today = calendar.startOfDay(for: Date())
        
        return logs.contains { log in
            calendar.startOfDay(for: DateHelper.convertDate(date: log.createdAt)) == today
        }
    }
    
    func add(context: ModelContext, log: Log) {
        context.insert(log)
    }
    
    @MainActor
    func deleteAllLogs(context: ModelContext) throws {
        let items = try context.fetch(FetchDescriptor<Log>())
        guard !items.isEmpty else { return }
        
        items.forEach { context.delete($0) }
        try context.save()
    }
}

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
    }
}

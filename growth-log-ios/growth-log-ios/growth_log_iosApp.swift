//
//  growth_log_iosApp.swift
//  growth-log-ios
//
//  Created by shin takeuchi on 2026/01/01.
//

import SwiftData
import SwiftUI

@main
struct growth_log_iosApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [Log.self])
    }
}

struct RootView: View {
    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            LogsListView() { route in}
        }
        .navigationDestination(for: Route.self) { route in
            switch route {
            case .home:
                LogsListView() { route in}
            default:
                EmptyView()
            }
        }
    }
}

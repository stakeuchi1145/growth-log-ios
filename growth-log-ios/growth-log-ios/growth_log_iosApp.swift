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
            LogsListView() { route in
                path.append(route)
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .register:
                    LogRegisterView(onNavigate: { route in
                        if route == .home {
                            path.removeAll()
                        } else {
                            path.append(route)
                        }
                    }, onBack: {
                        path.removeAll()
                    })
                default:
                    EmptyView()
                }
            }
        }
    }
}

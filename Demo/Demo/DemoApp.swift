//
//  DemoApp.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-01-16.
//  Copyright © 2023-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SystemNotification

@main
struct DemoApp: App {

    @StateObject
    private var context = SystemNotificationContext()
    
    @State
    private var style = SystemNotificationStyle.standard

    var body: some Scene {
        WindowGroup {
            content
                .systemNotification(context)    // Context-based notifications are flexible
                .systemNotificationStyle(style) // This is how to set a global style
                .tint(.orange)
        }
    }
}

private extension DemoApp {

    /// This demo adds the context-based notification to all
    /// tabs, to make notifications display above all tabs.
    var content: some View {
        #if os(iOS)
        TabView {
            contentView.tabItem(1)
            contentView.tabItem(2)
            contentView.tabItem(3)
            contentView.tabItem(4)
        }
        #else
        contentView
        #endif
    }

    var contentView: some View {
        #if os(iOS)
        NavigationStack {
            ContentView(style: $style)
        }
        #else
        ContentView()
        #endif
    }
}

private extension View {

    func tabItem(_ index: Int) -> some View {
        self.tabItem {
            Label(
                "Tab \(index)",
                systemImage: "0\(index).circle")
        }
    }
}

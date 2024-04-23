//
//  DemoApp.swift
//  Demo
//
//  Created by Daniel Saidi on 2023-01-16.
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
                .systemNotification(context)    // Context-based notifications are versatile
                .systemNotificationStyle(style)
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
        TabView {
            NavigationStack {
                ContentView(style: $style)
            }
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
                systemImage: "0\(index).square")
        }
    }
}

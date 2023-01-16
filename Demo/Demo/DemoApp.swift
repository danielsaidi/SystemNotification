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

    var body: some Scene {
        WindowGroup {
            content
                .systemNotification(context)    // Context-based notifications are versatile
                .environmentObject(context)     // You can pass a context as init param or env.object
        }
    }
}

private extension DemoApp {

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
            NavigationView {
                ContentView()
            }.navigationViewStyle(.stack)
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

//
//  DemoApp.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-06-01.
//

import SwiftUI
import SystemNotification

@main
struct DemoApp: App {
    
    @StateObject private var context = SystemNotificationContext()
        
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView().tabItem(1)
                ContentView().tabItem(2)
                ContentView().tabItem(3)
                ContentView().tabItem(4)
            }
            .systemNotification(context)    // Context-based notifications are versatile
            .environmentObject(context)     // You can pass a context as init param or env.object
        }
    }
}

private extension View {
    
    func tabItem(_ index: Int) -> some View {
        self.tabItem {
            Label(
                "Page \(index)",
                systemImage: "0\(index).square")
        }
    }
}

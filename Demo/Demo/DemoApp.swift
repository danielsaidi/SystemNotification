//
//  DemoApp.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-06-01.
//

import SwiftUI

@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView().tabItem(1)
                ContentView().tabItem(2)
                ContentView().tabItem(3)
                ContentView().tabItem(4)
            }
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

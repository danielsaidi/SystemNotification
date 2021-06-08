//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SystemNotification

struct ContentView: View {
    
    @State private var isStaticNotificationActive = false
    @StateObject private var context = SystemNotificationContext()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Context-based notifications").padding(.top)) {
                    Button("Show silent mode on", action: showSilentModeOn)
                    Button("Show silent mode off", action: showSilentModeOff)
                    Button("Show localized notification", action: showLocalized)
                    Button("Show orange warning", action: showWarning)
                    Button("Show red error from bottom", action: showError)
                    Button("Show custom view", action: showCustomView)
                }
                Section(header: Text("Static notifications")) {
                    Button("Show static notification", action: showStaticNotification)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .navigationTitle("System Notification")
            .listStyle(InsetGroupedListStyle())
        }
        .systemNotification(context: context)
        .systemNotification {
            SystemNotification(isActive: $isStaticNotificationActive) { _ in
                DemoNotification.silentModeOn
            }
        }
    }
}

private extension ContentView {
    
    func showCustomView() {
        context.present(
            content: DemoNotification.custom,
            configuration: DemoNotification.customConfig)
    }
    
    func showError() {
        context.present(
            content: DemoNotification.error,
            configuration: DemoNotification.errorConfig)
    }
    
    func showLocalized() {
        context.present(
            content: DemoNotification.localized)
    }
    
    func showSilentModeOff() {
        context.present(
            content: DemoNotification.silentModeOff)
    }
    
    func showSilentModeOn() {
        context.present(
            content: DemoNotification.silentModeOn)
    }
    
    func showWarning() {
        context.present(
            content: DemoNotification.warning,
            configuration: DemoNotification.warningConfig)
    }
    
    func showStaticNotification() {
        isStaticNotificationActive = true
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

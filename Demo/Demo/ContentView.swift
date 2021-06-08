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
                    button(.silentModeOn, "Show silent mode on", showSilentModeOn)
                    button(.silentModeOff, "Show silent mode off", showSilentModeOff)
                    button(.globe, "Show localized notification", showLocalized)
                    button(.warning, "Show orange warning", showWarning)
                    button(.error, "Show red error from bottom", showError)
                    button(.flag, "Show custom view", showCustomView)
                }
                Section(header: Text("Static notifications")) {
                    button(.static, "Show static notification", showStaticNotification)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .navigationTitle("System Notification")
            .listStyle(InsetGroupedListStyle())
        }
        .systemNotification(context: context)
        .systemNotification {
            SystemNotification(isActive: $isStaticNotificationActive) { _ in
                DemoNotification.static
            }
        }
    }
}

private extension ContentView {
    
    func button(_ icon: Image, _ text: String, _ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                icon.frame(width: 25)
                Text(text)
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
    
    func showStaticNotification() {
        isStaticNotificationActive = true
    }
    
    func showWarning() {
        context.present(
            content: DemoNotification.warning,
            configuration: DemoNotification.warningConfig)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

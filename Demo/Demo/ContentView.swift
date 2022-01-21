//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit
import SystemNotification

/**
 This is the main demo app view, which is reused across four
 demo app tabs.
 
 The view uses a global `SystemNotificationContext` which it
 receives as an environment object. Presenting notifications
 with this context means that the `DemoApp` will present the
 same notification in all four tabs.
 
 The view also has a `isStaticActive` property which it uses
 to present a view-specific notification.
 
 Note that the context-based approach requires an additional
 setup for each modal that you present. In the code below, a
 `systemNotification` modifier is added to each modal. While
 it works ok, a sheet will reveal any underlying, additional
 notifications, which may look a bit strange. Future work :)
 */
struct ContentView: View {
    
    init(isModal: Bool = false) {
        self.isModal = isModal
    }
    
    private let isModal: Bool
    
    @State private var isCoverActive = false
    @State private var isSheetActive = false
    @State private var isStaticActive = false
    
    @EnvironmentObject private var context: SystemNotificationContext
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Context-based notifications")) {
                    listItem(.silentModeOn, "Show silent mode on", showSilentModeOn)
                    listItem(.silentModeOff, "Show silent mode off", showSilentModeOff)
                    listItem(.globe, "Show localized notification", showLocalized)
                    listItem(.warning, "Show orange warning", showWarning)
                    listItem(.error, "Show red error from bottom", showError)
                    listItem(.flag, "Show custom view", showCustomView)
                }
                Section(header: Text("Non-dismissing notifications")) {
                    listItem(.static, "Show non-dismissing notification", showStaticNotification)
                }
                Section(header: Text("Modal screens")) {
                    listItem(.sheet, "Show sheet", showModalSheet)
                    listItem(.cover, "Show full screen cover", showModalCover)
                    if isModal {
                        listItem(.dismiss, "Dismiss", dismiss)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("System Notification")
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $isSheetActive) {
            ContentView(isModal: true).systemNotification(context)
        }
        .fullScreenCover(isPresented: $isCoverActive) {
            ContentView(isModal: true).systemNotification(context)
        }
        .systemNotification(isActive: $isStaticActive) {    // View-based notifications are easy to use
            DemoNotification.static
        }
    }
}

private extension ContentView {
    
    func listItem(_ icon: Image, _ text: String, _ action: @escaping () -> Void) -> some View {
        ListItem {
            Button(action: action) {
                Label(text, image: icon)
            }
        }
    }
}

private extension ContentView {
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }

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
    
    func showModalCover() {
        isCoverActive = true
    }
    
    func showModalSheet() {
        isSheetActive = true
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
        isStaticActive = true
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

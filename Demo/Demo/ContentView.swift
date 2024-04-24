//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SystemNotification

/// This is main screen is reused across all four tabs.
///
/// The ``DemoApp`` has a shared ``SystemNotificationContext``
/// that it applies to the main app view. This makes the app
/// able to show notifications above the tab view, so that a
/// notification stays when switching tabs.
///
/// Since notification styles and configurations are applied
/// with view modifiers, we pass in the style if you want to
/// change it. But remember that you then have to set it for
/// every notification, since it persists the last value. In
/// a real-world app, you should probably use separate state
/// and modifiers for different types of notifications.
///
/// > Important: Note how this view adds .systemNotification
/// view modifiers to the sheet and full screen modals. This
/// is needed, since a sheet and full screen modal creates a
/// new view hierarchy.
struct ContentView: View {

    init(
        style: Binding<SystemNotificationStyle>,
        isModal: Bool = false
    ) {
        self._style = style
        self.isModal = isModal
    }

    private let isModal: Bool
    
    @Binding
    var style: SystemNotificationStyle
    
    @Environment(\.dismiss) 
    var dismiss

    @EnvironmentObject
    var notification: SystemNotificationContext

    @State
    var isCoverActive = false
    
    @State
    var isSilentModeOn = false

    @State
    var isSheetActive = false
    
    @StateObject
    var toast = SystemNotificationContext()

    var body: some View {
        List {
            Section("Section.Notifications") {
                Toggle(isOn: $isSilentModeOn) {
                    label(.silentModeOff, "Toggle.SilentMode")
                }
                listItem(.flag, "Menu.LocalizedMessage", presentLocalizedMessage)
                listItem(.static, "Menu.CustomView", presentCustomView)
            }
            Section("Section.Predefined") {
                listItem(.error, "Menu.Error", presentError)
                listItem(.success, "Menu.Success", presentSuccess)
                listItem(.warning, "Menu.Warning", presentWarning)
            }
            Section("Section.Toasts") {
                listItem(.sheet, "Menu.BottomToast", presentBottomToast)
                
            }
            Section("Section.Modals") {
                listItem(.sheet, "Menu.Sheet", presentModalSheet)
                listItem(.cover, "Menu.Cover", presentModalCover)
                if isModal {
                    listItem(.dismiss, "Dismiss", dismiss.callAsFunction)
                }
            }
        }
        .buttonStyle(.plain)
        .navigationTitle("SystemNotification")
        .sheet(isPresented: $isSheetActive) {
            ContentView(style: $style, isModal: true)
                .systemNotification(notification)
                .systemNotificationStyle(style)
        }
        #if os(iOS)
        .fullScreenCover(isPresented: $isCoverActive) {
            ContentView(style: $style, isModal: true)
                .systemNotification(notification)
                .systemNotificationStyle(style)
        }
        #endif
        .systemNotification(toast)
        .systemNotificationConfiguration(.standardToast)
        .onChange(of: isSilentModeOn) { _ in presentSilentMode() }
    }
}

private extension ContentView {

    func label(_ icon: Image, _ text: LocalizedStringKey) -> some View {
        Label {
            Text(text)
        } icon: {
            icon
        }
    }

    func listItem(_ icon: Image, _ text: LocalizedStringKey, _ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            label(icon, text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
        }
    }
}

private extension ContentView {
    
    var flagView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Color.blue
                    .frame(width: 45)
                Color.yellow
                    .frame(width: 15)
                Color.blue
            }
            .frame(height: 30)
            
            Color.yellow
                .frame(height: 15)
            
            HStack(spacing: 0) {
                Color.blue
                    .frame(width: 45)
                Color.yellow
                    .frame(width: 15)
                Color.blue
            }
            .frame(height: 30)
        }
    }
    
    func presentBottomToast() {
        toast.present {
            SystemNotificationMessage(
                title: "Message.Toast.Title",
                text: "Message.Toast.Text",
                style: .prominent(backgroundColor: .black)
            )
        }
    }
    
    func presentCustomView() {
        notification.present(
            flagView
        )
    }
    
    func presentError() {
        notification.presentMessage(
            .error(
                title: "Message.Error.Title",
                text: "Message.Error.Text"
            )
        )
    }
    
    func presentLocalizedMessage() {
        notification.present(
            SystemNotificationMessage(
                icon: Text("🇸🇪"),
                title: "Message.Localized.Title",
                text: "Message.Localized.Text"
            )
        )
    }

    func presentModalCover() {
        isCoverActive = true
    }

    func presentModalSheet() {
        isSheetActive = true
    }

    func presentSilentMode() {
        notification.presentMessage(
            .silentMode(on: isSilentModeOn)
        )
    }
    
    func presentSuccess() {
        notification.presentMessage(
            .success(
                title: "Message.Success.Title",
                text: "Message.Success.Text"
            )
        )
    }
    
    func presentWarning() {
        notification.presentMessage(
            .warning(
                title: "Message.Warning.Title",
                text: "Message.Warning.Text"
            )
        )
    }
}

#Preview {
    
    struct Preview: View {
        
        @StateObject
        var notification = SystemNotificationContext()
        
        @State
        var style = SystemNotificationStyle.standard
        
        var body: some View {
            ContentView(style: $style)
                .systemNotification(notification)
        }
    }
    
    return Preview()
}

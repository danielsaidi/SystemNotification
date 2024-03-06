//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SystemNotification

/**
 This is the main demo app view, which is reused across four
 demo app tabs on iOS.

 The ``DemoApp`` struct creates a `SystemNotificationContext`
 that it injects as an environment object and applies to the
 view hierarchy, using a `systemNotification` modifier. This
 context can be used to present an app-wide notification. We
 also use a state-based `systemNotification` in this view to
 present nofitications based on `isNotificationActive`.

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

    @State
    private var isCoverActive = false

    @State
    private var isNotificationActive = false

    @State
    private var isSilentModeOn = false

    @State
    private var isSheetActive = false

    @EnvironmentObject
    private var context: SystemNotificationContext

    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        List {
            Section(header: Text("Context-based notifications")) {
                Toggle(isOn: $isSilentModeOn) {
                    label(.silentModeOff, "Silent mode")
                }
                listItem(.globe, "Show localized notification", presentLocalized)
                listItem(.warning, "Show orange warning", presentWarning)
                listItem(.error, "Show red error from bottom", presentError)
                listItem(.flag, "Show custom view", presentCustomView)
            }
            Section(header: Text("Non-dismissing notifications")) {
                listItem(.static, "Show non-dismissing notification", presentStaticNotification)
            }
            Section(header: Text("Modal screens")) {
                listItem(.sheet, "Show sheet", presentModalSheet)
                listItem(.cover, "Show full screen cover", presentModalCover)
                if isModal {
                    listItem(.dismiss, "Dismiss", dismiss)
                }
            }
        }
        .buttonStyle(.plain)
        .navigationTitle("SystemNotification")
        .sheet(isPresented: $isSheetActive) {
            ContentView(isModal: true).systemNotification(context)
        }
        #if os(iOS)
        .fullScreenCover(isPresented: $isCoverActive) {
            ContentView(isModal: true).systemNotification(context)
        }
        #endif
        .systemNotification(isActive: $isNotificationActive) {
            DemoNotification.static
        }
        .onChange(of: isSilentModeOn) {
            if $0 {
                presentSilentModeOn()
            } else {
                presentSilentModeOff()
            }
        }
    }
}

private extension ContentView {

    func label(_ icon: Image, _ text: String) -> some View {
        Label {
            Text(text)
        } icon: {
            icon
        }
    }

    func listItem(_ icon: Image, _ text: String, _ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            label(icon, text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
        }
    }
}

private extension ContentView {

    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }

    func presentCustomView() {
        context.present(
            content: DemoNotification.custom,
            style: DemoNotification.customStyle
        )
    }

    func presentError() {
        context.present(
            content: DemoNotification.error,
            style: DemoNotification.errorStyle
        )
    }

    func presentLocalized() {
        context.present(
            content: DemoNotification.localized
        )
    }

    func presentModalCover() {
        isCoverActive = true
    }

    func presentModalSheet() {
        isSheetActive = true
    }

    func presentSilentModeOff() {
        context.present(
            content: DemoNotification.silentModeOff
        )
    }

    func presentSilentModeOn() {
        context.present(
            content: DemoNotification.silentModeOn
        )
    }

    func presentStaticNotification() {
        isNotificationActive = true
    }

    func presentWarning() {
        context.present(
            content: DemoNotification.warning,
            style: DemoNotification.warningStyle
        )
    }
}


#Preview {
    
    ContentView()
}

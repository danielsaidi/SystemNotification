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
    
    @State private var isActive = false

    var body: some View {
        List {
            Button("Toggle notification", action: toggleNotification)
        }.systemNotification(isActive: $isActive) {
            SystemNotificationMessage(
                icon: Image(systemName: "bell.slash.fill"),
                title: "Silent Mode",
                text: "On",
                configuration: .init(iconColor: .red)
            )
        }
    }
    
    func toggleNotification() {
        isActive.toggle()
    }
}

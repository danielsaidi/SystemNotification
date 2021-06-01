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
    
    @State private var isDefaultPresented = false
    @State private var isStyledPresented = false
    @State private var isCustomPresented = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("").frame(height: 1)) {
                    Toggle("Show standard notification", isOn: $isDefaultPresented)
                    Toggle("Show styled notification", isOn: $isStyledPresented)
                    Toggle("Show custom notification", isOn: $isCustomPresented)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .navigationTitle("System Notification")
            .listStyle(InsetGroupedListStyle())
        }
        .systemNotification {
            SystemNotification(
                icon: Image(systemName: "exclamationmark.triangle"),
                title: "Alert",
                text: "Something happened!",
                isActive: $isDefaultPresented)
        }
        .systemNotification {
            SystemNotification(
                isActive: $isStyledPresented,
                configuration: SystemNotification.Configuration(
                    backgroundColor: .orange,
                    edge: .bottom)) { _ in
                SystemNotificationMessage(
                    icon: Image(systemName: "exclamationmark.triangle"),
                    title: "Warning",
                    text: "This is a long message to demonstrate multiline messages.",
                    configuration: SystemNotificationMessage.Configuration(
                        iconColor: .white,
                        iconFont: .headline,
                        textColor: .white,
                        titleColor: .white,
                        titleFont: .headline
                    )
                )
            }
        }
        .systemNotification {
            SystemNotification(
                isActive: $isCustomPresented,
                configuration: SystemNotification.Configuration(
                    backgroundColor: .blue,
                    edge: .bottom)) { _ in
                HStack {
                    Color.yellow
                    Text("Custom view")
                        .foregroundColor(.white)
                    Color.yellow
                }.frame(height: 50)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

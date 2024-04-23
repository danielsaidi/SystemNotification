//
//  SilentModeBell.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2023-01-17.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//
//  Inspiration: https://www.youtube.com/watch?v=qHoSKE3GZr4
//

import SwiftUI

struct SilentModeBell: View {

    var isSilentModeOn = false

    @State
    private var isRotated: Bool = false

    @State
    private var isAnimated: Bool = false

    var body: some View {
        Image(systemName: iconName)
            .rotationEffect(
                .degrees(isRotated ? -45 : 0),
                anchor: .top
            )
            .animation(
                .interpolatingSpring(
                    mass: 0.5,
                    stiffness: animationStiffness,
                    damping: animationDamping,
                    initialVelocity: 0
                ),
                value: isAnimated)
            .foregroundColor(iconColor)
            .onAppear(perform: animate)
    }
}

private extension SilentModeBell {

    func animate() {
        withAnimation { isRotated = true }
        perform(after: 0.1) {
            isRotated = false
            isAnimated = true
        }
    }

    func perform(after: Double, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: action)
    }

    var animationDamping: Double {
        isSilentModeOn ? 4 : 1.5
    }

    var animationStiffness: Double {
        isSilentModeOn ? 129 : 179
    }

    var iconName: String {
        isSilentModeOn ? "bell.slash.fill" : "bell.fill"
    }

    var iconColor: Color {
        isSilentModeOn ? .red : .gray
    }
}

#Preview {

    struct Preview: View {

        @State
        private var hasBells = false

        var body: some View {
            VStack {
                if hasBells {
                    SilentModeBell(isSilentModeOn: true)
                    SilentModeBell(isSilentModeOn: false)
                }
                
                Button("Ding!") { hasBells.toggle() }
            }
            .font(.largeTitle)
        }
    }

    return Preview()
}

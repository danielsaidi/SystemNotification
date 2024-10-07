//
//  SystemNotification.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2022-01-20.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

#if os(macOS)
import SwiftUI

/// This view can be used to create an overlay that can then
/// be added to any AppKit view, using `addAsOverlay(to:)`.
public struct SystemNotificationAppKitOverlay: View {
    
    public init(context: SystemNotificationContext) {
        self._context = ObservedObject(wrappedValue: context)
    }
    
    @ObservedObject
    var context: SystemNotificationContext
    
    public var body: some View {
        Color.clear
            .disabled(true)
            .edgesIgnoringSafeArea(.all)
            .systemNotification(context)
    }
}

public extension SystemNotificationAppKitOverlay {
    
    /// Add the overlay view to a certain AppKit view.
    func addAsOverlay(to view: NSView) {
        let overlay = NSHostingController(rootView: self)
        overlay.view.wantsLayer = true
        overlay.view.layer!.backgroundColor = .clear
        view.addSubview(overlay.view)

        overlay.view.translatesAutoresizingMaskIntoConstraints = false
        overlay.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        overlay.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        overlay.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        overlay.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
#endif

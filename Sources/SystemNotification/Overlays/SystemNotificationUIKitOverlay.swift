//
//  SystemNotification.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2022-01-20.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI

/// This view can be used to create an overlay that can then
/// be added to any UIKit view, using `addAsOverlay(to:)`.
public struct SystemNotificationUIKitOverlay: View {
    
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

public extension SystemNotificationUIKitOverlay {
    
    /// Add the overlay view to a certain UIKit view.
    func addAsOverlay(to view: UIView) {
        let overlay = UIHostingController(rootView: self)
        view.addSubview(overlay.view)

        // Prevent the UIHostingController from grabbing all touch events going to the UIKit view
        overlay.view.isUserInteractionEnabled = false
        overlay.view.backgroundColor = .clear
        overlay.view.translatesAutoresizingMaskIntoConstraints = false
        overlay.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        overlay.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        overlay.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        overlay.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
#endif

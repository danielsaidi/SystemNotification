//
//  SystemNotificationEdge.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This enum defines edges from which a system notification can be presented.
public enum SystemNotificationEdge {
    
    case top, bottom
    
    public var alignment: Alignment {
        switch self {
        case .top: .top
        case .bottom: .bottom
        }
    }
}

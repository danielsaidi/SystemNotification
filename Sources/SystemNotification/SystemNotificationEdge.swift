//
//  SystemNotificationEdge.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum specifies the edges from which a notification
 can be presented.
 */
public enum SystemNotificationEdge {
    
    case top, bottom
    
    public var alignment: Alignment {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        }
    }
}

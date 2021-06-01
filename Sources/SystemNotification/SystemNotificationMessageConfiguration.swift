//
//  SystemNotificationMessageConfiguration.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension SystemNotificationMessage {
    
    /**
     This type can be used to configre the look and behavior
     of a `SystemNotificationMessage`.
     */
    public struct Configuration {
        
        public init(
            iconColor: Color = .primary.opacity(0.6),
            iconFont: Font = Font.footnote,
            padding: CGSize = .init(width: 8, height: 15),
            textColor: Color = .primary.opacity(0.6),
            textFont: Font = Font.footnote,
            titleColor: Color = .primary.opacity(0.6),
            titleFont: Font = Font.footnote.bold()) {
            self.iconColor = iconColor
            self.iconFont = iconFont
            self.padding = padding
            self.textColor = textColor
            self.textFont = textFont
            self.titleColor = titleColor
            self.titleFont = titleFont
        }
        
        public let iconColor: Color
        public let iconFont: Font
        public let padding: CGSize
        public let textColor: Color
        public let textFont: Font
        public let titleColor: Color
        public let titleFont: Font
    }
}

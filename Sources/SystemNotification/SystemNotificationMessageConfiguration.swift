//
//  SystemNotificationMessageConfiguration.swift
//  SystemNotification
//
//  Created by Daniel Saidi on 2021-06-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This type can be used to configure the look and behavior of
 a `SystemNotificationMessage` view.
 */
public struct SystemNotificationMessageConfiguration {
    
    
    /// Create a notification message configuration.
    ///
    /// - Parameters:
    ///   - iconColor: The color to apply to the icon.
    ///   - iconFont: The font to apply to the icon.
    ///   - padding: The padding to add to the content.
    ///   - textColor: The color to apply to the text.
    ///   - textFont: The font to apply to the text.
    ///   - titleColor: The color to apply to the title.
    ///   - titleFont: The font to apply to the title.
    public init(
        iconColor: Color = .primary.opacity(0.6),
        iconFont: Font = Font.title3,
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
    
    /**
     This is a standard notification message configuration.
     */
    public static let standard = SystemNotificationMessageConfiguration()
    
    /**
     The color to apply to the icon.
     */
    public let iconColor: Color
    
    /**
     The font to apply to the icon.
     */
    public let iconFont: Font
    
    /**
     The padding to add to the content.
     */
    public let padding: CGSize
    
    /**
     The color to apply to the text.
     */
    public let textColor: Color
    
    /**
     The font to apply to the text.
     */
    public let textFont: Font
    
    /**
     The color to apply to the title.
     */
    public let titleColor: Color
    
    /**
     The font to apply to the title.
     */
    public let titleFont: Font
}

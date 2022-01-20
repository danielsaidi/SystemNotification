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
    ///   - iconTextSpacing: The spacing to apply between the icon and the text.
    ///   - minWidth: The minimum width of the message view.
    ///   - padding: The padding to add to the content.
    ///   - textColor: The color to apply to the text.
    ///   - textFont: The font to apply to the text.
    ///   - titleColor: The color to apply to the title.
    ///   - titleFont: The font to apply to the title.
    ///   - titleTextSpacing: The spacing to apply between the title and the text.
    public init(
        iconColor: Color = .primary.opacity(0.6),
        iconFont: Font = Font.title3,
        iconTextSpacing: CGFloat = 20,
        minWidth: CGFloat = 150,
        padding: CGSize = .init(width: 15, height: 7),
        textColor: Color = .primary.opacity(0.4),
        textFont: Font = Font.footnote.bold(),
        titleColor: Color = .primary.opacity(0.6),
        titleFont: Font = Font.footnote.bold(),
        titleTextSpacing: CGFloat = 2) {
        self.iconColor = iconColor
        self.iconFont = iconFont
        self.iconTextSpacing = iconTextSpacing
        self.minWidth = minWidth
        self.padding = padding
        self.textColor = textColor
        self.textFont = textFont
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.titleTextSpacing = titleTextSpacing
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
     The spacing to apply between the icon and the text.
     */
    public let iconTextSpacing: CGFloat
    
    /**
     The minimum width of the message view.
     */
    public let minWidth: CGFloat
    
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
    
    /**
     The spacing to apply between the title and the text.
     */
    public let titleTextSpacing: CGFloat
}

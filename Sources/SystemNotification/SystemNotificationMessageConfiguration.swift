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
 a ``SystemNotificationMessage``.
 */
public struct SystemNotificationMessageConfiguration {

    /**
     Create a system notification message configuration.

     - Parameters:
       - iconColor: The color to apply to the icon.
       - iconFont: The font to apply to the icon.
       - iconTextSpacing: The spacing to apply between the icon and the text.
       - padding: The padding to add to the content.
       - textColor: The color to apply to the text.
       - textFont: The font to apply to the text.
       - titleColor: The color to apply to the title.
       - titleFont: The font to apply to the title.
       - titleTextSpacing: The spacing to apply between the title and the text.
     */
    public init(
        iconColor: Color = .primary.opacity(0.6),
        iconFont: Font = Font.title3,
        iconTextSpacing: CGFloat = 20,
        padding: CGSize = .init(width: 15, height: 7),
        textColor: Color = .primary.opacity(0.4),
        textFont: Font = Font.footnote.bold(),
        titleColor: Color = .primary.opacity(0.6),
        titleFont: Font = Font.footnote.bold(),
        titleTextSpacing: CGFloat = 2
    ) {
        self.iconColor = iconColor
        self.iconFont = iconFont
        self.iconTextSpacing = iconTextSpacing
        self.padding = padding
        self.textColor = textColor
        self.textFont = textFont
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.titleTextSpacing = titleTextSpacing
    }
    
    /**
     This is a standard notification message configuration.

     You can apply a custom value to this property to affect
     all system notification within an app.     
     */
    public static var standard = SystemNotificationMessageConfiguration()
    
    /**
     The color to apply to the icon.
     */
    public var iconColor: Color
    
    /**
     The font to apply to the icon.
     */
    public var iconFont: Font
    
    /**
     The spacing to apply between the icon and the text.
     */
    public var iconTextSpacing: CGFloat
    
    /**
     The padding to add to the content.
     */
    public var padding: CGSize
    
    /**
     The color to apply to the text.
     */
    public var textColor: Color
    
    /**
     The font to apply to the text.
     */
    public var textFont: Font
    
    /**
     The color to apply to the title.
     */
    public var titleColor: Color
    
    /**
     The font to apply to the title.
     */
    public var titleFont: Font
    
    /**
     The spacing to apply between the title and the text.
     */
    public var titleTextSpacing: CGFloat
}

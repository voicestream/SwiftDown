//
//  File.swift
//  
//
//  Created by Joep van den Bogaert on 16/03/2023.
//

import Foundation
import SwiftUI
import Down

public struct CustomParagraphStyleCollection: ParagraphStyleCollection {
    
    // MARK: - Properties
    
    public var heading1: NSParagraphStyle
    public var heading2: NSParagraphStyle
    public var heading3: NSParagraphStyle
    public var heading4: NSParagraphStyle
    public var heading5: NSParagraphStyle
    public var heading6: NSParagraphStyle
    public var body: NSParagraphStyle
    public var code: NSParagraphStyle
    
    // MARK: - Life cycle
    public init(
        h1ParagraphSpacing: CGFloat = 12,
        h2ParagraphSpacing: CGFloat = 10,
        h3ParagraphSpacing: CGFloat = 8,
        h4ParagraphSpacing: CGFloat = 0,
        h5ParagraphSpacing: CGFloat = 0,
        h6ParagraphSpacing: CGFloat = 0,
        h1ParagraphSpacingBefore: CGFloat = 20,
        h2ParagraphSpacingBefore: CGFloat = 16,
        h3ParagraphSpacingBefore: CGFloat = 12,
        h4ParagraphSpacingBefore: CGFloat = 8,
        h5ParagraphSpacingBefore: CGFloat = 8,
        h6ParagraphSpacingBefore: CGFloat = 8,
        bodyParagraphSpacing: CGFloat = 4,
        bodyParagraphSpacingBefore: CGFloat = 4,
        bodyLineSpacing: CGFloat = 3,
        codeParagraphSpacing: CGFloat = 8,
        codeParagraphSpacingBefore: CGFloat = 8
    ) {
        let h1Style = NSMutableParagraphStyle()
        h1Style.paragraphSpacing = h1ParagraphSpacing
        h1Style.paragraphSpacingBefore = h1ParagraphSpacingBefore
        let h2Style = NSMutableParagraphStyle()
        h2Style.paragraphSpacing = h2ParagraphSpacing
        h2Style.paragraphSpacingBefore = h2ParagraphSpacingBefore
        let h3Style = NSMutableParagraphStyle()
        h3Style.paragraphSpacing = h3ParagraphSpacing
        h3Style.paragraphSpacingBefore = h3ParagraphSpacingBefore
        let h4Style = NSMutableParagraphStyle()
        h4Style.paragraphSpacing = h4ParagraphSpacing
        h4Style.paragraphSpacingBefore = h4ParagraphSpacingBefore
        let h5Style = NSMutableParagraphStyle()
        h5Style.paragraphSpacing = h5ParagraphSpacing
        h5Style.paragraphSpacingBefore = h5ParagraphSpacingBefore
        let h6Style = NSMutableParagraphStyle()
        h6Style.paragraphSpacing = h6ParagraphSpacing
        h6Style.paragraphSpacingBefore = h6ParagraphSpacingBefore
        let bodyStyle = NSMutableParagraphStyle()
        bodyStyle.paragraphSpacing = bodyParagraphSpacing
        bodyStyle.paragraphSpacingBefore = bodyParagraphSpacingBefore
        bodyStyle.lineSpacing = bodyLineSpacing
        let codeStyle = NSMutableParagraphStyle()
        codeStyle.paragraphSpacing = codeParagraphSpacing
        codeStyle.paragraphSpacingBefore = codeParagraphSpacingBefore

        heading1 = h1Style
        heading2 = h2Style
        heading3 = h3Style
        heading4 = h4Style
        heading5 = h5Style
        heading6 = h6Style
        body = bodyStyle
        code = codeStyle
    }

    public init(
        h1Style: NSParagraphStyle,
        h2Style: NSParagraphStyle,
        h3Style: NSParagraphStyle,
        h4Style: NSParagraphStyle,
        h5Style: NSParagraphStyle,
        h6Style: NSParagraphStyle,
        bodyStyle: NSParagraphStyle,
        codeStyle: NSParagraphStyle
    ) {
        heading1 = h1Style
        heading2 = h2Style
        heading3 = h3Style
        heading4 = h4Style
        heading5 = h5Style
        heading6 = h6Style
        body = bodyStyle
        code = codeStyle
    }
}

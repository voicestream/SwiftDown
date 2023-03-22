//
//  File.swift
//  
//
//  Created by Joep van den Bogaert on 21/03/2023.
//

import Foundation
import SwiftUI

enum LibreFranklinFont: String, CaseIterable {
    case black = "LibreFranklin-Black"
    case blackItalic = "LibreFranklin-BlackItalic"
    case bold = "LibreFranklin-Bold"
    case boldItalic = "LibreFranklin-BoldItalic"
    case extraBold = "LibreFranklin-ExtraBold"
    case extraBoldItalic = "LibreFranklin-ExtraBoldItalic"
    case extraLight = "LibreFranklin-ExtraLight"
    case extraLightItalic = "LibreFranklin-ExtraLightItalic"
    case italic = "LibreFranklin-Italic"
    case light = "LibreFranklin-Light"
    case lightItalic = "LibreFranklin-LightItalic"
    case medium = "LibreFranklin-Medium"
    case mediumItalic = "LibreFranklin-MediumItalic"
    case regular = "LibreFranklin-Regular"
    case semiBold = "LibreFranklin-SemiBold"
    case semiBoldItalic = "LibreFranklin-SemiBoldItalic"
    case thin = "LibreFranklin-Thin"
    case thinItalic = "LibreFranklin-ThinItalic"
}

public struct FontManager {
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
            let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
            let font = CGFont(fontDataProvider) else {
                fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
        }
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }

    public static func registerFonts() {
        LibreFranklinFont.allCases.forEach {
            registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "ttf")
        }
    }
}

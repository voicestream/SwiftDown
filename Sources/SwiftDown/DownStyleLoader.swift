//
//  DownStyleLoader.swift
//  
//
//  Created by Joep van den Bogaert on 15/03/2023.
//
import SwiftUI
import Down
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public class DownStyleLoader {
    var name: String
    var styles: [String : [String : AnyObject]] = [:]
    var fontNameMap: [String: String] = [:]
    var fontSizeMap: [String: CGFloat] = [:]
    var fontColorMap: [String: String] = [:]
    var styler: DownStyler? = nil

    convenience init(scheme: ColorScheme) {
        var themeName = "default-light"
        switch scheme {
        case .dark:
            themeName = "default-dark"
        case .light:
            themeName = "default-light"
        @unknown default:
            themeName = "default-light"
        }
        self.init(name: themeName)
    }

    public init(name: String) {
        self.name = name
        if let path = getPath(name) {
            self.styles = self.loadStyles(path)
            self.splitStylesDict()
        } else {
            assertionFailure()
        }
    }
    
    func getPath(_ name: String) -> String? {
        if let url = Bundle.module.url(forResource: "Themes/\(name)", withExtension: "json") {
            return url.path
        } else {
            print("Resource `\(name)` not found.")
            return nil
        }
    }
    
    func loadStyles(_ path: String) -> [String : [String : AnyObject]] {
        do {
            let json = try String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)
            if let data = json.data(using: .utf8) {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data, options: []) as! [String : AnyObject]
                    if let styles = parsedData["styles"] as? [String: [String : AnyObject]] {
                        return styles
                    }
                    return [:]
                } catch let error as NSError {
                    print(error)
                }
            }
        } catch let error as NSError {
            print(error)
        }
        return [:]
    }
    
    func splitStylesDict() {
        MarkdownNode.MarkdownType.allCases.forEach( { mdType in
            let mdTypeString = mdType.toString()
            if let fontName = self.styles[mdTypeString]?["font"] as? String {
                self.fontNameMap[mdTypeString] = fontName
            } else {
                self.fontNameMap[mdTypeString] = "HelveticaNeue"
            }
            if let fontSize = self.styles[mdTypeString]?["size"] as? CGFloat {
                self.fontSizeMap[mdTypeString] = fontSize
            } else {
                self.fontSizeMap[mdTypeString] = CGFloat(15.0)
            }
            if let fontColor = self.styles[mdTypeString]?["color"] as? String {
                self.fontColorMap[mdTypeString] = fontColor
            } else {
                self.fontColorMap[mdTypeString] = "#FFFFFF"
            }
        })
    }
    
    func getFontCollection() -> StaticFontCollection {
        return StaticFontCollection(
            heading1: DownFont(name: self.fontNameMap["h1"]!, size: self.fontSizeMap["h1"]!) ?? .boldSystemFont(ofSize: 28),
            heading2: DownFont(name: self.fontNameMap["h2"]!, size: self.fontSizeMap["h2"]!) ?? .boldSystemFont(ofSize: 24),
            heading3: DownFont(name: self.fontNameMap["h3"]!, size: self.fontSizeMap["h3"]!) ?? .boldSystemFont(ofSize: 20),
            heading4: DownFont(name: self.fontNameMap["h4"]!, size: self.fontSizeMap["h4"]!) ?? .boldSystemFont(ofSize: 18),
            heading5: DownFont(name: self.fontNameMap["h5"]!, size: self.fontSizeMap["h5"]!) ?? .boldSystemFont(ofSize: 18),
            heading6: DownFont(name: self.fontNameMap["h6"]!, size: self.fontSizeMap["h6"]!) ?? .boldSystemFont(ofSize: 18),
            body: DownFont(name: self.fontNameMap["body"]!, size: self.fontSizeMap["body"]!) ?? .systemFont(ofSize: 17),
            code: DownFont(name: self.fontNameMap["inlineCode"]!, size: self.fontSizeMap["inlineCode"]!) ?? .monospacedSystemFont(ofSize: 17, weight: .regular),
            listItemPrefix: DownFont(name: self.fontNameMap["list"]!, size: self.fontSizeMap["list"]!) ?? .monospacedDigitSystemFont(ofSize: 17, weight: .regular)
        )
    }
    
    func getColorCollection() -> StaticColorCollection {
        return StaticColorCollection(
            heading1: UniversalColor(hexString: self.fontColorMap["h1"]!),
            heading2: UniversalColor(hexString: (self.fontColorMap["h2"]! )),
            heading3: UniversalColor(hexString: (self.fontColorMap["h3"]! )),
            heading4: UniversalColor(hexString: (self.fontColorMap["h4"]! )),
            heading5: UniversalColor(hexString: self.fontColorMap["h5"]! ),
            heading6: UniversalColor(hexString: self.fontColorMap["h6"]! ),
            body: UniversalColor(hexString: self.fontColorMap["body"]! ),
            code: UniversalColor(hexString: self.fontColorMap["inlineCode"]! ),
            link: UniversalColor(hexString: self.fontColorMap["link"]! ),
            quote: UniversalColor(hexString: self.fontColorMap["blockQuote"]! ),
            //            quoteStripe: UniversalColor(hexString: self.fontColorMap["blockQuote"]!),
            //            thematicBreak: UniversalColor(hexString: self.fontColorMap[""]!),
            listItemPrefix: UniversalColor(hexString: self.fontColorMap["list"]! )
            //            codeBlockBackground: UniversalColor(hexString: self.fontColorMap["body"]!)
        )
    }
    
    func getParagraphStyle() -> StaticParagraphStyleCollection {
        return StaticParagraphStyleCollection()
    }
    
    func getListItemOptions() -> ListItemOptions {
        return ListItemOptions()
    }
    
    func getQuoteStripeOptions() -> QuoteStripeOptions {
        return QuoteStripeOptions()
    }
    
    func getThematicBreakOptions() -> ThematicBreakOptions {
        return ThematicBreakOptions()
    }
    
    func getCodeBlockOptions() -> CodeBlockOptions {
        return CodeBlockOptions()
    }
    
    func getDownStylerConfiguration() -> DownStylerConfiguration {
        return DownStylerConfiguration(
            fonts: getFontCollection(),
            colors: getColorCollection(),
            paragraphStyles: getParagraphStyle(),
            listItemOptions: getListItemOptions(),
            quoteStripeOptions: getQuoteStripeOptions(),
            thematicBreakOptions: getThematicBreakOptions(),
            codeBlockOptions: getCodeBlockOptions()
        )
    }
    
    func getDownStyler() -> DownStyler {
        return DownStyler(configuration: getDownStylerConfiguration())
    }
}

public func loadDownStyler(_ theme: Theme.BuiltIn) -> DownStyler {
    switch theme {
    case .defaultDark:
        let loader = DownStyleLoader(name: "default-dark")
        return loader.getDownStyler()
    case .defaultLight:
        let loader = DownStyleLoader(name: "default-light")
        return loader.getDownStyler()
    }
}

//
//  DownStyleLoaderTests.swift
//  
//
//  Created by Joep van den Bogaert on 15/03/2023.
//

import XCTest
import Nimble
import Down

@testable import SwiftDown

final class DownStyleLoaderTests: XCTestCase {
    
    func testDownStyleLoaderInitDark() {
        let loader = DownStyleLoader(name: "default-dark")
        expect(loader.styles.count).to(equal(15))
    }
    
    func testDownStyleLoaderInitLight() {
        let loader = DownStyleLoader(name: "default-light")
        expect(loader.styles.count).to(equal(15))
    }
    
    func testFontParsing() {
        let loader = DownStyleLoader(name: "default-dark")
        let fontCollection = loader.getFontCollection()
        expect(fontCollection.heading1).to(equal(DownFont(name: "HelveticaNeue", size: 23)))
        expect(fontCollection.body).to(equal(DownFont(name: "Menlo-Regular", size: 15)))
    }
    
    func testColorParsing() {
        let loader = DownStyleLoader(name: "default-light")
        let colorCollection = loader.getColorCollection()
        expect(colorCollection.heading3).to(equal(UniversalColor(hexString: "#C96667")))
        expect(colorCollection.link).to(equal(UniversalColor(hexString: "#a66bff")))
    }
    
    func testLoadDownStylerDark() {
        let downStyler = loadDownStyler(.defaultDark)
        expect(downStyler.fonts.heading1).to(equal(DownFont(name: "HelveticaNeue", size: 23)))
        expect(downStyler.colors.heading1).to(equal(UniversalColor(hexString: "#D36770")))
    }
    
    func testLoadDownStylerLight() {
        let downStyler = loadDownStyler(.defaultLight)
        expect(downStyler.fonts.heading1).to(equal(DownFont(name: "HelveticaNeue", size: 23)))
        expect(downStyler.colors.heading1).to(equal(UniversalColor(hexString: "#C96667")))
    }
    
}

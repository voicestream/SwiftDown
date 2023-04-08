//
//  SwiftDownViewer.swift
//
//  Based on an implementation by Mikhail Ivanov on 01.06.2021.
//
import SwiftUI
#if os(iOS)
import UIKit
typealias ViewRepresentable = UIViewRepresentable
#elseif os(macOS)
import AppKit
typealias ViewRepresentable = NSViewRepresentable
#endif
import Down

struct MarkdownRepresentable: ViewRepresentable {
    var markdown: String

#if os(iOS)
    func makeUIView(context: Context) -> DownTextView {
        let styler = loadDefaultDownStyler(context.environment.colorScheme)
        let downView = DownTextView(frame: .zero, styler: styler)
        downView.text = self.markdown
        downView.textAlignment = NSTextAlignment.left
        downView.isScrollEnabled = true
        downView.showsVerticalScrollIndicator = false
        downView.showsHorizontalScrollIndicator = false
        downView.isEditable = false
        downView.backgroundColor = UIColor.clear
        downView.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.horizontal)
        downView.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)
        return downView
    }

    func updateUIView(_ uiView: DownTextView, context: Context) {
        uiView.styler = loadDefaultDownStyler(context.environment.colorScheme)
        uiView.text = markdown
    }

#elseif os(macOS)
    func makeNSView(context: Context) -> DownTextView {
        let styler = loadDefaultDownStyler(context.environment.colorScheme)
        let downView = DownTextView(frame: .zero, styler: styler)
        downView.string = self.markdown
        downView.isEditable = false
        downView.backgroundColor = NSColor.clear
        downView.setContentCompressionResistancePriority(NSLayoutConstraint.Priority.defaultLow, for: NSLayoutConstraint.Orientation.horizontal)
        downView.setContentCompressionResistancePriority(NSLayoutConstraint.Priority.defaultLow, for: NSLayoutConstraint.Orientation.vertical)
        return downView
    }

    func updateNSView(_ nsView: DownTextView, context: Context) {
        nsView.styler = loadDefaultDownStyler(context.environment.colorScheme)
        nsView.string = markdown
    }
#endif
}

public struct SwiftDownViewer: View {

    var text: String
    
    public init(text: String) {
        self.text = text
    }

    public var body: some View {
        MarkdownRepresentable(markdown: text)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

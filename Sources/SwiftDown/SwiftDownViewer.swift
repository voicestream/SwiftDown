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
    @Binding var markdown: String

#if os(iOS)
    func makeUIView(context: Context) -> DownTextView {
        let styler = loadDefaultDownStyler(context.environment.colorScheme)
        let downView = DownTextView(frame: .zero, styler: styler)
        downView.text = self.markdown
        downView.textAlignment = .left
        downView.isScrollEnabled = false
        downView.showsVerticalScrollIndicator = false
        downView.showsHorizontalScrollIndicator = false
        downView.isEditable = false
        downView.backgroundColor = .clear
        downView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        downView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return downView
    }

    func updateUIView(_ uiView: DownTextView, context: Context) {
        uiView.styler = loadDefaultDownStyler(context.environment.colorScheme)
        uiView.text = markdown
    }

#elseif os(macOS)
    func makeNSView(context: Context) -> TextView {
        let downView = DownTextView(frame: .zero, styler: styler)
        downView.string = self.markdown
        downView.isEditable = false
        downView.backgroundColor = .clear
        downView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        downView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return downView
    }

    func updateNSView(_ nsView: NSTextView, context: Context) {
        nsView.styler = loadDefaultDownStyler(context.environment.colorScheme)
        nsView.string = markdown    }
#endif
}

public struct SwiftDownViewer: View {

    @State var text: String

    public init(text: String) {
        self.text = text
    }

    public var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                MarkdownRepresentable(markdown: $text)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
        }
    }
}

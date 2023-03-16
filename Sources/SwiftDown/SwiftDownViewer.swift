//
//  SwiftDownViewer.swift
//
//  Based on an implementation by Mikhail Ivanov on 01.06.2021.
//
import SwiftUI
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
import Down

struct MarkdownRepresentable: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    @Binding var dynamicHeight: CGFloat
    var markdown: String
    var styler: DownStyler
    @State var test: Int = 0

    init(markdown: String, height: Binding<CGFloat>, styler: DownStyler) {
        self._dynamicHeight = height
        self.markdown = markdown
        self.styler = styler
    }

    // TODO: As soon as PR: 258 is accepted - you need to uncomment
    //    func makeCoordinator() -> Cordinator {
    //        Cordinator(text: markdownObject.textView)
    //    }
    
    func makeUIView(context: Context) -> TextView {
        let downView = DownTextView(frame: .zero, styler: styler)
        downView.text = self.markdown
        // TODO: As soon as PR: 258 is accepted - you need to uncomment
        //        let attributedText = try? down.toAttributedString(styler: DownStyler(delegate: context.coordinator))
        downView.textAlignment = .left
        downView.isScrollEnabled = false
        downView.showsVerticalScrollIndicator = false
        downView.showsHorizontalScrollIndicator = false
        downView.isEditable = false
        downView.backgroundColor = .clear
        downView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        downView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

//        return markdownObject.textView
        return downView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            /// Allows you to change the color of the text when switching the device theme.
            /// I advise you to do it in the future through the configuration when setting up your own Styler class
//            uiView.textColor = colorScheme == .dark ? UIColor.white : UIColor.black
            
            dynamicHeight = uiView.sizeThatFits(CGSize(width: uiView.bounds.width,
                                                       height: CGFloat.greatestFiniteMagnitude))
            .height
        }
    }
    
    // TODO: As soon as PR: 258 is accepted - you need to uncomment
    //    class Cordinator: NSObject, AsyncImageLoadDelegate {
    //
    //        public var textView: UITextView
    //
    //        init(text: UITextView) {
    //            textView = text
    //        }
    //
    //        func textAttachmentDidLoadImage(textAttachment: AsyncImageLoad, displaySizeChanged: Bool)
    //            {
    //                if displaySizeChanged
    //                {
    //                    textView.layoutManager.setNeedsLayout(forAttachment: textAttachment)
    //                }
    //
    //                // always re-display, the image might have changed
    //                textView.layoutManager.setNeedsDisplay(forAttachment: textAttachment)
    //            }
    //    }
}

public struct SwiftDownViewer: View {

    private var markdownString: String
    var styler: DownStyler
    @State private var height: CGFloat = .zero
    
    public init(text: String, scheme: ColorScheme) {
        self.markdownString = text
        self.styler = loadDefaultDownStyler(scheme)
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                MarkdownRepresentable(markdown: markdownString, height: $height, styler: self.styler)
                    .frame(height: height)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

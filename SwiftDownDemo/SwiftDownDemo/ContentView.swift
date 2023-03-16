//
//  ContentView.swift
//  VoamNotes
//
//  Created by Joep van den Bogaert on 28/02/2023.
//

import SwiftUI
import Down
import SwiftDown

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isEditing = false
    @State private var noteText = """
    # My Note Title
    
    This is the body of my note. It can contain **bold** and *italic* text, as well as other Markdown formatting like links and images.
    
    > This quote is amazing


    ## Examples
    In this section, we show the following examples:
    * A code example
    * Markdown examples
      - with heading 4
      - with heading 5
      - with heading 6

    ### Code example
    Consider the following code:
    ```python
    a = np.arange(4)
    b = 3 + a
    ```
    Did you know that `b == np.array([3, 4, 5, 6])`?
    
    Here comes a thematic break.
    
    ---
    
    ### Markdown Examples
    Let's try some headers.
    #### Heading 4
    Followed by some text.
    ##### Heading 5
    Followed by some text.
    ##### Heading 6
    Followed by more text.

    ## Resources
    You should check out [voam.io](https://voam.io).
    """

    var body: some View {
        VStack {
            if isEditing {
                SwiftDownEditor(text: $noteText, themeName: colorScheme == .dark ? "default-dark" : "default-light")
                    .padding()
            } else {
//                Text(noteText)
                SwiftDownViewer(text: noteText, scheme: colorScheme)
                    .padding()
            }
            Button(isEditing ? "Save" : "Edit") {
                isEditing.toggle()
            }
        }
        .navigationTitle("Note")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

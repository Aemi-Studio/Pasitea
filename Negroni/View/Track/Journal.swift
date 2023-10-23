//
//  TrackItemView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct TextView: UIViewRepresentable {
 
    @Binding var text: String
    @Binding var textStyle: UIFont.TextStyle
 
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
 
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
    
        
 
        return textView
    }
 
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
        uiView.textColor = .white
        uiView.backgroundColor = .black
        uiView.layer.opacity = 0.5
        
        
    }
}

struct Journal: View {
    @State private var trackItemContent: String = ""
    @State private var textStyle = UIFont.TextStyle.body
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.2).edgesIgnoringSafeArea(.all)
                
                VStack{
                        Text("Hi user how are you ? ")
                        
                        TextView(text: $trackItemContent,textStyle: $textStyle)
                        .frame(height: 350)
                        .cornerRadius(10)
                        
                    
                }
                .padding()
                
            }
            .toolbar {
                HStack {
//                    Button(role:.cancel, action: {}){
//                        Text("Cancel")
//                    }
                    Spacer()
                    Button(action: {}){
                        Text("Save")
                    }
                }
            }
//            .interactiveDismissDisabled()
        }
        
    



    }
}
#Preview {
    Journal()
}

//
//  TestBackgroundView.swift
//  Negroni
//
//  Created by Firdavs Juraev on 19/10/23.
//

import SwiftUI

struct TestBackgroundView: View {
    //MARK: PROPERTIES
    var msg = "Ciao"
    
    //MARK: BODY
    var body: some View {
        NavigationStack {
            ZStack() {
                Color.purple.opacity(0.2).edgesIgnoringSafeArea(.all)
                VStack() {
                    Button(action: {
                        
                    }){
                        Text("Click me")
                    }
                    Text(msg)
                }
            }// end zstack
            .navigationTitle("Test")
        }//end: NavigationStack
    }
}

//MARK: PREVIEW

#Preview {
    TestBackgroundView()
}

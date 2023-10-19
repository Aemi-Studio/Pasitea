//
//  CalmExerciseFinishedView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct CalmExerciseFinishedView: View {

    @Environment(\.dismiss) var dismiss
    @State private var isPresented = false

    var previousDismissAction: DismissAction?

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Text("Exercise Finished")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("Do you still need help ?")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                HStack(spacing:20) {

                    Button("Yes", systemImage:"questionmark.circle.fill",action:{
                        isPresented = true
                    })
                        .navigationDestination(isPresented: $isPresented) {
                            MultipleChoicesView(dismissAction: previousDismissAction ?? dismiss, lastExercise: .Steps)
                        }
                        .navigationSplitViewStyle(.prominentDetail)
                        .buttonStyle(.borderedProminent)

                    Button("I'm fine.", systemImage:"checkmark.circle.fill", action:{ dismiss() })
                        .buttonStyle(.borderedProminent)
                }
                Spacer()
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    CalmExerciseFinishedView()
}

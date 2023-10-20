//
//  TrackItemAddView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 20/10/23.
//

import SwiftUI
import SwiftData

struct TrackItemAddView: View {

    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var trackTypeId: Int = 1

    func save() {
        let item = TrackItem(
            title,
            desc,
            type: TrackItem.TrackType.allCases[trackTypeId].rawValue,
            tags: [],
            date: Date.now
        )

        context.insert(item)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }


    var body: some View {

        NavigationView {
            
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    
                    VStack(alignment: .leading) {
                        Text("Title")
                            .bold()
                        TextField("Feeling Sad", text: $title)
                            .padding()
                            .background {
                                Color.gray.opacity(0.15)
                            }
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Description")
                            .bold()
                        TextField("I've been feeling blue lately", text: $desc)
                            .padding()
                            .background {
                                Color.gray.opacity(0.15)
                            }
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Type")
                            .bold()
                        Picker(selection: $trackTypeId, label: Text("Type")) {
                            Text("5 Steps").tag(1)
                            Text("Breathing").tag(2)
                            Text("Listening").tag(3)
                            Text("Feeling").tag(4)
                        }.pickerStyle(.palette)
                    }
                }.scaledToFit()
                
                Spacer()
            }
            .padding()
            .toolbar {
                Button(action: {
                    self.save()
                    self.dismiss()
                }) {
                    Text("Save")
                }
            }
        }
    }
}

#Preview {
    TrackItemAddView()
        .modelContainer(try! ModelContainer(for: TrackItem.self))
}

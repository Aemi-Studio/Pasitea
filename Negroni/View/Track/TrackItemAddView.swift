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

    @Binding var isPresented: Bool

    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var trackTypeId: Int = 4
    @State private var startDate: Date = Date.now
    @State private var endDate: Date = Date.now

    var previousId: UUID? = nil

    func save() {
        let item = TrackItem(
            type: TrackItem.TrackType.allCases[trackTypeId].rawValue,
            desc: desc,
            startDate: startDate,
            endDate: endDate,
            previousId: previousId
        )

        context.insert(item)
        
        do {
            try context.save()
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical) {
                    Form {
                        VStack(alignment: .leading){
                            Label("Exercise", systemImage: "square.grid.2x2")
                            Picker(selection: $trackTypeId, label: Text("Type")) {
                                Text("5 Steps").tag(1)
                                Text("Breathing").tag(2)
                                Text("Listening").tag(3)
                                Text("Feeling").tag(4)
                            }
                            .pickerStyle(.segmented)
                            .labelsHidden()
                            .focusable()
                        }
                        .safeAreaPadding(.bottom)


                        VStack(alignment: .leading) {
                            Label("Personal Notes", systemImage: "face.smiling.inverse")
                            VStack(alignment: .leading){
                                TextField("I've been feeling blue lately...", text: $desc, axis: .vertical)
                                    .submitLabel(.next)
                                    .lineLimit(10, reservesSpace: true)
                                    .labelsHidden()
                                    .padding(12)
                            }
                            .background {
                                RoundedRectangle(cornerRadius:10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThickMaterial)
                                    .cornerRadius(10)
                                    .opacity(0.2)
                            }
                        }
                        .safeAreaPadding(.bottom)

                        VStack(alignment: .leading) {
                            Label("Start Date", systemImage: "calendar")
                            DatePicker("Starting Date\n", selection: $startDate)
                                .labelsHidden()
                                .scaledToFill()
                                .focusable()
                        }
                        .safeAreaPadding(.bottom)

                        VStack(alignment: .leading) {
                            Label("End Date", systemImage: "calendar")
                            DatePicker("Ending Date\n", selection: $endDate)
                                .labelsHidden()
                                .scaledToFill()
                                .focusable()
                        }
                        .safeAreaPadding(.bottom)
                    }
                    .formStyle(.columns)
                    .safeAreaPadding(.all)
                }
            }
        }
        .navigationTitle("New Tracked Event")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbar {
            ToolbarItemGroup(placement: .cancellationAction) {
                Button("Cancel", action: {
                    isPresented = false
                })
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .confirmationAction) {
                Button("Save", action: {
                    self.save()
                    do {
                        try context.save()
                    } catch {
#if DEBUG
                        print(error.localizedDescription)
#endif
                    }
                    isPresented = false
                })
            }
        }
    }
}


#if DEBUG
struct TrackItemAddView_Preview: PreviewProvider  {
    static var previews: some View {

        @State var isPresented = true

        TrackItemAddView(isPresented: $isPresented)
            .modelContainer(try! ModelContainer(for: TrackItem.self))
    }
}
#endif

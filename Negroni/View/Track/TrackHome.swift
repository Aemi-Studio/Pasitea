//
//  TrackHome.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI
import SwiftData

struct TrackHome: View {
    @Environment(\.modelContext) private var modelContext

    @State private var addViewIsPresented: Bool = false

    @Query(filter: #Predicate<TrackItem> { item in
        item.type == "Feeling"
    }, sort: \TrackItem.startDate, order: .reverse)
    var feelingItems: [TrackItem]

    @Query(filter: #Predicate<TrackItem> { item in
        item.type != "Feeling"
    }, sort: \TrackItem.startDate, order: .reverse)
    var notFeelingItems: [TrackItem]

    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    Text("Track")
                        .font(.largeTitle)
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)

                Divider()
                    .padding(.bottom)

                VStack(alignment: .leading, spacing: 16) {
                    VStack(spacing: 16) {
                        HStack {
                            NavigationLink {
                                TrackJournalView(items: feelingItems)
                            } label: {
                                Text("Journal")
                                    .fontDesign(.serif)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .fontWeight(.medium)
                            }
                            .font(.title2)
                            .bold()
                        }
                    }
                    .padding(.horizontal)
                    ScrollView(.horizontal) {
                        HStack(spacing: 16) {
                            ForEach(feelingItems) { item in
                                NavigationLink {
                                    TrackItemView(trackItem: item)
                                } label: {
                                    TrackFeelingItemRow(trackItem: item)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .scrollClipDisabled()
                }

                Divider()
                    .padding(.vertical)

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        NavigationLink {
                            TrackHistoryView(items: notFeelingItems)
                        } label: {
                            Text("History")
                                .fontDesign(.serif)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .fontWeight(.medium)
                        }
                        .font(.title2)
                        .bold()
                    }
                    VStack(alignment: .leading, spacing: 32) {
                        ScrollView {
                            ForEach(notFeelingItems) { item in
                                NavigationLink {
                                    TrackItemView(trackItem: item)
                                } label: {
                                    HStack {
                                        TrackItemRow(trackItem: item)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .padding()
                                    .background(.regularMaterial)
                                    .cornerRadius(12)
                                    .shadow(color: Color.accentColor.opacity(0.05), radius: 16, x: 0, y: 8)
                                }
                            }
                        }
                        .scrollClipDisabled()
                    }
                }
                .padding([.bottom, .horizontal])
            }
            .sheet(isPresented: $addViewIsPresented) {
                TrackItemAddView()
            }
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button("Add", systemImage: "plus") {
                        addViewIsPresented.toggle()
                    }
                }
            }
            .pasitea()
        }
    }
}

#if DEBUG
#Preview {
    TrackHome()
        .environment(ModelData())
        .modelContainer(try! ModelContainer(for: TrackItem.self))
}
#endif

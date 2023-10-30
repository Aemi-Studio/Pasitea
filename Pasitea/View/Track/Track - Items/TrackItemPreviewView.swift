//
//  TrackItemView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 29/10/23.
//

import SwiftUI
import SwiftData

struct TrackItemPreviewView: View {
    var trackItem: TrackItem

    var body: some View {
        ScrollView {
            HStack {
                Text(trackItem.type)
                    .font(.largeTitle)
                    .fontDesign(.serif)
                    .fontWeight(.bold)
                    .foregroundStyle(.foreground)
                Spacer()
            }
            .padding(.vertical)

            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Personal Notes")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        if trackItem.desc.isEmpty {
                            TrackItemRowEmpty(text: "No notes for this event.")
                        } else {
                            HStack {
                                Text(trackItem.desc)
                                    .fontWeight(.medium)
                                Spacer(minLength: 0)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.thinMaterial)
                    .cornerRadius(16)

                    LazyHStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(isFeeling(trackItem) ? "Written on" : "Saved on")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text(trackItem.startDate.formatted())
                                    .fontWeight(.medium)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(.thinMaterial)
                        .cornerRadius(16)

                        if !isFeeling(trackItem) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Lasted")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    Text(
                                        Helper.dateFormatter
                                            .string(from: trackItem.endDate.timeIntervalSince(trackItem.startDate)) ?? "Unknown"
                                    )
                                }
                                Spacer()
                            }
                            .padding()
                            .background(.thinMaterial)
                            .cornerRadius(16)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
        .padding(.bottom, 16)
        .ignoresSafeArea(.all)
        .pasitea()
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        TrackItemPreviewView(trackItem: TrackItem())
    }
}
#endif

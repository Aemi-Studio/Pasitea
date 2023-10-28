//
//  TrackFeelingItem.swift
//  Negroni
//
//  Created by Guillaume Coquard on 27/10/23.
//

import SwiftUI
import SwiftData

struct TrackFeelingItemRow: View {
    var trackItem: TrackItem

    func getInfoFromDate(_ date: Date) -> (Int, String) {
        let calendar = Calendar.current
        let formatter = DateFormatter()

        formatter.dateFormat = "MMMM"
        formatter.locale = Locale.current

        let day = calendar.component(.day, from: date)
        let month = formatter.string(from: date)

        return (day, month)
    }

    private var dateInfo: (Int, String) {
        getInfoFromDate(trackItem.startDate)
    }

    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text(dateInfo.0.description)
                    .font(.largeTitle)
                    .fontDesign(.serif)
                    .fontWeight(.black)
                Text(dateInfo.1.uppercased().prefix(3))
                    .font(.headline)
                    .fontDesign(.serif)
                    .fontWeight(.heavy)
            }

            if !trackItem.desc.isEmpty {
                VStack {
                    Text(trackItem.desc)
                        .lineLimit(3)
                        .frame(maxWidth: 128)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(16)
        .shadow(color: Color.accentColor.opacity(0.05), radius: 16, x: 0, y: 8)
    }
}

#Preview {
    TrackFeelingItemRow(trackItem: TrackItem())
}

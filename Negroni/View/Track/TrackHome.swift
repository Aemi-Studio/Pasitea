//
//  TrackHome.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI


struct TrackHome: View {
    
    @Environment(ModelData.self) var modelData

    
    var body: some View {
        
        NavigationStack{
           
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                        .opacity(0.3)
                    NavigationLink {
                        Journal()
                    } label: {
                        Label("Journal",systemImage: "square.and.pencil")
                    }
                    
                }
                .padding([.top],200)
                .padding([.leading,.trailing],70)
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                        .opacity(0.3)
                    NavigationLink {
                        History()
                    } label: {
                        Label("History",systemImage: "calendar")
                    }
                }
                .padding([.bottom],200)
                .padding([.leading,.trailing],70)
                
                
                
            }
            .navigationTitle("Track")
            .font(.title)
            
        }
        
        .accentColor(Color(red: 0.029, green: 0.49, blue: 0.998))
        
        
    }
}

#Preview {
    TrackHome()
        .environment(ModelData())
}

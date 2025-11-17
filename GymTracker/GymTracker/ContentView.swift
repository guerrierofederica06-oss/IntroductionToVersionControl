//
//  ContentView.swift
//  GymTracker
//
//  Created by Federica Guerriero on 09/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showTrainingDetail = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    
                    Text("How was your training today?")
                        .fontWeight(.bold)
                    
                    PrimaryButton(title: "Begin") {
                        showTrainingDetail = true
                    }
                    .padding()
                    
                    Spacer()
                }
                
                VStack {
                    HStack {
                        Text("explore.")
                            .font(.title)
                            .bold()
                            .padding(.leading, 30)
                        Spacer()
                    }
                    .padding(.top, 40)
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $showTrainingDetail) {
                TrainingDetailView()
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6).opacity(0.5))
        }
    }
}

#Preview {
    ContentView()
}

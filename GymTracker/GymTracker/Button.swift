//
//  Button.swift
//  GymTracker
//
//  Created by Federica Guerriero on 11/11/25.
//

import Foundation
import SwiftUI

struct PrimaryButton: View {
    
    let title: String
    let action: () -> Void
    
        var body: some View {
                Button(action: action){
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: 120)
                        .padding()
                        .background(.black)
                        .cornerRadius(30)
                    
                }
            .padding()
        }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(title: "Begin") {
            print("Button Pressed")
        }
    }
}


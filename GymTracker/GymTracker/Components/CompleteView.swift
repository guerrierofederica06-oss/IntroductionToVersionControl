//
//  CompleteView.swift
//  GymTracker
//
//  Created by Federica Guerriero on 14/11/25.
//

import SwiftUI

struct CompleteView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color.black)
                    .frame(width: 65, height: 100)
                Image(systemName: "checkmark")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }

            Text("Great! Your gymnastics training has been logged. Keep up the progress!")
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            PrimaryButton(title: "Done") {
                dismiss()
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6).opacity(0.5))
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CompleteView()
    }
}

import SwiftUI

struct DescribeNewSkillsView: View {
    @State private var descriptionText: String = ""
    @State private var goNext: Bool = false

    private var isNextEnabled: Bool {
        !descriptionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()

                VStack(spacing: 12) {
                    VStack(spacing: 4) {
                        Text("Did you try any new skills today?")
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)

                        Text("Which skill?")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }

                    TextField("Describe the new skills you tried...", text: $descriptionText)
                        .textInputAutocapitalization(.sentences)
                        .disableAutocorrection(false)
                        .padding(.horizontal, 14)
                        .frame(height: 44)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6).opacity(0.5))

            Button(action: { goNext = true }) {
                Image(systemName: "chevron.right")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(isNextEnabled ? Color.black : Color.gray)
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
            .disabled(!isNextEnabled)
            .offset(x: 125)
            .padding(.bottom, 30)
            .animation(.easeInOut, value: isNextEnabled)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $goNext) {
            CoachFeedbackView()
        }
    }
}

#Preview {
    NavigationStack {
        DescribeNewSkillsView()
    }
}

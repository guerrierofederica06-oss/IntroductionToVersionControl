import SwiftUI

struct ReflectionView: View {
    @State private var nextGoal: String = ""
    @State private var proudNote: String = ""
    @State private var goNext: Bool = false

    private var isNextEnabled: Bool {
        !nextGoal.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !proudNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()

                VStack(spacing: 16) {
                    // Prima domanda
                    VStack(spacing: 8) {
                        Text("What is one thing you want to improve next training?")
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)

                        TextField("Your goal for next time...", text: $nextGoal)
                            .textInputAutocapitalization(.sentences)
                            .disableAutocorrection(false)
                            .padding(.horizontal, 14)
                            .frame(height: 44)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
                            .padding(.horizontal, 24)
                    }

                    // Seconda domanda
                    VStack(spacing: 8) {
                        Text("What made you proud of your training today?")
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)

                        TextField("Celebrate your progress...", text: $proudNote)
                            .textInputAutocapitalization(.sentences)
                            .disableAutocorrection(false)
                            .padding(.horizontal, 14)
                            .frame(height: 44)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
                            .padding(.horizontal, 24)
                    }
                }

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
            CompleteView()
        }
    }
}

#Preview {
    NavigationStack {
        ReflectionView()
    }
}

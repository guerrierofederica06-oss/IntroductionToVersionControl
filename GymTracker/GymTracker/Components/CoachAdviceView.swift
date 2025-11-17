import SwiftUI

struct CoachAdviceView: View {
    @State private var feedbackText: String = ""
    @State private var goNext: Bool = false
    @State private var selectedOption: String? = nil

    private var isNextEnabled: Bool {
        !feedbackText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack(alignment: .bottom) {

            VStack(spacing: 20) {
                Spacer()
                
                VStack(spacing: 12) {
                    Text("What advice or correction did your coach give?")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                    
                    TextField("Describe the feedback...", text: $feedbackText)
                        .textInputAutocapitalization(.sentences)
                        .disableAutocorrection(false)
                        .padding(.horizontal, 14)
                        .frame(height: 44)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
                        .padding(.horizontal, 24)
                    
                    Text("Did it help improve?")
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                    
                    HStack(spacing: 16) {
                        ForEach(["Yes", "No"], id: \.self) { option in
                            Button(action: {
                                selectedOption = option
                            }) {
                                Text(option)
                                    .fontWeight(.semibold)
                                    .foregroundColor(selectedOption == option ? .white : .black)
                                    .frame(maxWidth: 120)
                                    .padding()
                                    .background(selectedOption == option ? Color.black : Color.white)
                                    .cornerRadius(15)
                                    .shadow(radius: 1)
                            }
                        }
                    }
                    
                    Button(action: {
                        selectedOption = "Somewhat"
                    }) {
                        Text("Somewhat")
                            .fontWeight(.semibold)
                            .foregroundColor(selectedOption == "Somewhat" ? .white : .black)
                            .frame(maxWidth: 120)
                            .padding()
                            .background(selectedOption == "Somewhat" ? Color.black : Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 1)
                    }
                    .padding(.top, 8)
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
        .navigationDestination(isPresented: $goNext) {
            ReflectionView()
        }
    }
}

#Preview {
    NavigationStack {
        CoachAdviceView()
    }
}

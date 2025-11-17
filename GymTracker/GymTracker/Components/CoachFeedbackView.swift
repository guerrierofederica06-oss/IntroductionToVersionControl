import SwiftUI

struct CoachFeedbackView: View {
    
    enum Route: Hashable {
        case coachAdvice
        case reflection
    }
    
    @State private var selected: String?
    @State private var route: Route?
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 24) {
                Text("Did your coach give you helpful feedback today?")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                
                HStack(spacing: 12) {
                    pillButton(title: "Yes", isSelected: selected == "Yes") {
                        selected = "Yes"
                        route = .coachAdvice
                    }
                    
                    pillButton(title: "No", isSelected: selected == "No") {
                        selected = "No"
                        route = .reflection
                    }
                }
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(false)
        .navigationDestination(item: $route) { route in
            switch route {
            case .coachAdvice:
                CoachAdviceView()
            case .reflection:
                ReflectionView()
            }
        }
    }
    
    private func pillButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(isSelected ? .white : .black)
                .frame(maxWidth: 120)
                .padding()
                .background(isSelected ? Color.black : Color.white)
                .cornerRadius(15)
                .shadow(radius: 1)
                .animation(.easeInOut(duration: 0.15), value: isSelected)
        }
    }
}

#Preview {
    NavigationStack {
        CoachFeedbackView()
    }
}

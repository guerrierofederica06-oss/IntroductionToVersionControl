import SwiftUI

struct NewSkillsView: View {
    private enum Selection: Hashable {
        case yes
        case no
    }

    private enum Route: Hashable {
        case describe
        case coachFeedback
    }

    @State private var selected: Selection?
    @State private var route: Route?

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                VStack(spacing: 8) {
                    Text("Did you try any new skills today?")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                .frame(maxWidth: .infinity)

                HStack(spacing: 12) {
                    selectablePill(
                        title: "Yes",
                        isSelected: selected == .yes
                    ) {
                        selected = .yes
                        route = .describe
                    }

                    selectablePill(
                        title: "No",
                        isSelected: selected == .no
                    ) {
                        selected = .no
                        route = .coachFeedback
                    }
                }
                .padding(.top, 16)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6).opacity(0.5))
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $route) { destination in
            switch destination {
            case .describe:
                DescribeNewSkillsView()
            case .coachFeedback:
                CoachFeedbackView()
            }
        }
    }

    @ViewBuilder
    private func selectablePill(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
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
        NewSkillsView()
    }
}

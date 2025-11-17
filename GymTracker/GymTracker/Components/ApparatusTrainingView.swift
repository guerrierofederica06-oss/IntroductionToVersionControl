import SwiftUI

struct TrainingDetailView: View {
    @State private var floorButtonBool = false
    @State private var balanceBeamButtonBool = false
    @State private var unevenBarsButtonBool = false
    @State private var vaultButtonBool = false
    
    @State private var goBestApparatus = false
    
    var anyButtonSelected: Bool {
        floorButtonBool || balanceBeamButtonBool || unevenBarsButtonBool || vaultButtonBool
    }
    
    private var selectedApparatusSet: Set<String> {
        var set = Set<String>()
        if floorButtonBool { set.insert("Floor") }
        if balanceBeamButtonBool { set.insert("Balance Beam") }
        if unevenBarsButtonBool { set.insert("Uneven Bars") }
        if vaultButtonBool { set.insert("Vault") }
        return set
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            VStack {
                Spacer()
                
                VStack(spacing: 4) {
                    Text("Which apparatus did you focus on today?")
                        .fontWeight(.bold)
                        .padding(.bottom, 14)
                    Text("You can select more than one")
                        .foregroundColor(.gray)
                        .padding(.bottom, 14)
                }
                
                VStack(spacing: 12) {
                    HStack(spacing: 16) {
                        toggleButton(title: "Floor", isOn: $floorButtonBool)
                        toggleButton(title: "Balance Beam", isOn: $balanceBeamButtonBool)
                    }
                    
                    HStack(spacing: 16) {
                        toggleButton(title: "Uneven Bars", isOn: $unevenBarsButtonBool)
                        toggleButton(title: "Vault", isOn: $vaultButtonBool)
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6).opacity(0.5))
            
            if anyButtonSelected {
                Button(action: {
                    goBestApparatus = true
                }) {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.black)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                .offset(x: 125)
                .padding(.bottom, 30)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut, value: anyButtonSelected)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationDestination(isPresented: $goBestApparatus) {
            BestApparatusView(selectedApparatus: selectedApparatusSet)
        }
    }
    
    private func toggleButton(title: String, isOn: Binding<Bool>) -> some View {
        Button(action: { isOn.wrappedValue.toggle() }) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(isOn.wrappedValue ? .white : .black)
                .frame(maxWidth: 120)
                .padding()
                .background(isOn.wrappedValue ? Color.black : Color.white)
                .cornerRadius(15)
                .shadow(radius: 1)
        }
    }
}

#Preview {
    TrainingDetailView()
}

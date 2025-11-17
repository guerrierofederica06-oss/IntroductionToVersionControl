//
//  MoreWorkView.swift
//  GymTracker
//
//  Created by Federica Guerriero on 13/11/25.
//

import SwiftUI

struct MoreWorkView: View {
    // Apparatus selected on the first screen; we only show these
    let selectedApparatus: Set<String>

    @State private var needsWork: Set<String> = []
    @State private var goNext: Bool = false

    private var anySelected: Bool { !needsWork.isEmpty }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()

                VStack(spacing: 4) {
                    Text("Which apparatus needs more work?")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 14)
                    Text("You can select more than one")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 14)
                }
                .frame(maxWidth: .infinity)

                let items = Array(selectedApparatus).sorted()
                if items.isEmpty {
                    Text("No apparatus selected previously.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    VStack(spacing: 12) {
                        ForEach(pairs(from: items), id: \.self) { pair in
                            if let first = pair.first, let second = pair.second {
                                HStack(spacing: 16) {
                                    apparatusToggleButton(
                                        title: first,
                                        isOn: Binding(
                                            get: { needsWork.contains(first) },
                                            set: { newValue in
                                                if newValue { needsWork.insert(first) }
                                                else { needsWork.remove(first) }
                                            }
                                        )
                                    )
                                    apparatusToggleButton(
                                        title: second,
                                        isOn: Binding(
                                            get: { needsWork.contains(second) },
                                            set: { newValue in
                                                if newValue { needsWork.insert(second) }
                                                else { needsWork.remove(second) }
                                            }
                                        )
                                    )
                                }
                            } else if let only = pair.first ?? pair.second {
                                HStack {
                                    Spacer()
                                    apparatusToggleButton(
                                        title: only,
                                        isOn: Binding(
                                            get: { needsWork.contains(only) },
                                            set: { newValue in
                                                if newValue { needsWork.insert(only) }
                                                else { needsWork.remove(only) }
                                            }
                                        )
                                    )
                                    Spacer()
                                }
                            }
                        }
                    }
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6).opacity(0.5))

            if anySelected {
                Button(action: { goNext = true }) {
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
                .animation(.easeInOut, value: anySelected)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $goNext) {
            // Next screen after MoreWorkView
            NewSkillsView()
        }
    }

    private func apparatusToggleButton(title: String, isOn: Binding<Bool>) -> some View {
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

    private func pairs(from items: [String]) -> [RowPair] {
        var result: [RowPair] = []
        var index = 0
        while index < items.count {
            let first = items[index]
            let second = index + 1 < items.count ? items[index + 1] : nil
            result.append(RowPair(first: first, second: second))
            index += 2
        }
        return result
    }

    private struct RowPair: Hashable {
        let first: String?
        let second: String?
    }
}

#Preview {
    NavigationStack {
        MoreWorkView(selectedApparatus: ["Floor", "Vault", "Uneven Bars"])
    }
}

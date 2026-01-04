//
//  LogRegisterView.swift
//  growth-log-ios
//
//  Created by shin takeuchi on 2026/01/03.
//

import SwiftUI
import SwiftData

enum Field: Hashable {
    case done
    case learn
    case block
    case next
}

struct LogRegisterView: View {
    let onNavigate: (Route) -> Void
    let onBack: () -> Void

    @Environment(\.modelContext) private var modelContext

    @State var doneText: String = ""
    @State var learnText: String = ""
    @State var blockText: String = ""
    @State var nextText: String = ""

    @FocusState private var focused: Field?

    @State var value: Int = 1  // 1〜5
    var max: Int = 5

    @State var selected: [LogCategory] = []

    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Button(action: onBack) {
                        Image("arrow_back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Text("\(DateHelper.toDay(date: Date(), format: "yyyy/MM/dd"))")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button(action: { onNavigate(.home) }) {
                        Text("保存")
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding(.horizontal, 24)
                
                Divider()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#E5E5E7"))

                ScrollView {
                    LazyVStack {
                        VStack {
                            VStack {
                                Text("Done")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                
                                TextEditor(text: $doneText)
                                    .frame(height: 100)
                                    .padding(4)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .focused($focused, equals: .done)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.3))
                                    )
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            Button("Done") { focused = nil }
                                        }
                                    }

                                Text("Learn")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .padding(.top, 20)
                                
                                TextEditor(text: $learnText)
                                    .frame(height: 100)
                                    .padding(4)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .focused($focused, equals: .learn)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.3))
                                    )
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            Button("Done") { focused = nil }
                                        }
                                    }

                                Text("Block")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .padding(.top, 20)
                                
                                TextEditor(text: $blockText)
                                    .frame(height: 100)
                                    .padding(4)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .focused($focused, equals: .block)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.3))
                                    )
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            Button("Done") { focused = nil }
                                        }
                                    }

                                Text("Next")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .padding(.top, 20)
                                
                                TextEditor(text: $nextText)
                                    .frame(height: 100)
                                    .padding(4)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .focused($focused, equals: .next)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.3))
                                    )
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            Button("Done") { focused = nil }
                                        }
                                    }

                                Text("Satisfaction")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .padding(.top, 20)
                                
                                HStack(spacing: 8) {
                                    ForEach(1...max, id: \.self) { i in
                                        Button {
                                            value = i
                                        } label: {
                                            Image(systemName: i <= value ? "star.fill" : "star")
                                                .font(.title2)
                                                .foregroundStyle(.yellow)
                                                .accessibilityLabel("Satisfaction \(i) of \(max)")
                                        }
                                        .buttonStyle(.plain)
                                    }
                                    
                                    Text("\(value)/\(max)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .padding(.leading, 6)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)

                                Text("Category")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .padding(.top, 20)
                                
                                HStack(spacing: 6) {
                                    ForEach(LogCategory.allCases) { category in
                                        Button {
                                            if let index = selected.firstIndex(of: category) {
                                                selected.remove(at: index)
                                            } else {
                                                selected.append(category)
                                            }
                                        } label: {
                                            Text(category.rawValue)
                                                .font(.body)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 4)
                                                .background(category.color.opacity(0.15))
                                                .foregroundStyle(category.color)
                                                .clipShape(Capsule())
                                                .opacity(selected.contains(category) ? 1.0 : 0.4)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                        }
                        .background(Color(hex: "#FFFFFF"))
                        .cornerRadius(10)
                        .padding()
                        .onTapGesture {
                            focused = nil
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color(hex: "#F6F7F8"))
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LogRegisterView(onNavigate: { route in }, onBack: {})
}

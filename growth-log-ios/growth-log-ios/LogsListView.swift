//
//  ContentView.swift
//  growth-log-ios
//
//  Created by shin takeuchi on 2026/01/01.
//

import SwiftData
import SwiftUI

struct LogsListView: View {
    let onNavigate: (Route) -> Void

    @ObservedObject var viewModel = LogsListViewModel.shared
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Log.createdAt) private var logs: [Log]

    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    HStack {
                        Image("title_logo")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(5)
                            .frame(width: 24, height: 24)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 8)

                        Image("title_logue")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(6)
                            .frame(width: 24, height: 24)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()

                    Button(action: {}) {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: 32, height: 32)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                }
                

                Divider()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#E5E5E7"))
                
                VStack {
                    VStack {
                        VStack {
                            HStack {
                                Text("[")
                                    .font(.system(size: 28))
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 8)

                                Text("今日(\(DateHelper.toDay(date: Date())))")
                                    .font(.system(size: 28))
                                    .fontWeight(.semibold)

                                Text("]")
                                    .font(.system(size: 28))
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 8)
                            }
                            .padding()

                            Text(viewModel.logs.isEmpty ? "まだ書かれていません。" : "記録済み")
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                                .foregroundColor(.gray.opacity(0.6))
                            
                            Button(action: {}) {
                                Text("今日を書く")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .background(!viewModel.logs.isEmpty ? .gray.opacity(0.8) : Color(hex: "#FF9F73"))
                            .disabled(!viewModel.logs.isEmpty)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.4), radius: 0, x: 2, y: 2)
                            .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#FFFFFF"))
                        .cornerRadius(10)
                        .padding()
                    }
                    

                    HStack {
                        Text("記録：\(DateHelper.toDay(date: Date()))")
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()

                        Text("連続：3")
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#FFFFFF"))
                    .cornerRadius(10)
                    .padding()
                    
                    Text("今月の記録")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .shadow(color: .gray.opacity(0.2), radius: 0, x: 1, y: 2)

                    ScrollView {
                        LazyVStack {
                            ForEach(logs) { log in
                                VStack {
                                    HStack {
                                        Text("\(DateHelper.toDay(date: DateHelper.convertDate(date: log.createdAt), format: "MM/dd hh:mm"))")
                                            .font(.system(size: 20))
                                            .fontWeight(.semibold)

                                        Text("今日の記録")
                                            .font(.system(size: 20))
                                            .fontWeight(.semibold)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    
                                    Divider()
                                        .frame(maxWidth: .infinity)
                                        .background(Color(hex: "#E5E5E7"))
                                        .padding(.horizontal, 8)
                                }
                            }
                        }
                    }
                    .background(.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color(hex: "#F6F7F8"))
        }
        .navigationBarBackButtonHidden(true)
        .task {
            modelContext.insert(
                Log(
                    title: "今日の記録",
                    content: "今日の記録",
                    createdAt: DateHelper.toDay(date: Date()),
                    updatedAt: DateHelper.toDay(date: Date())
                )
            )

            debugPrint("logs count: \(logs.count)")
            debugPrint("logs last: \(logs.last?.title ?? "nil")")
        }
    }
}

#Preview {
    LogsListView() {route in}
}

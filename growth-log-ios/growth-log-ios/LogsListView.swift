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

    @Query(sort: \Log.createdAt, order: .reverse) private var logs: [Log]

    var streak: Int {
        viewModel.calculateStreak(logs: logs)
    }

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

                            let hasForToday = viewModel.hasLogForToday(logs: logs)
                            Text(hasForToday ? "記録済み" : "まだ書かれていません。")
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                                .foregroundColor(.gray.opacity(0.6))
                            
                            Button(action: { onNavigate(.register) }) {
                                Text("今日を書く")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .background(hasForToday ? .gray.opacity(0.8) : Color(hex: "#FF9F73"))
                            .disabled(hasForToday)
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
                        HStack {
                            Text("記録：")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)

                            let date = logs.first?.createdAt != nil ? DateHelper.convertDate(date: logs.first!.createdAt) : nil
                            Text(date != nil ? DateHelper.toDay(date: date!) : "なし")
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()

                        Text("連続：\(streak)")
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
                        .padding(.horizontal, 20)
                        .shadow(color: .gray.opacity(0.2), radius: 0, x: 1, y: 2)

                    if logs.isEmpty {
                        VStack {
                            Text("記録なし")
                                .font(.system(size: 28))
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(logs) { log in
                                    VStack {
                                        HStack {
                                            let date = DateHelper.convertDate(date: log.createdAt)

                                            Text("\(DateHelper.toDay(date: date, format: "MM月dd日"))")
                                                .font(.system(size: 20))
                                                .fontWeight(.semibold)

                                            Text("\(log.title)")
                                                .font(.system(size: 20))
                                                .fontWeight(.semibold)
                                                .frame(maxWidth: .infinity, alignment: .center)

                                            Image("arrow_forward")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 24, height: 24)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        .onTapGesture {
                                            debugPrint("log: \(log.title)")
                                        }
                                        
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
                        .padding(.horizontal, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color(hex: "#F6F7F8"))
        }
        .navigationBarBackButtonHidden(true)
        .task {
            do {
                try viewModel.deleteAllLogs(context: modelContext)
                viewModel.getLogs(context: modelContext)
            } catch {
                debugPrint(error)
            }
        }
    }
}

#Preview {
    LogsListView() {route in}
}

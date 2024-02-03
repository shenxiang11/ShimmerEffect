//
//  ContentView.swift
//  ShimmerEffect
//
//  Created by 香饽饽zizizi on 2024/2/3.
//

import SwiftUI

struct ContentView: View {
    @State var effectActive1 = false
    @State var effectActive2 = false
    @State var effectActive3 = false
    @State var effectActive4 = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    Button {
                        effectActive1.toggle()
                    } label: {
                        Text("立即下载")
                            .foregroundStyle(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 80)
                            .background(.blue, in: .capsule)
                            .shimeerEffect(active: effectActive1, duration: 0.3)
                    }

                    Image(.logo)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shimeerEffect(active: effectActive2)
                        .onTapGesture {
                            effectActive2.toggle()
                        }

                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.orange)
                        .frame(width: 200, height: 400)
                        .shimeerEffect(active: effectActive3)
                        .onTapGesture {
                            effectActive3.toggle()
                        }

                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .mask {
                            GeometryReader { geo in
                                Path { path in
                                    let rect = CGRect(x: 0, y: 0, width: 200, height: 200)

                                    path.addRect(rect)
                                    path.addRect(rect.insetBy(dx: 40, dy: 40))
                                }
                                .fill(style: FillStyle(eoFill: true))
                            }
                        }
                        .shimeerEffect(active: effectActive4)
                        .onTapGesture {
                            effectActive4.toggle()
                        }

                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("闪烁")
        }
    }
}

#Preview {
    ContentView()
}

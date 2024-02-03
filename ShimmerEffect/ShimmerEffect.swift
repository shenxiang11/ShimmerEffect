//
//  ShimmerEffect.swift
//  ShimmerEffect
//
//  Created by 香饽饽zizizi on 2024/2/3.
//

import SwiftUI

fileprivate struct ShimmerEffect: ViewModifier {
    let active: Bool
    let duration: TimeInterval

    // 渐变色
    private let gradient = LinearGradient(colors: [
        .clear,
        .clear,
        .clear,
        .white.opacity(0.1),
        .white.opacity(0.15),
        .white.opacity(0.2),
        .white.opacity(0.9),
        .white.opacity(0.2),
        .white.opacity(0.15),
        .white.opacity(0.1),
        .clear,
        .clear,
        .clear,
    ], startPoint: .init(x: 0.25, y: 0), endPoint: .init(x: 0.75, y: 1))

    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geo in
                    let size = geo.size
                    let l = size.height

                    ZStack {
                        SimmerShape()
                            .fill(gradient)
                            .frame(width: l * 2, height: l)
                            .scaleEffect(x: 0.5)
                    }
                    .frame(width: l, height: l)
                    .offset(x: -l)
                    .keyframeAnimator(initialValue: 0.0, trigger: active) { content, progress in
                        content.offset(x: (size.width + l) * progress)
                    } keyframes: { _ in
                        CubicKeyframe(0, duration: 0)
                        CubicKeyframe(1, duration: duration)
                    }

                }
            }
            .mask {
                content
            }
    }
}

// 平行四边形
fileprivate struct SimmerShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .init(x: rect.maxX / 2, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX / 2, y: rect.maxY))
            path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        }
    }
}

extension View {
    func shimeerEffect(active: Bool, duration: TimeInterval = 1) -> some View {
        self.modifier(ShimmerEffect(active: active, duration: duration))
    }
}


//
//  ContentView.swift
//  Tappy
//
//  Created by Mohamed El-Halawani on 2024-11-22.
//

import SwiftUI

struct ContentView: View {
    @State var size: CGFloat = 100
    @State var color: Color = .blue
    
    @State var offset: CGSize = .zero
    @State var position: CGPoint = .zero
    
    var body: some View {
        VStack {
            Circle()
                .fill(color)
                .position(position)
                .frame(width: size , height: size)
                .animation(.easeIn, value: size)
                .offset(offset)
                .onTapGesture {
                    size = 50
                }
                .onTapGesture(count: 2) {
                    size = 250
                }
                .onLongPressGesture (minimumDuration: 5, maximumDistance: 1, pressing: { value in
                    print(value)
                }) {
                    withAnimation {
                        color = .green
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation
                        }
                    
                        .onEnded { value in
                            position = value.location
                            offset = .zero
                        }
                )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

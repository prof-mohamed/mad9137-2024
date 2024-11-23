//
//  ContentView.swift
//  SwiftyAnimation
//
//  Created by Mohamed El-Halawani on 2024-11-20.
//

import SwiftUI

struct ContentView: View {
    
    @State var width:CGFloat = 100.0
    
    @State var animate = false
    
    @State var degrees = 0.0
    @State var size: CGFloat = 100.0
    @State var color: Color = .blue
    
    var animation: Animation {
        .smooth
        .repeatForever(autoreverses: false)
    }
    
    var animation2: Animation {
        .easeInOut(duration: 4.0)
        .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        
        // just to show that animation can be done through different animation types
        VStack(alignment: animate ? .trailing : .leading) {
            Rectangle()
                .foregroundStyle(.red)
                .frame(width: width, height: width)
                .rotationEffect(.degrees(degrees))
                .animation(animation, value: width)
                .animation(animation2, value: degrees)
                .onTapGesture {
                    width = width == 300 ? 100 : 300
                    degrees = 360
                }
            
            Rectangle()
                .fill(color)
                .frame(width: size, height: size)
                .rotationEffect(.degrees(degrees))
                .animation(Animation.interpolatingSpring (duration: 2.0, bounce: 10).repeatForever(autoreverses: true), value: degrees)
                .onTapGesture {
                    degrees = degrees == 360 ? 0 : 360
                    size = 300
                    color = .red
                }
            
            Image(systemName: "truck.box.fill")
                .font(.largeTitle)
                .animation(.easeIn, value: animate)
            
            Toggle("Tap to animate", isOn: $animate)
            
            Button("Animate") {
                withAnimation(.linear(duration: 0.4).repeatForever(autoreverses: false)) {
                    animate.toggle()
                }
            }
            
            Circle()
                .fill(.red)
                .frame(width: width)
                .animation(.snappy, value: width)
                .onTapGesture {
                    width = 300
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  SwiftUI_netology
//
//  Created by Artur Skaliy on 29.01.2023.
//

import SwiftUI

struct FeedView: View {
    
    @State private var isPushEnable = false
    @State private var isSMSEnable = true
    @State var volume = 50.0
    @State var isEditing = false
    
    var body: some View {
        Form {
            Toggle(isOn: $isPushEnable, label: {
                Text("Push")
            })
            Text("FeedView")
            Toggle(isOn: $isSMSEnable, label: {
                Text("SMS")
            })
            VStack {
                Text("\(volume)").foregroundColor(volume >= 80 ? .red : .green)
                Slider(value: $volume, in: 0...100) { isEditing in
                    self.isEditing = isEditing
                }
            }
            Text("Заголовок")
                .modifier(HeaderTitle())
            Text("Основной текст")
                .modifier(RegularTitle())
        }
    }
}

struct HeaderTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.red)
            .font(.system(size: 36, weight: .bold, design: .monospaced))
    }
}

struct RegularTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .regular, design: .default))
    }
}

struct ProfileView: View {
    
    @State private var login = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
                .frame(height: 120)
            VStack {
                TextField(" Email or phone", text: $login)
                    .modifier(AuthField())
                    .padding(.top, 10)
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                TextField(" Password", text: $password)
                    .modifier(AuthField())
                    .padding(.bottom, 10)
            }
            .background(Color.init(.systemGray6))
            .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
            )
            .cornerRadius(10)
            
            Button(action: {print("Hello World")}, label: {
                Text("Log in")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .regular, design: .default))
            })
            .frame(minWidth: nil, idealWidth: nil, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(
            Image("blue_pixel")
                .resizable()
            )
            .cornerRadius(10)
            .padding(.top, 10)
        }
        .padding(.horizontal, 16)
    }
}

struct AuthField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.init(.systemGray6))
            .font(.system(size: 16, weight: .regular, design: .default))
    }
}

struct PlayerView: View {
    var body: some View {
        Text("PlayerView")
            .padding()
    }
}

struct VideoView: View {
    var body: some View {
        Text("VideoView")
            .padding()
    }
}

struct RecorderView: View {
    var body: some View {
        Text("RecorderView")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

struct TabBarView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "house")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            PlayerView()
                .tabItem {
                    Label("Player", systemImage: "music.note")
                }
            VideoView()
                .tabItem {
                    Label("Video", systemImage: "video")
                }
            RecorderView()
                .tabItem {
                    Label("Recorder", systemImage: "mic")
                }
        }
    }
}

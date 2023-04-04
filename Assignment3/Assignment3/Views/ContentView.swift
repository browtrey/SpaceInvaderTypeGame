//
//  ContentView.swift
//  Assignment3
//
//  Created by  on 2022-11-17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
        
        ZStack{
        
        Image("stars")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                NavigationLink(destination: GameView()){
                    Text("Play")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(50)
                }
                
                NavigationLink(destination: HiScoresView()){
                    Text("Hi-scores")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(50)
                }

            }.frame(width: 800, height: 225, alignment: .center)
            
        }
        
        }.navigationViewStyle(StackNavigationViewStyle())
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

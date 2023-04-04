//
//  HiScoresView.swift
//  Assignment3
//
//  Created by  on 2022-11-17.
//

import SwiftUI

struct scoreRow : View {
    var hiScore : HiScores
    
    var body : some View {
        VStack{
            Text("Score: \(hiScore.score)")
                .font(.largeTitle)
                .foregroundColor(.purple)
                .frame(width: 300, height: 45, alignment: .center)
        }
    }
}

struct HiScoresView: View {
    @ObservedObject var fetch = GetData()
    
    var body: some View {
        List{
            ForEach(fetch.hiScores, id: \.self){ s in
                scoreRow(hiScore: s)
            }
        }
    }
}

struct HiScoresView_Previews: PreviewProvider {
    static var previews: some View {
        HiScoresView()
    }
}

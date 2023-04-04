//
//  GetData.swift
//  Assignment3
//
//  Created by  on 2022-11-24.
//

import SwiftUI

public struct HiScores : Codable, Hashable{
    public var id: String
    public var score: String
    
    public func hash(into hasher: inout Hasher){
        hasher.combine(score)
    }
    
}

public class GetData: ObservableObject {
    @Published var hiScores = [HiScores]()
    
    init(){
        let url = URL(string: "https://browtrey.dev.fast.sheridanc.on.ca/A3php/getScoreData.php")!
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            do {
                if let scoreData = data {
                    let decodedData = try JSONDecoder().decode([HiScores].self, from: scoreData)
                    DispatchQueue.main.async {
                        print(decodedData)
                        self.hiScores = decodedData
                    }
                }else {
                    print ("no data")
                }
            }catch {
                print("Error: \(error)")
            }
        }.resume()
    }
    
}

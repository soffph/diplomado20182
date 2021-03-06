//
//  FishService.swift
//  PlasticFishesGood
//
//  Created by d182_sofia_d on 06/04/18.
//  Copyright © 2018 d182_sofia_d. All rights reserved.
//

import Foundation
class FishService{
    let baseURL = URL(string: "https://plasticfishes.herokuapp.com")!
    let session = URLSession.shared
    
    static let shared = FishService()
    func all(success: @escaping (([Fish]) -> Void))  {
//        let urlc = URLComponents()
//        urlc.queryItems
        
        let url = baseURL.appendingPathComponent("api/fishes")
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard error == nil else{ return }
            guard let httpResponse = response as? HTTPURLResponse else {return}
            switch httpResponse.statusCode{
            case 200:
                //parse something
                self?.parseFishes(data, completion: success)
            default:
                return
            }
        }
        task.resume()
    }
    func parseFishes(_ data: Data?, completion: @escaping (([Fish]) -> Void)) -> Void {
        guard let data = data else {return}
        let decoder = JSONDecoder()
        do{
            
            let json = try decoder.decode([Fish].self, from: data)
            DispatchQueue.main.async{ completion(json) }
        }catch let err{
            print("parsin error \(err)")
        }
       
    }
}


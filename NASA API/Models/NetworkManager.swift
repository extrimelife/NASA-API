//
//  NetworkManager.swift
//  NASA API
//
//  Created by roman Khilchenko on 22.09.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    //Метод для загрузки картинки с сервера
    func fetchImage(from url: String?, completion: @escaping(Data) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        DispatchQueue.global().async {
            guard let imageUrl = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageUrl)
            }
        }
    }
    
    //Метод для загрузки данных с сервера
    func fetchNasa(from url: String?, completion: @escaping(Nasa) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let jsonDecoder = JSONDecoder()
            
            do {
                let nasa = try jsonDecoder.decode(Nasa.self, from: data)
                
                DispatchQueue.main.async {
                    completion(nasa)
                    print(nasa)
                    
                }
                
            } catch {
                
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    
                }
            }
        }
        task.resume()
    }
}

enum Link: String {
    case nasaURL = "https://api.nasa.gov/planetary/apod?api_key=YigFXbdhor1XgRdVXZmOolHFEpXsrWSCqh0UpF6G"
           
}

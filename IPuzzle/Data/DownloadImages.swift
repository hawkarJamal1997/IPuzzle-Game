//
//  DownloadImages.swift
//  IPuzzle
//
//  Created by hawkar on 2020-12-08.
//

import Foundation

class DownloadImages {
    
    func getImages(page: Int, amount: Int, completion: @escaping ([String]) -> Void) {
        
        var imageUrls = [String]()
        let url = URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=\(amount)")
       
        let task = URLSession.shared.dataTask(with: url!) { (data, _, error) in
            guard let data = data else {
                print(error)
                return
            }
            let puzzleImages = try? JSONDecoder().decode([Images].self, from: data)
            puzzleImages?.forEach { (image) in
                imageUrls.append(image.download_url)
            }
            DispatchQueue.main.async {
                completion(imageUrls)
            }
            
        }
        task.resume()
    }
}


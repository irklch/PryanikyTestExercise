//
//  API.swift
//  PryanikyTest
//
//  Created by Ирина Кольчугина on 04.03.2021.
//

import Foundation
import Alamofire

class ResponseJson: Decodable{
    var mainData = [DataJson]()
    var view = [""]
    
    static var shared = ResponseJson()
    private init() {}
    
    enum CodingKeys: String, CodingKey {
        case mainData = "data"
        case view
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.mainData = try values.decode([DataJson].self, forKey: .mainData)
        self.view = try values.decode([String].self, forKey: .view)
    }
}


class DataJson: Decodable {
    
    var name = ""
    var textFromData: String?
    var url: String?
    var selectedId: Int?
    var variants: [VariantsJson]?
    
    
    static var shared = [DataJson]()
    private init() {}
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case dataFromData = "data"
    }
    
    enum DataFromData: String, CodingKey {
        case textFromData = "text"
        case url
        case selectedId
        case variants
    }
    
    
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let dataContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.name =  try dataContainer.decode(String.self, forKey: .name)
        
        let dataFromDataContainer = try dataContainer.nestedContainer(keyedBy: DataFromData.self, forKey: .dataFromData)
        
        if dataFromDataContainer.contains(.textFromData){
            if let text1 =  try dataFromDataContainer.decodeIfPresent(String.self, forKey: .textFromData) {
                self.textFromData = text1
            } else {
                self.textFromData = "N/A"
            }
        }
        if dataFromDataContainer.contains(.url) {
            if let url =  try dataFromDataContainer.decodeIfPresent(String.self, forKey: .url) {
                self.url = url
            } else {
                self.url = "N/A"
            }
        }
        if dataFromDataContainer.contains(.selectedId) {
            if let selectedId =  try dataFromDataContainer.decodeIfPresent(Int.self, forKey: .selectedId) {
                self.selectedId = selectedId
            } else {
                self.selectedId = 0
            }
        }
        if dataFromDataContainer.contains(.variants){
            self.variants = try dataFromDataContainer.decode([VariantsJson].self, forKey: .variants)
        }
        
    }
}




class VariantsJson: Decodable {
    var id = 0
    var textFromVariants = ""
    
    static var shared = [VariantsJson]()
    private init() {}
    
    enum CodingKeys: String, CodingKey {
        case id
        case textFromVariants = "text"
    }
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let variantsContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try variantsContainer.decode(Int.self, forKey: .id)
        self.textFromVariants = try variantsContainer.decode(String.self, forKey: .textFromVariants)
    }
}

public func loadResponseData(completion: @escaping (Bool) -> Void ){
    
    //список друзей
    AF.request("https://pryaniky.com/static/json/sample.json").responseData { response in
        do {
            let data = try JSONDecoder().decode(ResponseJson.self, from: response.value!)
            ResponseJson.shared = data
            DataJson.shared = data.mainData
            print(data.mainData.count)
            completion(true)
        }
        catch {
            print("\(error)")
        }
    }
    
}



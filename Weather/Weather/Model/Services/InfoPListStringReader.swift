//
//  InfopListReader.swift
//  Weather
//
//  Created by Tiago Flores on 13/02/2021.
//

import Foundation

enum InfoPListStringReader: String {
    case API_KEY = "API_KEY"
    case BASE_URL = "BASE_URL"
    
    func getValue() -> String? {
        let key = self.rawValue
        return infoForKey(key)
    }
    
    private func infoForKey(_ key: String) -> String? {
            return (Bundle.main.infoDictionary?[key] as? String)?
                .replacingOccurrences(of: "\\", with: "")
     }
}

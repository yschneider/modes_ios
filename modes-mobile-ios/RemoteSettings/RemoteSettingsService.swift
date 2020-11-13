//
//  RemoteSettingsService.swift
//  modes-mobile-ios
//
//  Created by Chris Fletcher on 10/15/20.
//

import Foundation

class RemoteSettingsService {
    
    //Production URL
    //private let remoteSettingsUrl = "https://download.militaryonesource.mil/MyMilitaryOneSource/remoteSettings.json"
    
    //Testing URL
    private let remoteSettingsUrl = //"https://mos-file-storage.s3-us-gov-west-1.amazonaws.com/MyMilitaryOneSource/remoteSettings.json"
    
    "https://mos-file-storage.s3-us-gov-west-1.amazonaws.com/MyMilitaryOneSource/remoteSettings-DEBUG.json"
    
    
    private let remoteSettingsFileName = "remoteSettings"
    
    var remoteSettingsDelegate: RemoteSettingsDelegate?
    
    func getRemoteSettings() {
        /*
        #if DEBUG
        if let data = self.readRemoteSettingsFromLocalJsonFile(forName: remoteSettingsFileName) {
            self.remoteSettingsDelegate?.remoteSettingsReceived(self.parseRemoteSettings(jsonData: data))
        }
        #else
        */
        self.readRemoteSettingsFromUrl(fromURLString: remoteSettingsUrl) { (result) in
            switch result {
            case .success(let data):
                self.remoteSettingsDelegate?.remoteSettingsReceived(self.parseRemoteSettings(jsonData: data))
            case .failure(let error):
                print(error)
            }
        }
        //#endif
    }
    
    private func readRemoteSettingsFromLocalJsonFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func readRemoteSettingsFromUrl(fromURLString urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    completion(.success(data))
                }
            }
            urlSession.resume()
        }
    }
    
    private func parseRemoteSettings(jsonData: Data) -> RemoteSettings? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(RemoteSettings.self, from: jsonData)
            print("Version: ", decodedData.appUpdateSettings.version)
            print("Force Update: ", decodedData.appUpdateSettings.forceUpdate)
            print("Update Message: ", decodedData.appUpdateSettings.updateMessage)
            print("Force Date: ", decodedData.appUpdateSettings.forceDate)
            return decodedData
        } catch {
            print("Error decoding Json data")
        }
        return nil
    }
}

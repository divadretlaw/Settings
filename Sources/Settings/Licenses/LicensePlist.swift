//
//  LicensePlist.swift
//  Settings
//
//  Created by David Walter on 13.02.22.
//

import Foundation

public struct LicensePlist: Hashable {
    public enum Error: Swift.Error {
        case noSettingsBundle
        case noLicensePlist
        case invalidFormat
    }
    
    public struct Entry: Identifiable, Hashable {
        public let id: UUID
        public let title: String
        public let license: String
        
        public init?(title: String, url: URL) {
            self.id = UUID()
            self.title = title
            
            do {
                let dictionary = try NSDictionary(contentsOf: url, error: ())
                guard let dict = dictionary["PreferenceSpecifiers"] as? NSArray, let license = dict.firstObject as? NSDictionary else {
                    return nil
                }
                
                guard let string = license["FooterText"] as? String else {
                    return nil
                }
                
                self.license = string
            } catch {
                return nil
            }
        }
        
        #if DEBUG
        init(title: String, license: String) {
            self.id = UUID()
            self.title = title
            self.license = license
        }
        #endif
    }
    
    public let entries: [Entry]
    
    public init(filename: String, settingsBundle: URL? = Bundle.main.url(forResource: "Settings", withExtension: "bundle")) throws {
        guard let settingsURL = settingsBundle else {
            throw Error.noSettingsBundle
        }
        
        let licensesURL = settingsURL.appendingPathComponent(filename).appendingPathExtension("plist")
        guard FileManager.default.fileExists(atPath: licensesURL.path) else {
            throw Error.noLicensePlist
        }
        
        let dictionary = try NSDictionary(contentsOf: licensesURL, error: ())
        
        guard let licenses = dictionary["PreferenceSpecifiers"] as? NSArray else {
            throw Error.invalidFormat
        }
        
        self.entries = licenses.compactMap { entry -> Entry? in
            guard let dict = entry as? NSDictionary,
                  let title = dict["Title"] as? String,
                  let file = dict["File"] as? String else { return nil }
            
            return Entry(title: title, url: settingsURL.appendingPathComponent(file).appendingPathExtension("plist"))
        }
    }
    
    #if DEBUG
    init() {
        self.entries = [Entry(title: "Test", license: "A"), Entry(title: "Test", license: "A")]
    }
    #endif
}

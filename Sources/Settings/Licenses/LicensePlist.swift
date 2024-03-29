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
        public let licenseType: LicenseType?
        public var source: String?
        
        public init?(title: String, url: URL) {
            self.id = UUID()
            self.title = title
            
            do {
                let dictionary = try NSDictionary(contentsOf: url, error: ())
                guard let array = dictionary["PreferenceSpecifiers"] as? NSArray, let license = array.lastObject as? NSDictionary else {
                    return nil
                }
                
                guard let string = license["FooterText"] as? String else {
                    return nil
                }
                
                self.license = string
                
                if let string = license["License"] as? String {
                    self.licenseType = LicenseType(rawValue: string)
                } else {
                    self.licenseType = nil
                }
                
                for element in array {
                    if let dict = element as? NSDictionary {
                        if let source = dict["DefaultValue"] as? String {
                            self.source = source
                        }
                    }
                }
            } catch {
                return nil
            }
        }
        
        #if DEBUG
        init(title: String, license: String, licenseType: LicenseType? = nil, source: String? = nil) {
            self.id = UUID()
            self.title = title
            self.license = license
            self.licenseType = licenseType
            self.source = source
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
        self.entries = [Entry(title: "Test", license: "A"), Entry(title: "Test", license: "A", source: "https://github.com/test/test")]
    }
    #endif
}

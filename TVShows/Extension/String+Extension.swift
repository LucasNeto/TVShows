//
//  String+Extension.swift
//  TVShows
//
//  Created by Lucas  N Santana on 03/07/23.
//
import Foundation

extension String {
    
    var utfData: Data {
        return Data(utf8)
    }
    
    var attributedHtmlString: NSAttributedString? {
        
        do {
            return try NSAttributedString(data: utfData, options: [
              .documentType: NSAttributedString.DocumentType.html,
              .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil)
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}

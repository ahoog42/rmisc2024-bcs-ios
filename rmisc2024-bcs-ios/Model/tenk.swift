//
//  tenk.swift
//  rmisc2024-bcs-ios
//
//  Created by Hiro Protagonist on 6/11/24.
//

import Foundation

// create a Codable struct for a 10-K filing object
// the struct should have the following properties:
// 1. id: Int
// 2. filing_id: String
// 3. company_id: String
// 4. url: String
// 5. items_json: String
// 6. company_name: String
// 7. filed_at: String
struct TenK: Codable, Identifiable {
    var id: Int
    var filing_id: String
    var company_id: String
    var url: String
    var items_json: String
    var company_name: String
    var filed_at: String
}
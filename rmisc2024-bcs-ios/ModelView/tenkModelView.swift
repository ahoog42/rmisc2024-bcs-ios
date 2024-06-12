//
//  tenkModelView.swift
//  rmisc2024-bcs-ios
//
//  Created by Hiro Protagonist on 6/11/24.
//

import Foundation

class TenKModelView: ObservableObject {
    @Published var tenks = [TenK]()
    
    init() {
      print("Fetching 10-K filings from tenkModelView...")
        fetchTenKFilings()
    }
    
    func fetchTenKFilings() {
        // the list view should be populated with data from the server
        // here's an example of how to do this with curl:
        // curl -H "Authorization: Bearer ${TOKEN}" https://rmisc2024.andrewhoog.com/api/v1/tenks
        // the server will return a json array of 10-K filings objects
        // here's an example of what the 10-k filing object will look like:
        //   {
        //     "id": 3481,
        //     "filing_id": "0001888524-24-003521",
        //     "company_id": "3160",
        //     "url": "https://www.sec.gov/Archives/edgar/data/1626941/000188852424003521/wcm14l18_10k-2023.htm",
        //     "items_json": "{\"Item 1C. Cybersecurity.\":[\"Item 1C. Cybersecurity. Omitted.\"]}",
        //     "company_name": "Wells Fargo Commercial Mortgage Trust 2014-LC18",
        //     "filed_at": "2024-03-15T18:19:39.000Z"
        //   }
        // the list view should display the company name and the filed_at date
        // when a user taps on a list item, they should be taken to the Board Cybersecurity post

        // if the token in user defaults is nil, let's use this hardcoded token
        // otherwise, we'll use the token from user defaults
        let token = UserDefaults.standard.string(forKey: "token") ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFob29nNDIiLCJpYXQiOjE3MTgxNDQ2MzQsImV4cCI6MTcxODIzMTAzNCwiaXNzIjoicm1pc2MyMDI0In0.QXsXugvZqTNPBBez_3Y3InUyEGCLyZmVAjytVKgTSb0"
        let url = URL(string: "https://rmisc2024.andrewhoog.com/api/v1/tenks")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                // handle error here
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if response.statusCode == 200 {
                print("Success: \(response)")
                let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                print("Result: \(result ?? [])")
                if let result = result {
                    DispatchQueue.main.async {
                        self.tenks = result.map { tenk in
                            TenK(id: tenk["id"] as! Int,
                                 filing_id: tenk["filing_id"] as! String,
                                 company_id: tenk["company_id"] as! String,
                                 url: tenk["url"] as! String,
                                 items_json: tenk["items_json"] as! String,
                                 company_name: tenk["company_name"] as! String,
                                 filed_at: tenk["filed_at"] as! String)
                        }
                    }
                }
            } else {
                // handle non-200 HTTP status code here
                print("Failed: \(response)")
                return
            }
        }
        task.resume()
    }
}

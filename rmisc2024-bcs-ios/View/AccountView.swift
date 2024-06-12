//
//  Account.swift
//  rmisc2024-bcs-ios
//
//  Created by Hiro Protagonist on 6/6/24.
//

import SwiftUI
import CryptoKit

struct AccountView: View {
    @State private var username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    @State private var password: String = ""
    
    var body: some View {
        // create a form and add input fields for username and password
        // add a button to submit the form
        Form {
            Section {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            }
            
            Section {
                Button(action: {
                // submit the form with a POST to https://rmisc2024.andrewhoog.com/api/v1/login
                // here's an example of how to do this with curl: 
                // curl -i -X POST -H "Content-Type: application/json" https://rmisc2024.andrewhoog.com/api/v1/login -d '{"username": "ahoog42", "password": "pwd"}'
                // the payload should be a json object with the keys "username" and "password"
                // if the server returns a 200 status code, the payload will contain a JWT token in a json object with the key "token"
                // save the token to the keychain
                // if the returns any other HTTP status code besides a 200, display an alert
                // with the error message

                // let's store the username, passwork and token in UserDefaults
                let defaults = UserDefaults.standard
                defaults.set(self.username, forKey: "username")
                
                let passwordData = Data(self.password.utf8)
                let passwordHash = Insecure.MD5.hash(data: passwordData)
                let passwordHashString = passwordHash.map { String(format: "%02hhx", $0) }.joined()
                defaults.set(passwordHashString, forKey: "password")

                    let url = URL(string: "https://rmisc2024.andrewhoog.com/api/v1/login")!
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    let body = ["username": self.username, "password": self.password]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                            // handle error here
                            return
                        }
                    
                        if response.statusCode == 200 {
                            // print("Login successful: \(response)")
                            let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                            let token = result?["token"] as? String
                            // save token to keychain here
                            print("token: \(token ?? "")")
                            defaults.set(token, forKey: "token")
                        } else {
                            // handle non-200 HTTP status code here
                            print("Login failed: \(response)")
                        }
                    }
                    task.resume()
                }) {
                    Text("Submit")
                }
            }
        }
        .navigationTitle("Account")
    }
}

#Preview {
    AccountView()
}

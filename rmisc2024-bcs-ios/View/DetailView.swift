//
//  DetailView.swift
//  rmisc2024-bcs-ios
//
//  Created by Hiro Protagonist on 6/11/24.
//

import SwiftUI
import WebKit // Import the WebKit module

struct DetailView: View {
    let url: String

    var body: some View {
        WebView(url: url)
    }
}
#Preview {
    DetailView(url: "https://www.board-cybersecurity.com/annual-reports/tracker/20240610-netapp-inc-cybersecurity-10k/")
}

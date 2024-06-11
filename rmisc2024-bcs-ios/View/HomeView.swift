//
//  Home.swift
//  rmisc2024-bcs-ios
//
//  Created by Hiro Protagonist on 6/6/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var tenkModelView = TenKModelView()
    var body: some View {
        // display the most recent 10-K Cybersecurity filings
        // in a list view which will link out to the Board Cybersecurity post
        ScrollView {            
            LazyVStack {
                ForEach(tenkModelView.tenks) { tenk in
                    NavigationLink(destination: DetailView(url: tenk.url)) {
                        VStack(alignment: .leading) {
                            Text(tenk.company_name)
                                .font(.headline)
                            Text(tenk.filed_at)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

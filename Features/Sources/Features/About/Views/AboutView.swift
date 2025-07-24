//
//  AboutView.swift
//  SwiftUISampleApp
//
//  Created by James Swent on 7/23/25.
//

import Foundation
import SafariServices
import SwiftUI

public struct AboutView: View {
    public enum NavigationTarget {
        case libraries
    }

    @State var showWebView = false

    let onNavigation: (NavigationTarget) -> Void

    public init(onNavigation: @escaping (NavigationTarget) -> Void) {
        self.onNavigation = onNavigation
    }

    public var body: some View {
        List {
            HStack(alignment: .center) {
                Spacer()
                VStack {
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .padding(16)
                    Text(Bundle.main.appName)
                        .font(.headline)
                    Text("\(Bundle.main.appVersion) (\(Bundle.main.appBuild))")
                        .font(.caption2)
                }
                Spacer()
            }
            AboutRow(title: NSLocalizedString("Used libraries", bundle: .module, comment: "")) {
                onNavigation(.libraries)
            }
            AboutRow(title: NSLocalizedString("Author's blog", bundle: .module, comment: "")) {
               showWebView = true
            }
        }
        .fullScreenCover(isPresented: $showWebView) {
            SafariWebView(url: URL(string: "https://blog.kulman.sk")!)
                .ignoresSafeArea()
        }
        .navigationTitle(Text("About", bundle: .module))
    }
}

#Preview {
    NavigationStack {
        AboutView(onNavigation: { _ in })
    }
}

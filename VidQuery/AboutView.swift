//
//  AboutView.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

import SwiftUI

struct AboutView: View {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let contributors: [Contributor] = [Contributor(name: "Andrew Z.", role: .developer), Contributor(name: "Harris K.", role: .developer), Contributor(name: "Ansh S.", role: .graphics), Contributor(name: "NU", role: .graphics), Contributor(name: "Claire", role: .graphics)]

    #if os(iOS)
    @Binding var isPresented: Bool
    #endif
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                #if os(iOS)
                HStack(alignment: .center) {
                    Text("VidQuery")
                        .font(.system(size: 24, weight: .medium))
                    
                    Spacer()
                    
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                    }
                }
                #else
                Text("VidQuery")
                    .font(.system(size: 24, weight: .medium))
                #endif
                Text("Version \(appVersion ?? "0.0.0")")
                    .font(.system(size: 16, weight: .medium))

                Text("A CodeDay Project")
                    .opacity(0.5)

                Text("Powered by The Movie Database (TMDb)")
                    .opacity(0.5)
            }

            Divider()

            Section(header: Text("Contributors").font(.system(size: 16, weight: .medium))) {
                ForEach(contributors) { contributor in
                    ContributorListRow(name: contributor.name, role: contributor.role.rawValue)
                }
            }
        }
        .padding(24)
        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
    }
}

struct ContributorListRow: View {
    let name: String
    let role: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
                .bold()

            Text(role)
                .font(.subheadline)
        }
    }
}

#if DEBUG
#if os(iOS)
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(isPresented: .constant(false))
    }
}
#endif
#endif

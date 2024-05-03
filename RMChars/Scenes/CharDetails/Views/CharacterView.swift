//
//  CharacterView.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 02.05.2024.
//

import SwiftUI

struct CharacterView: View {
    var name: String
    var speciesGender: String
    var location: String
    var image: UIImage

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 350, alignment: .top)
                .clipped()
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .padding(.top, 16)

            VStack(alignment: .leading, spacing: 10) {
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)

                Text(speciesGender)
                    .font(.subheadline)

                Text("Location: \(location)")
                    .font(.subheadline)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}

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
    var status: CharacterStatus?

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width - 16, height: 350, alignment: .top)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.horizontal, 8)
                    .padding(.top, 16)

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(name)
                            .font(.title)
                            .fontWeight(.bold)

                        Spacer()

                        if let status = status {
                            Text(status.rawValue)
                                .font(.body)
                                .fontWeight(.bold)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(status.backgroundColor)
                                .cornerRadius(12)
                                .foregroundColor(.white)
                        }
                    }

                    Text(speciesGender)
                        .font(.subheadline)

                    Text("Location: \(location)")
                        .font(.subheadline)
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 16)
            }
        }
        .padding(.horizontal, 8)
    }
}

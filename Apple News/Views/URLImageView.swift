//
//  URLImageView.swift
//  AppleNews
//
//  Created by Pavel on 06.04.2022.
//

import SwiftUI

struct URLImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? URLImageView.defaultImage!)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    static let defaultImage = UIImage(named: "NewsIcon")
}

struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: nil)
    }
}

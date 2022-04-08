//
//  ContentView.swift
//  AppleNews
//
//  Created by Pavel on 05.04.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var newsFeed = NewsFeed()
    @State var searchText = ""
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor.gray
    }
    
    var body: some View {
        NavigationView {
            List(searchText == "" ? newsFeed.newsListItems : newsFeed.newsListItems.filter( {
                $0.title.contains(searchText)
            })) { (article: NewsListItem) in
                NavigationLink(destination: NewsListItemView(article: article)) {
                    NewsListItemListView(article: article)
                        .onAppear {
                            self.newsFeed.loadMoreArticles(currentItem: article)
                        }
                }
            }
            .searchable(text: $searchText)
            .navigationBarTitle("Apple News")
        }
    }
}

struct NewsListItemView: View {
    var article: NewsListItem
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Text(article.source.name!)
                        .font(.title).bold()
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.black)
                        .cornerRadius(20)
                        .frame(width: 280, height: 24)
                        .padding([.bottom, .top], 10)
                    Text(article.title)
                        .font(.title2).bold()
                        .frame(width: 380)
                        .padding(10)
                    URLImageView(urlString: article.urlToImage)
                        .frame(maxWidth: 350, maxHeight: 240)
                        .cornerRadius(10)
                    /*AsyncImage(url: article.urlToImage) { image in
                     image
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     } placeholder: {
                     ProgressView()
                     }
                     .frame(maxWidth: 350, maxHeight: 240)
                     .cornerRadius(10)*/
                    HStack {
                        Image(systemName: "pencil.circle")
                            .foregroundColor(.black)
                        Text("Author:")
                            .foregroundColor(.gray)
                        Text("\(article.author ?? "No Author")")
                    }
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding(.leading, 10)
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.black)
                        Text(normalizationOfDate(date: article.publishedAt!))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: 360, alignment: .leading)
                    .padding(.leading, 10)
                    VStack {
                        Text("Description")
                            .font(.headline).bold()
                            .padding(.vertical, 5)
                        Text(article.description)
                            .foregroundColor(.gray)
                            .frame(alignment: .leading)
                            .padding(.horizontal, 20)
                    }
                    NavigationLink("Go to the news...") {
                        URLWebView(urlToDisplay: URL(string: article.url)!)
                            .edgesIgnoringSafeArea(.all)
                            .navigationBarTitle(article.title)
                    }
                    .padding(.top, 5)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationBarTitle("About news")
    }
    
    func normalizationOfDate(date: String) -> String {
        let substringOfDate = date.prefix(date.count - 4)
        
        let year = substringOfDate.prefix(substringOfDate.count - 12)
        
        var month = substringOfDate.suffix(substringOfDate.count - 5)
        month = month.prefix(month.count - 9)
        
        var day = substringOfDate.suffix(substringOfDate.count - 8)
        day = day.prefix(day.count - 6)
        
        let AllMonth = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        let time = substringOfDate.suffix(substringOfDate.count - 11)
        return String(Int(day)!) + " " + AllMonth[Int(month)! - 1] + ", " + year + ", " + time
    }
}

struct NewsListItemListView: View {
    var article: NewsListItem
    
    var body: some View {
        HStack {
            URLImageView(urlString: article.urlToImage)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            /*AsyncImage(url: article.urlToImage) { image in
             image
             .resizable()
             .aspectRatio(contentMode: .fill)
             } placeholder: {
             ProgressView()
             }
             .frame(width: 100, height: 100)
             .cornerRadius(10)*/
            VStack(alignment: .leading) {
                Text("\(article.title)")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                Text("\(article.author ?? "No Author")")
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

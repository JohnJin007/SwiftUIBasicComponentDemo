//
//  PhotosPickerDemoView.swift
//  SwiftUIBasicComponentDemo
//
//  Created by v_jinlilili on 15/01/2025.
//
import SwiftUI
import AVKit
import PhotosUI

//Transferable协议用于数据的共享和传输
struct Movie: Transferable {
    let url: URL //保存视频文件的本地URL
    
    //定义数据如何在应用之间传输
    static var transferRepresentation: some TransferRepresentation {
        //指示视频文件的MIME类型是.movie
        FileRepresentation(contentType: .movie) { movie in
            //将视频的URL传输出去
            SentTransferredFile(movie.url)
        } importing: { received in
            //视频在应用的文档目录路径
            let copy = URL.documentsDirectory.appending(path: "movie.mp4")
            //存在性检查
            if FileManager.default.fileExists(atPath: copy.path()) {
                try FileManager.default.removeItem(at: copy)
            }
            //将视频从 received.file 复制到应用的文档目录下
            try FileManager.default.copyItem(at: received.file, to: copy)
            //返回一个新的Movie 实例
            return Self.init(url: copy)
        }
    }
}

struct PhotosPickerDemoView: View {
    //定义视频加载的四个状态
    enum LoadState {
        case unknown, loading, loaded(Movie), failed
    }
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var loadState = LoadState.unknown
    
    var body: some View {
        VStack {
            PhotosPicker("Select movie", selection: $selectedItem, matching: .videos)
            
            switch loadState {
            case .unknown:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded(let movie):
                VideoPlayer(player: AVPlayer(url: movie.url))
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            case .failed:
                Text("Import failed")
            }
        }
        //监听selectedItem的变化,当用户选择视频时触发
        .onChange(of: selectedItem) { oldValue, newValue in
            Task { //异步加载视频
                do {
                    loadState = .loading
                    if let movie = try await selectedItem?.loadTransferable(type: Movie.self) {
                        loadState = .loaded(movie)
                    } else {
                        loadState = .failed
                    }
                } catch {
                    loadState = .failed
                }
            }
        }
    }
}

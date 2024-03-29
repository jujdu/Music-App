//
//  Library.swift
//  Music-App
//
//  Created by Michael Sidoruk on 05/10/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarControllerDelegate?
    
    dynamic func viewWillAppear(_ animated: Bool) {
        let keyWindow = UIApplication.shared.connectedScenes
                                           .filter({$0.activationState == .foregroundActive})
                                           .map({$0 as? UIWindowScene})
                                           .compactMap({$0})
                                           .first?.windows
                                           .filter({$0.isKeyWindow}).first
                                       
                                       let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
                                       tabBarVC?.trackDetailView.delegate = self
    }
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button(action: {
                            self.track = self.tracks[0]
                            self.tabBarDelegate?.maximazeTrackDetailController(viewModel: self.track)
                        }, label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.9568420053, green: 0.9612699151, blue: 0.9720941186, alpha: 1)))
                                .cornerRadius(10)
                        })
                        Button(action: {
                            self.tracks = UserDefaults.standard.savedTracks()
                        }, label: {
                            Image(systemName: "arrow.2.circlepath")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.9568420053, green: 0.9612699151, blue: 0.9720941186, alpha: 1)))
                                .cornerRadius(10)
                        })
                    }
                }.padding().frame(height: 50)
                Divider().padding(.leading).padding(.trailing)
                
                List {
                    ForEach(tracks) { track in
                        LibraryCell(cell: track).gesture(LongPressGesture().onEnded({ (_) in
                            self.showingAlert = true
                            self.track = track
                        }).simultaneously(with: TapGesture()
                            .onEnded({ (_) in
                                let keyWindow = UIApplication.shared.connectedScenes
                                    .filter({$0.activationState == .foregroundActive})
                                    .map({$0 as? UIWindowScene})
                                    .compactMap({$0})
                                    .first?.windows
                                    .filter({$0.isKeyWindow}).first
                                
                                let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
                                tabBarVC?.trackDetailView.delegate = self
                                
                                self.track = track
                                self.tabBarDelegate?.maximazeTrackDetailController(viewModel: track)
                            })))
                    }.onDelete(perform: delete)
                }
            }.actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(title: Text("Do you wanna delete this track?"), buttons: [
                    .destructive(Text("Delete"), action: {
                        self.delete(track: self.track)
                    }),
                    .cancel()
                ])
            })
                .navigationBarTitle("Library")
        }
    }
    
    private func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favoriteTrackKey)
        }
    }
    
    private func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favoriteTrackKey)
        }
    }
}

struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack {
            URLImage(URL(string: cell.iconUrlString ?? "")!) { proxy in
                proxy.image.resizable()
            }
            .frame(width: 60, height: 60).cornerRadius(2)
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}

extension Library: TrackMovingDelegate {
    func moveBackForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var previousTrack: SearchViewModel.Cell!
        if myIndex - 1 == -1 {
            previousTrack = tracks[tracks.count - 1]
        } else {
            previousTrack = tracks[myIndex - 1]
        }
        self.track = previousTrack
        return previousTrack
    }
    
    func moveForwardForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell!
        if myIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[myIndex + 1]
        }
        self.track = nextTrack
        return nextTrack
    }
    
    
}

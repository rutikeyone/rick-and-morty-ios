//
//  SettingsView.swift
//  rick-and-morty
//
//  Created by Andrew on 16.02.2025.
//

import SwiftUI

struct SettingsView: View {
    let viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cells) { cell in
            HStack {
                if let image = cell.iconImage {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(8)
                        .background(Color(cell.color))
                        .cornerRadius(6)
                }
                Text(cell.displayTitle)
                    .padding(.leading, 10)
                
                Spacer()
            }
            .padding(.bottom, 3)
            .onTapGesture {
                cell.onHandler(cell.type)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    private static var viewModel =  SettingsViewModel(
        cells: SettingOption.allCases.compactMap({ option in
            return SettingCell(type: option) { option in
            }
        })
    )
    
    static var previews: some View {
        SettingsView(viewModel: viewModel)
    }
}

//
//  Extensions.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 10/1/22.
//

import SwiftUI

// Custom View property extensions
extension View {
    
    
    func popupNavigationView<Content: View>(horizontalPadding: CGFloat = 40, show: Binding<Bool>, @ViewBuilder content: @escaping()->Content) -> some View {
        
        return self
        
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay {
                
                if show.wrappedValue{
                    
                    GeometryReader{ proxy in
                        
                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        
                        let size = proxy.size
                        
                        NavigationView{
                            content()
                        }
                        .frame(width: size.width - horizontalPadding, height: size.height / 1.7, alignment: .center)
                        
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
}

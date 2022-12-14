//
//  NoItemsView.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/15/22.
//

import SwiftUI

    struct NoItemsView: View {
        
        @State var animate: Bool = false
        let secondaryAccentColor = Color("SecondaryAccentColor")
        
        var body: some View {
            ScrollView {
                VStack(spacing: 10) {
                    Text("No Items")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Use the add button above or below to add items to your to do list")
                        .padding(.bottom, 20)
                    NavigationLink(
                        destination: AddView(),
                        label: {
                        Text("Add something 🥳")
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(animate ? secondaryAccentColor: Color.accentColor)
                                .cornerRadius(10)
                            
                    })
                    .padding(.horizontal, animate ? 30 : 50)
                    .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                            radius: animate ? 30 : 10 ,
                            x: 0,
                            y: animate ? 50 : 30)
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -7 : 0)
                   
                    Spacer()
                    Spacer()
                    
                    
//                    NavigationLink(
//                        destination: AddListView(),
//                        label: {
//                            Text("New List")
//                                .foregroundColor(.white)
//                                .font(.headline)
//                                .frame(height: 60)
//                                .frame(maxWidth: 60)
//
//                                .background(animate ? secondaryAccentColor: Color.accentColor)
//                                .cornerRadius(90)
//
//                        })
                    
                }
                .multilineTextAlignment(.center)
                .padding(40)
                .onAppear(perform: addAnimation)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        func addAnimation() {
            guard !animate else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(
                            Animation
                                .easeInOut(duration: 2.0)
                                .repeatForever()
                            ) {
                    animate.toggle()
                }
            }
        }
        
        
    }

    struct NoItemsView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                NoItemsView()
                    .navigationTitle("Title")
            }
        }
    }

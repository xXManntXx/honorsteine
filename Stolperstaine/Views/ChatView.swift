//
//  ChatView.swift
//  Stolperstaine
//
//  Created by Viktor on 07/06/2023.
//

import SwiftUI
import Combine

struct ChatView: View {
    @State var chatMessages: [ChatMessage] = []
    @State var messageText: String = ""
    let opneAIService = OpenAIService()
    @State var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        VStack{
            ScrollView{
                LazyVStack{
                    ForEach(chatMessages, id: \.id) {message in
                        messageView(message: message)
                    }
                }
            }
            HStack{
                TextField("Enter a message", text: $messageText) {
                    
                }
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(12)
                Button {
                    sendMessage()
                }label: {
                    Text("Send")
                        .foregroundColor(.black)
                        .padding()
                        .background(.yellow)
                        .cornerRadius(12)
                        
                }
            }
        }
        .padding()
    }
    
    func messageView(message: ChatMessage) -> some View {
        HStack{
            if message.sender == .me {Spacer()}
            Text(message.content)
                .foregroundColor(.white)
                .padding()
                .background(message.sender == .me ? .yellow : .brown)
                .cornerRadius(16)
            if message.sender == .gpt {Spacer()}
        }
    }
    
    func sendMessage() {
        let myMessage = ChatMessage(id: UUID().uuidString, content: messageText, dateCreated: Date(), sender: .me)
        chatMessages.append(myMessage)
        opneAIService.sendMessage(message: messageText).sink { completion in
            
        } receiveValue: { response in
            guard let textResponse = response.choices.first?.text else { return }
            let gptMessage = ChatMessage(id: response.id, content: textResponse, dateCreated: Date(), sender: .gpt)
            chatMessages.append(gptMessage)
        }
        .store(in: &cancellables)
        
        messageText = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

struct ChatMessage {
    let id: String
    let content: String
    let dateCreated: Date
    let sender: MessageSender
}

enum MessageSender {
    case me
    case gpt
}

extension ChatMessage {
    static let sampleMessages = [
        ChatMessage(id: UUID().uuidString, content: "Sample message me", dateCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Sample message gpt", dateCreated: Date(), sender: .gpt),
        ChatMessage(id: UUID().uuidString, content: "Sample message me", dateCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Sample message gpt", dateCreated: Date(), sender: .gpt)
    ]
}

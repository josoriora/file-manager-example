//
//  ContentView.swift
//  FileManager
//
//  Created by JULIAN OSORIO RAMIREZ on 26/12/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var fileContent: String = ""
    @State private var statusMessage: String = ""

    private let fileManagerService = FileManagerService()

    var body: some View {
        VStack {
            Text("FileManager Example")
                .font(.title)
                .padding()

            Text(statusMessage)
                .foregroundColor(.gray)
                .padding()

            Button("Create Directory") {
                createDirectory()
            }
            .padding()

            Button("Create File and Write Data") {
                writeToFile()
            }
            .padding()

            Button("Read File") {
                readFromFile()
            }
            .padding()

            Button("Delete File") {
                deleteFile()
            }
            .padding()

            TextEditor(text: $fileContent)
                .padding()
                .frame(height: 150)
                .border(Color.gray)
                .padding()

            Spacer()
        }
        .padding()
    }

    // 1. Create a directory
    private func createDirectory() {
        let result = fileManagerService.createDirectory(named: "MyDirectory")

        switch result {
        case .success(let message):
            statusMessage = message
        case .failure(let error):
            statusMessage = "Error: \(error.localizedDescription)"
        }
    }

    // 2. Write data to a file
    private func writeToFile() {
        let content = "Hello, FileManager! This is a sample text file."

        let result = fileManagerService.writeToFile(named: "sample.txt", content: content)

        switch result {
        case .success(let message):
            statusMessage = message
        case .failure(let error):
            statusMessage = "Error: \(error.localizedDescription)"
        }
    }

    // 3. Read data from a file
    private func readFromFile() {
        let result = fileManagerService.readFromFile(named: "sample.txt")

        switch result {
        case .success(let content):
            fileContent = content
            statusMessage = "File read successfully."
        case .failure(let error):
            statusMessage = "Error: \(error.localizedDescription)"
        }
    }

    // 4. Delete a file
    private func deleteFile() {
        let result = fileManagerService.deleteFile(named: "sample.txt")

        switch result {
        case .success(let message):
            statusMessage = message
            fileContent = ""
        case .failure(let error):
            statusMessage = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}

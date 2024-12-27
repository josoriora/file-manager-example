//
//  FileManagerService.swift
//  FileManager
//
//  Created by JULIAN OSORIO RAMIREZ on 26/12/24.
//

import Foundation

import Foundation

class FileManagerService {

    private let fileManager = FileManager.default
    private var documentsDirectory: URL {
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    // 1. Create a directory
    func createDirectory(named directoryName: String) -> Result<String, Error> {
        let directoryURL = documentsDirectory.appendingPathComponent(directoryName)

        do {
            if !fileManager.fileExists(atPath: directoryURL.path) {
                try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                return .success("Directory '\(directoryName)' created.")
            } else {
                return .failure(FileManagerError.directoryAlreadyExists)
            }
        } catch {
            return .failure(error)
        }
    }

    // 2. Write data to a file
    func writeToFile(named fileName: String, content: String) -> Result<String, Error> {
        let fileURL = documentsDirectory.appendingPathComponent("MyDirectory").appendingPathComponent(fileName)

        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            return .success("Data written to '\(fileName)'.")
        } catch {
            return .failure(error)
        }
    }

    // 3. Read data from a file
    func readFromFile(named fileName: String) -> Result<String, Error> {
        let fileURL = documentsDirectory.appendingPathComponent("MyDirectory").appendingPathComponent(fileName)

        do {
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            return .success(content)
        } catch {
            return .failure(error)
        }
    }

    // 4. Delete a file
    func deleteFile(named fileName: String) -> Result<String, Error> {
        let fileURL = documentsDirectory.appendingPathComponent("MyDirectory").appendingPathComponent(fileName)

        do {
            if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
                return .success("File '\(fileName)' deleted.")
            } else {
                return .failure(FileManagerError.fileNotFound)
            }
        } catch {
            return .failure(error)
        }
    }

    // Helper error enum
    enum FileManagerError: Error {
        case directoryAlreadyExists
        case fileNotFound
    }
}


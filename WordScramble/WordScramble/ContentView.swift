//
//  ContentView.swift
//  WordScramble
//
//  Created by Amruta on 26/06/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Entre your word ",text: $newWord, onCommit: addNewWord)//We want to call addNewWord() when the user presses return on the keyboard,by providing an on commit closure
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)//disable capitalization
                
                List(usedWords, id: \.self){
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                Text("your score is \(score)")
            }
            .navigationBarTitle(rootWord)
            //call that startGame when our view is shown
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton:
                    .default(Text("Ok")))
            }
            .navigationBarItems(trailing: Button(action: startGame){
                    Text("Change the word")
                //challenge 2 Add a left bar button item that calls startGame(), so users can restart with a new word whenever they want to.
                //here we also need to reset usedWords value to empty so we do it in startGame function at start
               
                
                
                })
        }
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word or you enter three letter word")
            return
        }
        
        // Insert that word at position 0 in the usedWords array
        //Set newWord back to be an empty string
        usedWords.insert(answer, at: 0)
        newWord = ""
        score += 10 //chan 3 show score 
        
    }
    
    func startGame(){
        usedWords = [String]()
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL){
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                // If we are here everything has worked, so we can exit
                return
            }
        }
        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    
    
    //all functions are for checking purpose
    //1 checking it hasn’t been used already
    func isOriginal(word: String)-> Bool{
        !usedWords.contains(word)
    }
    
    //2 is the word possible (they aren’t trying to spell “car” from “silkworm”)
    //  if we create a variable copy of the root word, we can then loop over each letter of the user’s input word to see if that letter exists in our copy. If it does, we remove it from the copy (so it can’t be used twice), then continue. If we make it to the end of the user’s word successfully then the word is good, otherwise there’s a mistake and we return false.
    
    func isPossible(word: String)-> Bool{
        var tempWord = rootWord
        for letter in word{
            //checkning letter index and then remove that letter
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    
    //3 our last method will make an instance of UITextChecker, which is responsible for scanning strings for misspelled words. We’ll then create an NSRange to scan the entire length of our string, then call rangeOfMisspelledWord() on our text checker so that it looks for wrong words. When that finishes we’ll get back another NSRange telling us where the misspelled word was found, but if the word was OK the location for that range will be the special value NSNotFound.
    func isReal(word: String)-> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if(word.count > 3){//challeng 1. Disallow answers that are shorter than three letters
            
            return misspelledRange.location == NSNotFound
        }else{
            return false}
    }
    
    //for error
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

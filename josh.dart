import 'dart:io';
import 'dart:math';

void main() {
  // List of words to choose from
  List<String> words = ['apple', 'banana', 'cherry', 'date', 'elderberry'];

  // Select a random word
  Random random = Random();
  String word = words[random.nextInt(words.length)];

  // Create a list to store the guessed letters
  List<String> guessedLetters = [];

  // Create a list to store the word with guessed letters
  List<String> wordWithGuessedLetters = List.generate(word.length, (index) => '_');

  // Number of incorrect guesses
  int incorrectGuesses = 0;

  print('Welcome to Hangman!');

  while (incorrectGuesses < 6) {
    // Print the word with guessed letters
    print('Word: ${wordWithGuessedLetters.join(' ')}');

    // Ask the player for a guess
    print('Guess a letter:');
    String? guess = stdin.readLineSync();

    // Check if the guess is a single letter
    if (guess == null || guess.length != 1) {
      print('Please enter a single letter.');
      continue;
    }

    // Check if the guess has already been made
    if (guessedLetters.contains(guess)) {
      print('You already guessed that letter.');
      continue;
    }

    // Add the guess to the list of guessed letters
    guessedLetters.add(guess);

    // Check if the guess is in the word
    bool correctGuess = false;
    for (int i = 0; i < word.length; i++) {
      if (word[i] == guess) {
        wordWithGuessedLetters[i] = guess;
        correctGuess = true;
      }
    }

    // If the guess is not in the word, increment the number of incorrect guesses
    if (!correctGuess) {
      incorrectGuesses++;
      print('Incorrect guess. You have $incorrectGuesses incorrect guesses.');
    }

    // Check if the player has won
    if (!wordWithGuessedLetters.contains('_')) {
      print('Congratulations, you won! The word was $word.');
      return;
    }
  }

  // If the player has not won after 6 incorrect guesses, they lose
  print('Sorry, you lost. The word was $word.');
}
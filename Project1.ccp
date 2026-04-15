#include <iostream>
#include <string>
#include <cctype>
#include <fstream>
#include <vector>
#include <algorithm> // for sort
#include <utility> // for pair
using namespace std;

string removePunct(const string& s, const string& punct);
string makeLower(const string& s);
void getWords(vector<string>& words, ifstream& file);
void sortWords(vector<string>& words);
vector<pair<string, int>> getWordCounts(vector<string>& words);

int main() {
    string fName = "homes"; // change to read any named text file
    ifstream file(fName + ".txt");
    vector<string> allWords;

    if (!file) { // denoted in some book displays
        cout << "Error opening file.\n";
        return 1;
    }

    getWords(allWords, file);
    sortWords(allWords);

    cout << "Here is the frequency of every word in the "
         << fName << " text file:\n";
    
    vector<pair<string, int>> finalWordFrequency = getWordCounts(allWords);

    for (int i = 0; i < finalWordFrequency.size(); i++) {
        cout << "   " << finalWordFrequency[i].first << ": " 
             << finalWordFrequency[i].second << endl;
    }

    return 0;
}

string makeLower(const string& s) { // from Display 8.8
    string temp(s);
    for (int i = 0; i < s.length(); i++)
        temp[i] = tolower(s[i]);

    return temp;
}
string removePunct(const string& s, const string& punct) { // from Display 8.8
    string noPunct;
    int sLength = s.length();
    // punctLength not needed

    for (int i = 0; i < sLength; i++) {
        string aChar = s.substr(i, 1); // one character string
        int location = punct.find(aChar, 0);

        if (location == string::npos)
            noPunct = noPunct + aChar; // keep character
    }

    return noPunct;
}

void getWords(vector<string>& words, ifstream& file) {
    string word;
    string punct = ".,!?;:\"()[]{}<>";

    while (file >> word) {
        word = removePunct(word, punct);
        word = makeLower(word);

        if (!word.empty())
            words.push_back(word);
    }
}

void sortWords(vector<string>& words) {
    sort(words.begin(), words.end());
}

vector<pair<string, int>> getWordCounts(vector<string>& words) {
    vector<pair<string, int>> uniqueWithFrequency;

    string currentWord = words[0];
    int count = 1;

    for (int i = 1; i < words.size(); i++) {
        if (words[i] == currentWord) {
            count++;  // same word, increment count
        } else {
            uniqueWithFrequency.push_back(make_pair(currentWord, count));
            currentWord = words[i];
            count = 1;
        }
    }

    uniqueWithFrequency.push_back(make_pair(currentWord, count)); // push the last word group
    return uniqueWithFrequency;
}

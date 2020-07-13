#include <iostream>
#include <fstream>
#include <glob.h>
#include <vector>

using namespace std;
vector<vector<float>> GetALLEData(vector<string> DirCont);
vector<string> GetNames(string path);

int main()
{
    int numInt1, numInt2;

    vector<string> names = GetNames("./planets/pl_*.txt");
    vector<vector<float>> data = GetALLEData(names);

    cout << "in the matrix there are currently " << data.size() << " planets" << '\n';
    cout << "enter two numbers for a value from the Matrix" << '\n';
    cin >> numInt1;
    cout << '\n';
    cin >> numInt2;
    cout << '\n';

    cout << data[numInt1][numInt2] << '\n';
    cout << data.size() << '\n';

    return 0;
}
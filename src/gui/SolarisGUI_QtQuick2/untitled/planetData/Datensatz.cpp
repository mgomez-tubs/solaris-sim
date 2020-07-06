#include <iostream>
#include "Header.h"
using namespace std;

int main()
{
    call c;
    int numInt1, numInt2;
    vector<vector<float>> dataOUT = c.calling();

    cout << "in the matrix there are currently " << dataOUT.size() << " planets" << '\n';
    cout << "enter two numbers for a value from the Matrix" << '\n';
    cin >> numInt1;
    cout << '\n';
    cin >> numInt2;
    cout << '\n';

    cout << dataOUT[numInt1][numInt2] << '\n';
    cout << dataOUT.size() << '\n';

    return 0;
}
#include <iostream>
#include <fstream>
#include "Header_fin.h"

using namespace std;

int main()
{
    int numSel = 255;

    Data_Call plData;
    int numInt1, numInt2 = 0;
    vector<vector<string>> dataOUT = plData.calling("PlData.txt");

    Data_Call info;
    int numInt3, numInt4 = 0;
    vector<vector<string>> infoOUT = info.calling("Info.txt");

    do
    {
        cout << '\n'
             << "Select the desired dataset" << '\n';

        cout << "0 for exit" << '\n';
        cout << "1 for the planetary Information" << '\n';
        cout << "2 for the Information Texts" << '\n';
        cin >> numSel;

        // pl_* Matrix (Planetary variables)
        if (numSel == 1)
        {
            cout << "in the planetary data matrix there are currently " << dataOUT.size() << " planets" << '\n';
            cout << "enter two numbers for a value from the Matrix" << '\n';
            cin >> numInt1;
            cout << '\n';
            cin >> numInt2;
            cout << '\n';

            cout << dataOUT[numInt1][numInt2] << '\n';
        }

        // info_* Matrix (Information texts)
        else if (numSel == 2)
        {
            cout << "in the matrix there are currently " << infoOUT.size() << " planets" << '\n';
            cout << "enter one number for the informationtext of the planet" << '\n';
            cin >> numInt3;
            cout << '\n';

            std::string str;
            do
            {
                str = infoOUT[numInt3][numInt4];
                cout << str << '\n';
                numInt4++;
            } while (numInt4 <= 255);

            cout << '\n';
            cout << "END OF TEXT";
        }

    } while (numSel != 0);
    return 0;
}

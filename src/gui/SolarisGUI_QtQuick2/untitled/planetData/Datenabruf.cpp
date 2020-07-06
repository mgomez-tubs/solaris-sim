#include <iostream>
#include <fstream>
#include <glob.h>
#include <vector>

using namespace std;
vector<float> GetData(string filename);
vector<vector<float>> GetALLEData(vector<string> DirCont);
vector<string> GetNames(string path);
/*
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
}*/

//READ Planetary Data into Vector
vector<float> GetData(string filename)
{
    fstream myfile(filename);
    vector<float> daten;

    string str;
    while (getline(myfile, str))
    {
        if (str.size() > 0)
            daten.push_back(stof(str));
    }
    return daten;
}

//CREATE Matrix with the solar system data
vector<vector<float>> GetALLEData(vector<string> DirCont)
{
    //Datenmatrix
    vector<vector<float>> fileData;
    for (string name : DirCont)
    {
        vector<float> fileDataTemp = GetData(name);
        fileData.push_back(fileDataTemp);
    }
    return fileData;
}

//READ Names of Files in Dir
vector<string> GetNames(string path)
{
    vector<string> dir;
    glob_t glob_result;
    glob(path.c_str(), 0, NULL, &glob_result);
    for (unsigned int i = 0; i < glob_result.gl_pathc; ++i)
    {
        dir.push_back(string(glob_result.gl_pathv[i]));
    }
    globfree(&glob_result);
    return dir;
}

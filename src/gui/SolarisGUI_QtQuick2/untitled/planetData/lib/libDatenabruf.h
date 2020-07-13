#include <vector>
#include <string>

using namespace std;
//READ Planetary Data into Vector
vector<float> GetData(string filename);

//CREATE Matrix with the solar system data
vector<vector<float>> GetALLEData(vector<string> DirCont);

//READ Names of Files in Dir
vector<string> GetNames(string path);

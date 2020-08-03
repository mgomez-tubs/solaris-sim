#include <iostream>
#include <fstream>
//#include <glob.h>
#include <vector>

std::vector<float> GetData(std::string filename);
std::vector<std::vector<float>> GetFinData(std::vector<std::string> DirCont);
std::vector<std::string> GetNames();

//HEADER Matrix with Data
class call
{

public:
    std::vector<std::vector<float>> calling()
    {
        std::vector<std::string> names = GetNames();
        std::vector<std::vector<float>> dataTRF = GetFinData(names);
        return dataTRF;
    }
};

/*
//READ Names of Files in Dir
std::vector<std::string> GetNames(std::string path)
{
    std::vector<std::string> dir;
    glob_t glob_result;
    glob(path.c_str(), 0, NULL, &glob_result);
    for (unsigned int i = 0; i < glob_result.gl_pathc; ++i)
    {
        dir.push_back(std::string(glob_result.gl_pathv[i]));
    }
    globfree(&glob_result);
    return dir;
}*/

//READ Filenames BYPASS
std::vector<std::string> GetNames()
{
    std::fstream myfile("PlData.txt");
    std::vector<std::string> datStr;

    std::string str;
    while (std::getline(myfile, str))
    {
        if (str.size() > 0)
            datStr.push_back(str);
    }
    return datStr;
}

//READ Planetary Data into Vector
std::vector<float> GetData(std::string filename)
{
    std::fstream myfile(filename);
    std::vector<float> daten;

    std::string str;
    while (getline(myfile, str))
    {
        if (str.size() > 0)
            daten.push_back(stof(str));
    }
    return daten;
}

//CREATE Matrix with the solar system data
std::vector<std::vector<float>> GetFinData(std::vector<std::string> DirCont)
{
    //Datenmatrix
    std::vector<std::vector<float>> fileData;
    for (std::string name : DirCont)
    {
        std::vector<float> fileDataTemp = GetData(name);
        fileData.push_back(fileDataTemp);
    }
    return fileData;
}
#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <windows.h>
//#include <glob.h>

std::vector<std::string> GetNamesInf();
std::vector<std::string> GetDataInf(std::string filename);
std::vector<std::vector<std::string>> GetFinDataInf(std::vector<std::string> DirCont);

//HEADER Matrix with Data
class Information
{

public:
    std::vector<std::vector<std::string>> calling()
    {
        std::vector<std::string> names = GetNamesInf();
        std::vector<std::vector<std::string>> dataTRF = GetFinDataInf(names);
        return dataTRF;
    }
};
/*
//READ Names of Files in Dir
std::vector<std::string> GetNamesInf(std::string path)
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

//CREATE Vector with filenames secondary Path
/*
std::vector<std::string> get_all_files_names_within_folder()
{
    std::vector<std::string> names;
    std::string search_path = "./Info/info_*.txt/";
    WIN32_FIND_DATA fd; 
    HANDLE hFind = ::FindFirstFile(search_path.c_str(), &fd); 
    if(hFind != INVALID_HANDLE_VALUE) { 
        do { 
            // read all (real) files in current folder
            // , delete '!' read other 2 default folder . and ..
            if(! (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) ) {
                names.push_back(fd.cFileName);
            }
        }while(::FindNextFile(hFind, &fd)); 
        ::FindClose(hFind); 
    } 
    return names;
}*/

//READ Filenames BYPASS
std::vector<std::string> GetNamesInf()
{
    std::fstream myfile("Info.txt");
    std::vector<std::string> navn;

    std::string str;
    while (std::getline(myfile, str))
    {
        if (str.size() > 0)
            navn.push_back(str);
    }
    return navn;
}

//READ Planetary Data into Vector
std::vector<std::string> GetDataInf(std::string filename)
{
    std::fstream myfile(filename);
    std::vector<std::string> datStr;

    std::string str;
    while (std::getline(myfile, str))
    {
        if (str.size() > 0)
            datStr.push_back(str);
    }
    return datStr;
}

//CREATE Matrix with the solar system data
std::vector<std::vector<std::string>> GetFinDataInf(std::vector<std::string> DirCont)
{
    //Datenmatrix
    std::vector<std::vector<std::string>> fileData;
    for (std::string name : DirCont)
    {
        std::vector<std::string> fileDataTemp = GetDataInf(name);
        fileData.push_back(fileDataTemp);
    }
    return fileData;
}

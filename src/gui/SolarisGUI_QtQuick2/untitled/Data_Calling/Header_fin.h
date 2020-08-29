#include <iostream>
#include <fstream>
#include <vector>
#include <string>

std::vector<std::string> GetNamesDat(std::string path);
std::vector<std::string> GetDataTXT(std::string filename);
std::vector<std::vector<std::string>> GetDataMTX(std::vector<std::string> DirCont);

//HEAD Kreiren einer Klasse zum vereinfachen der Quellcodes
class Data_Call
{
    //Dateipfad als attribut der Klasse
    std::string str_Pathtxt;

public:
    //Objekt der Klasse hat die Methode calling
    std::vector<std::vector<std::string>> calling(std::string str_Pathtxt)
    {
        std::vector<std::string> names = GetNamesDat(str_Pathtxt);
        std::vector<std::vector<std::string>> dataTRF = GetDataMTX(names);
        return dataTRF;
    }
};

//READ Auslesen der Dateinamen aus dem Attribut der Klasse und erstellen eines Vektors mit den Namen der *.txt-Datei
std::vector<std::string> GetNamesDat(std::string path)
{
    std::fstream myfile(path);
    std::vector<std::string> navn;

    std::string str;
    while (std::getline(myfile, str))
    {
        if (str.size() > 0)
            navn.push_back(str);
    }
    return navn;
}

//READ Auslesen der Einzelnen Zeilen einer *.txt Datei und erstellen eines Vektors mit dem Inhalt der Zeilen der Datei
std::vector<std::string> GetDataTXT(std::string filename)
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

//CREATE Erstellen einer Matrix die mithilfe der GetDataTXT den Vektor der Dateinamen ausliest und eine Matrix mit den einzelnen Zeilen der Textdokumente erstellt
std::vector<std::vector<std::string>> GetDataMTX(std::vector<std::string> DirCont)
{
    //Datenmatrix
    std::vector<std::vector<std::string>> fileData;
    for (std::string name : DirCont)
    {
        std::vector<std::string> fileDataTemp = GetDataTXT(name);
        fileData.push_back(fileDataTemp);
    }
    return fileData;
}
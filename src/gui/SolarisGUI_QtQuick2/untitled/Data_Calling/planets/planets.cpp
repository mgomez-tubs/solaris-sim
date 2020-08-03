  }
#include <iostream>
#include <string>
#include <fstream>
#include <cmath>

using namespace std;

int main (void){

  string planet;
  char stop;


do {

  cout << "werte fuer welchen planeten ausgeben?" <<endl;
  cout << "fuer legenden dokument 'werte' eingeben\n";
  cin >> planet;

  if (planet == "merkur") {
    ofstream myfile;
    myfile.open ("pl_mercury.txt");
    myfile << 0.241010959 <<endl;
    myfile << 5.790934 * pow(10,10) <<endl;
    myfile << 0.2056 <<endl;
    myfile << 47360 <<endl;
    myfile << 4879400 <<endl;
    myfile << 4879400 <<endl;
    myfile << 3.301 * pow(10,13) <<endl;
    myfile << 5.427 <<endl;
    myfile << 6.04 * pow(10,10) <<endl;

    myfile.close();

    cout<< "done" <<endl;
  }
  else if (planet == "venus"){
    ofstream myfile;
    myfile.open ("pl_venus.txt");
    myfile << 0.6156191781 <<endl;
    myfile << 10.816 * pow(10, 10) <<endl;
    myfile << 0.0068 <<endl;
    myfile << 35020 <<endl;
    myfile << 12103600 <<endl;
    myfile << 12103600 <<endl;
    myfile << 4.875 * pow(10, 24) <<endl;
    myfile << 5.243 <<endl;

    myfile.close();

    cout<< "done" <<endl;
  }
  else if (planet == "erde"){
    ofstream myfile;
    myfile.open ("pl_earth.txt");
    myfile << 1 <<endl;
    myfile << 149598022.96 * pow(10, 10) <<endl;
    myfile << 0.0167086342 <<endl;
    myfile << 29780 <<endl;
    myfile << 12756270 <<endl;
    myfile << 12713500 <<endl;
    myfile << 5.9724 * pow (10, 24) <<endl;
    myfile << 5.514 <<endl;

    myfile.close();

    cout<< "done" <<endl;
  }
  else if (planet == "mars"){
    ofstream myfile;
    myfile.open ("pl_mars.txt");
    myfile << 1.88213699 <<endl;
    myfile << 227990000 * pow(10, 10) <<endl;
    myfile << 0.0935 <<endl;
    myfile << 24070 <<endl;
    myfile << 6792400 <<endl;
    myfile << 6752400 <<endl;
    myfile << 6.417 * std::pow(10, 23) <<endl;
    myfile << 3.933 <<endl;

    myfile.close();

    cout<< "done" <<endl;
  }
  else if (planet == "jupiter"){
    ofstream myfile;
    myfile.open ("pl_jupiter.txt");
    myfile << 11.863014 <<endl;
    myfile << 778510000 <<endl;
    myfile << 0.0489 <<endl;
    myfile << 13060 <<endl;
    myfile << 142984000 <<endl;
    myfile << 133708000 <<endl;
    myfile << 1.899 * std::pow(10,27) <<endl;
    myfile << 1.326 <<endl;

    myfile.close();

    cout<< "done" <<endl;
  }
  else if (planet == "saturn"){
    ofstream myfile;
    myfile.open ("pl_saturn.txt");
    myfile << 29.457 <<endl;
    myfile << 1433400000 <<endl;
    myfile << 0.0542 <<endl;
    myfile << 9680 <<endl;
    myfile << 120536000 <<endl;
    myfile << 108728000 <<endl;
    myfile << 5.683 * std::pow(10, 26) <<endl;
    myfile << 0.687 <<endl;

    myfile.close();

    cout<< "done" <<endl;
  }
  else if (planet == "uranus"){
    ofstream myfile;
    myfile.open ("pl_uranus.txt");
    myfile << 84.011 <<endl;
    myfile << 2872400000 <<endl;
    myfile << 0.0472 <<endl;
    myfile << 6810 <<endl;
    myfile << 51118000 <<endl;
    myfile << 49946000 <<endl;
    myfile << 8.681 * std::pow(10, 25) <<endl;
    myfile << 1.271 <<endl;

    myfile.close();

    cout<< "done" <<endl;
  }
  else if (planet == "neptun"){
    ofstream myfile;
    myfile.open ("pl_neptun.txt");
    myfile << 164.79 <<endl;
    myfile << 4495000000 <<endl;
    myfile << 0.00859 <<endl;
    myfile << 5430 <<endl;
    myfile << 49528000 <<endl;
    myfile << 48682000 <<endl;
    myfile << 1.024 * std::pow(10, 26) <<endl;
    myfile << 1.638 <<endl;

    myfile.close();

    cout<< "done" <<endl;
  }
  else if (planet == "pluto"){
    cout << "pluto ist kein planet mehr" <<endl;
  }
  else if (planet == "werte"){
    ofstream myfile;
    myfile.open ("werte.txt");
    myfile << "bahnperiode in a" <<endl;
    myfile << "große halbachse in m" <<endl;
    myfile << "exentrizität" <<endl;
    myfile << "mittlere Orbital geschwindigkeit in m/s" <<endl;
    myfile << "aequatordurchmesser in m" <<endl;
    myfile << "poldurchmesser in m" <<endl;
    myfile << "masse in kg" <<endl;
    myfile << "dichte in g/cm^3" <<endl;
    myfile << "mittlere entfernung zur sonne in m" << endl;

    myfile.close();

    cout<< "done" <<endl;
  }

  else {
    stop = 'b';
  }

} while(stop != 'b' );

  cout << "programm wird beendet" <<endl;

  return 0;
}

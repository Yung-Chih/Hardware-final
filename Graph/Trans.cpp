#include<iostream>
#include<fstream>
#include<string>
#include<bitset>
#include<vector>
#include<map>

using namespace std;

int main(){
    ifstream fin( "out.coe", ios::in );
    ofstream fout( "test.coe", ios::out );
    string s1, s2;
    getline( fin, s1);
    getline( fin, s2);

    fout << s1 << endl;
    fout << s2 << endl;
    cout << "s1:" << s1 << endl;
    cout << "s2:" << s2 << endl;

    string pixel;
    while( fin >> pixel ){
        pixel.pop_back();
        cout << "pixel: " << pixel << endl;
        if( pixel == "FFF" )
            fout << "0,\n";
        else
            fout << "1,\n";
    }

    return 0;
}
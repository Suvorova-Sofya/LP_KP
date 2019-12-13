#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <string.h>

struct person {
    std::string name;
    std::string fam;
    char sex;
    std::string indi;
};

struct family {
    std::vector<person> all;
};


bool out_of_family(std::string str) {
    if ((str[0] == '1') && (str[2] == 'H') && (str[3] == 'U') && (str[4] == 'S')) {
        return false;
    } else if ((str[0] == '1') && (str[2] == 'W') && (str[3] == 'I') && (str[4] == 'F')) {
        return false;
    } else if ((str[0] == '1') && (str[2] == 'C') && (str[3] == 'H') && (str[4] == 'I')) {
        return false;
    } else {
        return true;
    }

}


int main() {
    std::vector<family> familys;
    std::vector<person> persons;
    family family1;
    person individ;
    bool flag = false;
    char help[4];
    std::ifstream file("Family_Tree.ged");
    while (file) {
        std::string str;
        getline(file, str);
        if ((str[0] == '0') && (str[2] == '@') && (str[3] == 'I') && (str[4] == '5')) {
            for (size_t i = 2; i < 11; ++i) {
                individ.indi.push_back(str[i]);
            }
        } else if ((str[0] == '2') && (str[2] == 'G') && (str[3] == 'I') && (str[4] == 'V')) {
            int i = 7;
            while (str[i] != '\r') {
                individ.name.push_back(str[i]);
                ++i;
            }
        } else if ((str[0] == '2') && (str[2] == 'S') && (str[3] == 'U') && (str[4] == 'R')) {
            int i = 7;
            while (str[i] != '\r') {
                individ.fam.push_back(str[i]);
                ++i;
            }
        } else if ((str[0] == '1') && (str[2] == 'S') && (str[3] == 'E') && (str[4] == 'X')) {
            individ.sex = str[6];
            person individ2;
            individ2.indi = individ.indi;
            individ2.name = individ.name;
            individ2.fam = individ.fam;
            individ2.sex = individ.sex;
            persons.push_back(individ2);

            individ.name.erase();
            individ.fam.erase();
            individ.indi.erase();

        } else if ((str[0] == '1') && (str[2] == 'H') && (str[3] == 'U') && (str[4] == 'S')) {
            flag = true;
            for (int i = 7; i < 16; ++i) {
                individ.indi.push_back(str[i]);
            }
            int s = 0;
            while (persons[s].indi != individ.indi) {
                ++s;
            }
            person notfull;
            notfull.fam = persons[s].fam;
            notfull.name = persons[s].name;
            notfull.indi = persons[s].indi;
            notfull.sex = persons[s].sex;
            individ.indi.erase();
            family1.all.push_back(notfull);
        } else if ((str[0] == '1') && (str[2] == 'W') && (str[3] == 'I') && (str[4] == 'F')) {
            for (int i = 7; i < 16; ++i) {
                individ.indi.push_back(str[i]);
            }
            int s = 0;
            while (persons[s].indi != individ.indi) {
                ++s;
            }
            person notfull;
            notfull.fam = persons[s].fam;
            notfull.name = persons[s].name;
            notfull.indi = persons[s].indi;
            notfull.sex = persons[s].sex;
            individ.indi.erase();
            family1.all.push_back(notfull);
        } else if ((str[0] == '1') && (str[2] == 'C') && (str[3] == 'H') && (str[4] == 'I')) {
            for (int j = 0; j < 4; ++j) {
                help[j] = str[j + 2];
            }
            for (int i = 7; i < 16; ++i) {
                individ.indi.push_back(str[i]);
            }
            int s = 0;
            while (persons[s].indi != individ.indi) {
                ++s;
            }
            person notfull;
            notfull.fam = persons[s].fam;
            notfull.name = persons[s].name;
            notfull.indi = persons[s].indi;
            notfull.sex = persons[s].sex;
            individ.indi.erase();
            family1.all.push_back(notfull);
        }
        if ((strcmp(help, "CHILD")) && (out_of_family(str)) && (flag == true)) {
            family family2;
            family2.all = family1.all;
            family1.all.clear();
            familys.push_back(family2);
            for (int i = 0; i < 4; ++i) {
                help[i] = '0';
            }
            flag = false;
        }
    }
    std::ofstream out("prolog.pl");
    bool flag2=false;
    for (size_t k = 0; k < familys.size(); ++k) {
        for (size_t i = 2; i < familys[k].all.size(); ++i) {
            out << "parent( \"" << familys[k].all[i].name << " " << familys[k].all[i].fam <<
                      "\",\"" << familys[k].all[0].name << " " << familys[k].all[0].fam <<
                      "\",\"" << familys[k].all[1].name << " " << familys[k].all[1].fam <<
                      "\")" << "\n";
        }
        if(k==0){
            for (size_t i = 2; i < familys[k].all.size(); ++i) {
                if((familys[k].all[i].indi==familys[1].all[0].indi)||(familys[k].all[i].indi==familys[1].all[1].indi)){
                    flag2= true;
                }else if((familys[k].all[i].indi==familys[2].all[0].indi)||(familys[k].all[i].indi==familys[2].all[1].indi)){
                    flag2= true;
                }
                if(flag2== false){
                    if(familys[k].all[i].sex=='M'){
                        out << "parent(\"\",\""<<familys[k].all[i].name <<" "<<familys[k].all[i].fam<<
                                  "\",\"\")"<<"\n";
                    }else{
                        out << "parent(\"\",\"\",\""<<familys[k].all[i].name <<" "<<familys[k].all[i].fam<<
                                  "\")"<<"\n";
                    }
                }
                flag2= false;
            }
        }else if(k==1){
            for (size_t i = 2; i < familys[k].all.size(); ++i) {
                if((familys[k].all[i].indi==familys[0].all[0].indi)||(familys[k].all[i].indi==familys[0].all[1].indi)){
                    flag2= true;
                }else if((familys[k].all[i].indi==familys[2].all[0].indi)||(familys[k].all[i].indi==familys[2].all[1].indi)){
                    flag2= true;
                }
                if(flag2== false){
                    if(familys[k].all[i].sex=='M'){
                        out << "parent(\"\",\""<<familys[k].all[i].name <<" "<<familys[k].all[i].fam<<
                                  "\",\"\")"<<"\n";
                    }else{
                        out << "parent(\"\",\"\",\""<<familys[k].all[i].name <<" "<<familys[k].all[i].fam<<
                                  "\")"<<"\n";
                    }
                }
                flag2= false;
            }
        }else{
            for (size_t i = 2; i < familys[k].all.size(); ++i) {
                if((familys[k].all[i].indi==familys[0].all[0].indi)||(familys[k].all[i].indi==familys[0].all[1].indi)){
                    flag2= true;
                }else if((familys[k].all[i].indi==familys[1].all[0].indi)||(familys[k].all[i].indi==familys[1].all[1].indi)){
                    flag2= true;
                }
                if(flag2== false){
                    if(familys[k].all[i].sex=='M'){
                        out << "parent(\"\",\""<<familys[k].all[i].name <<" "<<familys[k].all[i].fam<<
                                  "\",\"\")"<<"\n";
                    }else{
                        out << "parent(\"\",\"\",\""<<familys[k].all[i].name <<" "<<familys[k].all[i].fam<<
                                  "\")"<<"\n";
                    }
                }
                flag2= false;
            }
        }
        out << "\n";
    }
    out.close();
    return 0;
}

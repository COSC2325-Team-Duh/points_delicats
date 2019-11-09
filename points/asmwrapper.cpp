int main(int argc, char* argv[]){
    if (argc == 1) {
        return 100; // 100 signifies no arguments passed
    }
    else if (argc > 2) {
        return 200; // 200 signifies not enough arguments passed
    }
    return 0;
}

#include <stdlib.h>
#include <unistd.h>
#include <limits.h>

const char* MINTTY_PATH = "/msys64/usr/bin/mintty.exe";
const char* ZSH_PATH = "/msys64/usr/bin/zsh.exe";
const char* BASH_PATH = "/msys64/usr/bin/bash.exe";

int main(int argc, const char* argv[]) {
    char rootDir[PATH_MAX];
    strcpy(rootDir, argv[0]);
    for (int i = strlen(rootDir) - 1; i >= 0; i--) {
        if (rootDir[i] == '\\') {
            rootDir[i] = '\0';
            break;
        }
    }
    
    char minttyPath[PATH_MAX];
    strcpy(minttyPath, rootDir);
    strcat(minttyPath, MINTTY_PATH);
    if (access(minttyPath, F_OK) != 0) {
        return 1;
    }

    putenv("CHERE_INVOKING=1");

    char zshPath[PATH_MAX];
    strcpy(zshPath, rootDir);
    strcat(zshPath, ZSH_PATH);
    if (access(zshPath, F_OK) == 0) {
        return execl(minttyPath, minttyPath, "-i", argv[0],
                zshPath, "--login", NULL);
    }

    char bashPath[PATH_MAX];
    strcpy(bashPath, rootDir);
    strcat(bashPath, BASH_PATH);
    if (access(bashPath, F_OK) == 0) {
        return execl(minttyPath, minttyPath, "-i", argv[0],
                bashPath, "--login", NULL);
    }

    return 1;
}

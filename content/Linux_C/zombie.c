#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argvs[])
{
    pid_t pid;
    pid = fork();
    if (pid < 0 ){
        perror("fork faild");
        
}
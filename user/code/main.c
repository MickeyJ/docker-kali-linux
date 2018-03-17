#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "main.h"

struct user createUser();

int main()
{

    printf("%s %s\n", PROGRAM_NAME, START_MESSAGE);

    int usersCreated = 0;
    int userIdx;
    int userLimitDefault = 4;
    int userLimit = userLimitDefault;

    struct user userRecords[5];

    while(userLimit >= 0){
        userRecords[userLimit] = createUser();
        userLimit -= 1;
    };

    for(userIdx = userLimitDefault; userIdx >= 0; userIdx--){
        printf("\n");
        printf("\nfirstName: %s", userRecords[userIdx].firstName);
        printf("\nlastName: %s", userRecords[userIdx].lastName);
        printf("\nage: %d\n", userRecords[userIdx].age);
    }

    return 0;
}


struct user createUser()
{

    struct user newUser;

    newUser.userID = 1;

    printf("\n");
    printf("First Name: ");
    scanf("%s", newUser.firstName);
    printf("Last Name: ");
    scanf("%s", newUser.lastName);
    printf("Age: ");
    scanf("%d", &newUser.age);

    return newUser;
}

#include<stdio.h>
#include<string.h>
char NAMTAB[10][20];
int namePtr=-1;
char DEFTAB[10][1000];
int min(int a,int b){if(a<b)return a;return b;}
int main()
{
	char line[100];
	int i,j,l;
	FILE* inFile;
	inFile = fopen("input.txt", "r");
	while(fgets(line, sizeof(line), inFile) != NULL)
	{
		if(line[0]=='M' && line[1]=='C')
		{
			l=strlen(line);
			char lineX[100];
			namePtr++;
			for(i=3;i<l;i++)
				NAMTAB[namePtr][i-3]=line[i];
			fgets(line, sizeof(line), inFile);
			j=0;
			while(!(line[0]=='M' && line[1]=='E'))
			{
				l=strlen(line);
				for(i=0;i<l;i++)
					DEFTAB[namePtr][j++]=line[i];
				fgets(line, sizeof(line), inFile);
			}
		}
		else
		{
			int flag;
			flag=1;
			for(i=0;i<=namePtr;i++)
			{
				if(strlen(line)!=strlen(&NAMTAB[i][0]))
					flag=0;
				l=min(strlen(line),strlen(&NAMTAB[i][0]))-1;
				for(j=0;j<l;j++)
					if(line[j]!=NAMTAB[i][j])
						flag=0;
				if(flag==1)
					break;
			}
			if(flag==0)
				printf("%s",line);
			else
			{
				printf("%s", &DEFTAB[i][0]);
			}
		}
	}
	return 0;
}

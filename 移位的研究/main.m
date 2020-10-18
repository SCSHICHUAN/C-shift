//
//  main.m
//  移位的研究
//
//  Created by Stan on 2020/10/18.
//

#import <Foundation/Foundation.h>


//int 二进制输出
void print_bin(int n,int buff_lenght)
{
    int i;
    int j = 1;
    int k = buff_lenght*8;
    for(i=sizeof(n)*k-1; i>=0; i --)
    {
        if(n&(1<<i))printf("1");
        else printf("0");
        
        if (j==8) {
            j = 0;
            printf(" ");
        }
        j++;
    }
    printf("\n");
}
//char 二进制输出
void strtobit(char *chr,int buff_lenght)
{

    char *pchr=chr;
    int i,j;
    for(i=0;i<buff_lenght;i++)
    {
        for(j=7;j>=0;j--)
        {
            char tmpp=pchr[i];
            tmpp=pchr[i]&(1<<j);
            printf("%d",tmpp>>j);
        }
        printf(" ");
    }
    printf("\n");
}



void presentBuffer(const unsigned char  buffer[]);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //一个字节的 和四个字节 & 会升级为int
        int a =  0B00000100  &  0B00000000000000000000000011111111;
        print_bin(a,1);
        printf("a = %d\n",a);
        
        //左移是低位补0
        a = 0B00000000000000000000000011111111 << 24;
        print_bin(a,1);
        printf("a = %d\n",a);
        
        //左移会使数增大
        a = 0B00000100;
        print_bin(a,1);
        printf("a = %d\n",a);
        a = 0B00000100 << 1;
        print_bin(a,1);
        printf("a = %d\n",a);
        
        
        /*
         使用如果一个数组中有int和字符
         就要移位来拼接
         因为int 是4位数组一个元素是一位，所以要拆分int到数组中
         */
        //257二进制：100000001
        unsigned char buffer[22] = {0B00000000,0B00000000,0B00000001,0B00000001,'H','E','L','L','O','W','2','0','2','0'};
        
        
        strtobit((char*)buffer,22);
        
        char arg[200] = {0};
        memcpy(arg, buffer+4,10);
        printf("arg = %s\n",arg);
        
        char s[] = "中国";
        memcpy(buffer+14,s,8);
        printf("buffer1 = %s\n",buffer+14);
        
        presentBuffer(buffer);
        
        
        int length = 10;
        
        //把int存入字节数组中
        buffer[0] = (char)((length >> 24) &0x000000ff);
        buffer[1] = (char)((length >> 16) &0x000000ff);
        buffer[2] = (char)((length >>  8) &0x000000ff);
        buffer[3] = (char)(length  >>  0  &0x000000ff);
        presentBuffer(buffer);
    }
    return 0;
}

void presentBuffer(const unsigned char  buffer[])
{
    
    printf("\n\n\n");
    
    int length =  ((buffer[0] &  0B00000000000000000000000011111111) << 24)
    + ((buffer[1] &  0B00000000000000000000000011111111) << 16)
    + ((buffer[2] &  0B00000000000000000000000011111111) << 8 )
    + ((buffer[3] &  0B00000000000000000000000011111111) << 0 );
    
    printf("int 数 :%d\n",length);
    printf("buffer = %s\n",buffer+4);
    strtobit((char*)buffer,30);
    
}


int main(){
    return 0;
}

void mod(){
    int* a = (int*)0x80400000;
    int* b = (int*)0x80500000;
    int* c = (int*)0x80600000;
    unsigned int n = 0x100000 >> 2;
    for(int i = 0; i < n; i++){
        unsigned int tempa = a[i];
        unsigned int tempb = b[i];
        if(tempa <= tempb){
            c[i] = tempa;
        } else {
            while(tempa > tempb){
                tempa = tempa - tempb;
            }
            c[i] = tempa;
        }
    }
    return;
}

# Title:  Procedure Calls 
# Desc:   Given the C program, complete the MIPS implementation of Main. 
# Author: Bryce Verberne
# Date:   03/16/2023



# int Dif(int a, int b){
#    return a - b;
# }

# int Sum(int a, int b){
#    return a + b;
# }

# int main(){
#    int x, y;
#    w = Sum(x, y);
#    z = Dif(y, x);
#    return 0;   // Do not implement
# }

Main:
      # Type your code here.
      
      
      j End

# Procedure Sum (Do not modify)
Sum:
      add $v0, $a0, $a1
      jr $ra

# Procedure Dif (Do not modify)
Dif:
      sub $v0, $a0, $a1
      jr $ra

End:
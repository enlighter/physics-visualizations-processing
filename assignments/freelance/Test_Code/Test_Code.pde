void setup() {
int[][] a = new int[3][8];
for (int i=0; i<a.length; i++)
for (int k=0; k<a[0].length; k++)
a[i][k] = (int)random(-8, 9);
display(a);
int total = sum(a);
println("\n\nSum of all items is "+total);
}

int sum(int[][] arr)
{
  int Sum = 0;
  
  for(int i=0; i<arr.length; i++)
    for(int k=0; k<arr[0].length; k++)
      Sum = Sum + arr[i][k];
      
  return Sum;
}

void display(int[][] arr) {
for (int i=0; i<arr.length; i++) {
for (int k=0; k< arr[0].length; k++) {
print(arr[i][k]+" ");
}
println();
}
}
/*
" write the method sum here, that returns the total of all the items of a
" two-dimensional integer array that is passed to the method
*/

counter=0
max=10

while [ $counter -le $max ]
do
  echo $counter
  ((counter++)) # the double parenthesises enable arithmetic expansion
done

counter=0

until [ $counter -gt $max ]
do
  echo $counter
  ((counter++))
done

numbers='1 2 3 4 5 6 7 8 9 10'

for number in $numbers
do
  echo $number
done

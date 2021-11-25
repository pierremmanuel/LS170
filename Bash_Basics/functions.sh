greeting () {
  echo Hello $1
  echo Hello $2
}

greeting "Peter" "Paul"

# The code below performs the same action. We can interpolate variables in double-quoted strings.

greeting () {
  echo "Hello $1"
  echo "Hello $2"
}

greeting "Peter" "Paul"

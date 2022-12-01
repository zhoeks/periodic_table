PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
  
  if [[ -z $1 ]]
  then
  echo "Please provide an element as an argument."
  exit
  else
  #check for element by number and set variables
    if [[  $1 =~ ^[0-9]+$ ]]
    then
    ELEMENT=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id)  WHERE atomic_number=$1;")
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$1;")
    NAME=$($PSQL "SELECT name FROM elements INNER JOIN properties USING(atomic_number) WHERE atomic_number=$1;")
    SYMBOL=$($PSQL "SELECT symbol FROM elements INNER JOIN properties USING(atomic_number) WHERE atomic_number=$1;")
    ELEMENT_TYPE=$($PSQL "SELECT element_type FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$1;")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$1;")
    MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$1;")
    BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$1;")    
    else
# check for element by text and set variables
    ELEMENT=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$1' OR name='$1';")
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1' OR name='$1';")
    NAME=$($PSQL "SELECT name FROM elements INNER JOIN properties USING(atomic_number) WHERE symbol='$1' OR name='$1';")
    SYMBOL=$($PSQL "SELECT symbol FROM elements INNER JOIN properties USING(atomic_number) WHERE symbol='$1' OR name='$1';")
    ELEMENT_TYPE=$($PSQL "SELECT element_type FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1' OR name='$1';")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1' OR name='$1';")
    MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1' OR name='$1';")
    BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1' OR name='$1';")

    fi
  fi
  #formatting found columns
  SYMBOL_FINAL=$(echo "$SYMBOL" | sed -e "s/^ *//g")
  ATOMIC_NUMBER_FINAL=$(echo "$ATOMIC_NUMBER" | sed -e 's/^ *//')
  ATOMIC_MASS_FINAL=$(echo "$ATOMIC_MASS" | sed -e 's/^ *//')
  MELTING_POINT_CELSIUS_FINAL=$(echo "$MELTING_POINT_CELSIUS" | sed -e 's/^ *//')
  BOILING_POINT_CELSIUS_FINAL=$(echo "$BOILING_POINT_CELSIUS" | sed -e 's/^ *//')
  
  if [[ -z $ELEMENT ]]
  #if not found
  then
  echo "I could not find that element in the database."
  exit
  else
  #if element found
  echo "The element with atomic number $ATOMIC_NUMBER_FINAL is$NAME ($SYMBOL_FINAL). It's a$ELEMENT_TYPE, with a mass of $ATOMIC_MASS_FINAL amu.$NAME has a melting point of $MELTING_POINT_CELSIUS_FINAL celsius and a boiling point of $BOILING_POINT_CELSIUS_FINAL celsius."
  fi

  

#!/bin/bash

# wish design:
#./cheatgithub.sh --dates 10/10/2019 12/10/2019 15/10/2019
#./cheatgithub.sh --from-to 10/10/2019 25/10/2019


do_dummy_thing() {
  declare -r FILENAME="dummy.txt"

  if [ -e "$FILENAME" ]; then
    rm $FILENAME
    echo "removed $FILENAME"

  else
    touch "$FILENAME"
    echo "dummy text" > "$FILENAME"
    echo "added $FILENAME"
  fi
}

create_commits() {
  local number_of_commits_per_day=$1
  local number_of_days=$2

  for ((i=number_of_days-1; i >= 0; i--)); do
    
    for ((j=0; j < number_of_commits_per_day; j++)); do

      do_dummy_thing
      git add .
      git commit -m "dummy commit"

      local date_to_commit=`date --date="$i days ago"`
      GIT_COMMITTER_DATE="$date_to_commit" git commit --amend --no-edit --date "$date_to_commit"
      echo "committed $(( j + 1 )) commits for $date_to_commit"

    done

  done
}


# expected: ./cheatgithub.sh [number of commits per day] [number of days]

integer_pattern="^[0-9]+$"

if [[ $1 =~ $integer_pattern && $2 =~ $integer_pattern ]]; then

  create_commits $1 $2

elif [[ ! $1 =~ integer_pattern ]]; then
  echo "need a valid [number of commits per day] as 1st parameter"

elif [[ ! $2 =~ integer_pattern ]]; then
  echo "need a valid [number of day] as 2nd parameter"

fi









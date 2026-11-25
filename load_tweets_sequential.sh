#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
time for file in $files; do
    unzip -p "$file" | sed 's/\\u0000//g' | docker compose exec -T pg_denormalized psql -d postgres -c "COPY tweets_jsonb(data) FROM STDIN WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\001', ESCAPE E'\001');"
    # copy your solution to the twitter_postgres assignment here
done

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time for file in $files; do
    python3 -u load_tweets.py --db=postgresql://postgres:pass@localhost:1131/ --inputs $file
    # copy your solution to the twitter_postgres assignment here
done

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time for file in $files; do
    python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:11320/ --inputs $file
done

#!/bin/sh

CURRENT_MONTH=$(date +%m)
SAMPLE_URL=https://samples.adsbexchange.com/readsb-hist/2023/$CURRENT_MONTH/01

mkdir "2023-$CURRENT_MONTH-01"
pushd "2023-$CURRENT_MONTH-01"
curl -L -O "$SAMPLE_URL/[00-23][00-59][0-5]{0,5}Z.json.gz"
popd

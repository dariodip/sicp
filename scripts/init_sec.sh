#!/bin/bash

Help()
{
    echo "Initialize a section boilerplate"
    echo
    echo "usage: $0 <c> <section> [<first ex> <last ex>]"
    echo
    echo "arguments:"
    echo "c            chapter"
    echo "section      section"
    echo "first ex     first exercise number (optional)"
    echo "last ex      last exercise number (optional)"
    echo
}

if [ "$#" -lt 2 ]; then
    Help
    exit 1
fi

CHAP=$1
SEC=${CHAP}.$2

if [ "$#" -eq 4 ]; then
    FIRST_EX=$3
    LAST_EX=$4
fi

SECTION_FOLDER="chapter${CHAP}/${SEC}"
echo "Creating folder ${SECTION_FOLDER}"
mkdir -p ${SECTION_FOLDER}

NOTES_FILE="${SECTION_FOLDER}/notes.md"
if [ ! -f "${NOTES_FILE}" ]; then
    echo "Creating notes file ${NOTES_FILE}"
    echo "# ${SEC}" >> ${NOTES_FILE}
fi

for ex in $(seq $FIRST_EX $LAST_EX)
do
    EX_FILE="${SECTION_FOLDER}/ex-${CHAP}.${ex}.rkt"
    echo "Creating file ${EX_FILE}"
    if [ ! -f "${EX_FILE}" ]; then
        echo "; Exercise ${ex}" > ${EX_FILE}
        echo "#lang sicp" >> ${EX_FILE}
    else
        echo "File ${EX_FILE} already exists"
    fi
done

 

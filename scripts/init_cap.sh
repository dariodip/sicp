#!/bin/bash

CAP=$1
SEC=${CAP}.$2

SECTION_FOLDER="cap${CAP}/${SEC}"
echo "Creating folder ${SECTION_FOLDER}"
mkdir -p ${SECTION_FOLDER}

NOTES_FILE="${SECTION_FOLDER}/notes.md"
if [ ! -f "${NOTES_FILE}" ]; then
    echo "Creating notes file ${NOTES_FILE}"
    echo "# ${SEC}" >> ${NOTES_FILE}
fi

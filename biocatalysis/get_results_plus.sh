set -e

EC_LEVEL="${1}"
FOLD="${2}"
DIR="data/biocatalysisV6/experiments"

# Program Goes
DATA_DIR="results/${EC_LEVEL}/${FOLD}"
STEPS=$(ls ${DATA_DIR} -t)
echo $STEPS
for STEP in ${STEPS};
do
    cp "${DIR}/${EC_LEVEL}/${FOLD}/src-test.txt" "${DATA_DIR}/${STEP}/src-test.txt";
    cp "${DIR}/${EC_LEVEL}/${FOLD}/tgt-test.txt" "${DATA_DIR}/${STEP}/tgt-test.txt";
    if [ ! -e "${DATA_DIR}/${STEP}/src-pred.txt" ]; then
    echo Creating "${DATA_DIR}/${STEP}/src-pred.txt" from "${DIR}/${EC_LEVEL}/${FOLD}/src-test.txt"
    cp "${DIR}/${EC_LEVEL}/${FOLD}/src-test.txt" "${DATA_DIR}/${STEP}/src-pred.txt";
    else
    echo "${DATA_DIR}/${STEP}/src-pred.txt exists, skip..."
    fi

    python bin/rbt-evaluate.py "${DATA_DIR}/${STEP}" \
        --name="top1" \
        --n-best-fw=10 \
        --n-best-bw=10 \
        --n-best-rtr=10 \
        --top-n-fw=1 \
        --top-n-bw=1 \
        --top-n-rtr=1;
    
    python bin/rbt-evaluate.py "${DATA_DIR}/${STEP}" \
        --name="top2" \
        --n-best-fw=10 \
        --n-best-bw=10 \
        --n-best-rtr=10 \
        --top-n-fw=2 \
        --top-n-bw=2 \
        --top-n-rtr=2;

    python bin/rbt-evaluate.py "${DATA_DIR}/${STEP}" \
        --name="top3" \
        --n-best-fw=10 \
        --n-best-bw=10 \
        --n-best-rtr=10 \
        --top-n-fw=3 \
        --top-n-bw=3 \
        --top-n-rtr=3;

    python bin/rbt-evaluate.py "${DATA_DIR}/${STEP}" \
        --name="top4" \
        --n-best-fw=10 \
        --n-best-bw=10 \
        --n-best-rtr=10 \
        --top-n-fw=4 \
        --top-n-bw=4 \
        --top-n-rtr=4;

    python bin/rbt-evaluate.py "${DATA_DIR}/${STEP}" \
        --name="top5" \
        --n-best-fw=10 \
        --n-best-bw=10 \
        --n-best-rtr=10 \
        --top-n-fw=5 \
        --top-n-bw=5 \
        --top-n-rtr=5;
    
done
EC_LEVEL="${1}"
FOLD="${2}"
DATASET_TRANSFER="data/biocatalysisV6/experiments/${EC_LEVEL}/${FOLD}"
TASK="${EC_LEVEL}_fold${FOLD}"

mkdir -p results

# Get Every Step Stage of Model and Do Evals
MODELS=$(ls model/"${TASK}"*.pt -t)
for MODEL in ${MODELS};
    do
        echo "Evaluate on EC_LEVEL=${EC_LEVEL}"
        echo "Use model skpt=${MODEL}"
        PREFIX=$(basename ${MODEL})
        STEP=$(echo ${PREFIX} | sed -r "s/[0-9]_fold[0-9]_step_([0-9]+)\.pt/\1/g")
        SUB_PATH=results/${EC_LEVEL}/${FOLD}/${STEP}
        mkdir -p ${SUB_PATH}
        onmt_translate -model "${MODEL}" \
            -src "${DATASET_TRANSFER}/src-test.txt" \
            -output "${SUB_PATH}/tgt-pred.txt" \
            -n_best 10 -beam_size 10 -max_length 300 -batch_size 64 \
            -gpu 0;
    done

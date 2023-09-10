DATA_DIR="data/biocatalysisV6"
EC_LEVEL="$1"
FOLD="$2"

OUTPUT_DIR="preprocessing"
DATASET="data/uspto_dataset"
mkdir -p "$OUTPUT_DIR"
# According to Level set and fold
DATASET_TRANSFER="${DATA_DIR}/experiments/${EC_LEVEL}/${FOLD}"
SAVE_PREFIX="${EC_LEVEL}_fold${FOLD}"

# forward
onmt_preprocess \
  -train_src "${DATASET}/src-train.txt" "${DATASET_TRANSFER}/src-train.txt" \
  -train_tgt "${DATASET}/tgt-train.txt" "${DATASET_TRANSFER}/tgt-train.txt" \
  -valid_src "${DATASET_TRANSFER}/src-valid.txt" \
  -valid_tgt "${DATASET_TRANSFER}/tgt-valid.txt" \
  -train_ids uspto transfer \
  -save_data  "$OUTPUT_DIR"/$SAVE_PREFIX \
  -src_seq_length 3000 -tgt_seq_length 3000 \
  -src_vocab_size 3000 -tgt_vocab_size 3000 \
  -share_vocab

DATA_DIR="data/biocatalysisV6"
INPUT_FILE="data_biocatalysis.csv"
python bin/rbt-preprocess.py $DATA_DIR/$INPUT_FILE $DATA_DIR \
  --remove-patterns=$DATA_DIR/patterns.txt \
  --remove-molecules=$DATA_DIR/molecules.txt \
  --ec-level=4

# 直接设置成 4
# 后面直接复制 5 份, 每份都删除即可

python bin/cv.py
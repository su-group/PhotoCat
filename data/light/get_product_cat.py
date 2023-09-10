import pandas as pd
from z.smi import RXN
from z.utils import set_seeds, split_df
from pathlib import Path
from os import makedirs

SEED = 42
DATA = Path('data.csv')
OUT_DIR = Path('product_cat')

set_seeds(SEED)
makedirs(OUT_DIR, exist_ok=True)

"""转化为 t5chem 的数据格式"""
df = pd.read_csv(DATA, index_col=0)
reactions = df['canonized_rxns']
cat = df['cat_class']

def class2str(cat_class):
    return str(cat_class // 10) + '.' + str(cat_class % 10)

source = df.apply(lambda row: repr(RXN(row['canonized_rxns'])).split('>>')[0] + '>' + class2str(row['cat_class']) + '>', axis=1)
target = reactions.apply(lambda x: repr(RXN(x)).split('>>')[1])
source_train, source_val, source_test = split_df(source, random_state=SEED)
target_train, target_val, target_test = split_df(target, random_state=SEED)

source_train.to_csv(OUT_DIR / 'train.source', index=None, header=None)
source_val.to_csv(OUT_DIR / 'val.source', index=None, header=None)
source_test.to_csv(OUT_DIR / 'test.source', index=None, header=None)
target_train.to_csv(OUT_DIR / 'train.target', index=None, header=None)
target_val.to_csv(OUT_DIR / 'val.target', index=None, header=None)
target_test.to_csv(OUT_DIR / 'test.target', index=None, header=None)

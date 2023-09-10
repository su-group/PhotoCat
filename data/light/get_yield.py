import pandas as pd
from z.utils import set_seeds, split_df
from pathlib import Path
from os import makedirs

SEED = 42
DATA = Path('data.csv')
OUT_DIR = Path('yield')

set_seeds(SEED)
makedirs(OUT_DIR, exist_ok=True)

"""转化为 t5chem 的数据格式"""
df = pd.read_csv(DATA, index_col=0)
reactions = df['canonized_rxns']
"""处理一下多个 yield 的情况"""
def yield_filter(yield_):
    if '/' in yield_:
        return yield_.split('/')[0]
    else:
        return yield_
yield_ = df['yield/%'].apply(yield_filter)
source = reactions
target = yield_
source_train, source_val, source_test = split_df(source, random_state=SEED)
target_train, target_val, target_test = split_df(target, random_state=SEED)

source_train.to_csv(OUT_DIR / 'train.source', index=None, header=None)
source_val.to_csv(OUT_DIR / 'val.source', index=None, header=None)
source_test.to_csv(OUT_DIR / 'test.source', index=None, header=None)
target_train.to_csv(OUT_DIR / 'train.target', index=None, header=None)
target_val.to_csv(OUT_DIR / 'val.target', index=None, header=None)
target_test.to_csv(OUT_DIR / 'test.target', index=None, header=None)
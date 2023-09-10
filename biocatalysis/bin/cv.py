from pathlib import Path
import shutil

DIR = Path('data/biocatalysisV5/experiments')


def reduce(line: str, keep: int = 0):
    rxn = line.split('|')[0]
    if keep == 0:
        return rxn.strip() + '\n'
    else:
        conditions = line.split('|')[1].split()
        rtn = rxn
        rtn += '|'
        for i in range(keep):
            rtn += ' '
            rtn += conditions[i]
        rtn += '\n'
        return ''.join(rtn)


def reduce_copy(pathi: Path, patho: Path, keep: int):
    if str(pathi).split('/')[-1].startswith('src'):  # 只处理 src 文件
        n_err = 0
        print(f'processing {pathi} to {patho}')
        with open(pathi, 'r') as fi:
            content = fi.readlines()
        reduced_content = []
        for line in content:
            try:
                reduced_content.append(reduce(line, keep=keep))
            except:
                n_err += 1
        if n_err != 0:
            print(f'错误个数: {n_err}')
        with open(patho, 'w') as fo:
            fo.writelines(reduced_content)
    else:
        print(f'simple copy {pathi} to {patho}')
        shutil.copyfile(pathi, patho)


a_s = ['src', 'tgt']
b_s = ['test', 'train', 'valid']
c_s = [a + '-' + b for a, b in zip(a_s * 3, b_s * 2)]

for ec_level in range(4):  # 复制 4 份
    for fold in range(5):
        for file in c_s:
            pathi = DIR / '4' / str(fold) / f'{file}.txt'
            diro = DIR / str(ec_level) / str(fold)
            diro.mkdir(exist_ok=True, parents=True)
            patho = diro / f'{file}.txt'
            reduce_copy(pathi, patho, keep=ec_level)

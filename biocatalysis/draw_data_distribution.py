import numpy as np
import pandas as pd
import seaborn as sns
from matplotlib import pyplot as plt

plt.rcParams['font.family'] = 'times new roman'

def plot_dis(df: pd.DataFrame, fontsize_big=30, fontsize_small=25):
    plt.figure(figsize=(16, 12), dpi=300)
    # sns.color_palette("Paired", 8)
    # ax = sns.distplot(df['E_gap'], color='#144A74', label="Measured E_gap", norm_hist=True,
    #              hist_kws=dict(linewidth=0),kde=False,
    #              bins=50)
    ax = sns.distplot(df['weight'], kde=False, color='#B9CDE5')
    # ax.set(ylabel='Count', xlabel='E_gap (eV)')
    ticklabels=fontsize_small
    ax.set_xticks(np.arange(10, 1000, 50))
    ax.set_xticklabels(np.arange(10, 1000, 50), fontsize=ticklabels)
    ax.set_ylabel('Count', fontsize=fontsize_big)
    ax2 = plt.twinx()
    ax2 = sns.distplot(df['weight'], kde=True, hist=False, ax=ax2, color='#C5E0B4')
    ax2.set_ylabel('Density', fontsize=fontsize_big)
    ax.set_yticklabels([0, 100, 200, 300, 400, 500, 600, 700], fontsize=ticklabels)
    ax2.set_yticklabels([0, 0.2, 0.4, 0.6, 0.8, 1], fontsize=fontsize_big)
    plt.legend(fontsize=ticklabels)
    plt.tick_params(labelsize=ticklabels)
    plt.xlabel("E_g", fontsize=fontsize_big, labelpad=20)
    plt.ylabel("Distribution", fontsize=fontsize_big, labelpad=25)
    plt.savefig('./分布图.png', dpi=250)
    plt.show()
# import numpy as np
# import seaborn as sns
# from matplotlib import pyplot as plt
#
# # generate some random test data
# y = np.abs(np.random.normal(np.random.choice([5, 9, 15], 2000, p=[3/9, 5/9, 1/9]), 2, 2000))
#
# ax = sns.distplot(y, kde=False)
# ax.set_title('Distribution of Flavor Purchases\nNumber Purchased')
# ax.set(ylabel='Count', xlabel='Number of Flavors Purchased')
# n = 20
# ax.set_xticks(range(n))
# ax.set_xticklabels(range(n))
#
# ax2 = plt.twinx()
# ax2 = sns.distplot(y, kde=True, hist=False, ax=ax2)
# ax2.set_ylabel('density')
# plt.show()

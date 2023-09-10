# if forward
EC_LEVEL="${1}"
FOLD="${2}"
TASK="${EC_LEVEL}_fold${FOLD}"

# 程序部分
DATASET="preprocessing/${TASK}"
FROM="model/${TASK}_step_50000.pt"
OUTDIR="model_continue/${TASK}"
LOGDIR="logs/${TASK}"
W1=9
W2=1

mkdir -p $OUTDIR
mkdir -p $LOGDIR

onmt_train -data ${DATASET} \
    -save_model ${OUTDIR} \
    -data_ids uspto transfer --data_weights ${W1} ${W2} \
    -seed 42 -gpu_ranks 0 \
    -train_steps 70000 -param_init 0 \
    -train_from ${FROM} \
    -max_generator_batches 32 \
    -batch_size 4096 -batch_type tokens \
    -normalization tokens -max_grad_norm 0  -accum_count 4 \
    -optim adam -adam_beta1 0.9 -adam_beta2 0.998 -decay_method noam \
    -warmup_steps 800 -learning_rate 2 -label_smoothing 0.0 \
    -layers 2 -rnn_size 384 -word_vec_size 384 \
    -encoder_type transformer -decoder_type transformer \
    -dropout 0.1 -position_encoding -share_embeddings  \
    -global_attention general -global_attention_function softmax \
    -self_attn_type scaled-dot -heads 4 -transformer_ff 1024 \
    --tensorboard --tensorboard_log_dir ${LOGDIR}
#!/bin/bash
mkdir -p results

export CUDA_VISIBLE_DEVICES=0

# Run experiments on CF-IMDB
PREF='cfimdb'
OPTION='finetune'
python classifier.py \
    --option "${OPTION}" \
    --lr 1e-5 \
    --seed 1234 \
    --train "data/${PREF}-train.txt" \
    --dev "data/${PREF}-dev.txt" \
    --test "data/${PREF}-test.txt" \
    --dev_out "results/${PREF}-dev-${OPTION}-output.txt" \
    --test_out "results/${PREF}-test-${OPTION}-output.txt" \
    --filepath "results/${PREF}-model-${OPTION}.pt" \
    --use_gpu | tee results/${PREF}-train-${OPTION}-log.txt
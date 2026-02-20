# BERT-based Classification Assignment

This code is adapted from CMU's [CS11-747: Neural Networks for NLP](http://www.phontron.com/class/nn4nlp2020/), by Shuyan Zhou, Zhengbao Jiang, Ritam Dutt and Brendon Boldt


This code is to perform text classification on ``cfimdb`` dataset with the BERT model.


## Code Structure
* The details of the code structure is described below.

### classifier.py
This file contains the pipeline to 
* call the BERT model to encode the sentences for their contextualized representations
* feed in the encoded representations for the sentence classification task
* fine-tune the Bert model on the downstream tasks (e.g. sentence classification)


### BertSentClassifier (to be implemented)
This class is used to
* encode the sentences using BERT to obtain the pooled output representation of the sentence.
* classify the sentence by applying dropout to the pooled-output and project it using a linear layer.
* adjust the model paramters depending on whether we are pre-training or fine-tuning BERT

### BertDataset and create_data (to be implemented)
This class and the function is used to
* load the textual data into a list of sentences, labels, tokens for the labels 

### utils.py
This file contains utility functions for various purposes.


## Important Notes
* Follow `setup.sh` to properly setup the environment and install dependencies.

python3 classifier.py --option [pretrain/finetune] --epochs NUM_EPOCHS --lr LR --train data/sst-train.txt --dev data/sst-dev.txt --test data/sst-test.txt
```

### Submission
* The coding file should be a zip file with the following structure
```
File Name/
├── classifier.py
├── utils.py
├── README.md
├── cfimdb-dev-pretrain-output.txt
├── cfimdb-test-pretrain-output.txt
├── cfimdb-train-pretrain-log.txt 
├── cfimdb-dev-finetune-output.txt 
├── cfimdb-test-finetune-output.txt 
├── cfimdb-train-finetune-log.txt 
├── run_exp.sh 
└── setup.sh
```


### Acknowledgement
Parts of the code are from the [`transformers`](https://github.com/huggingface/transformers) library ([Apache License 2.0](./LICENSE)).

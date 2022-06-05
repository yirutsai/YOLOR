# DLMI Task1

## Installation
```
conda create -n <env_name> python=3.8
conda activate <env_name>

cd /path/to/yolor
pip install -r requirements.txt

conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch

cd mish-cuda
python setup.py build install
cd ..

cd pytorch_wavelets
pip install .
cd ..
```

## Preprocessing
### Roboflow(Recommend)
```
curl -L "https://app.roboflow.com/ds/oooooooo?key=xxxxxxxx" > roboflow.zip
unzip roboflow.zip
```
This will produce two folders `train` and `valid`.
These two folders would be used in further training steps.

```
unzip Public_Image.zip
unzip Private_Image.zip
cd Image
cp * ../Public_Image
cd ../
```

## Training
```
python train.py --batch-size 4 --img 1280 1280 --data custom.yaml --weights yolor-e6.pt --device 0 --name yolo_e6_base --hyp hyp.scratch.1280.yaml --epochs 100 --workers 4
```
You could modify custom.yaml to meet your need(specify directory of your training and validation data).


## Inferencing
```
python detect.py --source <dir_image>\
                 --weights <weight_file>... \
                 --conf <confidence_threshold>\
                 --img-size <img_size>
                 [--augment \]
                 --save-txt
                 --save-conf
                 --name <inference_name>
                 
```
If you want to ensemble models, you can feed multiple model into `weights`.
Sample: 
```
python detect.py --source ../Public_Image/\
                --weights runs/train/yolor_d6/weights/best.pt runs/train/yolor_d6/weights/best_ap50.pt\
                            runs/train/yolor_d6_base/weights/best.pt  runs/train/yolor_d6_base/weights/best_ap50.pt\
                            runs/train/yolor_e6/weights/best.pt runs/train/yolor_e6/weights/best_ap50.pt\
                            runs/train/yolor_e6_base/weights/best.pt\
                            runs/train/yolor_w6/weights/best.pt runs/train/yolor_w6/weights/best_ap50.pt runs/train/yolor_w6/weights/best_f.pt\
                            runs/train/yolor_w6_base/weights/best.pt runs/train/yolor_w6_base/weights/best_ap50.pt \
                            runs/train/yolor_p6/weights/best.pt runs/train/yolor_p6/weights/best_ap50.pt runs/train/yolor_p6/weights/best_f.pt\
                            runs/train/yolor_p6_base/weights/best.pt runs/train/yolor_p6_base/weights/best_ap50.pt  runs/train/yolor_p6_base/weights/best_f.pt \
--conf 0.05 --img-size 1664 --device 0 --augment --save-txt --save-conf --name inference_yolor_ensemble_v10_dewp_both_private
```

## Postprocess
```
cd /path/to/postprocess
python postprocess.py --type <yolor> --target <name_of_model> --output <output_path>
```

Sample:
```
python postprocess.py --type yolor --target inference_yolor_ensembleAll_dewp --output public_yolor_ensembleAll_dewp.json
```

@article{wang2021you,
  title={You Only Learn One Representation: Unified Network for Multiple Tasks},
  author={Wang, Chien-Yao and Yeh, I-Hau and Liao, Hong-Yuan Mark},
  journal={arXiv preprint arXiv:2105.04206},
  year={2021}
}

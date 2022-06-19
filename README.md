# DLMI Task1

## Installation
If this is not working, please refer to the README.md in yolor and yolov5 repectively.
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
You need to upload your dataset to roboflow on your own. And output in YOLO v5 Pytorch format.
Here is the setting of our dataset.
![image](https://user-images.githubusercontent.com/35464631/172047986-a6f4fc4c-0abf-479f-b98f-b2f9b1d07b62.png)

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
Before training, please make sure you have downloaded the pretrained model weight offered by the author of YOLOR in this [link](https://github.com/WongKinYiu/yolor/tree/paper) and this [link](https://github.com/WongKinYiu/yolor/releases/tag/weights).
After training, there should be a folder named as the name you passed in argument.
```
python train.py --batch-size 4 --img 1280 1280 --data custom.yaml --weights yolor-e6.pt --device 0 --name yolo_e6_base --hyp hyp.scratch.1280.yaml --epochs 100 --workers 4
```
You could modify custom.yaml to meet your need(specify directory of your training and validation data).

## Pretrained model
Please use this [link](https://drive.google.com/drive/folders/1tI5Vl_Y3gxeMbUGzDkRE32yV5ndf3Er_?usp=sharing) to download the pretrained model.
You could put this folder in `yolor`.



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
## Reproduce
In order to get the best result in private dataset, please refer to the following model weights.
![image](https://user-images.githubusercontent.com/35464631/172910843-75db4adf-f87e-4689-8897-085e875cc742.png)
```
python detect.py --source ../Public_Image/\
                --weights runs/train/yolor_d6/weights/best.pt runs/train/yolor_d6/weights/best_ap50.pt runs/train/yolor_d6/weights/best_overall.pt\
                            runs/train/yolor_d6_base/weights/best.pt \
                            runs/train/yolor_e6/weights/best.pt \
                            runs/train/yolor_e6_base/weights/best.pt\
                            runs/train/yolor_w6/weights/best.pt runs/train/yolor_w6/weights/best_ap50.pt runs/train/yolor_w6/weights/best_f.pt\
                            runs/train/yolor_w6_base/weights/best.pt runs/train/yolor_w6_base/weights/best_ap.pt runs/train/yolor_w6_base/weights/best_ap50.pt \
                            runs/train/yolor_p6/weights/best.pt runs/train/yolor_p6/weights/best_ap.pt runs/train/yolor_p6/weights/best_ap50.pt runs/train/yolor_p6/weights/best_f.pt\
                            runs/train/yolor_p6_base/weights/best.pt runs/train/yolor_p6_base/weights/best_ap.pt runs/train/yolor_p6_base/weights/best_ap50.pt  runs/train/yolor_p6_base/weights/best_f.pt \
--conf 0.05 --img-size 1664 --device 0 --augment --save-txt --save-conf --name inference_yolor_ensemble_v10_dewp_both_private
```



python detect.py --source ../Public_Image/ --weights runs/train/v5x62/weights/best.pt --img 1664 --conf 0.05 --name inference_x_aug --save-txt --save-conf --augment --device cpu


python detect.py --source ../Public_Image/ --img 1664 --weights runs/train/v5s6_adjust/weights/best.pt runs/train/v5m6_adjust/weights/best.pt runs/train/v5l6_adjust/weights/best.pt --img 1664 --conf 0.1 --name inference_s6-m6-l6_aug_conf010 --save-txt --save-conf --augment --device cpu
CUDA_VISIBLE_DEVICES=4 python train.py --batch-size 4 --img 1280 1280 --data custom.yaml --weights yolor-p6-paper-541.pt --device 4 --name yolo_p6 --hyp hyp.scratch.1280.yaml --epochs 100 --workers 0

CUDA_VISIBLE_DEVICES=2,3 python -m torch.distributed.launch --nproc_per_node 2 --master_port 3030 train.py --batch-size 4 --img 1280 1280 --data custom.yaml --weights yolor-w6-paper-555.pt --device 2,3 --sync-bn --name yolor_p6 --hyp hyp.scratch.1280.yaml --epochs 100

# one model All
CUDA_VISIBLE_DEVICES=0 python detect.py --source ../Public_Image/ --weights runs/train/yolor_w6_tune/weights/best.pt runs/train/yolor_w6_tune/weights/best_ap.pt runs/train/yolor_w6_tune/weights/best_ap50.pt runs/train/yolor_w6_tune/weights/best_overall.pt runs/train/yolor_w6_tune/weights/best_f.pt --conf 0.05 --img-size 1664 --device 0 --augment --save-txt --save-conf --name inference_yolor_ensembleAll_f_w6_tune_private

#All
CUDA_VISIBLE_DEVICES=7 python detect.py --source ../Public_Image/ --weights runs/train/yolor_d6/weights/best.pt runs/train/yolor_d6/weights/best_ap.pt runs/train/yolor_d6/weights/best_ap50.pt runs/train/yolor_d6/weights/best_overall.pt runs/train/yolor_w6/weights/best.pt runs/train/yolor_w6/weights/best_ap.pt runs/train/yolor_w6/weights/best_ap50.pt runs/train/yolor_w6/weights/best_overall.pt  runs/train/yolor_e6/weights/best.pt runs/train/yolor_e6/weights/best_ap.pt runs/train/yolor_e6/weights/best_ap50.pt runs/train/yolor_e6/weights/best_overall.pt runs/train/yolor_p6/weights/best.pt runs/train/yolor_p6/weights/best_ap50.pt runs/train/yolor_p6/weights/best_ap.pt runs/train/yolor_p6/weights/best_overall.pt  --conf 0.05 --img-size 1664 --device 7 --augment --save-txt --save-conf --name inference_yolor_ensembleAll_f_d6_w6_e6_p6_private
#All+f
CUDA_VISIBLE_DEVICES=7 python detect.py --source ../Public_Image/ --weights runs/train/yolor_d6/weights/best.pt runs/train/yolor_d6/weights/best_ap.pt runs/train/yolor_d6/weights/best_ap50.pt runs/train/yolor_d6/weights/best_overall.pt runs/train/yolor_d6/weights/best_f.pt runs/train/yolor_w6/weights/best.pt runs/train/yolor_w6/weights/best_ap.pt runs/train/yolor_w6/weights/best_ap50.pt runs/train/yolor_w6/weights/best_overall.pt runs/train/yolor_w6/weights/best_f.pt  runs/train/yolor_e6/weights/best.pt runs/train/yolor_e6/weights/best_ap.pt runs/train/yolor_e6/weights/best_ap50.pt runs/train/yolor_e6/weights/best_overall.pt runs/train/yolor_e6/weights/best_f.pt runs/train/yolor_p6/weights/best.pt runs/train/yolor_p6/weights/best_ap50.pt runs/train/yolor_p6/weights/best_ap.pt runs/train/yolor_p6/weights/best_overall.pt  runs/train/yolor_p6/weights/best_f.pt --conf 0.05 --img-size 1664 --device 7 --augment --save-txt --save-conf --name inference_yolor_ensembleAll_f_d6_w6_e6_p6_private
#All+fpr
CUDA_VISIBLE_DEVICES=7 python detect.py --source ../Public_Image/ --weights runs/train/yolor_d6/weights/best.pt runs/train/yolor_d6/weights/best_ap.pt runs/train/yolor_d6/weights/best_ap50.pt runs/train/yolor_d6/weights/best_overall.pt runs/train/yolor_d6/weights/best_f.pt runs/train/yolor_d6/weights/best_r.pt runs/train/yolor_d6/weights/best_p.pt runs/train/yolor_w6/weights/best.pt runs/train/yolor_w6/weights/best_ap.pt runs/train/yolor_w6/weights/best_ap50.pt runs/train/yolor_w6/weights/best_overall.pt runs/train/yolor_w6/weights/best_f.pt runs/train/yolor_w6/weights/best_r.pt runs/train/yolor_w6/weights/best_p.pt runs/train/yolor_e6/weights/best.pt runs/train/yolor_e6/weights/best_ap.pt runs/train/yolor_e6/weights/best_ap50.pt runs/train/yolor_e6/weights/best_overall.pt runs/train/yolor_e6/weights/best_f.pt runs/train/yolor_e6/weights/best_r.pt runs/train/yolor_e6/weights/best_p.pt runs/train/yolor_p6/weights/best.pt runs/train/yolor_p6/weights/best_ap50.pt runs/train/yolor_p6/weights/best_ap.pt runs/train/yolor_p6/weights/best_overall.pt  runs/train/yolor_p6/weights/best_f.pt runs/train/yolor_p6/weights/best_r.pt runs/train/yolor_p6/weights/best_p.pt --conf 0.05 --img-size 1664 --device 7 --augment --save-txt --save-conf --name inference_yolor_ensembleAll_frp_d6_w6_e6_p6_private

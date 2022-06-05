python train.py --img 640 --batch 32 --epochs 100 --data data/custom.yaml --weights yolov5x.pt --workers 0 --hyp ./data/hyps/hyp.scratch-high.yaml
CUDA_VISIBLE_DEVICES=4,5 python -m torch.distributed.launch --nproc_per_node 2 train.py --img 1280 --batch 4 --epochs 100 --data data/custom.yaml --weights yolov5m6.pt --name yolov5m6_adjust --workers 0 --hyp ./data/hyps/hyp.scratch-high.yaml --exist-ok --device 4,5

## transformer
python train.py --img 1280 --batch 8 --epochs 300 --data data/custom.yaml --weights yolov5s6.pt --cfg yolov5s-transformer.yaml --name yolov5s-transformer_aug --workers 4 --hyp ./data/hyps/hyp.scratch-high.yaml

python train.py --img 1280 --batch 16 --epochs 300 --data data/custom.yaml --weights yolov5l6.pt --cfg yolov5l-transformer.yaml --name yolov5l-transformer_aug --workers 4 --hyp ./data/hyps/hyp.scratch-high.yaml
import os
import glob
import json

from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("--type",type=str)
parser.add_argument("--target",type=str)
parser.add_argument("--output",type=str)

args = parser.parse_args()

L = sorted(glob.glob(f"{args.type}/runs/detect/{args.target}/*.jpg"))
print(L[0]<L[1])
print(L)
print(len(L))


D = {}
for i in range(len(os.listdir(f"Public_Image"))):
    L[i] = os.path.basename(L[i])
    if(os.path.exists(f"{args.type}/runs/detect/{args.target}/labels/{L[i].split('.')[0]}.txt")==False):
        D[L[i]]=[]
        print(L[i])
        continue
    with open(f"{args.type}/runs/detect/{args.target}/labels/{L[i].split('.')[0]}.txt") as f:
        ans = f.readlines()
    for j in range(len(ans)):
        ans[j] = [eval(x) for x in ans[j].strip().split()]
    assert len(ans)<=200
    D[L[i]] = ans
with open(args.output,"w") as f:
    json.dump(D,f)

# For GCP

First we need to create a gpu instance 
For this example we will use a L4 spot instance which is fairly cheap


Login to the instance 

Replace the model with the one you want to use available models are listed below

llama-2-7b
llama-2-13b
llama-2-70b
llama-2-7b-chat
llama-2-13b-chat
llama-2-70b-chat

Copy the model from our GCS 
```
gsutil -m cp -r gs://llama-pajama/llama-2-7b .
```
Change directory to the model directoy
```
cd llama-2-7b
```
Verify the integrity of the data transferred
```
md5sum -c checklist.chk
```
when the checksum is finished you should see something like this where each file is listed and says OK next to it
```
consolidated.00.pth: OK
params.json: OK
```

Now we have a model

```
gcloud compute instances create llama13ba100-40gb \
    --project=optimum-entity-397317 \
    --zone=us-central1-a \
    --machine-type=a2-highgpu-1g \
    --network-interface=address=34.132.87.213,network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --metadata=ssh-keys=jeffp:ssh-rsa\ \
AAAAB3NzaC1yc2EAAAADAQABAAACAQDN710Bj6S3cSx8AtmmYr\+EieAu4XwNTViw3wMjzhLfATZpxkbGRZKNkhnkfTDi62rWYx6juobsQl/h4G77j7Uq56f3mpOQcGyFjifvFpcNa0Lgw\+YTpAJW920WfrJWfNSxgp7JmKnxbIh0gInLm9/kFit8dkbXCbm7zXvLVRuVOH38D0KKCbeEp8riUJw1R9U0zuuiUWzdlmq46QGChQji\+JnQlOo1fveeyePH1g91wlyo9qPqSSGsz\+24DLiVzMgf1sIHBS0cvbyFkvTu0GlRzJYdSNQA0dEntc3pfGeEiWzfbxJPgibq32TSQMNE3ek9UCtmeVGeiizU9QKxHwVAe0Opyqtngbd/K4Y0ASwQhBj4u3nqs\+JBYsMQUCwp0Q\+EXbPO6rtkCzl3dDrVErHghcAs5U/zy1RcMFLlW6Miqc2VX/x0IURRVNLx8htmLDXkmx6wkt9GInWcKKfT4cdL72FHrX6U\+ti9HKXrqKKAz4YTYcXD5GmabRPEnx3M52Q8JFHaLHGdtYuemX3UV\+6BN92pBSEU10dfPLUgGnVtzaEL4FEmOHjhf7uk2gx6lpBk4HPu521p7ZXOCX3984J56xElxZUgyzP6biGocUi/VHEuDIWizvLc0mDgDfuBApkzq1tGItjZqChkBsGGpMV\+UYQSaMZyB1GioNb2/K/dmw==\ jeffp@biocode.ca \
    --no-restart-on-failure \
    --maintenance-policy=TERMINATE \
    --provisioning-model=SPOT \
    --instance-termination-action=DELETE \
    --max-run-duration=7200s \
    --service-account=1042886631329-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --accelerator=count=1,type=nvidia-tesla-a100 \
    --create-disk=auto-delete=yes,boot=yes,device-name=llama13ba100-40gb,image=projects/ml-images/global/images/c0-deeplearning-common-gpu-v20230822-debian-11-py310,mode=rw,size=256,type=projects/optimum-entity-397317/zones/us-central1-a/diskTypes/pd-ssd \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=goog-ec-src=vm_add-gcloud \
    --reservation-affinity=any
```

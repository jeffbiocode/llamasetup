# For GCP
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



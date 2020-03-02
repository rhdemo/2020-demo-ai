# 2020-demo-ai


## Deployment  
```
oc create -f https://raw.githubusercontent.com/rhdemo/2020-demo-ai/install/deployment.yml
oc new-app --template=digit-recognition-server \
    --param=APPLICATION_NAME=tf-cnn \
    --param=IMAGE_REPOSITORY=quay.io/redhatdemo/2020-digit-recognition:latest \
    --param=TF_CPP_MIN_VLOG_LEVEL=2

oc create route passthrough tf-cnn --port=8501-tcp  --service=tf-cnn-rest 
# oc set env dc/tf-cnn TF_CPP_MIN_VLOG_LEVEL=3 or 1
```
## cleanup
```
oc delete template digit-recognition-server
oc delete all -l app=tf-cnn
oc delete route tf-cnn
```
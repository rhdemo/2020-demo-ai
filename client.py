import numpy as np
import json
import requests


# curl -d '{"signature_name":"predict_images","instances":[{"images":[0,0,0,0,0....
#   0,0,0],"keep_prob":[1]}]}'
#   -X POST http://tf-cnn-frontend.apps.summit-demo2.openshift.redhatkeynote.com/v1/models/mnist:predict
image=[]
URL = "http://tf-cnn-frontend.apps.summit-demo2.openshift.redhatkeynote.com/v1/models/mnist:predict"
data_dict = {'signature_name': 'predict_images','instances': [{'images': image, 'keep_prob': [1.0]}]}
r = requests.post(url = URL, data = json.dumps(data_dict))
output = r.text
output=json.loads(output)
pred=output["predictions"][0]
prediction = np.argmax(pred)
print("The prediction is:%s"%prediction)



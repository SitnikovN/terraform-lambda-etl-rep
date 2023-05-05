import json
import pandas as pd

def lambda_handler(event, context):
    d = {'a':[1,2,3],'b':[4,5,6]}
    df = pd.DataFrame(data=d)
    print(df)
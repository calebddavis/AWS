import urllib

ACCESS_KEY = "XXXXXXXXXXXXXXXXXX"

SECRET_KEY = "XXXXXxxxXxxXXXxxXXxxxXXXXxxX"

!pip install boto3

import boto3
import json
from datetime import datetime
import calendar
import random
import time
import uuid
import requests

# The name of the stream will be 
my_stream_name = 'data-stream'

# Our Kinesis client, name and info
kinesis_client = boto3.client('kinesis', region_name='us-east-1')

# Create the Stream
kinesis_client.create_stream(
    StreamName=my_stream_name,
    ShardCount=1
)

#fix creds 

#Adding Api producer
url = 'https://api.worldtradingdata.com/api/v1/stock'
params = {
    'symbol': 'SNAP',
    'api_token': 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
    }
#add api 
def put_to_stream(kin_client):
    record = {
        #feilds 
      
    }
    kinesis_client.put_record(
        StreamName=my_stream_name,
        Data=json.dumps(record),
        PartitionKey='a-partition'
    )

i = 0
while i < 20:
    i += 1
    put_to_stream(kinesis_client)
    time.sleep(.3)

# when we get some information on the stream required to read data from it
#change
response = kinesis_client.describe_stream(StreamName=my_stream_name)
my_shard_id = response['StreamDescription']['Shards'][0]['ShardId']

# With the shard id then you can get the shard iterator to actually review the data
shard_iterator = kinesis_client.get_shard_iterator(
    StreamName=my_stream_name,
    ShardId=my_shard_id,
    ShardIteratorType='TRIM_HORIZON'
)

my_shard_iterator = shard_iterator['ShardIterator']

# Now we can actually look at the data inside the Kinesis data stream
record_response = kinesis_client.get_records(
    ShardIterator=my_shard_iterator,
    Limit=1
)

# Iterate over all the data 1 at a time 
while 'NextShardIterator' in record_response:
    record_response = kinesis_client.get_records(
        ShardIterator=record_response['NextShardIterator'],
        Limit=1
    )
    print(record_response)
    print('')
    print(record_response['Records'][0]['Data'])
    print('\n\n')
    time.sleep(5)

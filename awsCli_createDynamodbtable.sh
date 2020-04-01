CreateTable - API Call/aws_cli

Task:create a dynamodb table for an online exotic pet store 

Table Name: PetInventory

Attributes: this will define the name and datatype of PK and SK if they are used
Name:pet_sepecies
Type: String,
Name: pet_id 
Type: Number

Key shemas: define which attibute fills which role contist of an attibute name and keytype
Patition Key: pet_species 
Sort Key: pet_id

Billing mode: can be provisioned or on-demand(used when demand not known) default is provisioned 
Billing Mode: On Demand 

#aws cli
#ssh to ec2

ssh hostname@ip 

#S is string type
#N is number type
# for key type in cli/sdks/cloudformation templates, keys are called HASH and RANGE istead of primary and sort key 
#billing mode is ref to as PAY_PER_REQUEST instead of on-demand mode otherwise its ref to as PROVISIONED

aws dynamodb\
    create-table\
        --table-name PetInventory\
        --attribute-definitions\
            AttributeName=pet_species,AttributeType=S\
            AttributeName=pet_id,AttributeType=N\
        --key-schema\
            AttributeName=pet_species,KeyType=HASH\
            AttributeName=pet_id,KeyType=RANGE\
        --billing-mode PAY_PER_REQUEST

#output: we get back a json document that describes the table 
#for Creation dame time we have the unix epoch notation of the time it was created 

#output:

{
    "TableDescription": {
        "TableArn": "arn:aws:dynamodb:us-east-1:132802488349:table/PetInventory", 
        "AttributeDefinitions": [
            {
                "AttributeName": "pet_id", 
                "AttributeType": "S"
            }, 
            {
                "AttributeName": "pet_species", 
                "AttributeType": "S"
            }
        ], 
        "ProvisionedThroughput": {
            "NumberOfDecreasesToday": 0, 
            "WriteCapacityUnits": 0, 
            "ReadCapacityUnits": 0
        }, 
        "TableSizeBytes": 0, 
        "TableName": "PetInventory", 
        "BillingModeSummary": {
            "BillingMode": "PAY_PER_REQUEST"
        }, 
        "TableStatus": "CREATING", 
        "TableId": "5f68de3e-15e4-4e90-9151-62446ef69d9a", 
        "KeySchema": [
            {
                "KeyType": "HASH", 
                "AttributeName": "pet_species"
            }, 
            {
                "KeyType": "RANGE", 
                "AttributeName": "pet_id"
            }
        ], 
        "ItemCount": 0, 
        "CreationDateTime": 1585762648.89
    }
}

#describe the table to check on it do

aws dynamodb describe-table --table-name PetInventory

#output is the same 
#but the Billing mode summary get something new its the last update to the billing
#"LastUpdateToPayPerRequestDateTime"

#output:

{
    "Table": {
        "TableArn": "arn:aws:dynamodb:us-east-1:132802488349:table/PetInventory", 
        "AttributeDefinitions": [
            {
                "AttributeName": "pet_id", 
                "AttributeType": "S"
            }, 
            {
                "AttributeName": "pet_species", 
                "AttributeType": "S"
            }
        ], 
        "ProvisionedThroughput": {
            "NumberOfDecreasesToday": 0, 
            "WriteCapacityUnits": 0, 
            "ReadCapacityUnits": 0
        }, 
        "TableSizeBytes": 0, 
        "TableName": "PetInventory", 
        "BillingModeSummary": {
            "LastUpdateToPayPerRequestDateTime": 1585762648.89, 
            "BillingMode": "PAY_PER_REQUEST"
        }, 
        "TableStatus": "ACTIVE", 
        "TableId": "5f68de3e-15e4-4e90-9151-62446ef69d9a", 
        "KeySchema": [
            {
                "KeyType": "HASH", 
                "AttributeName": "pet_species"
            }, 
            {
                "KeyType": "RANGE", 
                "AttributeName": "pet_id"
            }
        ], 
        "ItemCount": 0, 
        "CreationDateTime": 1585762648.89
    }
}

#to list tables in dynamodb 
#jsut shows list of table names we have 1

aws dynamodb list-tables

#output:

{
    "TableNames": [
        "PetInventory"
    ]
}

#query dynamodb
#we take out the data that we want from the return json object 
#in this format we are providing keys 
#here we have from our table object our partition key lable with the index 0 that we want, attibute name, we have our attribute definitions as index 1, attibute name, attribute name, the sort key type, attribute name of that, lastly the billing mode summary

-Partitionkey,partkeytype,
-SortKey,sortkeytype
-BilingMode
#each index 0 or 1 refers to a type S(1)  

#query section is a json query  
aws dynamodb describe-table --table-name PetInventory --query 'Table.{PartitionKey:KeySchema[0].AttributeName,PartKeyType:AttributeDefinitions[1].AttributeType,SortKey:KeySchema[1].AttributeName,SortKeyType:AttributeDefinitions[0].AttributeType,BillingMode:BillingModeSummary.BillingMode}'

#output:
{
    "SortKeyType": "N",
    "PartitionKey": "pet_species",
    "BillingMode": "PAY_PER_REQUEST",
    "SortKey": "pet_id",
    "PartKeyType": "S"
}

#deleting a table 
aws dynamodb delete-table --table-name PetInventory

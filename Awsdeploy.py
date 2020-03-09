#!/bin/python3

import boto3
from time import sleep
import requests
import os

def deploy(id,num,type,key):
    ec2 = boto3.resource('ec2')
    instance = ec2.create_instances(
    ImageId = id,
    MinCount = 1,
    MaxCount = num,
    InstanceType=type,
    KeyName=key,
    SecurityGroups='ssh')
    print('New instanceID IS : ' + instance[0].id)


def stop():
    id = input('Enter the id that you want to stop : ')
    ids = [id]
    ec2 = boto3.resource('ec2')
    ec2.instances.filter(InstanceIds = ids).stop()

def start():
    id = input('Enter id that you want to start : ')
    ids = [id]
    ec2 = boto3.resource('ec2')
    ec2.instances.filter(InstanceIds = ids).start()

def reboot():
    id = input('Enter the ID that you want to reboot : ')
    ids = [id]
    ec2 = boto3.resource('ec2')
    ec2.instances.filter(InstanceIds = ids).reboot()

def terminate():
    id = input('Enter the ID that you want to terminate : ')
    ids = [id]
    ec2 = boto3.resource('ec2')
    ec2.instances.filter(InstanceIds = ids).terminate()

def show():
    print('----------------------\nThese are the machines :')
    ec2 = boto3.resource('ec2')
    for instance in ec2.instances.all():
        print (instance.id , instance.state)

def get_key():
    print("These are the keys :")
    ec2 = boto3.client('ec2')
    response = ec2.describe_key_pairs()
    for i in response['KeyPairs']:
        print("\nKey: " + i['KeyName'])
    return(response)


#def regions():

               ######### Menu #########


while True:
    print("------------------------")
    print("1.deploy machhin\n2.stop Instances\n3.start Instances\n4.reboot Instances\n5.terminate Instances\n6.Show instances\n7.Show keys\n8.Exit")
    print("------------------------")
    sleep(1)
    choose = input("Enter 1 - 6 Pls :")
    if choose == "1":
        get_key()
        print("Choose key...")
        deploy(input("Enter AMI id: "),int(input("Enter how many machines: ")),input("Enter type: "),input("Key type :"))
        quit=input("Do you want to quit? (y/n):")
        if quit == "y" or quit == "yes":
            print("Bye Bye")
            break
        elif quit =="n" or quit =="no":
            continue
        else:
            print("Enter (yes/no) only !")

    elif choose == "2":
        show()
        stop()


    elif choose == "3":
        show()
        start()


    elif choose == "4":
        show()
        reboot()

    elif choose == "5":
        show()
        terminate()

    elif choose == "6":
        show()

    elif choose == "7":
        get_key()


    elif choose == "8":
        print("Bye Bye")
        break

    else:
        print ("enter 1-8 only")

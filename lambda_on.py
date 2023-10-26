import boto3
import os

ecs_cluster = os.environ["ECS_CLUSTER"]

def update_ecs_service(ecs_cluster, ecs_service):
    ecs = boto3.client('ecs')
    update_service = ecs.update_service(
        cluster=ecs_cluster,
        service=ecs_service,
        desiredCount=1,
    )
    print('Service updated:', ecs_service)

def lambda_handler(event, context):
    ecs = boto3.client('ecs')
    print('Turning ON cluster:', ecs_cluster)
    
    services = ecs.list_services(
        cluster=ecs_cluster,
        maxResults=50,
    )

    for service in services.get('serviceArns'):
        print('Turning ON service:', service[43:])
        update_ecs_service(ecs_cluster, service)

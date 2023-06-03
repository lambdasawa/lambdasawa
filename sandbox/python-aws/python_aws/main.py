import datetime
from itertools import chain
import json
import boto3
import sys

def default():
    raise Exception("Unknown arguments")


def use_cost_explorer():
    client = boto3.client('ce')

    current_month = datetime.now().replace(day=1)
    current_month_first_day = current_month.strftime('%Y-%m-%d')

    next_month = current_month.replace(month=current_month.month+1)
    next_month_first_day = next_month.strftime('%Y-%m-%d')

    response = client.get_cost_and_usage(
        TimePeriod={
            'Start': current_month_first_day,
            'End': next_month_first_day
        },
        Granularity='DAILY',
        GroupBy=[
            {
                'Type': 'DIMENSION',
                'Key': 'SERVICE'
            },
        ],
        Metrics=['NetUnblendedCost'],
    )
    json_string = json.dumps(response, sort_keys=True, indent=2)
    print(json_string)

    def convert_result_to_groups(result):
        return [
            [
                result['TimePeriod']['Start'],
                result['TimePeriod']['End'],
                group['Keys'][0],
                group['Metrics']['NetUnblendedCost']['Amount'],
                group['Metrics']['NetUnblendedCost']['Unit'],
            ] for group in result['Groups'] if len(result['Groups']) > 0
        ]

    def response_to_csv_records(response):
        return list(chain(*[convert_result_to_groups(result) for result in response['ResultsByTime']]))

    csv_records =  response_to_csv_records(response)
    print(csv_records)

if __name__ == "__main__":
    {
        "ce": use_cost_explorer,
    }.get(sys.argv[1], default)()

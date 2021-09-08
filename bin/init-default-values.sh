#!/bin/bash

# options:
aws_profile=""
aws_account_id=""
domain_url=""
hosted_zone_id=""

# get options:
while (( "$#" )); do
    case "$1" in
        -p|--profile)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                aws_profile=$2
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
            ;;
        -a|--account)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                aws_account_id=$2
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
            ;;
        -d|--domain)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                domain_url=$2
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
            ;;
        -h|--help)
            echo "Usage:  $0 -i <input> [options]" >&2
            echo "        -p | --profile  %  (set profile to ...)" >&2
            echo "        -l | --account  %  (set aws account of ...)" >&2
            echo "        -d | --debug     (debug mode)" >&2
            exit 0
            ;;
        -*|--*) # unsupported flags
            echo "Error: Unsupported flag: $1" >&2
            echo "$0 -h for help message" >&2
            exit 1
            ;;
        *)
            echo "Error: Arguments with not proper flag: $1" >&2
            echo "$0 -h for help message" >&2
            exit 1
            ;;
    esac
done


if [ -z $aws_profile ]; then
	    echo "aws_profile is empty"
        exit 1
fi

hosted_zone_id="$(aws route53 --profile=$aws_profile list-hosted-zones-by-name | jq --arg name $domain_url -r '.HostedZones | .[] | select(.Name=="\($name)") | .Id')"

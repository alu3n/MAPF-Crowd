import argparse
import json
from directed_graph import drawDirectedGraph

parser = argparse.ArgumentParser()
parser.add_argument("-f","--file",required=True)

if __name__ == "__main__":
    parser.parse_args()
    args = parser.parse_args()

    # try:
    with open(args.file, 'r') as file:
        data = json.load(file)       
        drawDirectedGraph(data)
    # except:
    #     print("There was a problem while loading your data.")

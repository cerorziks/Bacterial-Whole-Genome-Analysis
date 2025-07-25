import json
import glob
import pandas as pd
import os

# Path to your JSON report directory
json_dir = "/home/genomic/WGS/fastq/fastp_out/fastp_json"
json_files = glob.glob(os.path.join(json_dir, "*.json"))

summary_data = []

for jf in json_files:
    with open(jf) as f:
        data = json.load(f)
        sample = os.path.basename(jf).replace("_fastp.json", "")
        summary_data.append({
            "Sample": sample,
            "Total Reads": data['summary']['before_filtering']['total_reads'],
            "Q20 Rate (%)": round(data['summary']['before_filtering']['q20_rate'] * 100, 2),
            "Q30 Rate (%)": round(data['summary']['before_filtering']['q30_rate'] * 100, 2),
            "Filtered Reads": data['summary']['after_filtering']['total_reads'],
            "Duplication Rate (%)": round(data.get('duplication', {}).get('rate', 0) * 100, 2),
            "Adapter Content (%)": round(data['adapter_cutting'].get('adapter_rate', 0) * 100, 2),
        })

df = pd.DataFrame(summary_data)
df.sort_values("Sample", inplace=True)
df.to_csv("fastp_summary.csv", index=False)

print("fastp_summary.csv created.")

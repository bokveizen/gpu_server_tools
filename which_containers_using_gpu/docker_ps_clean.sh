( printf "NAMES\tIMAGE\tSTATUS\tPORTS\n" ; \
  docker ps --format '{{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}' ) \
| awk -F'\t' 'NR==1{print; next}{
  ports=$4; gsub(/\[::\]:/,"0.0.0.0:",ports); n=split(ports,a,/, /)
  delete seen; out=""
  for(i=1;i<=n;i++){
    p=a[i]; if(p=="")continue
    if(p ~ /^0\.0\.0\.0:[0-9]+->[0-9]+\/tcp$/){ hp=p; sub(/^0\.0\.0\.0:/,"",hp); sub(/\/tcp$/,"",hp); key=hp }
    else if(p ~ /^[0-9]+\/tcp$/){ hp=p; key=hp } else { hp=p; key=hp }
    if(!(key in seen)){ seen[key]=1; out = out (out?", ":"") hp }
  }
  print $1 "\t" $2 "\t" $3 "\t" out
}' | column -t -s $'\t'
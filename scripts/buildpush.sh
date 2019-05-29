docker login
docker build -t tpageforfunzies/kubewatcharmhf:v2 .
docker push tpageforfunzies/kubewatcharmhf:v2
echo "DONE"
init()
{
    echo "json-api-options:" >> $HOME/my-app/daml.yaml
    echo "- --address=0.0.0.0" >> $HOME/my-app/daml.yaml

    echo "DANGEROUSLY_DISABLE_HOST_CHECK=true" >> $HOME/my-app/ui/.env
    sed -i 's+ws://localhost:7575/+wss://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/+g' $HOME/my-app/ui/src/config.ts
}
echo Initialising...
init
echo Done!
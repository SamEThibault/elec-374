if [ $1 -eq 0 ]
then
    git add . && git commit -m "default commit msg" && git push
else
        git add . && git commit -m $1 && git push
fi
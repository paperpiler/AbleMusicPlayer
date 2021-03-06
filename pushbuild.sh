if [ -d app/build/outputs/apk/release ]; then
        if [ -n "$(ls -A app/build/outputs/apk/release)" ]; then
          mkdir ~/tmp
	  mv app/build/outputs/apk/release/*.apk ~/tmp/AbleMusic-${1}-$(echo $GITHUB_SHA | cut -c1-6).apk
          rm -rf app/build/outputs/apk
	  git clone https://github.com/uditkarode/AbleMusicPlayer -b builds
	  cd AbleMusicPlayer 
          rm -f AbleMusic-${1}-*.apk
	  mv ~/tmp/* .
          git add .
          git config --global user.name 'Bob The Builder'
          git config --global user.email 'bob@the.builder'
          git remote set-url origin "https://x-access-token:${GH_TOKEN}@github.com/${GH_REPO}"
	  git commit -m "bot: build arch: ${1} <$(echo $GITHUB_SHA | cut -c1-6)>"
          git push -u origin builds
	  cd ..
	  rm -rf AbleMusicPlayer
	  rm -rf ~/tmp
	fi
fi

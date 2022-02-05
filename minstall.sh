read -p "Mindustry version: " ver;
rm -f Mindustry.jar;
wget -q --show-progress https://github.com/Anuken/Mindustry/releases/download/v"$ver"/Mindustry.jar -o Mindustryv"$ver".jar;

#!/system/bin/sh

soc=$(getprop ro.soc.model)
[ -z "$soc" ] && soc=$(grep -i "Hardware" /proc/cpuinfo | awk '{print $NF}')

vendor=$(getprop ro.soc.manufacturer)
[ -z "$vendor" ] && vendor="Unknown"

case "$vendor" in
  QTI|Qualcomm*) vendor="Qualcomm" ;;
  MediaTek*) vendor="MediaTek" ;;
  samsung*|Samsung*) vendor="Samsung" ;;
esac

name="Unknown"

case "$soc" in
  SM8750) name="Snapdragon 8 Elite" ;;
  SM8650) name="Snapdragon 8 Gen 3" ;;
  SM8635) name="Snapdragon 8s Gen 3" ;;
  SM8550) name="Snapdragon 8 Gen 2" ;;
  SM8475) name="Snapdragon 8+ Gen 1" ;;
  SM8450) name="Snapdragon 8 Gen 1" ;;
  SM7675) name="Snapdragon 7+ Gen 3" ;;
  SM7550) name="Snapdragon 7 Gen 3" ;;
  SM7475) name="Snapdragon 7 Gen 2" ;;
  SM7435) name="Snapdragon 7s Gen 2" ;;
  SM6450) name="Snapdragon 6 Gen 1" ;;
  SM6375) name="Snapdragon 6s Gen 3" ;;
  SM6225) name="Snapdragon 680" ;;
  SM6115) name="Snapdragon 662" ;;

  MT6989) name="Dimensity 9300" ;;
  MT6983) name="Dimensity 9000" ;;
  MT6978) name="Dimensity 9200+" ;;
  MT6897) name="Dimensity 8300 Ultra" ;;
  MT6895) name="Dimensity 8200" ;;
  MT6877) name="Dimensity 7050" ;;
  MT6873) name="Dimensity 1080" ;;
  MT6872) name="Dimensity 920" ;;
  MT6853) name="Dimensity 700" ;;
  MT6789) name="Helio G99" ;;
  MT6769) name="Helio G80" ;;
  MT6765) name="Helio G35" ;;

  S5E9945) name="Exynos 2400" ;;
  S5E9925) name="Exynos 2200" ;;
  S5E8845) name="Exynos 1480" ;;
  S5E8835) name="Exynos 1380" ;;
  S5E8825) name="Exynos 1280" ;;
  S5E8815) name="Exynos 1330" ;;
esac

[ "$name" = "Unknown" ] && name="Unknown ($soc)"

cores=$(nproc 2>/dev/null)
[ -z "$cores" ] && cores=$(grep -c ^processor /proc/cpuinfo)

freq=$(cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_max_freq 2>/dev/null | sort -nr | head -n1)
if [ -n "$freq" ]; then
  freq=$(awk "BEGIN{printf \"%.2f\", $freq/1000000}")
  freq="@ $freq GHz"
else
  freq=""
fi

echo "CPU: $vendor $name [$soc] ($cores) $freq"

function win
  read -n 1 -l -P 'Deseja reiniciar para o Windows: [s/N] ' confirm

  if test "$confirm" = "S" -o "$confirm" = "s" -o "$confirm" = "Y" -o "$confirm" = "y"
    sudo efibootmgr -n 0003 > /dev/null &&
      qdbus-qt6 org.kde.Shutdown /Shutdown logoutAndReboot
    end
end

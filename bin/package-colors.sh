getPkgName() {
  case $1 in
    Ice-GE)     pkgName="" ;;
    Classic-GE) pkgName="" ;;
    Amber-Dark) pkgName="" ;;
    CatMocha)   pkgName="" ;;
    CatLatte)
      pkgName=Catppuccin
      dirName=Cat
      ;;
    *)
      pkgName=$color
      dirName=$color
  esac
}

# How to create a package with LemonPack :

## You need :

- Your app (have to be path independent if your app require to be in a specific folder it won't work for now !)
- tar
- an icon for your app
- filled app info (see below)

## There is a simple structure to respect in your app package : 

        
      your app 
              |___ App
              |       |___ ( Your app files )
              |
              |___ Assets
              |          |___ Icon
              |          |        |___ appicon.png (icon of your app)
              |          |
              |          |___ Info
              |                   |___ appname.txt (contain the proper name of your app)
              |                   |___ author.txt (contain the author of the package)
              |                   |___ env.txt (contain the environement (currently not implemented) )
              |                   |___ packageid.txt (contain the id of your package)
              |                   |___ permission.txt (contain the permissions (currently not implemented) )
              |                   |___ soft-info.txt (contain the description about your software)
              |                   |___ startupvmclass.txt (contain the VMclass for the window manager)
              |                   |___ type.txt (contain the type of the application (Refer to freedesktop standard) )
              |                   |___ ver.txt (contain the version of your app (currently not implemented) )
              |
              |___ Launcher (contain launch informations for your app)

        
## Package the application

Compress your folder in tar.xz and rename the tar.xz in lem

Enjoy your new app !

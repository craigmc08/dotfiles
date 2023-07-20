{ lib, config, ... }: {
  settings = {
    width = 480;
    height = 250;
    location = "center";
    show = "drun";
    prompt = "Search...";
    filter_rate = 100;
    allow_markup = true;
    no_actions = true;
    halign = "fill";
    orientation = "vertical";
    content_halign = "fill";
    insensitive = true;
    allow_images = true;
    image_size = 40;
    gtk_dark = true;
  };

  style = with config.style;
    "	* {\n		font-family: 'FiraCode Nerd Font Mono';\n		font-size: 13px;\n	}\n\n	window {\n		margin: 0px;\n		border: 5px solid #${primaryColor};\n		background-color: #${primaryColor};\n		border-radius: 15px;\n	}\n\n	#input {\n		padding: 4px\n		margin: 4px;\n		padding-left: 20px;\n		border: none;\n		color: #fff;\n		font-weight: bold;\n		background: linear-gradient(90deg, #${primaryColor}, #${primaryColorLight});\n		border-radius: 15px;\n		margin: 10px;\n		margin-bottom: 2px;\n	}\n	#input:focus {\n		border: 0px solid #fff;\n		margin-bottom: 2px;\n	}\n\n	#inner-box {\n		margin: 4px;\n		border: 10px solid #fff;\n		color: #${primaryColor};\n		font-weight: bold;\n		background-color: #fff;\n		border-radius: 15px;\n	}\n\n	#outer-box {\n		margin: 0;\n		border: none;\n		border-radius: 15px;\n		background-color: #fff;\n	}\n\n	#scroll {\n		margin-top: 5px;\n		border: none;\n		border-radius: 15px;\n		margin-bottom: 5px;\n	}\n\n	#text:selected {\n		color: #fff;\n		margin: 0px 0px;\n		border: none;\n		border-radius: 15px;\n	}\n\n	#entry {\n		margin: 0px 0px;\n		padding: 5px 10px;\n		border: none;\n		border-radius: 15px;\n		background-color: transparent;\n	}\n\n	#entry:selected {\n		margin: 0px 0px;\n		border: none;\n		border-radius: 15px;\n		background: linear-gradient(90deg, #${primaryColor}, #${primaryColorLight});\n	}\n";
}

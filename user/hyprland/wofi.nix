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

  style = with config.style; ''
    * {
  		font-family: 'FiraCode Nerd Font Mono';
  		font-size: 13px;
  	}
  	window {
  		margin: 0px;
  		border: 5px solid #${primaryColor};
  		background-color: #${primaryColor};
  		border-radius: 15px;
  	}
  	#input {
  		padding: 4px
  		margin: 4px;
  		padding-left: 20px;
  		border: none;
  		color: #fff;
  		font-weight: bold;
  		background: linear-gradient(90deg, #${primaryColor}, #${primaryColorLight});
  		border-radius: 15px;
  		margin: 10px;
  		margin-bottom: 2px;
  	}
  	#input:focus {
  		border: 0px solid #fff;
  		margin-bottom: 2px;
  	}
  	#inner-box {
  		margin: 4px;
  		border: 10px solid #fff;
  		color: #${primaryColor};
  		font-weight: bold;
  		background-color: #fff;
  		border-radius: 15px;
  	}
  	#outer-box {
  		margin: 0;
  		border: none;
  		border-radius: 15px;
  		background-color: #fff;
  	}
  	#scroll {
  		margin-top: 5px;
  		border: none;
  		border-radius: 15px;
  		margin-bottom: 5px;
  	}
  	#text:selected {
  		color: #fff;
  		margin: 0px 0px;
  		border: none;
  		border-radius: 15px;
  	}
  	#entry {
  		margin: 0px 0px;
  		padding: 5px 10px;
  		border: none;
  		border-radius: 15px;
  		background-color: transparent;
  	}
  	#entry:selected {
  		margin: 0px 0px;
  		border: none;
  		border-radius: 15px;
  		background: linear-gradient(90deg, #${primaryColor}, #${primaryColorLight});
  	}
  '';
}

{ lib, ... }:

rec {
	types.hexColor = lib.types.mkOptionType {
		name = "hexColor";
		description = "hex color RGB[A] color code, starting with #";
		descriptionClass = "noun";
		# TODO: more specific checks?
		check = lib.isString;
		merge = lib.options.mergeEqualOption;
	};

	hex2hypr = hexColor:
		let hexRGBA = if builtins.stringLength hexColor == 7
										then hexColor + "ff"
										else hexColor;
		in "rgba(${lib.strings.removePrefix "#" hexRGBA})";
}

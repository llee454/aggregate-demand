product_pref_out.md: product_pref.md
	GUILE_LOAD_PATH=. amina --warn --no-json --init=init.scm --template=product_pref.md > product_pref_out.md
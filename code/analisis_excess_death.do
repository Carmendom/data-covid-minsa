* ===========================================================================
* Series por distrito en Lima
* ===========================================================================
	include common.doh

	use "$data_path/totaL_muertes_no_violentas"

	gen t = date // wofd(date)
	su t
	drop if t == r(max) // week not ended
	
	gen day = doy(date)
	gen week = week(date)
	gen year = year(date)
	*format %tw week

	loc t day
	loc fmt 0(1000)6000
	loc fmt 0(100)1000
	gcollapse (sum) deaths, by(year `t') fast

	tw	///
		(line deaths `t' if year == 2017, lc(gs8) lw(medium)) ///
		(line deaths `t' if year == 2018, lc(gs6) lw(medium)) ///
		(line deaths `t' if year == 2019, lc(gs4) lw(medium)) ///
		(line deaths `t' if year == 2020, lc(orange) lw(medium)) ///
		`cmd' ///
		, ///
		title("Muertes no violentas por dia (2017-2020)") yscale(range(0 0)) ///
		xtitle("Dia") ///
		ytitle("Casos", margin(right) ) ///
		xlabel(1(31)360) ///
		ylabel(`fmt', format(%6.0fc) angle(horizontal)) ///
		scheme(s2color) ///
		graphregion(fcolor(white) lc(white) ifcolor(white) ilc(white) margin(sides)) ///
		legend(order(1 "2017" 2 "2018" 3 "2019" 4 "2020")  rows(1) region(fcolor(white) lcolor(white)) ) ///
		xsize(20) ysize(16)

	graph export "../figures/excess_mortality.png", replace width(2000)
	graph export "../figures/excess_mortality.pdf", replace

exit

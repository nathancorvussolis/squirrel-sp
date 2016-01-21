/*
Test : UTF-16 Surrogate Pair Patch for Windows Unicode Build

俱 U+4FF1
剝 U+525D
𠮟 U+20B9F
吞 U+541E
噓 U+5653
姸 U+59F8
屛 U+5C5B
幷 U+5E77
瘦 U+7626
繫 U+7E6B
𩸕 U+29E15
𩸽 U+29E3D
*/

local s = "俱剝𠮟吞噓姸屛幷瘦繫𩸕𩸽";
foreach(sss in s)
{
	print(format("%X ", sss));
	print("\n");
}
print("\n");

local i;
local r;

print("search [<U+20B9F>-<U+29E3D>]\n");
i=0;
while( r = regexp("[𠮟-𩸽]").search(s, i) )
{
	i = r.end;
	print(format(" %d-%d ", r.begin, r.end));
	print("\n");

	local ss = s.slice(r.begin, r.end);
	foreach(sss in ss)
	{
		print(format("%X ", sss));
		print("\n");
	}
}
print("\n");

print("search <U+20B9F>\n");
i=0;
while( r = regexp("𠮟").search(s, i) )
{
	i = r.end;
	print(format(" %d-%d ", r.begin, r.end));
	print("\n");

	local ss = s.slice(r.begin, r.end);
	foreach(sss in ss)
	{
		print(format("%X ", sss));
		print("\n");
	}
}
print("\n");

print("match .*<U+29E15><U+29E3D>\n");
print(regexp(".*𩸕𩸽").match(s).tostring() + "\n");

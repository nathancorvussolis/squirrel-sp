/*
俱 4ff1
剝 525d
吞 541e
噓 5653
姸 59f8
屛 5c5b
幷 5e77
瘦 7626
繫 7e6b
𠮟 20b9f

𩸕 29e15
𩸽 29e3d
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

print("search \"[<U+20b9f>-<U+29e3d>]\"\n");
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

print("search \"[<U+20b9f>]\"\n");
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

print("match \".*<U+29e15><U+29e3d>\"\n");
print(regexp(".*𩸕𩸽").match(s).tostring() + "\n");

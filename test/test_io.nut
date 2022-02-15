
function issurrogatepair(u16)
{
	if (0xD800 <= u16 && u16 <= 0xDBFF)
	{
		return -1;
	}
	else if (0xDC00 <= u16 && u16 <= 0xDFFF)
	{
		return 1;
	}

	return 0;
}

function u16tou32(first, second)
{
	local u32 = first;

	if (issurrogatepair(first) == -1 && issurrogatepair(second) == 1)
	{
		u32 = 0x10000 + ((first & 0x3FF) << 10 | (second & 0x3FF));
	}

	return u32;
}

function u32tou8(u32)
{
	local u8 = [];

	if (u32 <= 0x7F)
	{
		u8.append(u32);
	}
	else if (u32 <= 0x7FF)
	{
		u8.append(0xC0 | (u32 >> 6));
		u8.append(0x80 | (u32 & 0x3F));
	}
	else if (u32 <= 0xFFFF)
	{
		u8.append(0xE0 | ((u32 >> 12) & 0x0F));
		u8.append(0x80 | ((u32 >> 6 ) & 0x3F));
		u8.append(0x80 | (u32 & 0x3F));
	}
	else if (u32 <= 0x10FFFF)
	{
		u8.append(0xF0 | ((u32 >> 18) & 0x03));
		u8.append(0x80 | ((u32 >> 12) & 0x3F));
		u8.append(0x80 | ((u32 >> 6 ) & 0x3F));
		u8.append(0x80 | (u32 & 0x3F));
	}

	return u8;
}

function u16tou8(s)
{
	local u8 = [];
	local u;
	local chs = 0;

	foreach(ch in s)
	{
		u = [];
		if (issurrogatepair(ch) == 0)
		{
			u = u32tou8(ch);
			chs = 0;
		}
		else if (issurrogatepair(ch) == -1)
		{
			chs = ch;
		}
		else if (issurrogatepair(ch) == 1)
		{
			if (chs)
			{
				u = u32tou8(u16tou32(chs, ch));
			}
			chs = 0;
		}

		foreach(uch in u)
		{
			u8.append(uch);
		}
	}

	return u8;
}

function fwritebom8(f)
{
	f.writen(0xEF, 'c');
	f.writen(0xBB, 'c');
	f.writen(0xBF, 'c');
}

function fprint8(f, s)
{
	local u8 = u16tou8(s);
	foreach(ch in u8)
	{
		f.writen(ch, 'c');
	}
}

function fwritebom(f)
{
	f.writen(0xFEFF, 'w');
}

function fprint(f, s)
{
	foreach(ch in s)
	{
		f.writen(ch, 'w');
	}
}

function fclose(f)
{
	f.close();
}

//------------------------------------------------------------------------------

local s = "あいうえお\n俱剝𠮟吞噓姸屛幷瘦繫\nわをん\n𩸕𩸽セ゚ツ゚ト゚\n";
local f;

f = file("a8.txt", "wb");
fwritebom8(f);
fprint8(f, s);
fclose(f);

f = file("a16.txt", "wb");
fwritebom(f);
fprint(f, s);
fclose(f);

f = file("b8.txt", "w,ccs=UTF-8");
fprint(f, s);
fclose(f);

f = file("b16.txt", "w,ccs=UTF-16LE");
fprint(f, s);
fclose(f);

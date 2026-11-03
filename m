Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763527;
	b=m1Q38s4/e81VU/hbs3Q23b5aIwHKYKwfo3E65LuBBMz4t+3OqnRC2SUlXMCCru8bmUdT
	 lBTGXtRH+Vd+ygDYAV/yEoiynEkC8VoY84i4jlAjWxJY05WXbFXYbMo6diFvhLbC8hoGX
	 +P+EcXQHmk4IwvN9vCLXD2pCUFsLxVbR2WqEwwEWW0/SpE6UxOpfpEiGz1RfU1cXaUGZF
	 nM6ldS/CZLAqGqr29NH1mJhbktA3GLscaYyZMD3LeU9bQXADP1yMw6pg6jZd3XiA7VTxp
	 OnqCLTnG3eqc5BBDDN6j4iDltd8aYGmlK8P3icWnGtKT8tJF7ubEgTSAtCnej1mN1+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763527;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=Ld/0/oO5/dcyaFSZVTGSJT7CZ63LB3da6H6DL8O7euU=;
	b=OBFC9QzUr3vPvc/s1nnTja6neK7SEVWw1njr3b3iOTlCsBfUjcM/ECMZjhDZmwS1WRFB
	 jVXNmLdXLOTnIMW2UWey4gbnbIHHUptE74VdicJqJxGu+VfxjjCxG50HWxRvh/2gYBWLT
	 D29VLBamDNtUutyA32gDQpL3KX+csKZL0/Hazufs4rC/oDRTWJEU4rRcN6uqZIkAZDBNf
	 amDbjSZbs1Aa4XuY1R5Y/s6ZXD6+/r6Bxx8S2HExlVPj5LxkSknCDWRvNNaC7KXpQb21U
	 hJBhNOlKzibFbpzXtTsEq7QTYl8/vhYrAQxVLL5PSvWJFWlmJqkxDv+0TNcZSQhZ/Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="zDdQR/oN";
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A1606A31B;
	Wed,  4 Nov 2026 03:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 906A1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zDdQR/oN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793763521; bh=Ld/0/oO5/dcyaFSZVTGSJT7CZ63LB3da6H6DL8O7euU=;
	h=From:To:Cc:Subject:Date;
	b=zDdQR/oNBiRYRgam32mzLNqqNN4+LyxgpmKjjPXIe4k3zEfsTk/C753e4auFhzHqr
	 nbUY+j8lDMX1OijRnOpRtKgGlRYpKnf1w0DOP2n+HNmyrk8W0sPFq84UZh8zkt64Hg
	 OrvnOOMivjsYs/bZvmeqfH++n0Haquz931e//tCA=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 9A7B4E35; Wed, 04 Nov 2026 11:38:39 +0800
X-QQ-mid: xmsmtpt1793763519t1zc3rdps
Message-ID: <tencent_2BA96BDF7A23284E7DA60251823E63515808@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahv0YBCtuDRj6dEHyIkojQmXqyn3geZQd7rrVELvo9W8+QfzBLrC
	 GT768jPzDl87QVpd6GDWHvQjsP7nAOVg6eoY9NF641Cegs3UdZQs76sHoURyANmbJQR9Iii1xGcZ
	 MgpkQ7lTjS+w7mWPj+pDdfbrje4omrS52DW4OQbG0/SDzZqZ9ArzCVLR+VGBdiu8UDpM7U17NsYM
	 SIH9DmFdHhXpIAa34N1Awmw1FIU8lnqTmtekD656XFubiBZQneaB8Yyo07Pch+Cb8pomyRjyunpV
	 nKLjuBN56jfkzKKQjSK732mJFXBjO+kfQDMkiiOX744w1o6zwL+szLKoysMXG3x5n2pIfMjXG0wG
	 HW+ZAaM9M2cCu7CxG3XbAuNOqABh5O7CbYT4nLosxE5JCuYxEp5YalZwUBl8Hng0/pEc2ZlR9T9R
	 8V9dLOykJZTzp2obc3cL2arm52Sa2BzN257x5zHPmOgCMp4+SuEeaS+Myfb7CBPFQMmCgeKvpyio
	 4/G0jPoYTn7Eu2V2A/aRsW5SVnMlsnwOq963I7Gguxy3RW3pyNlEC7C0LT7/f7G/SNeTMo7QKcJi
	 XtgTAB7IyZe6fHfK8jPI6JN5fitmP0qBUMLIPr5l9W6pEwK6zm741vuAb/z67/4KMwoPKCcNcHpE
	 xghdkH4nNT10UjIsNI3SXcSpoHWvYvgvQQXQMt8hseupJJnZmHerup6Ly/NZB3qG/V3nvg3tEQ+o
	 VEtHYS+DozrjwJUa9uCNjqWX8WNM26+aJx8/EPwBmDpIYoc/biRFfEBss64uxgHkP89EXU7gAe07
	 YbcU9GHb3b5dzyVZqvL5ZXFEgTN0wrGUeIzS/IpPd84JGYUE0PEn49TG1hZyhqUNrLwxZjwZOmRN
	 K/xNR4UznH/s+jF8j9KTdZ40sKi9IjuTY7Mk/O0yjlHY+UsrnGlLxdqQTvJK6YbqyN+3W4yBs8Pt
	 lEvu64x2WHNe+Cib+jx/Jbqsx2yYnYVLYOrWJMWwnFXStZudhzb8sCp6XttJZ7IvKPhTtgVJv6FR
	 tOIXrmYUdr456Re5u0phNa3dZXw91VfvEqyzzeFvRJ11xigPX4HrkLyZGCbaPo4hQNXLH6xZwPPL
	 qivLhO
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Guikun Yang <yangguikun19@qq.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: ntfs3: unvalidated c_unit in sparse/compressed attribute header
 triggers UBSAN shift-out-of-bounds in attr_set_size_ex()
X-OQ-MSGID: <c18-ntfs3-cunit-shift-20261103@qq.com>
Date: Tue, 03 Nov 2026 18:00:00 +0800
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

Truncating a file whose non-resident attribute carries the sparse or
compressed flag ends in a UBSAN shift-out-of-bounds. The shift amount
is the raw on-disk c_unit byte, which is never bounds-checked on the
ext attribute path.

  UBSAN: shift-out-of-bounds in fs/ntfs3/attrib.c:485:9
  shift exponent 32 is too large for 32-bit type 'unsigned int'
  Call Trace:
   __ubsan_handle_shift_out_of_bounds
   attr_set_size_ex.cold+0x152/0x1bf [ntfs3]
   ntfs_set_size+0x202/0x360 [ntfs3]
   ntfs_setattr+0x363/0x6d0 [ntfs3]

## The gap

mi_enum_attr() (fs/ntfs3/record.c) validates each attribute it walks.
For a plain non-resident attribute it rejects any nonzero c_unit:

  } else {
          if (attr->nres.c_unit)
                  goto out;
          ...
  }

but the ext branch - first segment of an attribute with
ATTR_FLAG_SPARSED or ATTR_FLAG_COMPRESSED set - checks asize,
total_size alignment and total_size <= alloc_size only. c_unit is
accepted unbounded, and it is a raw u8 at attribute offset 0x22.

The first consumer is attr_set_size_ex() (fs/ntfs3/attrib.c:501):

  align = sbi->cluster_size;
  if (is_ext) {
          align <<= attr_b->nres.c_unit;
          ...
  }

and there are four more shift sites using the same field
(attrib.c:1168, 1732, 2089, 2401).

The kernel itself only ever writes 0 or NTFS_LZNT_CUNIT (4) into
c_unit (fs/ntfs3/frecord.c), so anything above 4 is a state the
filesystem never produces legitimately.

## Observed

The reported exponent tracks the on-disk byte exactly - one run per
forged value, each deterministic:

  c_unit = 32  ->  "shift exponent 32"
  c_unit = 64  ->  "shift exponent 64"
  c_unit = 255 ->  "shift exponent 255"

Trigger is open + ftruncate after mount; no privileges needed.

## Notes on reproduction

Two details make this awkward to reach by blind mutation and worth
spelling out:

- MFT records are covered by the update sequence array. Any field
  edit has to undo the USA fixup first and recompute it afterwards,
  or the record is rejected as corrupt.
- Converting the attribute to ext form makes total_size land at
  offset 0x40, where the runlist used to be. The attribute has to
  grow from 0x48 to 0x50, the runlist moves to 0x48, ATTR_END is
  re-appended and used is updated.

The reproducer (image builder with USA handling, ready-made image,
crash logs for all three c_unit values) is available on request.

## Suggested fix

Symmetric with the plain-attribute branch in mi_enum_attr():

  if (!attr->nres.svcn && is_attr_ext(attr)) {
          ...
          if (tot_size > alloc_size)
                  goto out;
  +       if (attr->nres.c_unit > NTFS_LZNT_CUNIT)
  +               goto out;
  } else {

Tested on 7.3.0 (ntfs3 as a module), deterministic; the ext branch
and the unbounded shift are unchanged in current mainline.

Thanks,
Guikun Yang


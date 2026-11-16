Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794891913;
	b=acGrUoxTVGgxX2QHUMLh5CCLdKCFp09hYLyrB6aHgBO7NXLmFTpYVvNYUlSynRfQb3SZ
	 AaNboOUmuOJm4ir1vrAnrQPSAm5Wbw8FTCiXNsH0qUMrdlW4II865fJI/vYd4wjiMMMgE
	 5Bvqx0FTP2WN9SQ4OuECsM6svXOAtJbrUSlQqC476MaCvrtomrFiPoi4E5poLkcnRbkxy
	 LNCrVTkpMl+Ue7DH/v2ePKF+uD/ALxqTkKg9cUo09jPuj71fxviTbEb+2RKeRMep1RAn+
	 9vflKisLHl2UwdJIzz5LrXQfN2eg+BWumXJn9lTP6kC0F7XxzoXvscYNRFxTWyYNYCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794891913;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mHVL9pD+BwW+ZAX8GM4hT5ju5yFgARR6ETM4eazQQF8=;
	b=wXR7yIk0G0FP61pR40SS882m4YoGCc/eSg9C3vu5icwfC7UhN0NW1UcL8+HXxDNsOl8u
	 2BRcjzQrUd9uIpIhsvMbHZfnAAD1a53cXAUZDZ6+8/aEWVR1YzpWJxgTQidxePXJZUZG8
	 SNw1lIiRlllFACUTVEagH90o5ycxWibYkim9D7bNh9ZJGn9e/L/AfSZvzCE4aF1CHkqmW
	 VFmxRWM7KTfmG1XUVw73GQllZh1z6Q06xk1UsP8V1zZjyZL8Oov0L6OVnIR7WhNJQgWKf
	 ju9JI/JUMvnNXeSjlRK3UYMwM0p2WYxvlM+bSZbtQ6zD21G4WzvOJmb1HBjrJAPTE8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=NnUmxsND;
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB93606A32C;
	Tue, 17 Nov 2026 05:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB93606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=NnUmxsND
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794891906; bh=mHVL9pD+BwW+ZAX8GM4hT5ju5yFgARR6ETM4eazQQF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NnUmxsNDc9HZSyqjwGLhTLrcM93Jbt9DQvqZTmC0Ya9Qp4EZPMpKgkS3LCUEEguPN
	 TD2f9or+Tt/yADMPYKmtdYIYTy9BTV/melkvYpVTGVdD+qqUvLQWbvMvVXVlaMCBlj
	 /564AiNo2PEp8zJH1HfwuNOrXm37uM659HVcbX+k=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 1443EE6E; Tue, 17 Nov 2026 13:05:04 +0800
X-QQ-mid: xmsmtpt1794891904t7q1yvrrx
Message-ID: <tencent_1CEFA39140271AD3A828251FDD28B254CE07@qq.com>
X-QQ-XMAILINFO: MJf32pulH481GwBHD0OnIjPWSAijnCN/IeaEjUN4rO/T7RbMoB3n3fmbAWt9j9
	 RhruHpfv+z7dEJxx3xqHKx+zaHf6hp+Nt/tyiz/rT464bt3ClpLqrN12ex3epxa2tBdEOZiQHN7q
	 LxZloLOF5SoJ/pxBXFVbyjNShu3PnVMsZb3zp2QCVZJMVG9uGnYTGd588wOG1cJYHT0lEvZLNCX7
	 OskdHIIc38YPm0VWtHv9hCAxmb3QA6lwwdBqs/o+uejW+FWyNX4Hk4+Jzig2Y9ag3Dy15G1vVD66
	 X4cRGKkkjQj+rIWvvjAsTVNU/ouS3BCcdqhn2JmF9FfU0LEyFsJ/q+3SpEc0GG6XKWQR+YAKsRFf
	 A2mHlIEXSQ5NCfPgae2VIFTvRZ06lBbS+aKkQbE8LiPhXsRNHUTfYLQ5QzUEpfYDCa1ZZP+3RfJf
	 TATTLhyJBGChYwi+aUKUlh7r5j26czGoMKl3CKoIDZe4hB/gEtDCWOaW68LwBByEBJ2PI1SSYD4W
	 dMqTHwvvkL9TKsy5EzMc8TeWHkNpCqbiGWP07JMK4L+clIXTk6VlXE3r5Hs62vjPM4LO/76m7NUq
	 UMwmySa3C0dykiR0tplaHaywToTbfr078JgDbyYW7VI5IVrZgVG4g4cucDz6ylmPj7CMbtVvp6nn
	 9Yy283uR5QmqPN0eCMDNNjjdeV9P+ibZW9g5ACx+T9Y8tvK1lhYfV1cTCNdBP9Zb8kKgJi44P1Yy
	 E5fVETu1Ie3KhKNbRTBN/5o6pMTJ0/uwSs/ggrQKIKBaDCykHVjGpUfKGzQkXqQlY3gIryG7h8pW
	 qKgUGJNK6/N5DNxEz2HgcnvN4WYojxAi/vAPk6V4a1t/SeSGjM1W/QxxWRsBc3rsItDIn+BX11ij
	 F3lreEzjCiKWl8x+VKbE9clM8EaarzZrwPawGaLUr9pCT7k4vEtqxPWcy981PwifxcXONtIi8a0u
	 X/ljBkOo1QK4tWFVqsvDbDqJIm+vm2G76LCGEVlYhSEf1G5v4kRvfpU+xPLRLZA2eiyg/CiCyB6c
	 osrNw81HbCQ/ubjbIGmkjK7cflaCXjwoOFkUdS0krDV559XsgrxwtzBl13ZwQ=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Guikun Yang <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>,
 =?utf-8?b?w5Z6Z8O8biBLw7xsdGVraW4=?= <ozgunkultekin@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfsplus: bound hfs_bnode_read_key() against the per-tree
 key buffer size
Date: Mon, 16 Nov 2026 22:30:00 +0800
X-OQ-MSGID: <re-c44-explain-search-key-alloc-20261116@qq.com>
In-Reply-To: <2e910d5d5ab8dc719b4e540410a9e1024eafdfd5.camel@dubeyko.com>
References: <c44-hfsplus-extkey-oob-20261112@qq.com>
 <tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com>
 <patch-hfsplus-readkey-bound-20261114@qq.com>
 <2e910d5d5ab8dc719b4e540410a9e1024eafdfd5.camel@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Slava,

The mismatch is between the declared type of fd->search_key and the
size it is actually allocated with.

hfs_find_init() allocates the key buffers from the per-tree key
length, not from the union size (fs/hfsplus/bfind.c:22):

	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
	fd->search_key = ptr;
	fd->key = ptr + tree->max_key_len + 2;

So search_key holds max_key_len + 2 bytes. For the extents tree,
max_key_len is forced to HFSPLUS_EXT_KEYLEN - sizeof(u16) = 10 at
mount time (btree.c:318), which gives search_key a 12-byte buffer.
The declared pointer type hfsplus_btree_key * suggests 518 bytes,
but only 12 bytes are actually there.

Now in hfs_bnode_read_key(), the existing bound is the union size
(bnode.c:87):

	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
		memset(key, 0, sizeof(hfsplus_btree_key));
		...
	}
	hfs_bnode_read(node, key, off, key_len);

key_len is attacker-controlled in the leaf/VARIDXKEYS/attr branch
(u16 read from the node plus 2). Anything up to 518 passes this
check, and hfs_bnode_read() writes it into the search_key of an
extents-tree hfs_find_data (a 24-byte kzalloc total, of which
search_key is the first 12). That is the slab-out-of-bounds write
from my report:

	BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x30/0x5f0
	Write of size 502 at addr ... by task init/1
	 hfsplus_bnode_read -> hfs_bnode_read_key
	 hfs_brec_insert -> __hfsplus_ext_write_extent
	 ...
	Allocated by task 1:
	 hfs_find_init (kzalloc 24)

reached via hfs_brec_insert() -> hfs_bnode_read_key(new_node,
fd->search_key, 14) on an extents tree (brec.c:169); the parent-key
update path at brec.c:151 reads into the same buffer the same way.

So memset(key, 0, sizeof(hfsplus_btree_key)) is unsafe in this
function too: the 518-byte clear runs off the same 12-byte
search_key, which is why the patch bounds both the read and the
clear with the same expression.

About "what if max_key_len is corrupted": it cannot reach the tree
at all. hfs_btree_open() validates it against fixed constants per
tree id (btree.c:318/331/350):

	case HFSPLUS_EXT_CNID:
		if (tree->max_key_len != HFSPLUS_EXT_KEYLEN - sizeof(u16))
			goto fail_page;
	case HFSPLUS_CAT_CNID:
		if (tree->max_key_len != HFSPLUS_CAT_KEYLEN - sizeof(u16))
			goto fail_page;
	case HFSPLUS_ATTR_CNID:
		if (tree->max_key_len != HFSPLUS_ATTR_KEYLEN - sizeof(u16))
			goto fail_page;

A corrupted max_key_len fails the mount. At runtime it is always
10, 516 or 266. And the bound stays consistent even in the
hypothetical case: search_key is allocated from max_key_len itself,
so a bound derived from max_key_len can never exceed the buffer,
whatever the value is.

That is also why I would argue max_key_len + 2 is the opposite of a
hardcoded value: sizeof(hfsplus_btree_key) = 518 is the constant
that has no relation to the allocation - it matches the catalog
tree only by coincidence (516 + 2) and overshoots extents by 506
bytes and attributes by 250 bytes. max_key_len + 2 is the only
expression that tracks the kzalloc() in hfs_find_init() one to one.

Both sizes in the patch come from the same source: the check
(key_len > max_key_len + 2) and the memset use the same expression
as the allocation. If you prefer to avoid recomputing it, storing
key_buf_len = max_key_len + 2 in struct hfs_btree at mount time
would make the correspondence explicit - happy to rework in that
shape if you prefer.

Thanks,
Guikun Yang


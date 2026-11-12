Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532723;
	b=dxmteGGRSuvTLFPQcAV7YPI4NNHk8bLH7aPdBTe9IkWIOC7bzvHMkoLFPLSVtktd1shZ
	 af8CrnzW0Cu/0b3dFLWPMIbRyIQCnOO/l3LNeMYNt+ct+w04jmvYNR10JTJQvpZGe0Uua
	 VQDacM1CMFVN1eVLxtgX6zmQUeIJmbX+NwwpQGYPq90gTJ1JTlD288HuksU6xmIbX/F9u
	 6QkRBw34gwT1xLTC9CWiAKzcpWo3z4sn5wejRGsLAE78If0NlGXKemPu1rWsGOnObXLg/
	 hM5vBGFpAKOuEDnWon4ZeFnzU7WybK/2m/Btw465t9p7fwag/foEJ8Ke2TFxq4fQEcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532723;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=VweIZJncufI4qxiNi9la2hhpX8UP/VSqawVkGohdoqk=;
	b=RxPBbCSrT40PLqoS4QLscNBsropkK1hX678M/p7VaBr8SNUMvQvnd6TNk0cF5p2H/8D1
	 2IihU8wWMHwjqIXpWGW2AQAsb6flP+NiQlRdrxljV4QsytJAk5V43n5iwj4THcd9e2cAl
	 cLKV8VFZfJwgEwE9SavgOjj1YplJUkxxwiY2aok+egUkOP/BF1Fvu6GZ3odGBYHZ+qEMa
	 1H245V1otSiEpVbCblDwWCqbHqE1GL6bM3opEmWQCdyvvrP/Bwr4S5xBIiPvATsZ79/gu
	 jkYFy8RwLif8G8G0kqk1c8i8HQkRsEgahuJQ+dlVG9+3EobYFUW6gzBlJCuKjCrg2jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=f7DA52wh;
	arc=none smtp.remote-ip=203.205.221.236
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A5606A327;
	Fri, 13 Nov 2026 01:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA4A5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=f7DA52wh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794532713; bh=VweIZJncufI4qxiNi9la2hhpX8UP/VSqawVkGohdoqk=;
	h=From:To:Cc:Subject:Date;
	b=f7DA52whRu9zxhNwY4n3Cu7FwzU4eW9eGVN2IAUcerOAaOfMdPGiCSbx6g9BJYYB2
	 NW7amMXa+FnA1FaOWFTXY2MY3WlPfHuku2aBSyoKduEyD+bRb0J3pB8q8xNOdKmLfK
	 vaFrCULY0TmesGG8ru6XutZyhooeuJKX690LzzAc=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 4A0010BF; Fri, 13 Nov 2026 09:18:32 +0800
X-QQ-mid: xmsmtpt1794532712tv1r7dmz9
Message-ID: <tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb50UofCUAfNsgu6HZLmSUutpfhL45iu8NQOHT2+DMp7KMvx9Y0vp
	 bqChCpGuqMxSVrp9LehunMcRd4WZ+XoB7sBYk2YXHSoPAqcc9OP3UIkekywmBTx4XYVR87WD+yYI
	 l5PcmWTvAmslYOm+UwjJutw8F7ZseeWogsVEQ7tCb2kJLrxeR0NEhTg6+OjgKxE8T5N8Oe0X+QJm
	 2gTS6N5mx3yKwETPsAXEAaFvBYGiKWAKAHqFDRgo1S7eDaTUfSB9udbkruGA1ihsCsqRMwHgnzqF
	 RuZdTa0YLQigKL5gAEckIYIqomnw3Yq4xca7Zs13yOVG3Do8Egjt7rLdLNSNYsrv5vtjztA0wdnx
	 FytvrD51fZPTTqkax2mVG+8MkozJnzRcG/9+J3fyqotBcYn5ctLtVyzBlciJXbf5nlDPMz9NTTDt
	 dkDpgo6vZu3Z+FCMWkBtB4eY26/usavi545oLbAbs0AUWWc+Zd1JWWiYnf57TPpiUTJY0LBnKQ7m
	 Y15JSX63s9bXpRPyvqDwoaq6CvA1abgich3GSR7AxJL0Nbml3ouIMIrxRjKYUZV/0He4I1ygyUqH
	 pxvctqka9D14L8ODT172e4FHlF/q5Ad+gWw1zvVZEc0kJ+5RUphvhLqhH+ccn5CUAuh/+VSWWgB9
	 2RJ7GAx1t0sf6PPq21sDkW7Bz8u/eLCmUMdVsJcnTIQ+ME7IR/N/PpIRIOXxwXqM/9oCS+cifmEg
	 wLccQS6lgp+DK8U28OmLGytzvxWp80xHH6CNyMZ4gnrdro/HyYcI5A3Xwv8QIHi8NCFK3EFWT0sC
	 wSoIoh3G9ZF7kh4SF+xmtSLt5c8adoQzOLkHGPEB1ak9StbeY1GMxeSXd8x+0nNvFBKP0onsVgJU
	 nbet1czU9InAAyLuqqlHomTstISSZAePjQVh/Zz/f0bSidEIINTv6VkwbZEm5viWsgWC6BUXmSUG
	 Yuz6VeO4Yzk9s0lrbmvANI0L3XdJZT7m7Wlekp3U4nKGw9be5VNhHqIPF1sm2Z1yQjy3RbcF+Nd1
	 U8TT2Ibsvz9fOsGm3cOQ0lioEQ1m7kIlCrr3+h4Gix1F/qFyyosZA62WVhCc291FrJur2OqAKwM5
	 LUdN4t
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Guikun Yang <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [Bug report] hfsplus: extents-tree search_key buffer is 24 bytes but
 hfs_bnode_read_key() bounds key reads against 518 - slab OOB write on fsync
X-OQ-MSGID: <c44-hfsplus-extkey-oob-20261112@qq.com>
Date: Thu, 12 Nov 2026 22:00:00 +0800
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

Appending to a file on a crafted HFS+ image ends in a
slab-out-of-bounds write into a 24-byte allocation. The extents tree
sizes its search key buffer from max_key_len, but
hfs_bnode_read_key() bounds the copy against the generic union size
(518), so any on-disk key length between 10 and 516 passes the bound
check and overflows the extents-tree buffer - and the reject path
itself memsets 518 bytes into the same 24-byte allocation.

  BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x30/0x5f0
  Write of size 502 at addr ffff888005fb4100 by task init/1
   hfsplus_bnode_read -> hfs_bnode_read_key
   hfs_brec_insert -> __hfsplus_ext_write_extent
   hfsplus_ext_write_extent -> hfsplus_write_inode
   hfsplus_file_fsync -> do_fsync
  Allocated by task 1:
   hfsplus_find_init (kzalloc 24) -> hfsplus_ext_write_extent
  The buggy address is located 0 bytes inside of
   allocated 24-byte region, cache kmalloc-32

## The size mismatch

hfs_find_init() sizes the search key per tree (fs/hfsplus/bfind.c:22):

  ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);

The extents tree's max_key_len is validated at mount to
HFSPLUS_EXT_KEYLEN - 2 = 10 (fs/hfsplus/btree.c:318), so its search
key is 24 bytes. The catalog tree's is 516*2+4 = 1036.

hfs_bnode_read_key() bounds the read with the generic key union
(fs/hfsplus/bnode.c):

  if (node->type == HFS_NODE_LEAF || ...)
          key_len = hfs_bnode_read_u16(node, off) + 2;   /* raw disk u16 */
  else
          key_len = tree->max_key_len + 2;

  if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
          memset(key, 0, sizeof(hfsplus_btree_key));     /* 518 */
          pr_err("hfsplus: Invalid key length: %u\n", key_len);
          return;
  }
  hfs_bnode_read(node, key, off, key_len);

sizeof(hfsplus_btree_key) is the union of cat (518), attr (268) and
ext (12) keys - 518. That bound is correct only where the buffer is
the catalog one. For the extents tree it means:

- key_len 10..516 passes the check and memcpy writes key_len bytes
  into a 24-byte allocation (502 with a crafted key length of 500)
- key_len 517..65535, or any odd value, takes the reject path, which
  memsets 518 bytes into the same 24-byte allocation

Both paths are out-of-bounds writes; the second one fires even for a
"rejected" key.

## Why the disk value reaches this point

The bnode loader validates key_size only against the record entry
size (fs/hfsplus/bnode.c:601):

  key_size = hfs_bnode_read_u16(node, off) + 2;
  if (key_size >= entry_size || key_size & 1)
          goto node_error;

A record with key length 500 in a 3814-byte slot passes: 502 < 3814
and even. The binary-search path that does check against
max_key_len (hfs_brec_keylen(), fs/hfsplus/brec.c:71) only runs for
the records it probes; placing the crafted record's cnid above the
search key keeps the search converging past it without ever probing
it. When an insert then forces a node split, hfs_bnode_split() moves
records verbatim into the new node, and brec.c:169 calls

  hfs_bnode_read_key(new_node, fd->search_key, 14);

on the new node's first record - the crafted one - with no
max_key_len bound in between.

## Reproducer

The trigger is write(2) + fsync on a file whose data fork has 8
extents followed by a non-contiguous allocation, forcing
hfsplus_ext_write_extent() to insert into the extents tree and split
the crafted leaf:

  # positive: ext leaf rec2 key_len = 500
  python3 mk_hfsplus_ext.py base_file.img run.img
  python3 trigger_write.py run.img pos.log     # KASAN OOB write 502

  # negative: same image, only that field differs
  python3 mk_hfsplus_ext.py base_file.img run.img neg   # key_len = 10
  python3 trigger_write.py run.img neg.log      # clean, write returns 4096

The negative control differs from the positive image in exactly one
field - the crafted key length - and parses normally, printing
"vda1 <lv...>"-equivalent extents output with no KASAN report.
Positive 4/4, negative 3/3. Each run regenerates from the base image
(the mount consumes it by writing the real extents tree back).

## Relation to the existing fixes

bb5e07cb92 ("hfs/hfsplus: fix slab-out-of-bounds in
hfs_bnode_read_key", 2024) added the 518 bound and the memset reject
path after syzbot hit the same function through fs/hfs and the
catalog tree, where the buffer is 1036 bytes and the bound holds.
The extents tree's buffer (24 bytes) was never covered by that fix -
the bound is larger than the buffer it protects, so the check is
inert there and the reject path is itself an overflow.

## Suggested fix

Bound against the actual buffer, not the union:

  if (key_len > tree->max_key_len + 2 || key_len < 1) {
          memset(key, 0, tree->max_key_len + 2);
          pr_err("hfsplus: Invalid key length: %u\n", key_len);
          return;
  }

This covers both the memcpy and the reject-path memset for every
tree with one change. The extents tree additionally can never see
a key_len above 12 on a well-formed volume (HFSPLUS_EXT_KEYLEN),
so max_key_len + 2 is the natural bound.

The reproducer (image builder for positive and negative cases,
serial logs) is available on request.

Tested on 7.3.0; fs/hfsplus/bnode.c is unchanged in current
mainline as of 2026-11-12.

Thanks,
Guikun Yang


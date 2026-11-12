Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535032;
	b=IbJR6G8GF3QzQO6MBUn5Jr+ibE1tskwc42BMwaQ6qlirIjg1nZ8V28t9L9JFRJlhhXt7
	 M5Y+MLHRFvvRjkcQYHkVEBqsXfEJSb/rDL1w3lArcIIrt0Egi8osHPviKP4yI/aRh4+ER
	 4CGcG17SzHEz+UhJT8qhdU559qWrZHRnV+EOi8/5WW9Vl9vV2oqS5TOzpEChEC7FhjV9P
	 xSWyPHCZJqoinXvVJ6zBT3ox6cqAT9S5yG6hpmqwzkKqy2YMPAMwQpNIFWPhLmTpgsmVm
	 IeHApwqExJvlEd40mJIAwgy46Xlzu4Y5iUVXwBUQBUIatR8DB7B4T0r3zLURfWY0Pzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535032;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=5uBavx2aBPdhiYJJvhZpvQRBtTzABPSffRIiryI8U3w=;
	b=W6h+qeRVjkGT+JvG1OyYUro/CEHKc0mCh3FCo05Zh64nT5pIu+qjKSGXnOWOfJBFCcD3
	 XGyfOdzuFWVztcRzzUk7sSnP2V2fo8GFzrhN3PefeTV7D7bmkl8ukoLxDd4IEXGNGv+41
	 3qWu68wY1FHJx5n22Mp8pWXJh8qJgQeRy5z4ITomFvRxpMjnB6c2ZQYcRENxJ264sZ+SJ
	 FPKzjnoyI5Ms5kkGleRd/Ro2NZp/+8GqM8+qpjDF0KsJoECfLcSBFE8FbdDrFTGKE/sBY
	 k0PGSQUK0q5W+TvsTDSzNANMy2HB5loSicqt6zYtryyXn+mAxOqjT+h8Veak/M7UoVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=BGNnhB6A;
	arc=none smtp.remote-ip=203.205.221.209
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B71606A33E;
	Fri, 13 Nov 2026 01:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60B71606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=BGNnhB6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794535022; bh=5uBavx2aBPdhiYJJvhZpvQRBtTzABPSffRIiryI8U3w=;
	h=From:To:Cc:Subject:Date;
	b=BGNnhB6AwyM7+P6jM8rDG8BqafGTsRTgi44KkKaKVIPc6OSPOIZP4/qlTfwItxtbG
	 ZkR7vfgPO1X6wvJAwZ+p49Eg2ery3JvT3pzOJPW2Hy5+62RZ+Iwom0iUYaz4CCdTNt
	 vYINE7OkAvV7DT0VImxV1p3g0fxFPXO55iZgCYAU=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E40A70EF; Fri, 13 Nov 2026 09:57:00 +0800
X-QQ-mid: xmsmtpt1794535020tfwxgqqm8
Message-ID: <tencent_8E7D477A9CDC4C75A3647C6EA270526FBF09@qq.com>
X-QQ-XMAILINFO: MJf32pulH481ojJCZe+fvGHXBbTYL9OmnpKR5Kb3VJteL+JotDvx1z/IqKWtr3
	 RVUdJ4yQljlGLyBJCiamn+VlYcs4wGlbPjHhx6MkuZuBYgoEOKv+kTy43uo4b1IlFgaP9cQBFQAM
	 jUhknJnejQF5jCFKlaeJYWIYCUhbZeU4wZTxiJi85J7Vc6LPFzZb3FDeDpfFxX5wi4arKHE7OYDV
	 8/KRS6GrypyR32AVd9h8YBDtPRIcEiPDpafhOJAZrKHJD+Xgwm6telEB4ex3nLpWX4rg2xUC2AsF
	 W0CtkTYuulnwpNQj19fL3hRDQPo2gm+eCpEbsnuqwcUXznHf+jk00SAIExbfxHWfsBXOplstZHxN
	 lrAPmObKZweThBLMnocotCh3OOnQD61BNTETuDgaMoSL/UbjFejvFFhP1TdJN0KTeAc7F7kn41I/
	 FvUAvp3jKF9GqG3Kw/nHJVhyXEzR/M1pVAkMyRBgPyerbNlWcLQ/Yo90RZOMG4G0pOIVQfenb3e6
	 ceLen7PEg2hUp3SjHzFskL+3Um5PhNEIN9KL0BJRucPaxf0d8KA7ogYtX28nsl8M53MiPN0uJodU
	 js/olSmLLs47BqZcskaoMnsfoe5FiJl9hh72OtLjdzlPEwYvTM7zVLmG91wRM3Nm13rgw5lLHYLB
	 keDEF56s0jybS1ZcyURPheuH3GapBsTGYg4b86dEIBdR825V2RKq0u0cujko996G9LO+WJAAdJD0
	 16rGKCtXZtfNBlBvKdiCyrtVi/EKay1k2isY771kDbUtuMYtrmNXHuT9ayWO2truK21Wrw9DbAfo
	 DoyRA/L3xMWPD0iDWzQyjo6hVhVJMp+fizawZ6a47tS7TIo4nzjWFxZzJYPfmd+zRTs0QMPSOED1
	 hjj6Kvyo++XmeOq3bFu5ku1mr0SPMpGqWhK6SMrV1Q2EbswCtB+YbbBcG3++NqLO0J45JDKU0BXK
	 HKwlGF+/TdBy0d+3wOipkJZKblZTtM46qx0MnjG4OeMYJHlG1gWr6SDBtLtB0jJWMXMyOO1EjB1d
	 OSIRReHHfg4NFbZjYuGmu+manuXqc2ZKbNfF1c5DAlq3ukqbRd
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Guikun Yang <yangguikun19@qq.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Bug report] ufs: five unvalidated cylinder-group offsets index bh[8]
 past the ucpi allocation - wild-pointer RMW on first write
X-OQ-MSGID: <ufs-cg-btotoff-20261112@qq.com>
Date: Thu, 12 Nov 2026 23:30:00 +0800
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

Hi Christian,

Following up on the fs_cgsize report from October 31: the same
cylinder-group load path reads five more offsets from disk without
any bound, and they are used as indices into the fixed bh[8] array
inside the 136-byte ucpi allocation. A crafted 44bsd image with
cg_btotoff = 0x3200 reaches bh[25] on the first block allocation and
does a read-modify-write through whatever pointer it finds there.

  UBSAN: array-index-out-of-bounds in fs/ufs/balloc.c:55:17
  index 25 is out of range for type 'buffer_head *[8]'
   adjust_free_blocks
   ufs_alloccg_block
   ufs_alloc_fragments
   ufs_new_fragments
   ufs_inode_getfrag
   ufs_getfrag_block
   __block_write_begin_int
  BUG: KASAN: slab-out-of-bounds in adjust_free_blocks+0x23aa/0x2460
  Read of size 8 at addr ffff888006083ad8 by task init/1
  which belongs to the cache kmalloc-192 of size 192
  allocated 136-byte region [ffff888006083a00, ffff888006083a88)
  Kernel panic - not syncing: kasan.fault=panic set ...

The 136-byte allocation is struct ufs_cg_private_info: the embedded
ufs_buffer_head (fragment, count, bh[8]) is 80 bytes, the scalars
24, the offsets 32.

## The gap

c9d263be26 ("ufs: validate cylinder group metadata before caching
it") added this check to ufs_read_cylinder() (fs/ufs/cylinder.c):

  /* these on-disk values become array and bitmap indices */
  if (ucpi->c_cgx != cgno ||
      ucpi->c_rotor >= uspi->s_fpg ||
      ucpi->c_frotor >= uspi->s_fpg ||
      ucpi->c_irotor >= uspi->s_ipg) {
          ...
          goto failed;
  }

The comment is right about the class of values, but the seven lines
immediately above it read seven more offsets of exactly that class,
and none of them is checked:

  ucpi->c_btotoff       = fs32_to_cpu(sb, ucg->cg_btotoff);
  ucpi->c_boff          = fs32_to_cpu(sb, ucg->cg_boff);
  ucpi->c_iusedoff      = fs32_to_cpu(sb, ucg->cg_iusedoff);
  ucpi->c_freeoff       = fs32_to_cpu(sb, ucg->cg_freeoff);
  ucpi->c_nextfreeoff   = fs32_to_cpu(sb, ucg->cg_nextfreeoff);
  ucpi->c_clustersumoff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clustersumoff);
  ucpi->c_clusteroff    = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clusteroff);

The first consumer is adjust_free_blocks() (fs/ufs/balloc.c:55):

  fs32_add(sb, &ubh_cg_blktot(ucpi, cylno), delta);

which expands through ubh_get_addr8() (fs/ufs/util.h:310):

  (u8*)(ubh)->bh[(begin) >> uspi->s_fshift]->b_data + ...

with begin = c_btotoff + cylno*4. bh[] has UFS_MAXFRAG (8) entries.
With s_fshift = 9 and c_btotoff = 0x3200 the index is 25, i.e.
ucpi + 200, past the 136-byte object. The load returns a wild
buffer_head pointer and fs32_add() then does a read-modify-write
through it - an arbitrary-address RMW, not just an out-of-bounds
read.

The same expansion applies to cg_boff (ubh_cg_blks) and cg_iusedoff
(ubh_cg_iused); cg_clustersumoff/cg_clusteroff are gated by
s_contigsumsize but the offsets themselves are still unchecked.
cg_freeoff/cg_nextfreeoff have a separate public patch in flight
and are not part of this report.

## Reproduction

A valid 44bsd image (magic, clean state, legal directory and inode
tables) with every other known surface kept legal: cg_cgx = 0 and
rotors 0 (passes c9d263be26), cg_freeoff = 176 with a fitting
bitmap, s_contigsumsize = 0 (cluster accounting early-returns),
fs_cgsize = 512 (the count=1 path from the previous report).

The only difference between the positive and negative image is
cg_btotoff: 0x3200 versus 432.

  positive: mount -> open -> write(2) -> UBSAN + KASAN + panic, 3/3
  negative: mount -> 0, open -> 3, write -> 4096, no report

Each run regenerates from the base image (the write updates the
filesystem state).

## Suggested fix

Bound the offsets where they are read, next to the existing check,
against the cylinder-group buffer length they index into:

  /* these on-disk values become array and bitmap indices */
  if (ucpi->c_cgx != cgno || ... ) { ... }
+ if (ucpi->c_btotoff >= uspi->s_cgsize ||
+     ucpi->c_boff >= uspi->s_cgsize ||
+     ucpi->c_iusedoff >= uspi->s_cgsize ||
+     ucpi->c_clustersumoff >= uspi->s_cgsize ||
+     ucpi->c_clusteroff >= uspi->s_cgsize) {
+         ufs_error(sb, __func__,
+                   "inconsistent offsets in cylinder group %u\n", cgno);
+         goto failed;
+ }

(The per-cylinder table sizes give tighter bounds - btotoff needs
room for s_ncyl * 4 bytes, boff for the block-position table - but
the buffer-length bound already removes the out-of-object access.)

Reproducer (image builder for both cases, serial logs) available on
request. Happy to send this as a patch as well.

Tested on 7.3.0; fs/ufs/cylinder.c is unchanged in mainline since
c9d263be26 (2026-08-01).

Thanks,
Guikun Yang


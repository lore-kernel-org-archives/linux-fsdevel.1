Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B643CEC1
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994829; cv=none; b=HwZxgfdaT7biCAY3rXcQT06FeUbZClBmO7aIpR6+2O4lOkIpMRyEszq94ChOhmb97Qe4RSY4pHSzsQWPHPq7IybWR9xerB16TF6ZKD/5ZmVoGp3lsfb/5mEjkJz5QHwJIK1LRfH5fxC/Ki/pQjiQLkj7o3kyOYpDaR/GIXR0nmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994829; c=relaxed/simple;
	bh=eN7zJvf/+oLGZ55IUmfU3ym5Kb47cbfGNvbIBKQF3f8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Hc2rflalFRPM6I/5egqf7nvSpKB3oGvNd2Uyl4Prjk/eFNLBBnhgMGXViZlXqeLpKPcN2K0hgL58xYXqo91oiof0gBekGpDC+CDCPN6AIoIhw/Bmvp34a1WAXytlLQaBY+6TMFaCqSheLA/MlSI00k2BlCoLJCO9aP9qAX1ZmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=MHgjQKJN; arc=none smtp.client-ip=74.125.224.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="MHgjQKJN"
Received: by mail-yx2-f1.google.com with SMTP id 00721157ae682-836c436a364so17384167b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1786994826; x=1787599626; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cSWPC0KF7JILNLnnS4uQoQ9FmZiV97QQH/JGXqfy17A=;
        b=MHgjQKJNFmrNu99JtaNkNatzO5tABmlKhTmr2KGVFXezyeVV+7osY24ndeyWhjeBXq
         xRZ/yg4zfO8TmPRLj26L+hkUCwgtM2Brc70VB80YPeeMy3qs8K6VJEG1oO+OZUH8gMue
         9LUggKI1wuoVcYWhPqbqBptfBjOnTdYe4MX81n9qOpLWhmSF9tdaUZhiM0RhzE/K2/EN
         glTmEJLLkF4pJ5MtMVQzJs/LFSUQl5IjDV7nBdnwYrvh9VOgvWZPjxS0M/O8u20RW6T+
         MRqKpu5bvI4ahMq3ylILyZwdT1AQopqdmvLBUk4EGrJjAXGL2NVEKk6gQwoflRHGoNO/
         hlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994826; x=1787599626;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cSWPC0KF7JILNLnnS4uQoQ9FmZiV97QQH/JGXqfy17A=;
        b=AHY3BfRP8oQQgb6YVdLeb7+sSrkGnZ1FvWyjzT+sB3Im7CaWXy0G/rX0yUswJFL9bx
         KsPIvQwRJWI8pI2s/6MQadD4zA5E2zQRFxUIQfhaPuwlU0fOuxhVp69a3fa5mOkY644m
         JWoYFm2C+A1Gk7mB+3xkKGPXPD+ktbHgDUM1mtEbQUqRsyf4r/LQLZ3Fx/jJ4ADdsGX+
         WDpKn2kx/Uq/TvETFmsDPnr95xNANpLNoZwFsngiA31H0g4aBIDZe01VOXEewOcfbfbs
         yx/D0QSvQJmpE6MfMuSQSRW2Z08K49fEvqFfL3GGoqlDoxLYRpIMaxgmx9IsJY66n/gX
         euqg==
X-Gm-Message-State: AOJu0YxhgaKolL2+AqC829EgjDR1jc1l8v676V/DQLIBy0t5ugiNCxMJ
	yD9BemBc+TpF66gxOfkpDJW1mlLM9YAdLjRXKJAL7tlUKPkihUqmG+Q9Ot5Z+tGwiIY=
X-Gm-Gg: AR+sD10KtP4lyRIZgGeUPFvPtyqmNdy7GKtjXL87DfATmwjBV8FLjGY5S5cKT/m5Yvr
	GfY+Q7NN07XAB9G5dDmcNQmedjzmpLPMHuT7+6z4CAl3Od5U8mkYgPntj16KmIJSG2bPxObvdSz
	i+CirrHJJ2Uh9wGO4zaKeZ9tYX/51BA+qLXXb0NJw7CQ2w1BFKD6QCaNG0dRZ4j6gRSh0UOQEXW
	8neaxsnTyZY1TJEFbzRHYuiI9dgg6CkKAYbHV4Wuj1tpYoE+74TTtSoVM3Pm6OotAsmeTg/iiav
	bPlXT4nRAcrD/G17jYbh0MIG4Z/yVkBlQ/weImACr6Sm3SbF04tpzaccY8KV6XdnXG/pvgbZ/Uz
	BI7qswgoFSHpZQGVRC6+kJysQKBdExIi3U79UYrGXhHTxyvEnJmYqHC0/Lawi4xrojB4j5k0K6N
	Kwd/3I6H3azS2dkv1sVT/djBFqeyuxXRGPcSTpJQUBSq3WEk4sE/jdWXcqINZBjghC21H6AeBlF
	74M8HEPqXyJsLUeiDbBWl1u52OIcESQjrDeklNrmrE2YQASJMi8PQ9Yeu1r/MkIrA/Eg9coCJB/
	joAr2rqT5s/veRqYucTnd/zx8BeUBbRhT9dpjir9KWdI669Yd/a/AQ==
X-Received: by 2002:a05:690c:e1c9:20b0:81e:8d96:a64 with SMTP id 00721157ae682-8370f52c59dmr81595617b3.13.1786994826197;
        Mon, 17 Aug 2026 12:27:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:4c8c:67e1:45cf:b20d? ([2600:1700:6476:1430:4c8c:67e1:45cf:b20d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84068075e41sm10614547b3.7.2026.08.17.12.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:27:05 -0700 (PDT)
Message-ID: <f876403501994cf23efade9cb7dcf974c7a004ab.camel@dubeyko.com>
Subject: [GIT PULL] hfs/hfsplus changes for 7.3-rc1
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, vdubeyko@coreweave.com, 
	aditya.ansh182@gmail.com, r772577952@gmail.com, kylebot@openai.com, 
	davemadmaxxx@gmail.com, mdshahid03@gmail.com
Date: Mon, 17 Aug 2026 12:27:03 -0700
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Linus,

This pull request contains several fixes in HFS/HFS+ of syzbot
reported issues and HFS/HFS+ fixes of xfstests failures.

Aditya Prakash Srivastava has implemented porting of
b-tree bitmap corruption check for HFS file system.
During b-tree open (hfs_btree_open()), the code verifies that
the allocation map bit for the tree header (node 0) is set.
If not, it indicates a corrupted map record/bitmap and mounts
the volume as read-only (SB_RDONLY) to prevent further damage.

David Maximiliano Hermitte has implemented the validation of
catalog CNIDs before instantiating inodes in HFS file system.
The hfs_cat_find_brec() first resolves a catalog thread record
by CNID and then looks up the corresponding catalog record
by parent/name. On a corrupted filesystem image, the second
lookup may find a record whose CNID does not match the CNID
that was requested. Finally, corrupted catalog records are
rejected.

Jiaming Zhang has implemented the validation of B-tree record
offset table. A crafted HFS+ image can contain a corrupted B-tree
node. The node descriptor may contain a record count that
does not fit in the node, and record offsets may be unordered,
unaligned, outside the node, or point into the offset table itself.
Validate num_recs against the node size before walking the record
offset table. Reject record ranges that are unordered, unaligned,
outside the node, or overlapping the offset table. Reject invalid
record indexes before reading their offset entries, and avoid
decrementing an already-zero leaf_count.

Kyle Zeng implemented nice refactoring of hfsplus_delete_cat()
logic. The hfsplus_delete_cat() is called with str =3D=3D NULL when
the last open reference to an unlinked HFS+ hardlink backing
inode is closed. In that case, the function finds the catalog thread
by CNID and rebuilds the catalog key from thread.nodeName.
A corrupted image can therefore provide an oversized thread name length
and make hfs_bnode_read() write past the catalog search-key allocation.
Read the CNID record through hfsplus_brec_read_cat(), which bounds the
record read to sizeof(hfsplus_cat_entry) and verifies that a thread
record's size exactly matches nodeName.length.

Mohammad Shahid has made cleanup in KUnit test. The kfree() safely
handles NULL pointers, so the explicit NULL check in
free_mock_str_env() before calling kfree() is unnecessary.

The rest patches contain fixes of generic/564 xfstests' test-case
failure for the case of HFS+ file system, syzbot reported issue in
hfs_mdb_commit() and hfs_mdb_close() methods of HFS file system, and
reworking the MDB locking scheme in HFS file system.

The following changes since commit
dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
tags/hfs-v7.3-tag1

for you to fetch changes up to
627b7865c062ff642c0000f3a4775f1a44b986a4:

  hfsplus: validate extent record length before writing it back (2026-
08-11 16:37:16 -0700)

----------------------------------------------------------------
hfs/hfsplus updates for v7.3

- hfsplus: validate extent record length before writing it back
- hfsplus: validate B-tree record offset table
- hfs: rework MDB locking scheme
- fs: hfsplus: remove redundant NULL check before kfree()
- hfs: port HFS+ b-tree bitmap corruption check
- hfs: don't re-dirty MDB buffers after a write failure
- hfsplus: fix error code when writing beyond volume capacity
- hfs: fix error code when writing beyond volume capacity
- hfsplus: validate thread record before delete key rebuild
- hfs: validate catalog CNIDs before instantiating inodes

----------------------------------------------------------------
Aditya Prakash Srivastava (1):
      hfs: port HFS+ b-tree bitmap corruption check

David Maximiliano Hermitte (1):
      hfs: validate catalog CNIDs before instantiating inodes

Jiaming Zhang (2):
      hfsplus: validate B-tree record offset table
      hfsplus: validate extent record length before writing it back

Kyle Zeng (1):
      hfsplus: validate thread record before delete key rebuild

Mohammad Shahid (1):
      fs: hfsplus: remove redundant NULL check before kfree()

Viacheslav Dubeyko (4):
      hfs: fix error code when writing beyond volume capacity
      hfsplus: fix error code when writing beyond volume capacity
      hfs: don't re-dirty MDB buffers after a write failure
      hfs: rework MDB locking scheme

 fs/hfs/bnode.c             |  42 ---------
 fs/hfs/btree.c             | 210 ++++++++++++++++++++++++++++++++++++-
--------
 fs/hfs/btree.h             |  40 +++++++++
 fs/hfs/catalog.c           |  41 ++++++++-
 fs/hfs/hfs_fs.h            |  33 ++++++-
 fs/hfs/inode.c             |  23 ++++-
 fs/hfs/mdb.c               | 110 +++++++++++++++++++-----
 fs/hfs/super.c             |  20 ++++-
 fs/hfsplus/bfind.c         |  23 ++---
 fs/hfsplus/bnode.c         |  16 +++-
 fs/hfsplus/brec.c          |  53 ++++++++----
 fs/hfsplus/btree.c         |  16 +++-
 fs/hfsplus/catalog.c       |  25 +++---
 fs/hfsplus/extents.c       |   2 +
 fs/hfsplus/hfsplus_fs.h    |  85 ++++++++++++++++++
 fs/hfsplus/inode.c         |  10 ++-
 fs/hfsplus/unicode_test.c  |   3 +-
 include/linux/hfs_common.h |  13 ++-
 18 files changed, 600 insertions(+), 165 deletions(-)

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755262;
	b=5K/tIRYjIsGyc0UYEL2N7YN6SflBBZ184nwu4CSiOyL5nFxwmpCPpV9Pl5Gns3ReoYhG
	 Nv77NwUaiIHEpIml1fVejunss+ZRGvOb6FWpLnORmetOS3g362GfFDn5/W3ZOKUfAN85Q
	 Gldpt4VFg/YIKpbnfITXWBQzsfpISZB0bKsEvg1KwBCNN9FonZwpiG7jKaUfwuajduXMG
	 Pg2wu2SX25OHwGAo/idu+0vH4tHNpjEdnborRxcOIlIQ3tdfiFaNzvWwaY5RvMFIJmQu6
	 AiIHyY3Uj5/oJxKZPgtdR1cCTQ/KH/G+jPocOde1VEZhibdnYnazEze+Q+lLdI3MI4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c/EVTji7z+Y6dwV+EMqdngXVJQdjsAkTv2omyfIXmss=;
	b=MyxcTXBYMyRSFZbVY4d94CLKTDpq559OiRaVKXrM4XpeC7l+1LrNPUB+wWBdNbP/aIh3
	 tjmRdMwQR3kX7ke9hMZi9/6VW1WahA07Zs14igDwfTeqI69EwUrbTpurQQilT5XtIDoO8
	 ub8pohLSXBq8wmZ5Ie6FP4gLscupUTx0CCDVPHMfxlsdU87zI4r//dbKHgUXT7wspQJCg
	 ugwvHmppHdUqFa40GKviK+GUR2+8XwQrwzvhs3Y6DwGEFrjCtK4Lek0hi2HQhuXe6U6wj
	 T8E088H6ab5jRNK91nFXiv2ERlTgsbqPSYGZYvO0yahRHR6M4gguMG25KNEL6Mrbfdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIWKpkz8;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF8606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 04:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AFF8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIWKpkz8
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1ae58d17cd9so8682637c88.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 20:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755261; x=1796360061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/EVTji7z+Y6dwV+EMqdngXVJQdjsAkTv2omyfIXmss=;
        b=VIWKpkz8JIPN/o3czMhuX5bNtXUftrBXZmDOgRv0WjQfzIlo/jEAWx332iNS6dfq8B
         g/5KPZiYthfNm1YbPv4csx5NepIlP1OLYhNHV4O3ID6/YTO+RKiaf5H5STw6lJ0GN5ef
         O5jxX8NBYMcInu/YVehQVyjka3x0F/VhYD4VVQisHbNbebIo1wWa7eweq2wnzjzD50EZ
         HOAAQAr+6nuaQWhSy5JYkWaiUqHlFsqfravVWHToTsQ1/t/9GAvWnL6HQVwgKFfwgAVY
         UHuAH8Umvs+zW4lB6x3ucFzEDnyar2tlGYDEmtmuPNTU5HFbrDS/y5uxyVb/RWlJTbpy
         yhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755261; x=1796360061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/EVTji7z+Y6dwV+EMqdngXVJQdjsAkTv2omyfIXmss=;
        b=e/7Hy9jbFLxW4oy1WRiKfdE4BJnRmg4OE+8GnDpeXzaV3t0DZAHbNqh8EbYWoCy9wd
         7sjP1L4C7VFuXo7XzfOnXnnEUeEjqWuF0n2jvCCrgn4q2r0hlAIRrN0RenI20eeeSpw4
         snlqkWSD6utVQqFXmIj7eFtAQGQoEU9kyDTHTuzct8tT6LbdpHH2+SYGiVTDFAD8HWfD
         ptymhoxvdB6PES9b8EaqjPCzFZXW54PVPeQ97Is+53E+7Pnn7O7ygVrUK7ZAok97HyOi
         RwjMltkiDuc/zv9Yzh3N/TPu3rNsGoRpSvCpr4e4Heos51l22n38o8nu01VMRCBqTlma
         S4Yw==
X-Gm-Message-State: APuU4Z9Jxo+ZZrfrZfeX273KdmbVZtRTipcHxPCjPWmhtLeQwgJvkX5Y
	W4DrW8L3Y+GyGYU2REJTJFdcfIjXcP9cMg23NVlRmXAL9pz12FDick+5
X-Gm-Gg: AZFdTZfuLJGYCs2Oz2Q6y0Nwkfn1+/apkIVCBhDiPeTqsoEtud+SfjGLDhbLfzzD58u
	u0xeYmkyAwbonYjcqaAHzrb6eWpj0hHFgrfm+B0HWajQAq0ufUWVlKIIYdyNDzLhzUiRy8J56yn
	i7IzzE6QU1x2YcqA//OZ9APusEHNDKb/f199VnXEulb38Q52/sJd2qjlPfVWHv7UwVtxdCrLXXd
	rCORJchB1gMcHrWc4FT7JIBE52Fq+574Zqypo4cN72beFsV08MmnGzqmOWo0wk54mRDfgehtWs0
	F3QzJR9Xgp9yC26Fqz7B+PhYGdt40uaj28Qg2lYT50A6Ug0pU3RcLvNITd3Emu1es6w4+ey/yXF
	daDZKTwfrqHGKv+iMsphv79KuAidO8xzlQRvWU6WBgI418ehIlCaqtdfWy24lgU6k6baIfxiUM5
	zJCrxRSyzY+LuLZaf016vAHqxivxYlG0PRQHIFB6kzF96LxHJTVgCLLZi68fvBeAcMJD4hv9yZQ
	NfBo0l1DG5ZA+KIIObhCSEihIkWDzHsZzlqOX1zLvbnwiMKvsvSJc4bgWJz2WGFiVCPweGyhQUO
	FXn8EDJXL/Qp5hOMGAx3vRnqfvdquZ9pZI/brAsNE42N0seNuHDxAtzGOCroUmnQgwxibZzasFa
	Gt0S37vyvuTdZtAi09M5dEr0wUCE=
X-Received: by 2002:a05:701a:cc91:20b0:1b5:7148:95b5 with SMTP id a92af1059eb24-1b571489632mr13900604c88.8.1795755261242;
        Thu, 26 Nov 2026 20:54:21 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:c4b4:d9b:2291:1e49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm80383487c88.14.2026.11.26.20.54.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 20:54:20 -0800 (PST)
From: Ozgun Kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	Ozgun Kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v4 0/3] hfs/hfsplus: pass the key buffer size to hfs_bnode_read_key()
Date: Thu, 26 Nov 2026 20:54:13 -0800
Message-ID: <20261127045416.1160-1-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119005943.37851-1-ozgunkultekin@gmail.com>
References: <20261119005943.37851-1-ozgunkultekin@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_bnode_read_key() checks the on-disk key length against the size of
the key union, but the buffers from hfs_find_init() are only
max_key_len + 2 bytes each. A crafted extents leaf key overflows them.

Changes in v4, following Viacheslav's review of v3:

- Reordered: the two fixes are now 1/3 (hfsplus) and 2/3 (hfs) with
  Cc: stable, and the cleanup is 3/3 without it, because
  include/linux/hfs_common.h only exists since v6.19. The fixes keep
  the literal 14 that 3/3 replaces. The "next two patches" wording is
  gone.

- The + 2 per buffer (the "+ 4" in total) is not double counting.
  max_key_len in the b-tree header record does not include the key_len
  field. hfs_btree_open() requires HFSPLUS_EXT_KEYLEN - sizeof(u16),
  HFSPLUS_CAT_KEYLEN - sizeof(u16) and HFSPLUS_ATTR_KEYLEN - sizeof(u16)
  (fs/hfsplus/btree.c:318, 331, 350), where the *_KEYLEN constants are
  the full struct sizes including key_len (hfs_common.h:363, 382, 627),
  and hfsplus_init_header_node() writes HFSPLUS_ATTR_KEYLEN -
  sizeof(u16) (fs/hfsplus/xattr.c:88). hfs_bnode_read_key() copies the
  on-disk length + 2 (fs/hfsplus/bnode.c:83, 85). So for the extents
  tree max_key_len is 10 and a valid key is 12 bytes. Without the + 2
  every full-size key would be rejected. hfs is the same with a u8
  length: HFS_MAX_EXT_KEYLEN and HFS_MAX_CAT_KEYLEN are
  sizeof(...) - sizeof(u8) (hfs_common.h:390-391, checked at
  fs/hfs/btree.c:251, 258). The comment on HFSPLUS_KEY_LEN_SIZE and
  HFS_KEY_LEN_MAX_SIZE now says this.

- key_buf_size is renamed to key_capacity.

- struct hfs_find_data: key_capacity now comes after bnode, where it
  pairs with record. pahole (x86_64, both drivers) shows 56 bytes before
  and after the series, with no hole; the 4 bytes of tail padding are
  used. The hfsplus headings are the ones you proposed ("set by
  hfs_find_init()", "filled by find", "filled by findrec, reset by
  hfs_find_result_init()"), and there are no per-field comments inside
  the struct. hfs keeps its struct without comments.

- hfs: the changed prototype in btree.h keeps extern like its
  neighbours.

- 3/3: HFS_BNODE_DESC_SIZE is used for sizes and the new
  HFS_BNODE_FIRST_REC_OFF for the offset of record 0. It also converts
  node_desc_size in hfsplus hfs_bnode_split(), the desc_size locals in
  hfsplus_fs.h, and sizeof(struct hfs_bnode_desc) in bnode.c, btree.c
  and hfsplus/xattr.c. hfs_btree_inc_height() gets a local cnid_off,
  and the 4 becomes sizeof(cnid). Long lines break after "=", and the
  conditions next to the changed lines are aligned.

Tested on mainline 9437ee8b6cf6 (7.4-rc4+) with KASAN in QEMU:
- hfsplus crafted images: without the series KASAN reports a
  double-free in hfsplus_find_exit() and the kernel oopses; with it they
  are refused with "Invalid key length: 516" and there is no KASAN
  report.
- hfsplus image made by mkfs.hfsplus: create, rename, delete, fill,
  xattrs, appends and remount work, and fsck.hfsplus reports it clean.
- hfs image made by hformat: 400 creates, 200 deletes, fragmented
  appends and remount work with no KASAN report, and hfsutils reads the
  result.

checkpatch --strict reports no errors. Each patch builds on its own
with W=1. 1/3 and 2/3 also apply to 6.12.y and 6.6.y, except for one
context conflict in hfs_find_init() (older hfs_dbg() format, no
hfs_find_result_init()); the fixed-up backports build with W=1.

v3: https://lore.kernel.org/all/20261119005943.37851-1-ozgunkultekin@gmail.com/
v2: https://lore.kernel.org/all/20261118013337.67813-1-ozgunkultekin@gmail.com/
v1: https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.com/

Ozgun Kultekin (3):
  hfsplus: pass the key buffer size to hfs_bnode_read_key()
  hfs: pass the key buffer size to hfs_bnode_read_key()
  hfs/hfsplus: name the node descriptor size and the first record offset

 fs/hfs/bfind.c             |  5 ++--
 fs/hfs/bnode.c             |  9 +++---
 fs/hfs/brec.c              | 47 +++++++++++++++++++------------
 fs/hfs/btree.c             |  9 +++---
 fs/hfs/btree.h             | 15 +++++++++-
 fs/hfsplus/bfind.c         |  5 ++--
 fs/hfsplus/bnode.c         |  9 +++---
 fs/hfsplus/brec.c          | 57 +++++++++++++++++++++++---------------
 fs/hfsplus/btree.c         |  9 +++---
 fs/hfsplus/hfsplus_fs.h    | 29 +++++++++++++------
 fs/hfsplus/xattr.c         |  6 ++--
 include/linux/hfs_common.h |  6 ++++
 12 files changed, 133 insertions(+), 73 deletions(-)


base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
-- 
2.39.5


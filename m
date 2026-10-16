Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE937DABD
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792193058; cv=none; b=jGXi/3NtCrrbnvZik5aHS5za/rAFnX0W4Ss3JmrRWGen4n/LHhZX23//tyog2aX/8x29Og1fOxNzKFPUP5K/Zw0NN7GfoqKExZ557kfKkiG4iv0ZeDFLj/Whc9sg09hubgXlvrUsZ1uvGEYVRUgxIMPwmqxTSJGLJDxK0ggoEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792193058; c=relaxed/simple;
	bh=YuCSu0KUlA61RKonog/8G3904xdj5d5wzDThguAvb4s=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=oVaoiKu48OKAnsGw1cFvN1EYsGCT4yKY+yJHTuWnRAxlo6OpJ4oBGd+ggigQeEbim2ftoFLuGF2gkO/2iBU9D+Bbi4258GRNkOTMteJUXdqOLSQKp4lKsJ4H2/xMiKZur1zEoHK89ctxDGAJnccsAgszaRye1pR1iYEIOu7DQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=QZ08b8cG; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="QZ08b8cG"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b0d126f631so3882357b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792193055; x=1792797855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8P9DrTPplGvyRcmS1s0MMPyOw0+R+/2HpDpl+9Qh+MI=;
        b=QZ08b8cGVGMhbSI/wdInjjIXcaKSpxFdkJibYBDabxSAk5LQI9lrrGRG5pN6YhxXq2
         pZpf4+L0tzYUOPGG5ekv/PE3Ohbw7MEEvjRWoTsn8FscI1wncKbbVjVcqHHoFN4vqBBK
         owcVTSlAI0CBUbDoWsaJzkQRWq8Gd/SS4kZhCqaojlCFrSW/vTaFvroxP/hxreynJ+cj
         jpzhWcol/GH+O9O9JELHgPysTAliTOzlsWeTmRnFPYxTZlhQ9TEIenRTIbUNPgkWTe5f
         Av6lAMD99WZKxJIkFhkSEDgdnM8cDtMXVQDwJwpiaQ9/w5Ub3AMrKsUcVhPmrhYZaNbE
         qQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792193055; x=1792797855;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8P9DrTPplGvyRcmS1s0MMPyOw0+R+/2HpDpl+9Qh+MI=;
        b=nCGcHv7eLfNA9MD34VdEIw8f8ij1eOPRzlaeWUP99tw2k4oCEYkIlENCsUM3TS3eBm
         igUiNDy4PEKqEk73GcCc6q2A42C5ulX5XRT0vMK62RUmkNtOxjnhyOYfVdK7+GQp35Bj
         lLdYTS6Yc8LkqgwMk98Lo5zrVgGiHHBznAIENGJyIa3Z4wxYOUUVIpwMnxhnS88W2KDh
         S6qdawUomhJIMf+3Xr/5z2ZYkvBDUVA/d/eQ/LyEfHwpuglxHudywLIglH8cyzb6E56s
         eF4YGvFiPjy7SNUXzDDd+EvFZCkWgViP2EVSuH/ohJ4AiQtTk66QmXRE80bkj978dnVv
         T7JQ==
X-Gm-Message-State: AFq9FYLrZ7iiCd6c7lQ+NizivMc3VkOz60ZIsQc8Vss+mxVBI8DPWkJa
	y5T4/kZG24jiosUMufE98x3XMWAfgKcIj8tsGm8WPvcLkIopT2GtEm7FvR73evlFFBo=
X-Gm-Gg: AYBFou32dIQ4j9PtgQ4lnpRCYimV035zMt1TJzwTnuprOTveRB5Li6IqMS1ZaUa7g+I
	+EsEFJWti9O7yBr8RJKQKCqQBbe6dCmtgcoj1gcKaWcrwkwyhVPFcHq9z3g6s5Jz0ijOmt6ySxj
	OpCa6/jSN6Nrn9yD/Hd1NJWx4u9K4PufpXOA7bvknQ90GwM3I6s+g5jlS/Y7IN8ft8EET0lvt6C
	kwTELLvUhLXg/09K/bnpRMW5NWUyr7dQPaMInILhiRPBrmzM7E8THJqGjOy3KvKaaKeSUZ+b57V
	p2iKY2X0BGz305nqAwCeD4s+jSAIjjk21rbPEQIWI8SXmSnXb3XNLTt9LMRE8dgKHRUYwxUCx2l
	HNAFXcCVJhozJmT3Vxw+jGCceTGzJdt2ZD5xIw/VdWub6vdvLTnfBVlSchB6Ze9VM4nRSb4BYkw
	80DCi8RZ4sMiPjh8RvI9V55hnW5QoV5cFewUf08qq3WYf8eUzmVgLivqqWVXmAZ+DpnTeRVgRKr
	+s9jPztwwpIov8k3G99YqmBaY8qZFsTYnQROchmdNH50KN1vZaK+sbvSCXAaY0/AMcS9Gpv41i3
	aUKpkWAb4XIHGxt/oqqWgougRZbBQF4w4h62HMkvHJ4O1B2p6GbjVTdzRG/cdIB0
X-Received: by 2002:a05:690c:5310:b0:8b0:f1c0:60a7 with SMTP id 00721157ae682-8b0f205b35cmr4777487b3.6.1792193054670;
        Fri, 16 Oct 2026 16:24:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:73b8:7067:c087:bc97? ([2600:1700:6476:1430:73b8:7067:c087:bc97])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e58dc156sm14773577b3.25.2026.10.16.16.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 16:24:13 -0700 (PDT)
Message-ID: <db285527bb969bdd9388a84523979ddff36e86cd.camel@dubeyko.com>
Subject: [GIT PULL] hfs/hfsplus changes for 7.4-rc1
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, vdubeyko@coreweave.com, 
	bruno.produit@trailofbits.com, davyfelipe34@gmail.com
Date: Fri, 16 Oct 2026 16:24:11 -0700
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

Bruno Produit has fixed issue in {hfs,hfsplus}_btree_close()
method. B-tree nodes with a zero reference count remain in
the node hash until folio reclaim or tree teardown frees them.
The folio release callbacks remove nodes while holding hash_lock,
but hfs_btree_close() walks and frees the same hash without
that lock.  Reclaim can therefore unhash and free a node after
close has loaded its pointer, causing a use-after-free or
double-free. Detach each node with hfs_bnode_unhash() while
holding hash_lock before inspecting and freeing it.
Drop the lock before hfs_bnode_free() so a large tree is not
freed while holding a spinlock.

Davy Felipe has fixed issues in hfs_inode_setattr() and
hfs_brec_insert():
- hfs_inode_setattr() rejects unsupported UID, GID and mode
  changes, but returns the value stored in error when
  the filesystem is not mounted with the quiet option.
  At this point error is zero, as execution has already passed a
  successful setattr_prepare() call. As a result, unsupported attribute
  changes are incorrectly reported to userspace as successful even
  though the inode remains unchanged. Return -EPERM for these
  operations while preserving the existing behavior for quiet mounts.
- hfs_brec_insert() may fail while inserting a new extent record, but
  __hfs_ext_write_extent() currently ignores its return value and
  clears HFS_FLG_EXT_DIRTY and HFS_FLG_EXT_NEW as if the insertion had
  succeeded. Use a reusable B-tree node range helper that takes
  the find data and the expected record size. The helper validates
  the bnode and tree pointers, entry offset and entry length, and
  ensures that the write range fits within the node.

Viacheslav Dubeyko has fixed the failure in xfstests generic/339
case. The xfstests generic/339 leaves an HFS+ volume corrupted and,
as a result, fsck.hfsplus reports a long run of "Illegal name".
The root cause is that fs/hfsplus/unicode.c's decomposition table
(Apple Technote #1150) decomposes each source character entirely on
its own and never does anything further with the result. Real fsck_hfs
has carried a permanent "FixDecomps" fixup in CatalogCheck.c for
exactly what that leaves unhandled. Fix makes hfsplus store, hash and
compare names the same way current macOS does.

The following changes since commit
cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
tags/hfs-v7.4-tag1

for you to fetch changes up to
f278d04be3acfd3a9eccf045b9eb180007cceccc:

  hfs: handle extent B-tree write errors (2026-09-30 11:11:14 -0700)

----------------------------------------------------------------
hfs/hfsplus updates for v7.4

- hfs: handle extent B-tree write errors
- hfsplus: add KUnit coverage for canonical reordering and legacy
fixups
- hfsplus: canonicalize decomposed catalog names like fsck_hfs expects
- hfsplus: add Unicode combining-class and legacy decomposition data
- hfs/hfsplus: serialize B-tree close against folio release
- hfs: return -EPERM for unsupported setattr changes

----------------------------------------------------------------
Bruno Produit (1):
      hfs/hfsplus: serialize B-tree close against folio release

Davy Felipe (2):
      hfs: return -EPERM for unsupported setattr changes
      hfs: handle extent B-tree write errors

Viacheslav Dubeyko (3):
      hfsplus: add Unicode combining-class and legacy decomposition
data
      hfsplus: canonicalize decomposed catalog names like fsck_hfs
expects
      hfsplus: add KUnit coverage for canonical reordering and legacy
fixups

 fs/hfs/btree.c            |   7 +-
 fs/hfs/btree.h            |  19 ++
 fs/hfs/extent.c           |  10 +-
 fs/hfs/inode.c            |   2 +-
 fs/hfsplus/btree.c        |   7 +-
 fs/hfsplus/hfsplus_fs.h   |   6 +-
 fs/hfsplus/tables.c       | 496
++++++++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/unicode.c      | 390 ++++++++++++++++++++++++------------
 fs/hfsplus/unicode.h      |  63 ++++++
 fs/hfsplus/unicode_test.c | 309 +++++++++++++++++++++++++++++
 10 files changed, 1165 insertions(+), 144 deletions(-)
 create mode 100644 fs/hfsplus/unicode.h

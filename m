Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222A38F658
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858743; cv=none; b=OkPXQqPynu30dRJHQERNNMGyeRfnVigJ7zS95aCPqqiAEfmHSgQZouwkfoHLERoPuDIftHfBZ3HOWpWF3YFkpuayhtPmFqZJTxGC5xrOxdP+WBXH52W+nRKF2OQHt/pXQzXTSsqwCKd9ADVFxl3mLTGYyxUV0PKPWoUIbaiyu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858743; c=relaxed/simple;
	bh=cM5jMfErasd8BLEAVG1vyvxUr26LK3lPLzuvhGvq9dU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=oG6DntgnrnDxG+h6acYnftdVOVe9A27ovWCdseFJDWCaWGKdS1XHGQYkeAeS08lNqpcOHx5gT95QxzkKWod5wj6W4kfmLKoUl9IZFFApt2cH1/dgVKwOeCDme447D+ZAuM0Y3sVb8VthvQ0ZZ2lQspxU4aSc/1hgwts/K03MtnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=O3hUlAjZ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="O3hUlAjZ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a46260385so29488237b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775858741; x=1776463541; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/XJaVGZ/lI47CNYm2TlDt2u10jZruVaD/13uVW4GfI=;
        b=O3hUlAjZlgCUy3epwaJ44v3E8evXXGaEUj7RPi8GM2gGjfj3sBIPnSRtLuiwlENGGV
         d60M0qfMaf+JkpakldOGaI3i0mghRnh3GiiVsRgPFzXupkbvFEhOL6XsRhYmZk8xJ7XZ
         /KwvNtjeNXV+JUbMF8CY5LbyzG5kS9fUI3duCT9KXd+ord4mRxlp6SjTvn8xwKZo0dlo
         kqW4dYwCqL5LZ3l9nfwoKw7gJCjLRyhuIqLlQN6AhnDFn16tesdpw3/VaLiUYZOfSTGP
         CPrh6dXbDV2wT3Rolou5qwTI+wFffqtJ4E91pgkcHw/4tC8u6A3bUnl1Hlq13S0vT4Tc
         VSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775858741; x=1776463541;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/XJaVGZ/lI47CNYm2TlDt2u10jZruVaD/13uVW4GfI=;
        b=D6Ca1eNFF1HlaXSQXXzD1eVcLAId+BLADPX6/nynROTiArkPVw3ocWc2KvmRNxnqS4
         zSUQEpPQVAOfc7Xbgi6d+yiXN6d4nx1g17xOLJs9RoFYFf9ldxV2J7QueTz84BPtbIZe
         8qVhdvomjREyhqRTrj4LJrfyom6gB3lWpuyM4KN1YXHyF416JE5U9891dAKKKdEvtQbu
         +LyBNqn79/UzYvrVbGHp2sqaBm0m0ybW6IA1WMy1lTPLCbRjxmt7dm74nVe5QKrceLc6
         KxR4EMCGEuc00+PF1VHneyddHa0RH17Jj+R35AFOwx6sC2pBU9DxI0qdIr/atTIUGnv+
         9Gpg==
X-Gm-Message-State: AOJu0YzLv0k7TXSFbbyUQxAAt1NtGA3M22r5nO7dLDh48mJNStawlY9w
	ApQeuFVxPECdFDG9VDi4BgDTjsNP/MkuZtaDm1uSoIF5U8H4G0490uiriNwpjGpjVNI=
X-Gm-Gg: AeBDieuSgj2gW65iZI3spgqiTGzQzZ4Guk/iyPO4xSgnQNfkyvDDnw1TJgsRutxfbJ8
	fgv/xpg33mtnp0ThemIlL9tZF+YVTvqOAE+yC8IpoO8lBMCK2a/BXog29YKDzPX7HdpZcwZ8ojb
	XIigVZfeBSjX5hnsZFiAM9eCMMmscP+XWS6h904tBOaID0cRS6qIW2lWcRE2H+dGZY7FgHgMQTb
	A9mWcH5X23f3q8ZVHrKmPHd/sYmLldxibe/s+CZ8zqSPwZFDYkPWCCVXvPsu+aCyGpE/7d44b9t
	RhU4/Jk84VIygGDbWHa/V2tGklSVn3chtXgQgGnofo3Kj8C6t0oaYP6R1NP5qhBPEViH5dwtoIR
	tHRTViuZHHL+9HxAtMzD4CeN7BUG2ngw6TGzMKoMNx9JXzVWV80K7wOuPU+cyoPUdNg0b/A6nY9
	jHadrk5Qpu2Fl0eOnVXKciHZy3p6eUXy1pQxeLt4PuPJWEdlU4mZ32kB4bjoFa6Lfh9cIvTF+8R
	pBOVDPLq+Tm2AX/+41nTyrBWgciVh7l3kxDOSvCFHi7DkcR0IrZVgu1bVhq
X-Received: by 2002:a05:690c:2506:b0:7a1:3088:e528 with SMTP id 00721157ae682-7af6fbf1a28mr54913667b3.18.1775858741060;
        Fri, 10 Apr 2026 15:05:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:cd6f:deb8:7bef:a487? ([2600:1700:6476:1430:cd6f:deb8:7bef:a487])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3f23f924sm19489487b3.24.2026.04.10.15.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:05:40 -0700 (PDT)
Message-ID: <8a4699567ef82973224fe25d372c0831a46b189e.camel@dubeyko.com>
Subject: [GIT PULL] hfs/hfsplus changes for 7.1-rc1
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, kartikey406@gmail.com, 
	shardul.b@mpiricsoftware.com, zilin@seu.edu.cn, Slava.Dubeyko@ibm.com
Date: Fri, 10 Apr 2026 15:05:38 -0700
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Linus,

This pull request contains several fixes of syzbot reported
issues and HFS+ fixes of xfstests failures.

Deepanshu Kartikey has fixed a syzbot reported issue of
a KMSAN uninit-value in hfsplus_strcasecmp(). The root
cause is that hfs_brec_read() doesn't validate that
the on-disk record size matches the expected size
for the record type being read. The fix introduced
hfsplus_brec_read_cat() wrapper that validates the record
size based on the type field and returns -EIO if size doesn't
match.

Shardul Bankar has fixed a syzbot reported issue of
processing corrupted HFS+ images where the b-tree
allocation bitmap indicates that the header node (Node 0) is free.
Node 0 must always be allocated. Violating this invariant leads
to allocator corruption, which cascades into kernel panics or
undefined behavior. Prevent trusting a corrupted allocator state
by adding a validation check during hfs_btree_open().
If corruption is detected, print a warning identifying the specific
corrupted tree and force the filesystem to mount read-only (SB_RDONLY).
This prevents kernel panics from corrupted images while enabling data
recovery.

Zilin Guan has fixed a potential deadlock in hfsplus_fill_super().
hfsplus_fill_super() calls hfs_find_init() to initialize a search
structure, which acquires tree->tree_lock. If the subsequent call to
hfsplus_cat_build_key() fails, the function jumps to the out_put_root
error label without releasing the lock. Fix this by adding the missing
hfs_find_exit(&fd) call before jumping to the out_put_root error label.
This ensures that tree->tree_lock is properly released on the error
path.

Yangtao Li has fixed the issue of not updating the change time
after file change. The fix updates file's ctime after rename in
hfsplus_rename().

The rest patches introduce the HFS+ fixes for the case of generic/348,
generic/728, generic/533, generic/523, and generic/642 test-cases of
xfstests suite.

The following changes since commit
6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
tags/hfs-v7.1-tag1

for you to fetch changes up to
c1307d18caa819ddc28459d858eb38fdd6c3f8a0:

  hfsplus: fix generic/642 failure (2026-04-08 14:23:29 -0700)

----------------------------------------------------------------
hfs/hfsplus updates for v7.1

- hfsplus: fix generic/642 failure
- hfsplus: rework logic of map nodes creation in xattr b-tree
- hfsplus: fix logic of alloc/free b-tree node
- hfsplus: fix error processing issue in hfs_bmap_free()
- hfsplus: fix potential race conditions in b-tree functionality
- hfsplus: extract hidden directory search into a helper function
- hfsplus: fix held lock freed on hfsplus_fill_super()
- hfsplus: fix generic/523 test-case failure
- hfsplus: validate b-tree node 0 bitmap at mount time
- hfsplus: refactor b-tree map page access and add node-type validation
- hfsplus: fix to update ctime after rename
- hfsplus: fix generic/533 test-case failure
- hfsplus: set ctime after setxattr and removexattr
- hfsplus: fix uninit-value by validating catalog record size
- hfsplus: fix potential Allocation File corruption after fsync

----------------------------------------------------------------
Deepanshu Kartikey (1):
      hfsplus: fix uninit-value by validating catalog record size

Shardul Bankar (2):
      hfsplus: refactor b-tree map page access and add node-type
validation
      hfsplus: validate b-tree node 0 bitmap at mount time

Viacheslav Dubeyko (10):
      hfsplus: fix potential Allocation File corruption after fsync
      hfsplus: set ctime after setxattr and removexattr
      hfsplus: fix generic/533 test-case failure
      hfsplus: fix to update ctime after rename
      hfsplus: fix generic/523 test-case failure
      hfsplus: fix potential race conditions in b-tree functionality
      hfsplus: fix error processing issue in hfs_bmap_free()
      hfsplus: fix logic of alloc/free b-tree node
      hfsplus: rework logic of map nodes creation in xattr b-tree
      hfsplus: fix generic/642 failure

Zilin Guan (2):
      hfsplus: fix held lock freed on hfsplus_fill_super()
      hfsplus: extract hidden directory search into a helper function

 fs/hfsplus/attributes.c    |  44 +++++++--
 fs/hfsplus/bfind.c         |  51 ++++++++++
 fs/hfsplus/bnode.c         |   3 +
 fs/hfsplus/brec.c          |  32 +++---
 fs/hfsplus/btree.c         | 241 ++++++++++++++++++++++++++++++++++++-
--------
 fs/hfsplus/catalog.c       |  11 ++-
 fs/hfsplus/dir.c           |  23 ++++-
 fs/hfsplus/extents.c       |   7 ++
 fs/hfsplus/hfsplus_fs.h    |  26 ++++-
 fs/hfsplus/inode.c         |  42 +++++---
 fs/hfsplus/super.c         |  47 +++++++--
 fs/hfsplus/unicode.c       | 121 ++++++++++++++++-------
 fs/hfsplus/unicode_test.c  |  51 ++++++----
 fs/hfsplus/xattr.c         | 156 +++++++++++++++++++++++------
 include/linux/hfs_common.h |   9 ++
 15 files changed, 682 insertions(+), 182 deletions(-)

Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2E3B14B7;
	Sat,  1 Aug 2026 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785624996; cv=pass; b=AUpfi9zDznHUkxHwxBnlKIa8kaPmx3g7IZnmp0k+kun60K62vxIrgrNfezl2v6ZqQEjS62gG0FTbpoIu1HmdWX7Sbn957x7rlIFL1D4dldYWXM9qzgqlrFwCNbUaZCBCCfGAHbxUiOWAARS5mZtDdG3xN5OnrJekp6JrJZuWpcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785624996; c=relaxed/simple;
	bh=abAaH2vcCsKHHcbyvDRFtWgQaQD84rFOXw2e+cCtaOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1ujPrNbAmrGLiS7UFmMqXWXabXqZL3i24is7D9BhuuXHNG6bPRLrXICgqCeu0apxY6xYaUDIVEMod1IJ9okWhWJzMGXE4YcRpn4vL0TpR7xMH1Rogk3nCQDQWpUV9w5kFk+nqhEC8+F5zf5mfcIf3J/uNGNn4z+GMmUmAN8T78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=U4U0feA3; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="U4U0feA3"
ARC-Seal: i=1; a=rsa-sha256; t=1785624966; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Sd95huZOnQg1FBuMvTD+cysTLqVQy4xj348zmmc9jRMcQcPccMi35RWmmMCC/gG2jQaV8CyQrKArKeCWZkcNyzkd259I5Q20ZlduxlvAbNVl8UmfuRAPK5Z6NNtCun98QPNC0MaROggR1GGMcBkyjTOvf5dL3hXs1NvypRykW7g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785624966; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E/8E9wlG3ScKMWg9N9gtBQgy0MCIgumMmXyH0y2xWCE=; 
	b=Ursk6gRI8QJPWD2wYc+tmqTOug7J2yMPAV8+bQPwhu7PnPZfKIsnIMs1qhaGYmQgmU1AqOHSnde6GvFanl9eQvogdibmqIcsedTdmHfELeNjG77iyGo+NCyg98wr6Z1sT1kD/Oxa98A+tuhFw8NDpLgxcKuDgKm4VYdUXudBBKo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785624966;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=E/8E9wlG3ScKMWg9N9gtBQgy0MCIgumMmXyH0y2xWCE=;
	b=U4U0feA3lWz20RdNVqKXznUTNUXGdCwOXUeiUsChGR1nROqUr/dFLVqXk8GbFyHf
	8QeQvQKDMLvmNpXVcykCPRe1t+jDYsfQzOTD3W0itGAnYbWeo7nm3G3Od/9Jo8v+3AS
	XXBvHS9Vpi+dVdLL94lwh/O8OOolosTHLXtN/DTQ=
Received: by mx.zoho.eu with SMTPS id 1785624964557853.5268062547236;
	Sun, 2 Aug 2026 00:56:04 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] ufs: correctness fixes for valid on-disk filesystems
Date: Sat,  1 Aug 2026 22:55:20 +0000
Message-ID: <20260801225530.148386-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The recent fs/ufs traffic has mostly been hardening against crafted
images. This is the other kind: filesystems that are entirely valid,
written by FreeBSD or by Linux itself, that fs/ufs then handles wrongly.
Most of it comes from comparing the code against what modern FreeBSD
writes; Linux last looked at the UFS2 layout around FreeBSD 5.x, and
several fields it still treats as spare have been in use for years.

Patch 1 is preparation with no functional change: it splits
fs_44.fs_sparecon[50] into the fields FreeBSD defines. The layout does
not move. sizeof(struct ufs_super_block_third) stays 356 and
fs_contigsumsize stays at offset 292, checked with the compiler before
and after, and cross-checked against a superblock written by mkfs.ufs,
where the same field sits at absolute offset 1316 with usb3 based at
1024.

Patches 2 and 3 are extended attribute fallout. A UFS2 inode can own
attribute blocks in di_extb[], which ffs_alloc() counts in di_blocks, so
deciding fast symlinks by i_blocks misfires on a short symlink that has
an attribute, and unlinking any inode with attributes leaks the blocks.

Patches 4 and 5 are the on-disk file flags. New inodes inherit the
parent directory's chflags, which FreeBSD never does, and the flags that
are there never reach S_IMMUTABLE or S_APPEND.

Patch 6 is an arithmetic bug in ufs_change_blocknr(), where a buffer
index within the folio is used as an offset into the relocated range.
It needs a page larger than the filesystem block. It does not touch the
deeper relocation problems described in [1], only the offset.

Patches 7 to 10 are mount policy. The read-only decision taken at mount
time can be undone with remount,rw, and nothing looks at the modern
feature flags, so filesystems needing fsck or journal replay, or holding
snapshots or metadata check hashes, are written to as if ordinary.

Testing
-------

Built with W=1 and checkpatch --strict clean on all ten. Runtime tested
in qemu against images from mkfs.ufs (Debian ufsutils 8.2). Cases that
need on-disk state Linux cannot create were produced by editing the
images directly. Every case was run twice, once on this series and once
on the unpatched base, same images, same script.

x86_64, KASAN, UFS2 16384/2048 and UFS1 8192/1024:

  case                                    unpatched          patched
  readlink, short symlink with extattrs   I/O beyond end     correct target
  unlink of the same symlink              ufs_panic          clean
  extattr fragment after inode delete     still allocated    free
  new inode under a flagged directory     flags 0x1          flags 0
  create inside an SF_IMMUTABLE dir       succeeds           EPERM
  remount,rw with fs_clean FSACTIVE       succeeds           refused
  FS_NEEDSFSCK / FS_SUJ read-write        read-write         read-only
  active snapshot read-write              read-write         read-only
  FS_METACKHASH read-write                read-write         read-only
  FS_METACKHASH with no hashes set        read-write         read-write

The unpatched readlink failure is the chain patch 2 describes, with the
ASCII of the link target used as a block pointer:

  vdl: rw=8388608, sector=15116822126868137148, nr_sectors = 4 limit=131072
  ufs: panic: ufs_free_fragments: freeing blocks are outside device

The last line of the table is a negative control: a filesystem that
advertises check hashes without maintaining any stays writable, so patch
10 is not simply refusing everything. 26 of 26 checks pass on the
series, KASAN quiet on both runs.

arm64 with 64 KiB pages, UFS1 4096/512, for patch 6:

  case                                    unpatched          patched
  file survives a tail relocation         corrupt at 4096    intact
  neighbouring file after relocation      intact             intact

A block is 8 fragments there and blks_per_page is 128, so a tail in the
second block gives beg 8 and beg & mask 8. With the fragments that
physically follow the tail occupied, extending the file relocates it and
the first byte of the moved tail reads back as zero. The same test on 4
KiB pages never reaches a nonzero beg & mask, which is why the bug is
invisible there.

Patch 10 is the one I am least sure belongs. Refusing read-write on
check-hashed filesystems is correct, but FreeBSD enables check hashes by
default, so images that mount read-write today would stop. That is a
policy call rather than a bug fix, and the patch is independent; drop it
and the other nine still apply.

Not addressed: UFS still has no extended attribute or ACL support, so
FS_ACLS filesystems are read with their access control ignored, and
fs_clean is never set to FSACTIVE while mounted read-write, so a crash
leaves a filesystem looking clean. Both are larger jobs.

Two things I looked at and dropped rather than send: the 4 GiB directory
truncation in ufs_last_byte() is already posted by YANXIN LI [2], and
the UFS_FSLOG read-write behaviour turned out to be deliberate, added in
2010 by Alex Viskovatoff with Evgeniy Dushistov's ack [3].

[1] https://lore.kernel.org/all/20241018231428.GC1172273@ZenIV/
[2] https://lore.kernel.org/all/20260718190300.867109-1-fadouse@pm.me/
[3] https://lore.kernel.org/all/1265683224.4096.1358983441@webmail.messagingengine.com/

Ali Ahmet Memis (10):
  ufs: name the modern UFS2 superblock fields
  ufs: use i_size to detect fast symlinks
  ufs: free UFS2 external attribute blocks on inode deletion
  ufs: do not inherit file flags from the parent directory
  ufs: honour on-disk immutable and append-only flags
  ufs: fix fragment relocation offsets within a folio
  ufs: revalidate filesystem state before remounting read-write
  ufs: refuse read-write mount when fsck or journal replay is needed
  ufs: refuse read-write mount of filesystems with active snapshots
  ufs: refuse read-write mount of check-hashed filesystems

 fs/ufs/balloc.c |   8 +--
 fs/ufs/ialloc.c |   4 +-
 fs/ufs/inode.c  | 126 +++++++++++++++++++++++++++++++++++++-------
 fs/ufs/super.c  | 136 +++++++++++++++++++++++++++++++++++-------------
 fs/ufs/ufs.h    |   2 +
 fs/ufs/ufs_fs.h |  33 +++++++++++-
 6 files changed, 246 insertions(+), 63 deletions(-)


base-commit: 2d2338c93da79b3bfe4b6099a931d9468d539952
-- 
2.55.0


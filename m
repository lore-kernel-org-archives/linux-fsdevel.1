Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795756943;
	b=PHWphWTxDF8DeazZve5GL0YFFBOgPvswQdlq3jCxcLR9AbU4DiEK0xShkTSamT0FpP42
	 k17mBiVVOtEhjab+/wQcodNfyPXMiDozq0uMfO5kUWpF/MERVdywAeyi24sMg9t4LWyaM
	 WpvC9KOw54bN0Ib6uHb4t9hvwGuGWecfP1Lvr2oRd1FTRMm5ad0cA1gmqrsMbK1k/gImp
	 bdWpOnjYeqIFLS2wnGCzuKsVHpuaXXH1QlA8YhjRCjd372Ug09aZTc9tr4sxAj+YseSTp
	 jMu77PqxW731m49UGgp1GM+z4a5VGH/fbzNBN9t72H4lYTLz5FJixzMfQiR9LrTJZgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795756943;
	h=DMARC-Filter:Received:From:Subject:To:Cc:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Date;
	bh=ZVzkz6cxPM/IifJCHIDhlGXAsKcYOygkvb4Ppz+DZWs=;
	b=nQauntr7r5di/O5X+SxaqJ6UQEjpD9lqM5ggWMcCNWKDpuJZ35JXSYl6njqPOG2YdmZp
	 bkfGdLuTRtRQlBTrFYdDUUQn8itM/sAzv+fKByOabzK3gQrtyZxaIRtJWkAEnaILfhmSp
	 CVsHDbhLnlot00LlOPAnSzJex9RH0WcenOs7VxB59JD2pzJOQckLqWSTyYajK8CiLPr4a
	 s3EDlZ6a14ODuI3a1C1/GwbcKudRyI/Om2ixbnJ7g+Y+7tc1dTbCYb9mfIqe3lsuvpKxc
	 53FcycdTl8/mIeBnTNv/cvEfE9hxaVMA9gnNwrgPA2LR2Ju4IJRYDazrfUOKwNTCuRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33E1606A31C;
	Fri, 27 Nov 2026 05:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E33E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id B1F54C9314; Fri, 27 Nov 2026 14:22:20 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH 0/4] ufs: fs_clean and fs_mtime of a 44bsd filesystem that is read-write
To: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
    Ali Ahmet Memis <ali@iusegentoo.com>,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Message-ID: <20261127-ufs-suj-0-v1@snowrabbit.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Fri, 27 Nov 2026 14:22:20 +0900 (JST)

After Linux crashes with a FreeBSD UFS mounted read-write, fsck_ffs -p
of FreeBSD 15.0 says

  /dev/md0: FILE SYSTEM CLEAN; SKIPPING CHECKS

and fsck_ffs -fn then finds 161 to 224 errors in it.  ufs leaves
fs_clean at 1 while the filesystem is read-write.

Patch 1 keeps fs_clean at 0 while a 44bsd or ufs2 filesystem is
read-write.  Patch 2 reads 2, which NetBSD leaves after a crash, as not
clean.  Patch 3 sets fs_mtime, without which FreeBSD's fsck recovers
from its soft updates journal and marks the filesystem clean.  Patch 4
keeps ufs_error() from storing 0xff, which the BSDs read as clean.

What changes for a user of Linux alone: after a crash the filesystem is
mounted read-only the next time, as one that FreeBSD left unclean is
today.  It can still be made read-write with remount, and then stays not
clean until a fsck on a BSD.

The filesystems were UFS1 and UFS2 with journaled soft updates.  Six
processes created, renamed and removed files, the device was suspended
with dmsetup, and its backing file was copied; eight such copies for
each kernel.  The UFS2 had its check hashes turned off in the image, as
Linux does not keep them; with them on fsck_ffs -p stops at the cylinder
group hashes with and without the patches.

Without the patches fsck_ffs -p skipped all eight as clean, and
fsck_ffs -fn found 161 to 224 errors in each.  With patch 1 alone it
recovered all eight from the journal and marked them clean, and -fn
found 154 to 225 errors.  With all four it says "Journal timestamp does
not match fs mount time" for all eight, goes on to the full check and
exits with 8, asking for a manual fsck; -fn reports 139 to 240 errors.

After an unmount fsck_ffs -fn finds nothing with any of the three.
After a remount to read-only it finds one without the patches, FREE BLK
COUNT(S) WRONG IN SUPERBLK, and none with them.  fs_clean goes
1, 0, 1, 0, 1 over mount read-only, remount read-write, read-only,
read-write, unmount.  A filesystem with 0 that is remounted read-write
has 0 after the unmount, and FreeBSD checks it.  One with 2 is mounted
read-only and keeps 2.  After ufs_error() fs_clean is 0, and 0 after
the unmount; it was 255.

Not tried: the background check that fsck -F leaves a filesystem with
soft updates only to, gjournal, write errors, and a filesystem made by
NetBSD.  That the BSD kernels read 0xff as clean is from their sources.

Patches 1, 7 and 8 of "ufs: correctness fixes for valid on-disk
filesystems" by Ali Ahmet Memis (2026-08-01) touch the same places.
Patch 1 there names the fields in fs_sparecon, fs_mtime among them, as
patch 3 here does for that one.  Patch 7 there refuses to remount
read-write a filesystem that is not clean; patch 1 here lets it through
and leaves it not clean at unmount, as the BSDs do after a forced mount.
Patch 8 there refuses UFS2 with a journal read-write; patch 3 here
leaves it writable and has FreeBSD's fsck ignore the journal.

This is on the fs/ufs of next-20261125.  Patch 2 applies to Linus' tree
(4dce97c6c265) as well; the others are on top of the sb_emergency_ro()
changes in next.

Showta Ishizaki (4):
  ufs: clear fs_clean of a 44bsd filesystem while it is read-write
  ufs: do not take a filesystem NetBSD has mounted for clean
  ufs: let FreeBSD see that its soft updates journal is out of date
  ufs: leave fs_clean of a 44bsd filesystem at 0 after an error

 fs/ufs/super.c  | 102 ++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ufs/ufs.h    |   1 +
 fs/ufs/ufs_fs.h |   4 +-
 3 files changed, 103 insertions(+), 4 deletions(-)

-- 
2.54.0 (Apple Git-157)


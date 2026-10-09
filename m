Received: from a9-38.smtp-out.amazonses.com (a9-38.smtp-out.amazonses.com [54.240.9.38])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7464F4020;
	Fri,  9 Oct 2026 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574906; cv=none; b=nUJ1ZwUwsb+961PKbg77O/+13+1Q9Z3ZmloyA3UDx2CfCIPCUTFs+bT7UIz9wPNkFyviSPz+V7ipzd8q2kcLPcs7wSVHff2+aoHikMx4mrXTKnJl63jlS9Xut+G42xQz/vwPaQsne8G35wGX4dQyzUe6OEHMaqT5zwtF3e1+cGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574906; c=relaxed/simple;
	bh=zo2hHrAETes0BxoLPKZMZ693zKCAzqOlZOVWCwq+IDQ=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=oHBHG8HTr5rpaFgzZPF+19kxEgj/Xc04Dq2crJuyYGYAfZqVYjivX1NHRx/Soi4m8K9nzR1qIuHbGoGuw5Yryd/cLrdqYOVEh98nNzxRaAXgoAEQS5HQLqJWIALg1kf3ioEXmX7raPCtbdTxCjNaPx+4+/+iPgVt7oPxW46P2V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nicolasfalesy.com; spf=pass smtp.mailfrom=send.nicolasfalesy.com; dkim=pass (1024-bit key) header.d=nicolasfalesy.com header.i=@nicolasfalesy.com header.b=FX0iCcFF; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=o9IdWwpl; arc=none smtp.client-ip=54.240.9.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nicolasfalesy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.nicolasfalesy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nicolasfalesy.com header.i=@nicolasfalesy.com header.b="FX0iCcFF";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="o9IdWwpl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=nicolasfalesy.com; t=1791574894;
	h=From:To:Cc:Reply-To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=zo2hHrAETes0BxoLPKZMZ693zKCAzqOlZOVWCwq+IDQ=;
	b=FX0iCcFFcno0z74mhSy0D92djf9ZvP7EOnN4SyFgtvHgyFOWx3JtGfm+34IOwS0D
	SlyhQ7Ytl2adrzBQWzRuGRRZtU6HI0Ir8AeivmpPNoERqzpem6SXHKzrGIJ+NfIDX44
	k6Y/YCX+Mc176+OJhbNGUVJ9mt6Qae2lMQZO7hyo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1791574894;
	h=From:To:Cc:Reply-To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=zo2hHrAETes0BxoLPKZMZ693zKCAzqOlZOVWCwq+IDQ=;
	b=o9IdWwplYefV+66L8k8YRNQgtSXB5DkWO0ySiSd1LLaC1mPBjpbgkhizIACdaet4
	a9vK/jv6dxggCFIiWSpB5IzRU4ATmnBAURm55fE6cK4xGG8fWEiUK4qNXH0CHXcg9TX
	QcBHo3fdyhB+zSHpP26XW0xSASmeTpcip+cMhUXw=
From: Nicolas Falesy <nicolas@nicolasfalesy.com>
To: linkinjeon@kernel.org, sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com, exfat@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, hch@lst.de, djwong@kernel.org, 
	nfalesy@gmail.com
Reply-To: nfalesy@gmail.com
Subject: [REGRESSION 7.2] exfat: stale dentry buffer of a deleted directory
 overwrites new file data
Message-ID: <010001a1222f66ba-0c745f29-d4fe-4862-93ff-1db2055b05fc-000000@email.amazonses.com>
Content-Transfer-Encoding: 7bit
Date: Fri, 9 Oct 2026 19:41:34 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.ab+1BOhI2G8lKXniYmrQtu8hqInlQv0hMf7S3fw6DdXZuhPmWRop4As2nYC+PvMCg/MeYgni+TDnIGoO6UR5+695Ups99kH4xr2cW/T33RKlxcJfmzZvDG+/D2zFM008PnQSMHraaQXnsyHltCPK4i0yAdm73tum8YqlC4670Nc=:1.us-east-1.QSNtDRXSTq9sAuvRl56h5mypgasnQ5yDLNpVzTnziu0=:AmazonSES
X-SES-Outgoing: 2026.10.09-54.240.9.38

Resent as plain text from a different address: the earlier copies
from my Gmail were rejected by the lists for containing HTML.
Sorry to the maintainers for the duplicates.

Hi,

Since v7.2, exfat can silently corrupt a newly written file: if a
directory with entries is deleted and its cluster is then reused for
file data, the deleted directory's dirty dentry buffer_head is still
in the block device mapping, and a later flush of the bdev (fsync,
syncfs, umount) writes it over the new data. The file reads back with
one 512-byte sector replaced by the deleted directory's (now
"not in use") directory entries. No error is reported.

It reproduces 100% of the time on v7.2.x and v7.3-rc6, and not at all
on v7.1.11 or v6.18.55. It happens with buffered writes (with or
without fsync) and with O_DIRECT. A syncfs() between the delete and
the new write avoids it.

#regzbot introduced: v7.1..v7.2

Reproducer (run as root; any non-exFAT working directory):

---8<---
#!/bin/sh
set -e
W=${1:-/tmp/exfat-repro}
mkdir -p "$W/mnt"; cd "$W"
truncate -s 0 img; truncate -s 256M img
mkfs.exfat img >/dev/null
DEV=$(losetup -f --show img)
mount -t exfat "$DEV" mnt
# A pushes the next allocation to ~188 MiB, where D's cluster goes.
dd if=/dev/zero of=mnt/A bs=1M count=188 status=none
mkdir mnt/D
touch mnt/D/f0 mnt/D/f1 mnt/D/f2
umount mnt; mount -t exfat "$DEV" mnt       # start with clean buffers
rm mnt/D/f0 mnt/D/f1 mnt/D/f2               # dirties D's dentry buffer
rmdir mnt/D                                 # frees D's cluster
rm mnt/A
# B reuses A's clusters, then D's freed cluster (file offset 188M).
head -c 200M /dev/urandom > ref
cp ref mnt/B
umount mnt; mount -t exfat "$DEV" mnt
if cmp ref mnt/B; then R=PASS; else R=FAIL; fi
umount mnt; losetup -d "$DEV"; rm -f img ref
echo "$R: exfat stale dentry repro on $(uname -r)"
[ "$R" = PASS ]
---8<---

On an affected kernel it prints, every time:

  ref mnt/B differ: char 197132289, line ...
  FAIL: exfat stale dentry repro on 7.3.0-rc6

Results

All runs in a KVM guest (4 vCPU, 4 GiB), image on tmpfs behind a
loop device, mkfs.exfat from exfatprogs 1.4.3 with default options
(256 MiB volume, 4 KiB clusters, 512-byte sectors).

"nofsync/fsync/O_DIRECT" is a harness equivalent to the script above
that writes B (filling the volume minus 1 MiB) with a per-4KiB-block
pattern and checks it with O_DIRECT reads after a remount; "syncfs"
adds a syncfs() on the mount between the deletes and writing B.

  kernel                     nofsync  fsync  O_DIRECT  syncfs  script
  6.18.55 (Arch linux-lts)    0/20    0/10    0/10     0/10    0/5
  7.1.11  (Arch linux)        0/20    0/10    0/10     0/10    0/5
  7.2.5   (distro build)     20/20   10/10   10/10     0/10    5/5
  7.2.9   (Arch linux)       20/20   10/10   10/10     0/10    5/5
  7.3-rc6 (defconfig +
           kvm_guest +
           EXFAT_FS/LOOP)    20/20   10/10   10/10     0/10    5/5

(n/N = corrupted runs / runs.) Every corrupted run had exactly one
bad 512-byte sector, always at file offset 197132288 (188 MiB), which
is the disk location of the deleted directory's cluster
(volume offset 199249920).

Observed bytes

First 64 bytes of the bad sector (7.3-rc6, buffered, no fsync; the
same layout on every kernel, only timestamps/checksum vary):

  05 02 e3 79 20 00 00 00 38 98 49 5d 38 98 49 5d
  38 98 49 5d ac ac 80 80 80 00 00 00 00 00 00 00
  40 03 00 07 13 c2 00 00 00 10 00 00 00 00 00 00
  00 00 00 00 08 bc 00 00 00 10 00 00 00 00 00 00

i.e. a File entry (0x85) and Stream Extension entry (0xC0) with the
InUse bit cleared: the deleted entries of a file inside the removed
directory (this harness used 4 KiB files named "zqfile0".."zqfile2";
first cluster 0xbc08, length 0x1000). The rest of the 4 KiB cluster
holds B's correct data; only the one sector whose buffer was dirtied
by the deletes is overwritten.

Analysis (hypothesis, from reading v7.3-rc6 fs/exfat)

exfat accesses directory entries through buffer_heads of the block
device (sb_bread() on s_bdev). Deleting the files in D marks their
entries free in D's cluster and dirties that buffer
(exfat_remove_entries() -> exfat_put_dentry_set() ->
exfat_update_bhs(), fs/exfat/dir.c). After exfat_rmdir(), D's
cluster is freed when the inode is evicted (exfat_evict_inode() ->
__exfat_truncate() -> exfat_free_cluster()), but nothing cleans or
forgets the dirty buffer, so it stays dirty in the bdev mapping.

Up to v7.1 this was harmless: file data went through
exfat_get_block() and __block_write_begin_int() /
do_direct_IO(), which call clean_bdev_bh_alias()/clean_bdev_aliases()
for newly allocated (buffer_new) blocks, dropping any stale bdev
buffer for the reused blocks.

In v7.2, commit 82a81a7352bc ("exfat: add iomap buffered I/O
support") and 867b9c96dc83 ("exfat: add iomap direct I/O support")
moved data I/O to iomap. __exfat_iomap_begin() (fs/exfat/iomap.c)
allocates clusters via exfat_map_cluster() and sets IOMAP_F_NEW, but
nothing calls clean_bdev_aliases() for the new clusters any more. The
file data is written through the inode's mapping, and the later
sync_blockdev() (exfat_file_fsync(), or sync_filesystem() at syncfs /
umount) writes the stale dentry buffer over it. That fits all of the
above: always exactly one sector, at the freed directory cluster;
fixed by syncfs() between delete and write (the buffer is written
back to its old, still-free place first); FAT/vfat, still on
buffer_heads for data, did not show it (0/60 with an equivalent
harness on 7.2.5).

A candidate fix (not a formal patch; tested only with this
reproducer, all cases above 0/N on v7.3-rc6 with it applied):

--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -7,6 +7,7 @@
 
 #include <linux/iomap.h>
 #include <linux/pagemap.h>
+#include <linux/buffer_head.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -77,6 +78,21 @@
 	if (err)
 		goto out;
 
+	/*
+	 * New clusters may still have dirty buffer_heads in the bdev
+	 * mapping (e.g. dentries of a just-removed directory).  Drop
+	 * them, as __block_write_begin_int() did for buffer_new
+	 * blocks, so a later bdev flush cannot write stale metadata
+	 * over the new file data.
+	 */
+	if (balloc) {
+		sector_t first = exfat_cluster_to_sector(sbi, cluster);
+		sector_t nr = (sector_t)num_clusters <<
+			      sbi->sect_per_clus_bits;
+
+		clean_bdev_aliases(sb->s_bdev, first, nr);
+	}
+
 	cluster_offset = exfat_cluster_offset(sbi, offset);
 	cluster_length = exfat_cluster_to_bytes(sbi, num_clusters);
 

An alternative would be to bforget()/clean the directory's buffers
when its clusters are freed (exfat_free_cluster(),
fs/exfat/fatent.c), but other freed metadata clusters could have the
same problem, so cleaning aliases on allocation (as the buffer_head
path did) seems the more complete fix. I have not checked whether
other iomap paths (e.g. page_mkwrite / fallocate) also allocate
clusters without it.

Workaround

Call syncfs() (or sync) on the exFAT mount after deleting
directories and before writing new data, or avoid v7.2+ for exFAT
volumes until fixed.

Disclosure: I found this while building a tool with an AI coding
assistant (Claude), which also helped with the analysis and the
candidate fix. The reproducer and every result above were run on the
kernels listed.

Thanks,
Nicolas Falesy

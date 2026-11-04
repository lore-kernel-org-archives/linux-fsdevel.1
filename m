Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825118;
	b=dQmWtulTP0KUOg+uUOnVCSOaa085xO4NeAcZ/lmUnKd5hOYhgtNWEfUGJZzW8kkbrX4i
	 k0amKgs5lvK4Q1Q/0/BakDAbqh3wQOsdFKmP2Q6CoPQX80gL5clDvRqtADkrl3Y4AJfdA
	 H/rwkYAwxTZ0PBMs/tG7RnM6SMSAHwY80hwsGRy2dXy6oLMhg7wdd5UrsAVdXzthJbI7W
	 M4bmJ3mFY7J+/4iFbDheLCgB8p3LZkcNvCmdWTPBvhlwLehcae+HmTXvIT4/HWk4G0S2U
	 iannn8ww58keKx+uiTmxykDx5NP/yjPTrpNvn+wzjy8lG+5uaTRWP3GhQMSGOf3pnng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=SQa+5QDLJp4c1K44TEDfHU/qPJ38QahiS1eT1+g2fvc=;
	b=v7+WSdXxXz69tTH6//APRW/N/DYIShcI9BVfpIXGfRcv4IpG9RV52KQcH29v0+t/IoU7
	 k3eDUum9t9GAroXX57Ib3EF483LjScJfLOtsWB8OmUZUJbNtKVQ9DYsgXhibyk4eweUhR
	 3YFLg7DBXI6SnyuX/yLStiqfgkup5pl1/08Imq2MQ+n66EsW67zYBRw7PKtOuUKIg2Rq8
	 V2NJRDLymmMrXYLYi1gD69im0klcF6vbibQUs1mPVk1qWXGaNXQDnR8V53P7PmkGW6xVv
	 7CZeGSWwxUrQnwg4IG9pJOxwXGmRp5WxdDmMYTPxr7Y10CzTP54sBqoQKN3L8BQuFRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=VqWsJaBv;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B3606BA3F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 20:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 251B3606BA3F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=VqWsJaBv
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e7ad9f78dso132297085a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 12:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825117; x=1794429917; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SQa+5QDLJp4c1K44TEDfHU/qPJ38QahiS1eT1+g2fvc=;
        b=VqWsJaBvh4Ij+ZHM4s7d1iBz5AuDyIpTspi0KF0W68FnZQsLCp13seWNIKUZ19xzj6
         6t1euWPJ8nCGPPXfzmFJcdvo4c0rxY1A549EgmhdPS0tvxFnYoF/XTZbkKi9cjdH62ui
         Y5cpwrGsQuXEox8I6nSfsbqe+pxbqx3Qmx7wcPjlgeMHSLObPZXuDGuyBHt6Bat2vCgf
         9eilKRUcLYqFw6oe0w/bdC5Tay6wUgogXTfYC8THMGo327jbkYU3llxVIc9q2zrieKLH
         2IWSeOguFytTNRLIR6o0Bcd5w8QxbqGUW8xUHN2h3HGQilOIoLTjp+SDA9a372h7Aq5l
         jDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825117; x=1794429917;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SQa+5QDLJp4c1K44TEDfHU/qPJ38QahiS1eT1+g2fvc=;
        b=1Tjk4eepuljf8CyCnbZN5OynyYKk01GYhUPAYzAlaiY0z4GerzPfC/Ar9+VtqVeCsr
         l9KREcXDvdrYDh87QAwFjTR/zZZ+rYFWHGK6/Q9b+utdw4hR3iUPLSey2k8RPk4yCVr5
         uv2xWXTRqX+cTef+z2Fk+gRJ5noznklGXhdLUTGuOe4/2V7x/bzxfWDi5mQKnGI0nb+2
         wvq/JF+V/3FJ6Zagz73RmKEk1sqabiyPH8q2/fWrzKA3s4r4dDYQeEySXy0NeeM1CZ9p
         1LZou/TnH2exg1x1gMRDCAq0136Kqxbe9m/sV2Rnsx+oc7YFeP0OZ3cM83NjdKVuhpyg
         JXrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFS3yaTx9rWtEnzF8SqRxj0E1yxuNeXT0hHXfG0zO7SlXK1PaZUlI3I6ppTaMIqz7blafkTTD9bojrtJLM@vger.kernel.org
X-Gm-Message-State: APuU4Z9feuhycBwin89WR1Z2Pxr8Zwzh0j/ACJpeIPz/O/BM58FADtGM
	tmYDcbQ748dfvjMsAg3yqqchdVwQF+nvNuzpAhj3nmB1xaIjj3uSAABtKG84Tcu47WM=
X-Gm-Gg: AYBFou1Vkx7cIqI4uV4ccjQkX/lkVS1PlIsZ9XcIqyzm1mwXANi3SOy8T+AmlXvOnlM
	Edgf64Ff4javV100USDY8J6jZbobZvNTaTy/nkUItEHub2dxtv2o4aOVGBsoGRazXscjoVLjzc6
	3HXmFc6JAJy9lAhxn3139Tu0sCRd2bhMbloqjNumKWPR30G3C5w2yERK2Y36V2n3aVkw2YCxRu6
	r7OTI1Zbb7xWYOe075/ewFsnbydnZnwLWFBBeD+ntP5sD9BDZRMwFjIFR9j75v+X6dq/bwoJ6yg
	oMiBG2Y3qkATpr1nmWAbE/vE6MCm/dx4P/Fx4LhKbY3wRlYRtrBBlLvhJWNZgZgjgkCXNXMjDtk
	LDL3O1TJ/qSW29tECSY8YuZJ5l45wdzHhH+19OVOQ6s0cZqF8JakfIVOtYt3oFS/ARZU6vjWRfN
	pMZIQFQ/ta5rPzRCf1sYai8H69JDzcAA3izTnTJSP+VgfzNYpFfvB4e7dniT7YnAPUqRFuDb3Yv
	Mf/L06KRxyRmgZbeSD/BScyGFD7qmMuNxxT3mo6Y4jCtngno6JyY9paSX90a3cdd55D9WSXXKsX
	c5JNPfDTxbpMYztww8bLnEWF6I8BbtD+ceidqwCrKl5T6g==
X-Received: by 2002:a05:620a:17ab:b0:940:f53d:5f7 with SMTP id af79cd13be357-944217ee7f8mr2773288785a.69.1793825116676;
        Wed, 04 Nov 2026 12:45:16 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d482e7efsm292937785a.24.2026.11.04.12.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:45:16 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 0/8] ovl: only sync what was written through the overlay
Date: Wed, 04 Nov 2026 20:44:57 +0000
Message-Id: <20261104-b4-ovl-containerized-sync-v3-0-8daa20144f53@toxicpanda.com>
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
X-B4-Tracking: v=1; b=H4sIAEqZ62oC/32Oyw7CIBBFf8WwdhSwPnDlfxgXA51ajEIDlfhI/
 13QmJhoXMziTO49uXcWKViKbD26s0DJRutdhtl4xEyLbk9g68xMcrkQ+UBX4NMRjHc9WpfLN6o
 hXp0BUSlNtcCGFLLc7wI19vJ0b3cvjmd9INMXYUlojAQ6oDNteRWc/paXdGtj78P1OTWJYn2vW
 v5ZlQRwWHFJcyFnS4WLTe8v1nToapwYf2JlWpKfOvVPJ7OuItXwFVXI5/JLNwzDA/nM96BWAQA
 A
X-Change-ID: 20261026-b4-ovl-containerized-sync-149bed1afe9a
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, Chengguang Xu <charliecgxu@tencent.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825112; l=9506;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=3ZHRL+xpFYoI2y0XZr159yuE7SE8dno/i1ROB+Pf2Jw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE+/c7riLL+F1FNYP/dyw96qb1qOPybOZ5X++JO1oMzYk1dzVKfYdWalEFeGffDvku69poqhVOD
 /juy6O37Org4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com/
v2: https://lore.kernel.org/all/20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com/

v2->v3:
- Patch 1 is Amir's, it adds fsync=relaxed. Only an overlay with that
  syncs just what was written through it, everybody else syncs the whole
  upper file system as before. fsync=auto, the default, picks relaxed if
  the upper file system supports RENAME_WHITEOUT. (Amir)
- Dropped the fake inodes and the calls in the ovl_do_*() helpers,
  patches 7 to 9 of v2. Upper inodes without an overlay inode are left
  to ->sync_fs() and the block device, like in v1. (Amir)

v1->v2:
- Dropped the superblock flag and the ext4, xfs and btrfs patches. This
  is all in overlayfs now and works the same on any upper file system.
  (Christoph, Amir)
- Upper inodes without an overlay inode get a fake one that goes on the
  dirty list, patches 7 to 9.
- The periodic flusher pass doesn't write the upper inode any more, and
  syncfs() doesn't make ext4 commit per inode.
- Record write errors in s_wb_err of the overlay.
- Make the root inode appear hashed so it can be on the dirty list,
  don't mark unhashed inodes dirty, read i_writecount with acquire.
  (Sashiko)
- Left alone: dirtied_time_when isn't set for an overlay inode that gets
  I_DIRTY_TIME from ->write_inode(). It only matters for the 12 hour
  expiry, where the upper file system writes the timestamps on its own.
  (Sashiko)
- Rewrote my commit messages. (Christoph)

What it does now:

sync_filesystem() writes every inode on a dirty list, calls ->sync_fs()
and writes the block device. Only the first step is expensive, because
of other people's data. With fsync=relaxed overlayfs writes the upper
inodes whose overlay inode was marked dirty and does the other two steps
as they are.

Whiteouts and the work directories have no overlay inode, so nobody
writes those inodes. That's fine if ->sync_fs() or the block device gets
all metadata to disk, which is what relaxed asks of the upper file
system.

Things I know about:

 - ext4 without a journal supports RENAME_WHITEOUT, so it gets relaxed.
   It's fine there, its metadata is in the buffers of the block device,
   which we write. I tested it like the others.
 - f2fs, ubifs, fuse and tmpfs get relaxed as well and I didn't test
   them. ubifs_sync_fs() doesn't write dirty inodes, so a chmod of the
   work directory at mount time waits for the flusher there.
 - A default mount shows fsync=relaxed or fsync=on in /proc/mounts now.
 - Tracking isn't free. A chown -R that copies up 2000 files got 2-10%
   slower and the rm -rf after it 1-4%.

The testing is the same as for v1, now also on ext4 without a journal.
syncfs() goes from 220-275ms to 43-54ms and unmount from 119-238ms to
36-43ms on those four. ext2 with [2] applied falls back to fsync=on
and does exactly what it did before. fstests with -overlay gives the
same results with and without the series on ext4 and on xfs, apart from
overlay/019 on ext4 and generic/733 and generic/751 on xfs, which are
flaky either way.

[2] https://lore.kernel.org/r/20261027-b4-ext2-dirsync-v1-1-3dcd012d518d@toxicpanda.com

--- Original email (v1) ---

Hello,

This picks up Chengguang Xu's "implement containerized syncfs for
overlayfs", last posted as RFC V6 in November 2021 [1].

syncfs() on an overlay and unmounting one call sync_filesystem() on the
upper file system, so they write every dirty inode on it no matter who
dirtied it. We run a lot of containers on one upper file system, and
stopping one of them writes out the dirty data of all the others. That
can take a very long time, and s_umount of the upper file system is held
the whole time, so anything that wants it exclusively queues up and then
everybody else queues up behind that.

With this an overlay only writes the upper inodes that were changed
through it, and then has the upper file system commit its metadata.

The V6 discussion ended with a direction but no V7, so that's what I
tried to follow:

 - V6 kept every overlay inode with an upper inode dirty for good. Jan
   and Amir didn't like the cost of walking them. Now an overlay inode
   is marked dirty when the upper inode is changed, mostly from
   ovl_copyattr() as Amir and Miklos suggested.
 - It never looks at the dirty flags of the upper inode, Miklos pointed
   out that they're cleared when writeback starts.
 - ->write_inode() goes through write_inode_now() on the upper inode,
   and keeps the overlay inode dirty while the upper inode is open for
   writing, which covers shared mappings.
 - V6 marked the inodes DONTCACHE, which Jan was worried about. This
   goes back to the v5 patch that keeps dirty overlay inodes cached.

One thing is new. V6 called wait_sb_inodes() on the upper file system to
catch writeback that was started but not finished, which waits for
everybody's writeback. Instead ->write_inode() keeps the overlay inode
dirty while the upper inode has pages tagged dirty or under writeback.
The tags don't have the problem the inode flags have, the writeback tag
is set before the dirty tag is cleared. So a clean overlay inode means
its data is on disk, and syncfs() only waits for its own inodes.

That takes care of the data. Metadata is harder, a lot of what is
changed on the upper file system has no overlay inode that could be on
the dirty list: the root of the overlay isn't hashed, and whiteouts,
index entries, the work directories and their parent have none. File
systems that log their metadata don't care, ->sync_fs() commits it. ext2
does, there a whiteout was gone after a crash. I first had overlayfs
write all of those itself and kept finding more of them, the last one
was the link count of the shared whiteout when a whiteout is removed.

So patch 1 adds a superblock flag, SB_I_OVL_USE_SYNC_FS, by which a file
system says that ->sync_fs() commits all of its metadata, and patches 2
to 4 set it for ext4 with a journal, xfs and btrfs. Without the flag on
the upper file system nothing changes, no inode is marked dirty and
syncfs() and unmount call sync_filesystem() like they always did.

Patches 5, 7, 8 and 10 are Chengguang's with changes noted in them,
patches 6 and 9 are new. I dropped Jan's Reviewed-by tags from V6 since
the patches changed.

lazytime on the upper file system needs its own handling. The flusher
leaves the timestamps in memory for up to 12 hours, so the overlay inode
can't be clean, but it can't stay dirty and pinned for that long either.
Patch 9 gives it I_DIRTY_TIME like the upper inode has, and forwards
->sync_lazytime() to the upper inode.

Things I know about:

 - An overlay inode that loses its last reference while it is dirty is
   kept until it has been written and then sits on the LRU, like with
   any other file system. Clean and unlinked ones are still freed right
   away.
 - Every overlay on such an upper file system gets a bdi.
 - I haven't measured syncfs() with a very large number of dirty inodes.

For testing I put several overlays on one upper file system and dirty
192M next to the overlay under test, through another overlay and
directly. Then syncfs() or unmount the one overlay, copy the block
device as it is at that moment, mount the copy, and check that
everything that was changed through the overlay is in it and that the
192M aren't. That passes with ext4, xfs and btrfs as the upper file
system. With KASAN and lockdep on, syncfs() goes from 239-284ms to
45-48ms and unmount from 126-234ms to 39-44ms. With ext2 and ext4
without a journal the 192M are written as before.

fstests with -overlay, the auto groups of generic and overlay, gives the
same results with and without the series on ext4 and on xfs.

[1] https://lore.kernel.org/r/20211122030038.1938875-1-cgxu519@mykernel.net

Thanks,

Josef

---
Changes in v3:
- Link to v2: https://patch.msgid.link/20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com

Changes in v2:
- Link to v1: https://patch.msgid.link/20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com

---
Amir Goldstein (1):
      ovl: expand fsync mount options

Chengguang Xu (4):
      ovl: setup overlayfs' private bdi
      ovl: implement overlayfs' own ->write_inode operation
      ovl: cache dirty overlayfs' inode
      ovl: implement containerized syncfs for overlayfs

Josef Bacik (3):
      ovl: make the root inode appear hashed
      ovl: mark the overlay inode dirty on modification
      ovl: handle lazytime on the upper filesystem

 Documentation/filesystems/overlayfs.rst |  32 +++++-
 fs/overlayfs/Kconfig                    |  21 ++++
 fs/overlayfs/copy_up.c                  |   5 +
 fs/overlayfs/dir.c                      |   1 +
 fs/overlayfs/file.c                     |   7 +-
 fs/overlayfs/inode.c                    |  23 +++-
 fs/overlayfs/overlayfs.h                |  68 +++++++++++-
 fs/overlayfs/params.c                   |  30 ++---
 fs/overlayfs/params.h                   |   1 +
 fs/overlayfs/super.c                    | 189 ++++++++++++++++++++++++++++++--
 fs/overlayfs/util.c                     |  70 +++++++++++-
 11 files changed, 410 insertions(+), 37 deletions(-)
---
base-commit: 2c8a968b488c134d05ccefff890270ac8ab899a8
change-id: 20261026-b4-ovl-containerized-sync-149bed1afe9a


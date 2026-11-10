Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320703;
	b=nxfzYUUzQOGNNyySVNZS2xF42lYjHJah8jNOWoYccow2PThkJ1DKoXZMko2y4ytv9WO0
	 wDdaN2SbuJwNFD7Lh1T1MNzpEdE2zBEZfvumD/FgEyK6kEh+QVx5GqYdMqOfaizTwYEGX
	 vQUaS17MCCvDuO9YgQcaA7e4pK0LvTidfFaXsfs+H3SRzt3YykLjpx9qryhjPYS2oSN2c
	 p10RcsmpsXBaZnxDqpfUSkg8cdjaozmt6XZ0w2aIF0oQCiGbNsOOnpkjlXiorSQCJHB/I
	 kguRWVaFXpFdPBaIy9Tq6rmtCWh+RmWDD8c27OTun6KV6t1TVIQk/9Pm9P48h1N+nYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=uitfk2/X4CWt6/0sIDAHZXqbT86JClnlrGBcisyK0Co=;
	b=kv+gjBMa+TzTJgeQqHW2tGotv+Fw92O7TARqCIXlEbgOWlUEPmYSMCJ7iO8zVQa72fGD
	 rB4Lmtjpw5eJH/7ETaqWo3U7NSL7c3uIpNVQwhgpS8d57xtRbVCoskNTHoF1D7Yxi4nni
	 Ta4/ca6Z4IjNYK1/ithihe9WAbxqi2ZQphJIf/oBvq4HLG7+/Z7Qz1AO5zOPT0qlWSfLE
	 loSHHD6HcILoPFHh/b/1UO6OWUe+4k6INGOF4+UIEoA1TSti8N9Ps4/J1GEClhhQbLO07
	 DE+w6FBdiizTB1fHyPvh2mcr6mAt8y4ssEv9zC1Wcx0clDQQfO1CfaVTEiPBwbWfeTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=dlwF12Yu;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB9606A325
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 14:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96EB9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=dlwF12Yu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53bb57f1310so22524641cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794320701; x=1794925501; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uitfk2/X4CWt6/0sIDAHZXqbT86JClnlrGBcisyK0Co=;
        b=dlwF12YuU0vn27rCv6GUvUF8Ehncd1Q/9lDcltMfWKd85hscEEqyQ6RM0Iyrbc1iwn
         JAJiMmol0n/Xkk22t8S9foNgetF6LO01gWji+GcHrnhnZ9KRYPSl2BUbiTgDQj9k+vuz
         WBDjclD0eG8G3GjbNIZNCBy2mlnxfSGuLZYq/M4AvHDcjQFbO0WZ6cY07y4kNq1ZGd2d
         5DFtfv6GGdA4KEkheZxRr+OU5QFZuzk5MxEBfnrHuZ7DreNv7QfWfxIk0+yth5eHNyMW
         Yd2gvKzL+pKnqMRWHL/9kUx1zLqFyBS2N2dTaOi+/tN9xYoF4tt7L0w2M0w97jdoNxCU
         IoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320701; x=1794925501;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uitfk2/X4CWt6/0sIDAHZXqbT86JClnlrGBcisyK0Co=;
        b=OUGne5f5XR7u3F00TIRQpuph/tnuxv3JIJqx1BocTwQl6RzMEfddcp6mNIRRvDXuTC
         pGRuKnKQlNhuFtmNTOnOyTvGpdAMWE+YzEtA9Mfd9wn5zqUqiYZ2Xw/EcsnNaCXCMiS6
         Yk9/mbQCL0pOBdRWLbw+bAsaD9TkMi9s61GEwAGqI35iNCwtEybkxnpllojXl4VK7RXt
         X2Y1/Ie89g4jPUgydPomEmPS/X4m5ZXPJp2i8T1vZCVrz3+SHGLG10aFiNgwAXE5mfVI
         iu5+yu42kmWpGo190kUGX8x+AyN/+bAMLKq2I6gXLuYe1PIIHGYM+QjFfjDiuBGDxdxX
         BWKQ==
X-Forwarded-Encrypted: i=1; AL+hErH0tdZTWL+gi10EYq6yNkO4/8AUNhClmCty/Br8IbkW+2Z1z8H+vhs5rTCzHwphEZKErGJBsTCImUNSn3oI@vger.kernel.org
X-Gm-Message-State: APuU4Z9VVufyAAgSNp1mysbCE680DA1TIxM1flabixcf6ZmScl+Dzqhg
	/eni0IKNMuBgRLFpwxof1dFooUZQp0G22xHwTAA+y2eQnQTHm6Y+vg2kuBKomf4RV7M=
X-Gm-Gg: AYBFou1BeXZ0FW2njgDkd7V4t37vM0AgYYqcjK+1AG1hFXeFg7JI04x4ksy+yQjV85p
	Ziagcvy1XLYkdJGf+t2Q8XBtkHuPa3h1qDeB4XG8ml36Exlj9Ho8bx2nfnLbGrATKxyR2J0fxLT
	ACUlHaMKghbzKRHqKTrimNS+UV9nRDKkWqaGcslj2VoxJ2qrRY0BSBhbBxpO439qQ3fANZB+/xd
	HvkIcxn6c+eqjipf+TKoBmaexbbaWm9SBQ2g8pZb54J8rROjt7reg1UGoAbkXiTUKXvL5sEgWjq
	4Yr56toaonpA3sCJCk/Tv118eB19AzQB9Hja8KJO2ijmnpnoqBk53BSMTAcVS1qMfp69ql4UtU1
	qZ7uge3FJGtnKo7RajuSIhvHEWIOC8aBBPofTckB+q4fPEm26riz5sxLSJ3gOtmgZQaQ6oKcrZP
	y6Z1R9V6XsG+zhUkHgZ2ewL46OIl7GAYzipnj6D6jU2GoV4i2TV95WWXNajbmbVQ8HuzBidc93J
	6Cvt/zfzZ9vQZo3DdDw4dCgPNrA/Rzx5XNtbO3b5VaKNQdxCkZk25hKA0Qhb0LIrhaIsmzaIOTE
	29nji93Y6Uurk4hjz6nh2xrJ2ffjni8QbLJ2HmaqeaJGJA==
X-Received: by 2002:a05:622a:4d95:b0:536:352d:65e9 with SMTP id d75a77b69052e-555287de21dmr39760591cf.65.1794320701138;
        Tue, 10 Nov 2026 06:25:01 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b44e617sm24793671cf.11.2026.11.10.06.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:25:00 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v6 0/9] ovl: only sync what was written through the overlay
Date: Tue, 10 Nov 2026 14:24:48 +0000
Message-Id: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
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
X-B4-Tracking: v=1; b=H4sIADEp82oC/33RwU7EIBAG4FfZcBYFCu3Wk+9hPAzMYDEKm1KbX
 Td9d2GNsYlNDxx+MvPlD1xZpjFQZo+HKxtpDjmkWEJ7d2BugPhKPGDJTAnVynK41TzN79ylOEG
 IZfmLkOdLdFzq3hJK8NQDK/unkXw43+znl5+cP+0buamCdcJCJm5HiG6oVzU+bON1egh5SuPlV
 nWWVf1t1e20miUX/CgUGamarof2aUrn4E4QEe5d+mC12qzWXL/HqcJp6r04kgZh1CbX/HFS6D2
 uqe0QQAmptTfNJqfX3N4XzLpwLSKSsB3iETY5s+Z2384UDhttNZDpPPp/3LIs36puiXBDAgAA
X-Change-ID: 20261026-b4-ovl-containerized-sync-149bed1afe9a
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, Chengguang Xu <charliecgxu@tencent.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794320698; l=13526;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=EZvIQYTVd5gJ0A2Q+LgE+v2arci+BF9HPmnecLyiS7A=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QC2RsiKWn+2aTsOo9LKX+Sg3SHlxk23wdE0iYBO8iXkj1qZHZxZyL3776vsq4Nzf+UjXV40KRmP
 A+WnShzNa+Qk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com/
v2: https://lore.kernel.org/all/20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com/
v3: https://lore.kernel.org/all/20261104-b4-ovl-containerized-sync-v3-0-8daa20144f53@toxicpanda.com/
v4: https://lore.kernel.org/all/20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com/
v5: https://lore.kernel.org/all/20261107-b4-ovl-containerized-sync-v5-0-d34b4ae57fdf@toxicpanda.com/

v5->v6:
- Lookup marks a merge directory and its parent when it sets the origin
  and impure xattrs on them. (Sashiko)
- New patch 8: if somebody else writes the pages of an upper inode and
  that fails, syncfs() on the overlay reports it. It's best effort, the
  limits are in the changelog, and it's on its own so it can be dropped.
  (Sashiko)
- Left alone: if the deferred timestamps can't be handed over because
  the upper file system is being frozen, the sync of the freeze can miss
  them. They are written after the thaw, it's in the changelog of patch
  7. (Sashiko)

v4->v5:
- Added sync_fs_and_bdev() to fs/sync.c for the ->sync_fs() and block
  device part of sync_filesystem(), so ovl_sync_fs() doesn't open code
  it, patch 2. (Christian)
- ovl_instantiate() marks a new inode and a new hard link dirty.
  (Christian, Sashiko)
- Copy up marks the parent as well, and the inode also when it only adds
  a link to an indexed upper inode. (Sashiko)
- Dropped "ovl: make the root inode appear hashed". A fake hash stays in
  the slab object when the inode is freed, and the next overlay inode in
  it looks hashed. The root isn't tracked at all now, ovl_sync_fs()
  writes its upper inode every time. (Sashiko)
- lazytime got a lot simpler. The overlay inode doesn't get I_DIRTY_TIME
  any more, deferred timestamps are handed to the upper file system when
  ->write_inode() finds them. That takes care of the I/O from dentry
  reclaim, so this doesn't need anything from Jan's deferred inode
  reclaim series. (Sashiko, Christian)
- ovl_sync_upper_inode() could lose an error.
- Left alone: fsync=auto still goes by RENAME_WHITEOUT, no flag. What
  that leaves uncovered is under "Things I know about". (Christian)
- Left alone: if somebody else starts the writeback of an upper inode
  and it fails, syncfs() on the overlay doesn't report it. It never has.
  (Sashiko)

v3->v4:
- Patch 1 is v2 of Amir's patch. It has ovl_tracks_dirty() and picks the
  mode for tmpfs at mount time, so I dropped my version from patch 2.
  fsync=auto stays auto if it doesn't become relaxed. (Amir)

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
 - f2fs, ubifs and fuse get relaxed as well and I didn't test them. f2fs
   writes its dirty inodes in the checkpoint. ubifs_sync_fs() doesn't,
   but the only thing overlayfs leaves dirty there on an inode it
   doesn't track is the chmod of the work directory to 0 at mount time,
   right after creating it with mode 0. fsync=on is there for anybody
   who needs more.
 - A default mount that gets relaxed shows that in /proc/mounts.
 - lazytime on the upper file system doesn't do anything for inodes that
   are modified or read through a relaxed overlay, their timestamps are
   written with the next pass of the flusher.
 - While a file is open for writing the flusher of the overlay looks at
   its inode up to every 5 seconds. That doesn't do any I/O.
 - With nobody else's data to skip syncfs() gets a bit slower. Over 30
   boots per kernel, after creating 2000 files and a chown -R of another
   2000 it goes from 51ms to 57ms on ext4 and takes 11ms longer on
   btrfs. After 2000 mkdirs it goes from 45ms to 48ms on xfs and from
   49ms to 54ms on btrfs, on ext4 I can't tell 235ms and 238ms apart.
   Nothing else I timed moves.

The testing is the same as for v1, now also on ext4 without a journal.
syncfs() goes from 222-268ms to 41-50ms and unmount from 122-236ms to
36-45ms on those four. ext2 with [2], which is in Jan's tree now,
doesn't get relaxed and does exactly what it did before. fstests with
-overlay gives the same results with and without the series on ext4 and
on xfs, apart from overlay/019 on ext4 and generic/670, 733 and 751 on
xfs, which are flaky either way. There's a new fstest for this [3], it
fails if I break the tracking.

[2] https://lore.kernel.org/r/20261027-b4-ext2-dirsync-v1-1-3dcd012d518d@toxicpanda.com
[3] https://lore.kernel.org/r/94833333cf2c5dd487022cb290174393.josef@toxicpanda.com

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
Changes in v6:
- Link to v5: https://patch.msgid.link/20261107-b4-ovl-containerized-sync-v5-0-d34b4ae57fdf@toxicpanda.com

Changes in v5:
- Link to v4: https://patch.msgid.link/20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com

Changes in v4:
- Link to v3: https://patch.msgid.link/20261104-b4-ovl-containerized-sync-v3-0-8daa20144f53@toxicpanda.com

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

Josef Bacik (4):
      fs: add sync_fs_and_bdev()
      ovl: mark the overlay inode dirty on modification
      ovl: write the timestamps that lazytime defers
      ovl: report failed upper writeback in syncfs()

 Documentation/filesystems/overlayfs.rst |  36 ++++++-
 fs/overlayfs/Kconfig                    |  21 ++++
 fs/overlayfs/copy_up.c                  |   9 ++
 fs/overlayfs/dir.c                      |   3 +
 fs/overlayfs/file.c                     |   7 +-
 fs/overlayfs/inode.c                    |   4 +-
 fs/overlayfs/namei.c                    |  10 +-
 fs/overlayfs/overlayfs.h                |  58 ++++++++++-
 fs/overlayfs/params.c                   |  32 +++---
 fs/overlayfs/params.h                   |   2 +
 fs/overlayfs/readdir.c                  |   1 +
 fs/overlayfs/super.c                    | 179 ++++++++++++++++++++++++++++++--
 fs/overlayfs/util.c                     |  93 ++++++++++++++++-
 fs/sync.c                               |  52 +++++++---
 include/linux/fs.h                      |   1 +
 15 files changed, 456 insertions(+), 52 deletions(-)
---
base-commit: 2c8a968b488c134d05ccefff890270ac8ab899a8
change-id: 20261026-b4-ovl-containerized-sync-149bed1afe9a


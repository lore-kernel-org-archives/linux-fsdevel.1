Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793200375;
	b=mB5ObwHRkr9nSc+x71ARJW15XT9A98gTEqcz0PI6kFlgPUzXFZWhk7xWPjAjh57PcUZc
	 RC7NJmGbQewfyN2m+xqpqrh3vAXgQijXCD/fwxSCgV3CjlLSF5xIu73P6aD4RhLcXiGGg
	 NSfUbgoPsitUHvoUbk/Ikn1kkrpnmpABTUi9U9EXRRJ8EFhTHvJmbEpWiRAYsm4sM7NrZ
	 W1tJHpCpG8D85sM+nQk4yc+OtYJQq/n8KgO57wX74in4jBICkX8iE1MuFmvnQGcdiWrUS
	 6W3dpcQ5/G/fBAMB8FvNTJj/hFEsWeGS19lLICuvO0v/t8DbdZ7j2jwB02yDbBZNuOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mvEQ77wrc+NNwvP1oUtKva4Bysns022AFrTrSBSP550=;
	b=tZ1R2ZzdsSpjC4lMgYS/6AIYTitd97Ijkop+1Lc+tVchcVl5xM69DQg+oaC3NZrWJJMr
	 YkiqojdHWMdFqMjjGLhycnEYQO5lNo5YzZVvJhg6MOXemNmec3nsYptCYF7K7BvQbT+oY
	 m8M9zPa4+nTkuYmMchmFU0jZVFcTyO+NlqejVFCPARIc0w6wOX/cNhulDaSf5pTMq84DY
	 Fy/LVu0egdRBzVz6vE8kSiCyOcKoy6325TVIcySZAMT0sUm4ltVRTMsa+lI88vAfJh0mz
	 sisdP6kwsbGxRlcnak34Lf9yNJ37c6cn6CkqVu6Mm5cftsOLPdPt6w4+NcU/LJSSLiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhAhqZGV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D503606A323
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 15:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D503606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhAhqZGV
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so1587558a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 08:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793200374; cv=none;
        d=google.com; s=arc-20260327;
        b=kyPeZou4Ss9gGIBPY2XAyO/3o0G8ydh6Yg4WmPhM1mVM3BWd2cRpm6eawQytzISRzh
         4YXoJVMZigGBacM8DoeoCgNNksyHD5my06gvh9vsx9Cq8shBQnYVnTWsZ1r9THYebYGb
         bCRCHNz01RMq1XCvtXUOXV1Cs3hqp5jp5cT8hmcCiJMr/zvqaraIIAxo4Sl5AFdyVc8Z
         WoNsHNOeKD+stgu01dPU+PMtsTbKOtL760LyFz68WsDNr3UYkEHQmHG/rGWMtK6n61/I
         YCsOF8ANeQ2sERFPisRNj5Rg65GqDMDoYQVtXEjhGigvtFsBsyKAZ+6/Cf0r7wCWVdNB
         sLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mvEQ77wrc+NNwvP1oUtKva4Bysns022AFrTrSBSP550=;
        fh=26+RCOGuG53CkStRiF8T8+vDBDvg6B7Ov4v27olt+IA=;
        b=C/b1EDE8tB6IFPoblDRyendQVJKh1ak86MruCD5U6i7VMTOB0QHMRIMrJc3xGCzado
         V3IoFsuPVToVHdsjADT2cZO7FFiEy6qIok7tv6i8alnifsKmRg9w0kCEx3pz2HQ1Lt9b
         LDhUZ9W8dmbZx7l01gXcxri2FNfF+C+WAcrlrwp6O5BfpOlCH+fw/Dn3KNrKXVs/wua6
         vw8HG4odOCSuR/Ov/P1ufJgAFrITbY5117MY5+BIBGz8yVxADuY4UrhCYQk3+JCw6l1b
         Z3PQhvoz2+AHS02LIXGaseKhuM2DxF4YGl5GBAhbSKsCR5Q1kxWsYxAr6bmuhT2Oz9nb
         Z3Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793200374; x=1793805174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mvEQ77wrc+NNwvP1oUtKva4Bysns022AFrTrSBSP550=;
        b=UhAhqZGVxEz/QR9YrWcKn4/UXhwaHMgzx8h7OkpvlN64DkfhYVcCpB/8CTDiBG/8gz
         ltMfSG3nFay5gi5Qf022JrUoVLlNxtPykN3SQwNQ9xRAgmeGKsb3NyNCpi18I81a29E8
         6hMKBDZj3pddLDDkP2pqS7LUnhjJ3sqRkTgYFdcmr+9wo+km2wGNrT2kdENWJbadxCUg
         Opr6aKOu642XGv7kfqarqxOOxzX6s2vCm5katnbraEVm5i0a779m5R1Cx+ULEUKeXc+f
         J2sicAA5gAaouAltK9ze20vz2pkbrf421mgXU6/tLVcUOgDi0UdozNiDM6jeeLvUYsW8
         NHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793200374; x=1793805174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mvEQ77wrc+NNwvP1oUtKva4Bysns022AFrTrSBSP550=;
        b=gyd4DRGtDEghnztC/Tr3GW6+Dq59ehqxDyFPeSF2nlUCVXZmJisKf0RFqhpxupYsuR
         rBX5Wphq6M3SDK/8280STbiepGf009iaqa0vMQ2q1olOyXXUqMUR0rW3jbDtI7tN+mFV
         W6C6DAt8bTI+/Pjor+36S8IOSpAgwkPGv+GAJmaNjdyzxC+iAv+0Q0Tz+NAlBcdLdaXl
         3fRewRSZ6JC+5NCdCnHF8sk83OT35rbGKEeGZ2vVGdQl3tQvKsVRkmujdp4yBNEMnFXz
         kHCE47UBJ+eyYbsS7bIk6GYGEzNUGJq4QPbljZ8alkT3YXW2N8bp3ACL1tEhV5yIq73g
         dK3Q==
X-Forwarded-Encrypted: i=1; AKwUvBx2Uk0+6p3CoK1UckZnH6o3E439RqHLRI7VfFyGII2NlJqo5EdRKpz37E8wZR98f+g0euKCKch9XNtNoZeF@vger.kernel.org
X-Gm-Message-State: AFq9FYKSrP4zJ9WQooF2lc0Bf7wnaQ5X2zaZhuZIkbLilIcgCy1TD0Jr
	GEnOKM6Owykba4vHJuGtv5phapCWPEqNkVpGRWF9E+Z5rb9nAeWuJUHi0rBiaHa/uGYhGyk5X+A
	COQFKpAgtZVmOVHnYyIXycZ9f5VvvLdM=
X-Gm-Gg: AYBFou3Tx0lkapUS7SXBy+aizWe6HIaiqe+srenj3A9cVjXasSDhcXra0R/zjQ4CdTm
	hFIc/TU0n793EEdZk5N1gfzoAD4e17YinnXif6yJkkFClojjOlyn33RQ5TQq90mdi0/z6IIrQAz
	NaIX5LtXVLlTmrcvZ/PGQpwr9BnNspH9N3Aq1wREcwMMqUvQ2FEtmVKS8SJAspKAHgHeXZtLrfH
	J5XkdBFPscz6ObdIxAsQTlRBveVSOtkI+aUPwinim3M6j2lIguVroU34fiD9RwlQeQbzHJ5T95S
	KPG0nRLojcZ1S8WzCR8MYRqjYTimLKF51IJK1LKnMJ9LmL9/VKNgJtEWFYB3USRehVSIVCBDp/4
	qVNUKQvTysKWz0F0RrCuwLjAZ1PoprEtQs7idnYjt4xprjqD+jjpPQyvKRJxIAPMhyvlOhQ==
X-Received: by 2002:aa7:c2c6:0:b0:6a9:aabb:5364 with SMTP id
 4fb4d7f45d1cf-6b49cbcfcf5mr1354898a12.11.1793200373111; Wed, 28 Oct 2026
 08:12:53 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com>
In-Reply-To: <20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Oct 2026 17:12:41 +0200
X-Gm-Features: AclHuK-8Efe1pYJJSPJZfrh0w35wEd33FdwWDpDBDPZR-9XwXeQicHIXG8N9WIY
Message-ID: <CAOQ4uxh7RFGmrFG_AUwJ3b2vHo6uhe+WiOG+VTp7oxUVEQRv-w@mail.gmail.com>
Subject: Re: [PATCH 00/10] ovl: only sync what was written through the overlay
To: Josef Bacik <josef@toxicpanda.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>, 
	Carlos Maiolino <cem@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chengguang Xu <charliecgxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:09=E2=80=AFPM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> Hello,
>
> This picks up Chengguang Xu's "implement containerized syncfs for
> overlayfs", last posted as RFC V6 in November 2021 [1].
>

Thanks for picking this up!
This looks like a very useful improvement.

> syncfs() on an overlay and unmounting one call sync_filesystem() on the
> upper file system, so they write every dirty inode on it no matter who
> dirtied it. We run a lot of containers on one upper file system, and
> stopping one of them writes out the dirty data of all the others. That
> can take a very long time, and s_umount of the upper file system is held
> the whole time, so anything that wants it exclusively queues up and then
> everybody else queues up behind that.
>
> With this an overlay only writes the upper inodes that were changed
> through it, and then has the upper file system commit its metadata.
>
> The V6 discussion ended with a direction but no V7, so that's what I
> tried to follow:
>
>  - V6 kept every overlay inode with an upper inode dirty for good. Jan
>    and Amir didn't like the cost of walking them. Now an overlay inode
>    is marked dirty when the upper inode is changed, mostly from
>    ovl_copyattr() as Amir and Miklos suggested.
>  - It never looks at the dirty flags of the upper inode, Miklos pointed
>    out that they're cleared when writeback starts.
>  - ->write_inode() goes through write_inode_now() on the upper inode,
>    and keeps the overlay inode dirty while the upper inode is open for
>    writing, which covers shared mappings.
>  - V6 marked the inodes DONTCACHE, which Jan was worried about. This
>    goes back to the v5 patch that keeps dirty overlay inodes cached.
>
> One thing is new. V6 called wait_sb_inodes() on the upper file system to
> catch writeback that was started but not finished, which waits for
> everybody's writeback. Instead ->write_inode() keeps the overlay inode
> dirty while the upper inode has pages tagged dirty or under writeback.
> The tags don't have the problem the inode flags have, the writeback tag
> is set before the dirty tag is cleared. So a clean overlay inode means
> its data is on disk, and syncfs() only waits for its own inodes.
>
> That takes care of the data. Metadata is harder, a lot of what is
> changed on the upper file system has no overlay inode that could be on
> the dirty list: the root of the overlay isn't hashed, and whiteouts,
> index entries, the work directories and their parent have none. File
> systems that log their metadata don't care, ->sync_fs() commits it. ext2
> does, there a whiteout was gone after a crash. I first had overlayfs
> write all of those itself and kept finding more of them, the last one
> was the link count of the shared whiteout when a whiteout is removed.
>
> So patch 1 adds a superblock flag, SB_I_OVL_USE_SYNC_FS, by which a file
> system says that ->sync_fs() commits all of its metadata,

I have some reservations about the flag name (how could I not)
but mostly because I am considering if this flag could serve something else
as well (more on patch 1 review).

> and patches 2
> to 4 set it for ext4 with a journal, xfs and btrfs. Without the flag on
> the upper file system nothing changes, no inode is marked dirty and
> syncfs() and unmount call sync_filesystem() like they always did.
>
> Patches 5, 7, 8 and 10 are Chengguang's with changes noted in them,
> patches 6 and 9 are new. I dropped Jan's Reviewed-by tags from V6 since
> the patches changed.
>
> lazytime on the upper file system needs its own handling. The flusher
> leaves the timestamps in memory for up to 12 hours, so the overlay inode
> can't be clean, but it can't stay dirty and pinned for that long either.
> Patch 9 gives it I_DIRTY_TIME like the upper inode has, and forwards
> ->sync_lazytime() to the upper inode.
>

I suggest asking review from Jan again for those writeback and lazytime
bits. Would be hard for me to validate those.

Thanks,
Amir.

> Things I know about:
>
>  - An overlay inode that loses its last reference while it is dirty is
>    kept until it has been written and then sits on the LRU, like with
>    any other file system. Clean and unlinked ones are still freed right
>    away.
>  - Every overlay on such an upper file system gets a bdi.
>  - I haven't measured syncfs() with a very large number of dirty inodes.
>
> For testing I put several overlays on one upper file system and dirty
> 192M next to the overlay under test, through another overlay and
> directly. Then syncfs() or unmount the one overlay, copy the block
> device as it is at that moment, mount the copy, and check that
> everything that was changed through the overlay is in it and that the
> 192M aren't. That passes with ext4, xfs and btrfs as the upper file
> system. With KASAN and lockdep on, syncfs() goes from 239-284ms to
> 45-48ms and unmount from 126-234ms to 39-44ms. With ext2 and ext4
> without a journal the 192M are written as before.
>
> fstests with -overlay, the auto groups of generic and overlay, gives the
> same results with and without the series on ext4 and on xfs.
>
> [1] https://lore.kernel.org/r/20211122030038.1938875-1-cgxu519@mykernel.n=
et
>
> Thanks,
>
> Josef
>
> ---
> Chengguang Xu (4):
>       ovl: setup overlayfs' private bdi
>       ovl: implement overlayfs' own ->write_inode operation
>       ovl: cache dirty overlayfs' inode
>       ovl: implement containerized syncfs for overlayfs
>
> Josef Bacik (6):
>       fs: add SB_I_OVL_USE_SYNC_FS
>       ext4: set SB_I_OVL_USE_SYNC_FS if there is a journal
>       xfs: set SB_I_OVL_USE_SYNC_FS
>       btrfs: set SB_I_OVL_USE_SYNC_FS
>       ovl: mark the overlay inode dirty on modification
>       ovl: handle lazytime on the upper filesystem
>
>  fs/btrfs/super.c               |   2 +-
>  fs/ext4/super.c                |   1 +
>  fs/overlayfs/copy_up.c         |   2 +
>  fs/overlayfs/dir.c             |   1 +
>  fs/overlayfs/file.c            |   8 ++-
>  fs/overlayfs/inode.c           |  21 +++++-
>  fs/overlayfs/overlayfs.h       |  28 ++++++++
>  fs/overlayfs/super.c           | 145 +++++++++++++++++++++++++++++++++++=
+++---
>  fs/overlayfs/util.c            |  14 +++-
>  fs/xfs/xfs_super.c             |   2 +-
>  include/linux/fs/super_types.h |   1 +
>  11 files changed, 211 insertions(+), 14 deletions(-)
> ---
> base-commit: 2c8a968b488c134d05ccefff890270ac8ab899a8
> change-id: 20261026-b4-ovl-containerized-sync-149bed1afe9a
>

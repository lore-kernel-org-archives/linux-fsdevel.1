Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4350D262FF8
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 03:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773805862; cv=pass; b=Z8FWI1XTiQfui14jmKSc6TsiRHHBTIIVQnoHb1kcdpTKprj8iUDkXLkn7y+JemFghlqAu7O7M5g9DyJMm1elljl7GmIGAb8HTPYZMlvXoOl9Q3WH8RL8KDvT/hZvSL2UeZqxKLN6zooEGdc/sZHS77XzaW5oX2e9vLLztPGBk7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773805862; c=relaxed/simple;
	bh=6rfy+YL8TbqCjX2Bi91JJPPsyBwsvbuy0eDI2V5QM0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbqJOTH6eTHGGNJkTGEVu7YR0Q5CZYxuEL2m8F1LhRutdvbO2tPzQCvixX4HPkzYeXlDRohaWtrgYrj6bZ56Z2ulYE1i7iaDV0ugUHqwMIKkg8ORDHl3JzCOvgc/ztBfJNGbEXjOQsiXmfJ2d1LndBviSsQ8IVVIXJbIBeSFW/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNjsWxu4; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNjsWxu4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b49819938so1056029f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 20:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773805860; cv=none;
        d=google.com; s=arc-20240605;
        b=R2Y4LIgMlYjA6Ma30RStwTgp9nkdL+dKFiasn5S+J+Jo3g8Wm5NXTsJ6P8Z1QT1sWw
         +RipqOTYZHCkhEQfzroXMpQqLQyb6ZchrKMj/uZaJdMoZVLKfUF1bWcuFfNxFPxnl/ed
         KvOHU6rzXqnCU4i6WGHZa9ytcvGCE6McqDfdERsonHzohLlttArAYb/jTZP422bJgvBN
         dYtBuWVDM5BGE37MZAfPrcn2Djt+FkZIbOsUhcJ80agWCJxISUJfFLGYxXeZ6lnK+Nob
         G/QtLzJVmuFzA4Z/u1bjYx3UROm1NxfROTFncLP9J8GgQtaa8wDQABOSPquJpsuRtxVJ
         tXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uAqgSBgM5GR2plF0BUM1uuvvYOmn5cIX6q0Wx3uim3A=;
        fh=gQdkKV1tGOGOzKyd3JoTBUe1U1ve+G3SIIwDLG1eHm4=;
        b=QPg6/Zk114rxCgsggVoH27QIuOf+vd7k5+FTbAaoAM5vzDovFtwZHniP3nKvxisL6p
         hw4j1ulOhLwl3utphzfvGkYnU39LkkSyQRhsf0d7eq6r9W88PE23TfXTTKIVD37hqYo4
         3p4Cas9rmakgiXEYyVdrPX0h/LcH2+hVw38480XjR2nvFlQTnJsDhDPes4tIH8WJV45+
         4Qy4kqtVqILT+Ydmj3SAnuAn/LWC1+x9yiPyYKBWU9ZRyaGabk0lC4xTn0L9ABr8n5Dg
         d8/zyATeCH0A3XFFhk5XnEiRZpW6zv7Yv/9zIdhXvX9l3Af52lqU78+z/zJFuSBDXvds
         J1WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773805860; x=1774410660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAqgSBgM5GR2plF0BUM1uuvvYOmn5cIX6q0Wx3uim3A=;
        b=GNjsWxu4pTngHvg4HiYoNMNeFhFYQjV9d8aA5r6XMD1Ri6SK+tFnAoZRIA17jIYc1o
         17sohN248vasq/zgSLCuLCFRoALswgiCYXID/GLwnWRcWzskI7P5balXg2J3vke265cb
         zUuxc/TSas+2EFAMtlt2d+SwJr1X7vzDmMXSXfpJ7D+EVxPY6NL/6Docv2BKdSp294cg
         2ZgZMFQEvjo2U1CeptMgxJ9qBZdcDEKeS4C9CqGbl8PLy3FyvwOlqshWTncNbhiSP6q1
         9BQ8tDCxXX+GdI+QwqbjPVDU2S0WG3RvD4rFKLWmNO7Ta4Ryag9oS1XqLmrWWcCZZvJ5
         l7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773805860; x=1774410660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uAqgSBgM5GR2plF0BUM1uuvvYOmn5cIX6q0Wx3uim3A=;
        b=ilA+EYHSnYOS3ZzfBvhP9JG8DTqSwhvBjtBgjNrEFbmJZBH709b5LUGdWZzAbI1Awp
         0vnV8Me7JenMO+exF7tKuz7BiL0FeqcbS65jQ3ewzxI3MciO63iPp/dz2SArmJzsPZ1e
         8VMCB/tNOq5qGDUfDxsQQ3idbnOn/TJbREgFnh5YDNepDmgd6Pkx0vZjozFMFHa7v0UE
         6C0YAd1EYyVA9kYnhNY9P/7E6Mb20r8VsEZfPvAIHqldTFTYUfTHn3w94GKvOdhDVSs5
         5BVcX4b7KQwR8luVfy1hxYdnBKVGt7L4WQapl7KoV4Hn2gI+JL73ueetFqFWyyovgqRm
         y+gg==
X-Gm-Message-State: AOJu0Yy2UzoU7WH2Gjbg/ITjW0KzngxyYIlf8CV7lnVbdfX+srzaVRYb
	fQtKllcGrXQbBQ14wxNvq5Go+V2WPydLmHAdfji0RSDPj50eaZKui366/DnuV7Gw1GPzQcGFztc
	8+rCVJ3S44Z3VfN89gG9+UXlAxtcW9sE=
X-Gm-Gg: ATEYQzxx0X0s+jCzpkQPB0F9MykzMQZ02DWoIdP5VbIztMOZw/rgr7IeqrIGBYltbdP
	sRJdf8pOzetvZC0gx0EJ54cv/kocCvwoNxOc0POSq4bDqZKiOgK8x25w0b1e+Ka15T+KCN5w/QN
	mxpmY2sknFCx7j/8VmgrLdnAq0jEByyYiShYVtSCkSn/uiWqV6y4U9Bm638AqLmvXZtZa6d9Lc/
	0wHobbQSksEi1wal50BPQu0MMCpnjDlUX/8o8qz2fl/hYJyhYmgpq7nz8PWUOXahkjEPUQcIRJX
	XXU1dg==
X-Received: by 2002:a5d:588a:0:b0:43b:493c:884b with SMTP id
 ffacd0b85a97d-43b527aa359mr2536473f8f.12.1773805859317; Tue, 17 Mar 2026
 20:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Utw_Cjiuq0_XhCoA5EXpzLE9qfRpiA0-fmXEmui7NnBnIeMiCDGOyXWPtE5DkxVNYNSsgiUotB7fsGYnlMQn1xDCx14yx1d0UJqx62vAwp4=@proton.me>
 <CAJnrk1YAhWnOt-7yr9gDmHdjANiC74-fC5mKsePC6wFTzwPjUw@mail.gmail.com> <Oh3QG6NmrGxixfRZmAUnkDb0ukAG1ro7XFSVCJVWYdyTqG4ddxHjQsfhBurktEbG5vJ97FA58bDMAuBsQzVlN8Tq-M4LUck18F0D0nVCsXg=@proton.me>
In-Reply-To: <Oh3QG6NmrGxixfRZmAUnkDb0ukAG1ro7XFSVCJVWYdyTqG4ddxHjQsfhBurktEbG5vJ97FA58bDMAuBsQzVlN8Tq-M4LUck18F0D0nVCsXg=@proton.me>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Mar 2026 20:50:47 -0700
X-Gm-Features: AaiRm51PUYamgbFWlUgsOs9BM9tmfk60sNpXBP_AmJ49RXQ4ScD5s_r_Bjh821w
Message-ID: <CAJnrk1Y25_HKeYou-JQHXOZ5HLhEcwnBmWoUm78smB825+v0UA@mail.gmail.com>
Subject: Re: [BUG] fuse: wb_wait_for_completion hang on suspend with
 fuse-overlayfs on tmpfs persists in 6.19.6 (AS_NO_DATA_INTEGRITY fix incomplete)
To: John <therealgraysky@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 2:08=E2=80=AFPM John <therealgraysky@proton.me> wro=
te:
>
>
> On Monday, March 16th, 2026 at 8:16 PM, Joanne Koong wrote:
>
> > Could you verify if this fixes the issue?:
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 8f8069fb76ba..4cbb22d80acf 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1990,9 +1990,13 @@ static long writeback_sb_inodes(struct super_blo=
ck *sb,
> >                  * Don't bother with new inodes or inodes being freed, =
first
> >                  * kind does not need periodic writeout yet, and for th=
e latter
> >                  * kind writeout is handled by the freer.
> > +                *
> > +                * For sync(2), skip inodes whose mappings have no data
> > +                * integrity guarantees (eg FUSE).
> >                  */
> >                 spin_lock(&inode->i_lock);
> > -               if (inode_state_read(inode) & (I_NEW | I_FREEING |
> > I_WILL_FREE)) {
> > +               if ((inode_state_read(inode) & (I_NEW | I_FREEING |
> > I_WILL_FREE)) ||
> > +                   (wbc.for_sync &&
> > mapping_no_data_integrity(inode->i_mapping))) {
> >                         redirty_tail_locked(inode, wb);
> >                         spin_unlock(&inode->i_lock);
> >                         continue;
> >
> > I think the changes from commit f9a49aa302a0 ("fs/writeback: skip
> > AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()") are still needed
> > even with the above patch since afaics, the writeback we wait on could
> > have been from a previous background/periodic writeback run before
> > sync was triggered.
>
> Yes, it does! Amazing!
>
> I applied it to 6.19.8, upon rebooting and following the steps I outlined=
 above I was able suspend and wake up three consecutive times.
>

I think this is the cleaner fix:

writeback: skip sync(2) inode writeback for filesystems with no data
integrity guarantees

Add SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
guarantee data persistence on sync (eg fuse) and skip sync(2) inode
writeback for superblocks with this flag set.

This replaces the per-inode AS_NO_DATA_INTEGRITY mapping flag added in
commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
in wait_sb_inodes()"). The flag belongs at the superblock level because
data integrity is a filesystem-wide property,  not a per-inode one. This
also allows sync_inodes_one_sb() to skip the entire filesystem
efficiently, rather than iterating every dirty inode only to skip each
one individually.

Without this, sync(2) triggers writeback on FUSE inodes and may block
waiting for the daemon to complete issued writeback or setattr (from
->write_inode()) requests.

This restores fuse to its prior behavior before tmp folios were removed,
where sync was essentially a no-op.

Reported-by: John <therealgraysky@proton.me>
Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and
internal rb tree")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fs-writeback.c              |  7 +------
 fs/fuse/file.c                 |  4 +---
 fs/fuse/inode.c                |  1 +
 fs/sync.c                      |  2 +-
 include/linux/fs/super_types.h |  1 +
 include/linux/pagemap.h        | 11 -----------
 6 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 8f8069fb76ba..7a02483e0d8d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2774,13 +2774,8 @@ static void wait_sb_inodes(struct super_block *sb)
                 * The mapping can appear untagged while still on-list sinc=
e we
                 * do not have the mapping lock. Skip it here, wb completio=
n
                 * will remove it.
-                *
-                * If the mapping does not have data integrity semantics,
-                * there's no need to wait for the writeout to complete, as=
 the
-                * mapping cannot guarantee that data is persistently store=
d.
                 */
-               if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
-                   mapping_no_data_integrity(mapping))
+               if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
                        continue;

                spin_unlock_irq(&sb->s_inode_wblist_lock);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7294bd347412..111ccc5bdda3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3205,10 +3205,8 @@ void fuse_init_file_inode(struct inode *inode,
unsigned int flags)

        inode->i_fop =3D &fuse_file_operations;
        inode->i_data.a_ops =3D &fuse_file_aops;
-       if (fc->writeback_cache) {
+       if (fc->writeback_cache)
                mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_dat=
a);
-               mapping_set_no_data_integrity(&inode->i_data);
-       }

        INIT_LIST_HEAD(&fi->write_files);
        INIT_LIST_HEAD(&fi->queued_writes);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index af8ad96829fd..bae7d9ac3a43 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1769,6 +1769,7 @@ static void fuse_sb_defaults(struct super_block *sb)
        sb->s_export_op =3D &fuse_export_operations;
        sb->s_iflags |=3D SB_I_IMA_UNVERIFIABLE_SIGNATURE;
        sb->s_iflags |=3D SB_I_NOIDMAP;
+       sb->s_iflags |=3D SB_I_NO_DATA_INTEGRITY;
        if (sb->s_user_ns !=3D &init_user_ns)
                sb->s_iflags |=3D SB_I_UNTRUSTED_MOUNTER;
        sb->s_flags &=3D ~(SB_NOSEC | SB_I_VERSION);
diff --git a/fs/sync.c b/fs/sync.c
index 942a60cfedfb..88c08e2f76b2 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(sync_filesystem);

 static void sync_inodes_one_sb(struct super_block *sb, void *arg)
 {
-       if (!sb_rdonly(sb))
+       if (!sb_rdonly(sb) && !(sb->s_iflags & SB_I_NO_DATA_INTEGRITY))
                sync_inodes_sb(sb);
 }

diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.=
h
index fa7638b81246..383050e7fdf5 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -338,5 +338,6 @@ struct super_block {
 #define SB_I_NOUMASK   0x00001000      /* VFS does not apply umask */
 #define SB_I_NOIDMAP   0x00002000      /* No idmapped mounts on this
superblock */
 #define SB_I_ALLOW_HSM 0x00004000      /* Allow HSM events on this
superblock */
+#define SB_I_NO_DATA_INTEGRITY 0x00008000 /* fs cannot guarantee data
persistence on sync */

 #endif /* _LINUX_FS_SUPER_TYPES_H */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ec442af3f886..31a848485ad9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,7 +210,6 @@ enum mapping_flags {
        AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM =3D 9,
        AS_KERNEL_FILE =3D 10,    /* mapping for a fake kernel file that sh=
ouldn't
                                   account usage to user cgroups */
-       AS_NO_DATA_INTEGRITY =3D 11, /* no data integrity guarantees */
        /* Bits 16-25 are used for FOLIO_ORDER */
        AS_FOLIO_ORDER_BITS =3D 5,
        AS_FOLIO_ORDER_MIN =3D 16,
@@ -346,16 +345,6 @@ static inline bool
mapping_writeback_may_deadlock_on_reclaim(const struct addres
        return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->fla=
gs);
 }

-static inline void mapping_set_no_data_integrity(struct address_space *map=
ping)
-{
-       set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
-}
-
-static inline bool mapping_no_data_integrity(const struct
address_space *mapping)
-{
-       return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
-}
-
 static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
 {
        return mapping->gfp_mask;

I tested it locally on my simulated repro and it fixed the issue for
me. Could you verify that this patch fixes the issue for you as well?

Thanks,
Joanne

> Is this something you plan to submit/backport to the stable kernels serie=
s?
>

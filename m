Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61F2D8391
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763519; cv=pass; b=WyIki5gq0r9qsAItp9fWmlRI/9Mpy/iTTb86OOSpRm3qwHhaHOo/dQA7UZEcY8sNYV+1mw7tMrSBwSoteA6aFtFvdrcnfibTlG/nYEJItArgeoGw+qQTZvLxC2CktjOsImFYeXV7+DyUjzLCZCYeOivs5fUFlQT7SyScIF9brME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763519; c=relaxed/simple;
	bh=wYh4SPPJLF/r4MeGpZ8zVNFb9u6oFz8nqxULoueV1NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dt1/k6E6QEhh3eIu49PYndPjWMM5bCh2zXVSlkmhosw6u02Gm5OL25fiulLh/wKHfiCjq4xZp+7F9PV9FN7ows9/278XHzcVUeID0VcY4A4GzkVIG+4nI1ohTKRIZ13907rJ21kHCyFk9dhjpnOag3xGnx65/UBLS0YVDgbwZnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHNxoHkP; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHNxoHkP"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb8b78d6cso2333575a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 03:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790763516; cv=none;
        d=google.com; s=arc-20260327;
        b=RvE3S4ZFLgfe+pvl46VEfHdtPRyBA8+CIUaPldeb4UxKFNT84UMjKOXRLlQZtBIICi
         x1sGJWrxYb5ubkNtP7Ii/eK94+DnsAib4UD9NEWao3dOGcI+qpMdV3t/eCCgs4MqQ7aE
         uSy+3GyYkQkPqgby2xwUMVdwUwud34db5OPLX458v6i+oIt3ZeB8vhROgU2UEUTSHQTE
         It3x/RSGj1J+t6q1LgUVDGiFnP2nBsNM8bUJWH5TihatVhMQj58T1u9O1xinLduYp+KG
         Fj/HAXpGFOkmSin8rxCxAfE8NyHFe92BPRlt4v347w8ncaQwks7lCJd+NpC43NLbqXA0
         7Rag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vqWINpH2l++yemIsiJMfBHQQztSFoALzePZUoHg8GKk=;
        fh=BU1RMsRKVCqFXVBe3AlLCHdJ9THjBO5N5nXg2oyerLI=;
        b=jdNlBqB62AX2Jz0uOvlzbBtcM+lo8CGLcaGCOsZB1F0y+iuOLXTePv9nFJ4fQcBTxw
         MuFvRDsRzl1SmTBCyff51SXEeIIS33L0A7fWE4zXpEOzZkdzuE4L8VBYkKbMSeMRlTMv
         43J1mpGncQKTg13Mcllr0up8oe7z/9TqerJas4A51RbAje9ZJEi3oSRPElzR43IFuoSs
         7EVHZ+7E0Mhz3CaCPCGgJdmSjFZUpjH4vknQkljSGlKaoaBSeytrYx/91EaAngTtQsgf
         /BPtAVYVcOU+i9krVVF3aETSqwcPhLY0XG9rwO2ckU2kCinWxBr4rjTvw66Xq4BBQOWh
         gFkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790763516; x=1791368316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vqWINpH2l++yemIsiJMfBHQQztSFoALzePZUoHg8GKk=;
        b=YHNxoHkP1LbfZMt0yZr8fx81CJihS/OGxti9IDpldzLE7Cr+9F0wK7x9+oi4uITug7
         tVlVDRe53lsqgA7wh710a2HrYrneC5ICIFTCZBrUU9ToawqiJzqDuVj3o1FSezWV0ned
         OwYQTAB8DG+vlrtLYFEB6DygLqoRbK7LGUHrG8+p252itWV05/cNG+itbMb8jbQlq3Iu
         d+ix7PqeYyAueBEvUcAuF6R/a+Fhv8rbVcwTQ4UbPvWk85BwwOgSiTML1/q90F1jgmG0
         xwbvro2FKpAbgwSRSM5IzI+SEWQrrQs46l0rjzpisjhnPmoNGJar2YTxMWwy8Oq8Dj9p
         k1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790763516; x=1791368316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqWINpH2l++yemIsiJMfBHQQztSFoALzePZUoHg8GKk=;
        b=wQwASG3svsevxx4l9uHoIZhTnf89LnsPUMZEizfcXmZGbKcG6Leu/oLUe4aRv5AcMj
         4IsbCbOWts9uFYHiv792im8FdV+mvNFlZhYIdcYnNLqLsra45khI/lNCdLstZpOVc7uB
         wscxSMrAi+BEeKZPGTKcfwXFgDhM4Iy+9euDOJN5S6koQBHxx+X8Y85mjjlofH0WNy2F
         zZv0F7VXR+rGR1ij/FO09kaKRtuZItmIRfMs4HzzAh6euOWHw3Pm3RpKmB+8u8PixLYv
         /w79IY1NF7o/D5AfROPgfMluwuH2Xr8S6m5q8NZbGX5Ru49MdEid0q2mIhQc0ZPQJQiV
         ys6g==
X-Forwarded-Encrypted: i=1; AKwUvBzZ1m4TfJfGTAbnbIZ1JSiIatqW/beb8U5T+v7TnZfmmiEPgvVHbOVzJM8mkIMLdfphLp2cUN2+VJlKOe+3@vger.kernel.org
X-Gm-Message-State: AFq9FYIKSjuC2bfeTxQk91TSN2JtkxeGHs5Z8Vd7x6GveZoE/YoiuPIO
	sqFoFjnZy8cLxtzoP4KgN1HWWpuoNh/o3MaL5y1EyJjFl9xZDuceCwaH+ZC97NegiFyN5VqNuos
	jG3YPnVICI4uvHwTDKHPORDmBGXzwGW8=
X-Gm-Gg: AYBFou1p2dktNrhrfDeMEq8l4w265tl5wkXv5skgDntfAUqFAzw8KftZgGsfPxsjl5X
	afEuUA/4Evv0XOlcDzVr4PWYP0d33D6+DMn5GG4bRs1XK4dSKf6QbWHPJJoAbmTXYwiFKrrCfOX
	wSkXxYQ0E+YEm0ftUKCA3n92RlOR/NDu5e+L+cK6bFOGmW9X/M//Uxqcpd1t7FYl3qn1HZHKK9O
	YPvrvPcEsMJ6RZzMYVMSHXgJBDLkrxjDMMt8HHWxPckVnLTnzo7/9CoPY8V19ziIV2X6b3YsuLu
	Bv6cEPiTnxk6vylhXQGPSErCPLOhqdAcBSLnL59sPw0BctcjqIYrVMBL
X-Received: by 2002:a05:6402:43c6:b0:6aa:7fb:7678 with SMTP id
 4fb4d7f45d1cf-6ae19864b56mr694393a12.6.1790763515717; Wed, 30 Sep 2026
 03:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911081309.14137-1-jack@suse.cz> <20260926024829.3051410-1-matthias.goergens@gmail.com>
 <cxgitt74gb6d42l4mdiztrz42xuaykfggsxoussgdmo3h2qur7@injom55qowrs>
In-Reply-To: <cxgitt74gb6d42l4mdiztrz42xuaykfggsxoussgdmo3h2qur7@injom55qowrs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 30 Sep 2026 12:18:24 +0200
X-Gm-Features: AclHuK-3QU8Ah69f36a00phhVqdJz9uhWwk7JlN9U3fb_vS0faf30d-5U8oF9rE
Message-ID: <CAOQ4uxhdRm4mENZCArR2PW+=NQz_jzqTugz6-tBmPLvCHfPkMQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] fs: Deferred inode reclaim
To: Jan Kara <jack@suse.cz>
Cc: Matthias Goergens <matthias.goergens@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, brauner@kernel.org, hch@infradead.org, 
	xyzzy@yandex-team.ru, tytso@mit.edu, djwong@kernel.org, agruenba@redhat.com, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 12:38=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hi Matthias!
>
> On Sat 26-09-26 10:48:29, Matthias Goergens wrote:
> > I ran v2 against its base in QEMU, on syzbot's disk image with a config
> > close to syzbot's (KASAN, lockdep):
> >
> > - Lazytime churn on ext4 under memory pressure: the PF_MEMALLOC warning
> >   fired with the sync_lazytime() stack in all 5 base runs, four times
> >   from kswapd, and in none of 5 runs with the series, which evicted as
> >   many inodes in reclaim context without reading ext4 metadata there.
> >   The workload also runs drop_caches=3D2 under memalloc_noreclaim_save(=
)
> >   from a debug patch.
> >
> > - Hibernation cycles with /sys/power/pm_test set to devices under that
> >   load, with inodes that 5/5 defers queued in each cycle, and with
> >   freeze_filesystems 0 and 1: no freezer timeouts and no hang involving
> >   the queue.  The stalls in throttle_direct_reclaim() from
> >   hibernate_preallocate_memory(), and lockdep's warning in
> >   __set_task_frozen() with freeze_filesystems=3D1, happen on the base
> >   kernel too.
> >
> > - One path the series does not cover, see below: with the series
> >   applied, unlinked ext4 inodes under an overlay are still deleted in
> >   reclaim context, and the warning fired in 2 of 3 runs, as without it.
> >
> > The reproducers and the debug patch are at
> > https://github.com/matthiasgoergens/linux/tree/deferred-reclaim-repro
> > and I can post them here if you prefer.  The Tested-by below covers the
> > lazytime and hibernation runs.
>
> Thanks for testing!
>
> > > @@ -988,13 +1013,27 @@ static enum lru_status inode_lru_isolate(struc=
t list_head *item,
> > >     inode_state_set(inode, I_FREEING);
> > > -   list_lru_isolate_move(lru, &inode->i_lru, freeable);
> > > +   /* Inode will take long time to cleanup. Offload that to worker. =
*/
> > > +   if (inode_state_read(inode) & I_DEFER_RECLAIM) {
> > > +           list_lru_isolate_move(lru, &inode->i_lru, &lists->deferre=
d);
> >
> > This is the only place I_DEFER_RECLAIM queues an inode, also with
> > Andreas's simplification folded in.  An inode that ->drop_inode() drops
> > on its last iput(), which for ext4 means every unlinked inode, never
> > gets here: iput_final() calls evict() directly, in whatever context the
> > iput() came from.
> >
> > syzbot hits that under reclaim with overlayfs on top of ext4, in the
> > same bug as the lazytime trace in your 2/5:
> >
> >   https://syzkaller.appspot.com/bug?extid=3D7f94fe3ce0f6613e12b8
> >   https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D12764a155800=
00
> >   https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D135309055800=
00
> >
> > Direct reclaim prunes overlayfs dentries, and dropping the overlay inod=
e
> > puts the last reference to an unlinked lower ext4 inode, so
> > ext4_evict_inode() runs its deletion path under PF_MEMALLOC.  My
> > reproducer above does the same: stat files through an overlay on ext4,
> > unlink them in the lower or upper directory, then apply memory pressure=
.
>
> This is an interesting case. When I was writing the patch set I was
> thinking whether unlinked inodes should be marked for deferred reclaim an=
d
> decided for "no" - unlink or file close should be happening from context
> where synchronous ->evict() should be possible (and is desirable!
> Offloading to async context always has these inconvenient questions about
> throttling associated with it and space being freed later than userspace
> expects it etc.). But I didn't think of overlayfs - I assume syzkaller
> unlinked upper layer inode under the overlayfs' hands - which can indeed
> lead to overlayfs dentry being effectively the last holder of inode
> reference and thus responsible for inode deletion.
>
> Inherently it is kind of nasty that overlayfs dentries can be the last
> thing protecting the inode from deletion but at the same time I don't see
> an easy way around it. Amir, maybe you have an idea?
>

No, not really. If you could use the ovl_destroy_inode() to mark the
ext4 inodes for deferred reclaim, but with current design this does not
seem possible.

FYI, I assume the same situation could unfold from dropping an
inode with cachefiles backing inode.

I don't think the issue exists with FUSE passthrough backing inode
at the moment, but I do have a plan for a similar construct of
backing inode that detaches on evict of fuse inode as in overlayfs.

Thanks,
Amir.
overlayfs

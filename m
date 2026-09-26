Received: from mail-dy2-f17.google.com (mail-dy2-f17.google.com [74.125.229.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A91632E7
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390916; cv=none; b=r5CMNG7L0vcnP/wNFg604SfLbxtwAw9aT3KPBWDcVAEvecSCH/mGGGZXkI39E3fUZvdmt16amWigjThEP/n2UbkRHUE2YLLPNm+Z2dW+96Mf1Fcf1ybwmAOY3eN/1ajS7ZjENoLXXVK+cvxTr7DDj/78xAV1Zl29hQuZtEoqTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390916; c=relaxed/simple;
	bh=B/C5vmAYwwzHwNyD/b6mRuObNGkjebSIeJM7Fx/NaD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuDTPlDDBs/aLevNLojk29umNwtUD43jRgJIpNNB6SVkQMoJK0ncSGP18N3aeWfdeS28lDefSy25aze+tG0UI0VQsh1kWxnO/N909I75OvJyCjRCi1wcz8eccguJ0wwODnP7WYXIO9U65HldcHDnMWfZikOYo7FTla4ZAGtWUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPQ4ZvL6; arc=none smtp.client-ip=74.125.229.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPQ4ZvL6"
Received: by mail-dy2-f17.google.com with SMTP id 5a478bee46e88-3427493501eso447353eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 19:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790390914; x=1790995714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4AfLUjZGBh+NyiRXQ29ny/IyjFejnXIP1LQYn6XeZ2o=;
        b=qPQ4ZvL6NSF8TdVbkRGDi7j5JSQjzO1VHT+jJV9SCyfhnkkoROUDguKAINMGA4qmGr
         EPRSumd3JKkngU0NuhI4JFBRG1c70N83rbXoKUvSz1Jk/TvMc+DACsJKSM7y5VLrXZk1
         SQFo15aMi1a2nt2Dci6Hw7rOpISwKgl66+hNTf28kSEUEwYMro/yRaqdtRSlaM5goLym
         s0dKBQsJjm3nXozcp8HIeYjdHQ4m14lyR8oHZFGtowLDK1reHZKPZEP8qFs4o0Ot/Yql
         hV5P9oBV8L/Nmn2S46fc3ieBafr8Lnt7hwD4/A7n8jiwn3sMNtwv6CpVfKGXs1onSERs
         aLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790390914; x=1790995714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4AfLUjZGBh+NyiRXQ29ny/IyjFejnXIP1LQYn6XeZ2o=;
        b=xQ5WDn1QMkEScLdC4GLTvv04xzLZMYqaJLoedl15ljYHnYiWk9oMdRvXhxWA9eR8wT
         aKV3wL3rxIkZaHOhPr/ek9+dIC6UvyzZ90FNVDIaiK/mwOl3SoSpSkAdUSa+KSrNroWf
         M9Y5exq83jmTPEdW7IQPzDLjDEAy18F4PxDNi9zVFDovekJAVwkjd0EQdcmzOJ2VqViD
         0N2y9fc8x1qugV9R+igL5kQBm28ILlW+4T9pij22GqUtBusr7Gfeqafm44nGjuMs2EQo
         tVP6BlcjDVrAUcwdkOmQ86w3pXGz1liAu4NQ5rF9ZhxkqpnjiyJJYznfRMnMFcG4rxmI
         AYUw==
X-Gm-Message-State: AFuF++mlFT/4NRH73bs3OjnInbsqI65qroIE0AXwstRxY2g73uC2xEot
	DEdew3cTjyIAunHzU0Hsu1+Xw/WwSRoLbvw/b8qiEgdFj+Jf63NTY+yH
X-Gm-Gg: AYBFou1YpRsdWbmtXyc0dnBzS3/d2oYXAsm9ZISbmMN/Q8IzXBGL4CbuLKSb2TMCOKP
	Y8foRqhLsb7IC1uotvrkfZEbpA1UNVNG48tLuQQAS5XVeZrGB2Fu4TQ805isragtMcjZvznxt0I
	AqJqZHiJiY3APuDGA1SJ9g9HL++oJ11604CiukB+JF+FuslxneBGtNkjgzvsphi9yi5BUlPKcb5
	jXPJx2kz1PLZ4+ykHYGmG+gUEu2EvdnwQEK3OFlgIFcoQSQHQpqURKpLEtztECGH3jL5Djo6YVI
	Dvh4BVksbW8IDPn64wZ+be/rtyscUdUVRVVYIaCe4b3cClBuJ7aQZWeF2tPLkfM7BO1/JN/NCUI
	iHCUgVMLyAarRF+ReVMd1kvlINQvbiukR9AntJn8X85PWNBsRn7yY6pK2ueWbsGsN2aEqxGdgj8
	cjDRZTE8Swbxh5m7A9pigsbwr7BK4aQcPHnQGfkZxqn6ANEQixYddiiS4q6X8JsIshhU2IAOI16
	kYdYhdRodSlISaeGicifIPLwRIvLCsagwoXjtK28ojjKd/Y7FNMRUdsFPZrsSKE6PJxWeZurtPc
	VgH1OlgZc7o7kKIP8DKBb4zT0X5vVhID15EfoXExxAHoUb/p+nsatTDqLbA=
X-Received: by 2002:a05:7300:4fa5:b0:33b:d8b2:8fba with SMTP id 5a478bee46e88-342700bdd29mr1509975eec.7.1790390914091;
        Fri, 25 Sep 2026 19:48:34 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341f2b18cbfsm7115584eec.30.2026.09.25.19.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 19:48:33 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	brauner@kernel.org,
	hch@infradead.org,
	xyzzy@yandex-team.ru,
	tytso@mit.edu,
	djwong@kernel.org,
	agruenba@redhat.com
Subject: Re: [PATCH v2 0/5] fs: Deferred inode reclaim
Date: Sat, 26 Sep 2026 10:48:29 +0800
Message-ID: <20260926024829.3051410-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911081309.14137-1-jack@suse.cz>
References: <20260911081309.14137-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honza,

I ran v2 against its base in QEMU, on syzbot's disk image with a config
close to syzbot's (KASAN, lockdep):

- Lazytime churn on ext4 under memory pressure: the PF_MEMALLOC warning
  fired with the sync_lazytime() stack in all 5 base runs, four times
  from kswapd, and in none of 5 runs with the series, which evicted as
  many inodes in reclaim context without reading ext4 metadata there.
  The workload also runs drop_caches=2 under memalloc_noreclaim_save()
  from a debug patch.

- Hibernation cycles with /sys/power/pm_test set to devices under that
  load, with inodes that 5/5 defers queued in each cycle, and with
  freeze_filesystems 0 and 1: no freezer timeouts and no hang involving
  the queue.  The stalls in throttle_direct_reclaim() from
  hibernate_preallocate_memory(), and lockdep's warning in
  __set_task_frozen() with freeze_filesystems=1, happen on the base
  kernel too.

- One path the series does not cover, see below: with the series
  applied, unlinked ext4 inodes under an overlay are still deleted in
  reclaim context, and the warning fired in 2 of 3 runs, as without it.

The reproducers and the debug patch are at
https://github.com/matthiasgoergens/linux/tree/deferred-reclaim-repro
and I can post them here if you prefer.  The Tested-by below covers the
lazytime and hibernation runs.

In 3/5:

> @@ -988,13 +1013,27 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  	inode_state_set(inode, I_FREEING);
> -	list_lru_isolate_move(lru, &inode->i_lru, freeable);
> +	/* Inode will take long time to cleanup. Offload that to worker. */
> +	if (inode_state_read(inode) & I_DEFER_RECLAIM) {
> +		list_lru_isolate_move(lru, &inode->i_lru, &lists->deferred);

This is the only place I_DEFER_RECLAIM queues an inode, also with
Andreas's simplification folded in.  An inode that ->drop_inode() drops
on its last iput(), which for ext4 means every unlinked inode, never
gets here: iput_final() calls evict() directly, in whatever context the
iput() came from.

syzbot hits that under reclaim with overlayfs on top of ext4, in the
same bug as the lazytime trace in your 2/5:

  https://syzkaller.appspot.com/bug?extid=7f94fe3ce0f6613e12b8
  https://syzkaller.appspot.com/text?tag=CrashReport&x=12764a15580000
  https://syzkaller.appspot.com/text?tag=CrashReport&x=13530905580000

Direct reclaim prunes overlayfs dentries, and dropping the overlay inode
puts the last reference to an unlinked lower ext4 inode, so
ext4_evict_inode() runs its deletion path under PF_MEMALLOC.  My
reproducer above does the same: stat files through an overlay on ext4,
unlink them in the lower or upper directory, then apply memory pressure.

Is that path meant to be covered?  Handing such inodes to the queue from
iput_final() under PF_MEMALLOC, as gfs2_drop_inode() does for gfs2,
mostly just delays things: blocks and quota come back later, lookups by
inode number wait in __wait_on_freeing_inode(), and umount would need
the inode counted in s_deferred_reclaim_count, as 3/5 does for its own.
But it does not work as is with freezing: ext4_evict_inode() takes
sb_start_intwrite() on the deletion path, so a worker evicting an
unlinked inode of a frozen filesystem sleeps until the thaw, holding a
batch of up to 16 inodes taken from any queue, and enough of those stop
the queue.  XFS keeps inodegc per mount and stops it in xfs_fs_sync_fs()
before SB_FREEZE_FS; this queue would need something like that before it
could take unlinked inodes.

On Ted's question (https://lore.kernel.org/r/aqQV6Uwma_KjUH0O@mit.edu):
with this WQ_FREEZABLE queue I would not wait either.  A non-freezable
queue would need draining before anything is frozen, because an eviction
after the hibernation snapshot writes to disk behind the image, and
draining later can wait on kjournald2 or on sb_start_intwrite().
Freezing the workers with the kernel threads avoids both.

One catch: a work item already blocked on something frozen earlier keeps
freeze_workqueues_busy() true until the freezer times out, and the
suspend or hibernation is aborted.  With /sys/power/freeze_filesystems=1
the filesystems are frozen before the freezer runs, so an eviction
waiting in sb_start_intwrite() is enough.  ext4 only takes that on the
deletion path, so 5/5 is not affected, but unlinked inodes routed
through the queue would be.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>

Thanks,
Matthias

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793909247;
	b=d17aJOatxgt+lvwqXAHPUCyCfI/U3mDTFBBHk8wnRp1o976Bqa0lfXRN8UheathC7h1m
	 wKBoBIH6g3lZrh2/NbCk5cNaEAjxwnUrQWtbrmN45mcz8e0amltKi0WBWFI+39QXovgHU
	 Vt8TYBbxwoboJnKtUE26l3kG89HHMo2q7bSq7tlP4LmZGaDy7W0Z/ccxEgpIA97KZ3t1c
	 UWB/YW0ZJRzMejuaN+lUGq+gjo2tl3NcVRV7hnNUIkxLHA4Wgp5j7wWkjFLci9bmGZtTq
	 4exPp5dQUCERsJ0AzEBjp4zDiWgDfPTawpim3sHaFZdi302dTRlp5N60Thgn9noYq/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909247;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=rlBVJT4GPajviox7GVvnaU/1fuJu0H3trSYA5DJJsWk=;
	b=J2YXWCim5uPkKM2BzJFpE16gfwppu2D3PBstrPpCkoHYLEMGvFFYEEcxWIEmnVKiJpDm
	 TNGDPpJP66LZ2r85fTBwUCrlyWRwU0jeCNg0OrBV58+HHPE5pJPBxvs4mvnncoH5MeY9t
	 B0kyw9FOy8gHBgnz+thGb59ZdIK8uQb43TFlfnv/vISjWaxbbFPP5wdQorBCAj+lRXTHE
	 Lkj1MacdUGP3fUyxdsj2rZjigO65qjWzUR0sv11BNp6vJDtzj0a4H0ajCIqLbzOALykxc
	 mqclyASwsRORego4rwLOhWTfvxF9JmwFbNBfGEPh1x5GZ4x0ZlyNZhSBi4GCbiBZn+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X3PuJfWr;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GR0lDTGc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC06606A329
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 20:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DC06606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X3PuJfWr;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GR0lDTGc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793909245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlBVJT4GPajviox7GVvnaU/1fuJu0H3trSYA5DJJsWk=;
	b=X3PuJfWrKkqyUl6d2raj/yZwk7aSZYQKGV8T3+BL7zooeyGfFsySMhBqn5WZInzSaDzBgZ
	zVCbWOk7kGLgA1pD/j78K1INw5hg1Hab6lCuQU4zGIGrlCImqayM05ROLQNOf0Shd7ygu5
	m0xxxLsUbCUAMKxQaqSoYtCiW+/yTFg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-ucJ1VR0JMJ-eMGEjPYAIqA-1; Thu, 05 Nov 2026 15:07:24 -0500
X-MC-Unique: ucJ1VR0JMJ-eMGEjPYAIqA-1
X-Mimecast-MFC-AGG-ID: ucJ1VR0JMJ-eMGEjPYAIqA_1793909243
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b18c67095dso34409317b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 12:07:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793909243; cv=none;
        d=google.com; s=arc-20260327;
        b=MreCQVc8yL4y4Z30O6T21DEUT5+QqX+xBzZojcI7e/UhtIN0fXibaodfQhrNdYwkYq
         T4MA/Vt10iMIIeEVYLqJHIXztlNa74WW/ifQ00KTrnwBJc1PeyxV0k42EDFXI0oAoBk/
         8g2Kwnwo/ycy86JLKZ14s38cKRhnYyOwxyo2/m2P4n10Zk+8mKwcRpzbqJigkmSsaod1
         G2TbQBo648jZOhxyI/GhGn6SjyoMprRKkbD3kSPmqvTT7Xsbob+IMR6KiUSXPZUBTnLl
         IL3f0sRVSowztCFtTuf2ximY1svTeCjxDYgOJW0wu3cJQMTEJRWPk7yeh5gnrDpcdA1l
         jocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rlBVJT4GPajviox7GVvnaU/1fuJu0H3trSYA5DJJsWk=;
        fh=hVfLv5tLqMklwMjEeL8FC/qmw3GuLkCoRh9a2Lx3owk=;
        b=iLL3St3MZAaYql1eDVjAXXdnqnPU1ygpOKkR3wDGVy90xvUYG8TjcQHEJU/bBm6wWy
         yPhp+6yckroylSAgEfLnDbDYujjBaoacCmZotVB9hmD6TthEgzq2nwlnOHdvscm/x2u2
         t/lEt84F/1YgqXcOO5ljUFjMlhTEFdDq/+aXudSVhZRbQYu6NjtIXYPDdlq0HK+cZjW+
         KP1Ur2/qwwKeynUtfqXpbgeHcmRlj13lPzLNnoEO+CQCMbjqmeJvhBwgzVWqr65hKoZq
         nG4L1Paak3fjtDSp3fYZdUdecrQq48pWUGRuT+r1XbJ5DTQmwIx6jw0OIr37T/zGQrXn
         wnOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793909243; x=1794514043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rlBVJT4GPajviox7GVvnaU/1fuJu0H3trSYA5DJJsWk=;
        b=GR0lDTGcKYtyjpNKy7xtV2HP3aZv14zXxyNWmOzP8iiDu5jKGmdq8UtIXXlSj1LMD1
         ozaOLuTlufFaguu1JDkS0rpa1By4GMrPEz/dD0TdKVQAS8zoNdFIGpohVbHC6ksw9ENY
         g7phkgUfsdpfzNr+7LMmVzkbFieT0S0qQP3jv9QDBgrjn6UR6ZIvKAPCiMrSjB29fX/V
         /hlv9pJ8H0+gFnWxjbpglTOCo3NcNIo/tUTlaOiZnaCVCfr+s2x1o2/JCPm3wJhmWDZj
         0Gj0CCgmdhSo6MOOMLUyjEUVSeoCZmMSBeK0BSUrXkviTOaQIAbnkrvDp0vBao0zv270
         ArrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909243; x=1794514043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlBVJT4GPajviox7GVvnaU/1fuJu0H3trSYA5DJJsWk=;
        b=NelpnKAdef1FetGh0mj9wj4BF33P17sqpqVO1/S/84vWYMNXiFuhvC0k2QpiQDWgZH
         Vbn4gAapLpcpybc7bf30drb4AoqMJQ7v4tnIVI4nyF+UWc45k8kHj/iqp3OvRkAfv1P1
         W9gSWCIYCM2ZqG3QDVoBcI8JWre00EsL91lwjeVPDOfoDTn2c+jPYehXvVhSRKfH6a9p
         qj5plkof7TlFslS/P7sWLPp2/4OpEkHg2cpDZeb9t/97AK04G8tim9S8iI8l3X5JMMwU
         nKvlhqePYXB/z0bUUlFEP3Krz/fonUKthYF7Bd36K/evBnHTAv4WXTPNRAi8p8/ScBHL
         VOwA==
X-Forwarded-Encrypted: i=1; AL+hErGcImSK0fDPwAE4X6SGMpDsSQ8eXfcAnWI2WcJZ3sn4wCU4JdLB2VWF9GtQLaj1G493ZKMMt86q43HF3YRg@vger.kernel.org
X-Gm-Message-State: APuU4Z+/rk3/7P/G5SChF7irn0yRWycbTw7xQ4ZbLhXQsrCRyPeshY+u
	HdDU2etAX6rQTwedXiTYllX/GSMLsg9FHJ8/Fs38Ry+XcNg2FFr0pl/cfMnY09oIuzaSyXyrLKa
	Hp5Pado/V4QBrBiXsn3B6+iAKrtUVclAXXUNeYiwc7d449y83Y4PREOyQ5yaA81gz0ClonkVrYd
	Je4XBCCVMtDqVYGKYigq3H1gECJVJGrQ6Wrd35Mwnu6Q==
X-Gm-Gg: AYBFou0adKa1iBqy01NJEyqoKdzOkwkxm1L2TYy1KZ5+FLpv2zKwa0EW4H3MdvKptKh
	gqTgTfNCKs/SuKuKCmLybTt1l0WCr0ua0l2NSXrRx9rJ/cFYCggzOQ47+Y2l1xQ8rsviULQnokx
	IiXbCLaqwF7+Dz7cVHjzbpM/d/KLfB2vCstSzFH6QFmrgroFCVd+GgqpeSiibA32yHSr5wwel/U
	pTvMIa+EB3/fKjI/4S89guvhiSzGTD4emXQJ3KHNK7feA==
X-Received: by 2002:a05:690c:c513:b0:8b1:368b:392f with SMTP id 00721157ae682-8b3419be4e8mr580217b3.49.1793909243381;
        Thu, 05 Nov 2026 12:07:23 -0800 (PST)
X-Received: by 2002:a05:690c:c513:b0:8b1:368b:392f with SMTP id
 00721157ae682-8b3419be4e8mr579957b3.49.1793909242884; Thu, 05 Nov 2026
 12:07:22 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103023804.8074-1-wuyiqing@cmss.chinamobile.com> <auo_CehOVzTMq6kc@dread>
In-Reply-To: <auo_CehOVzTMq6kc@dread>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 5 Nov 2026 21:07:11 +0100
X-Gm-Features: AclHuK_7bPPStvyJ7t0t9o12YGqSYrx1SyDLCxIY-DGoYpyY0de9k9HjzorVUGE
Message-ID: <CAHc6FU6aE1hdi4zsOgu6LUGJx6CE__PMwOfTY8KMccASRzzRaw@mail.gmail.com>
Subject: Re: [PATCH] iomap: allow writeback from kswapd again
To: Dave Chinner <dgc@kernel.org>
Cc: Yiqing Wu <wuyiqing@cmss.chinamobile.com>, Christian Brauner <brauner@kernel.org>, 
	gfs2@lists.linux.dev, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+5e659793378ad9e06387@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:17=E2=80=AFPM Dave Chinner <dgc@kernel.org> wrote:
> On Tue, Nov 03, 2026 at 10:38:04AM +0800, Yiqing Wu wrote:
> > Commit ff59f71f1c95 ("iomap: simplify writepages reclaim guard") remove=
d
> > the PF_KSWAPD exemption from the iomap_writepages() guard on the
> > assumption that kswapd can no longer reach filesystem writeback now
> > that pageout() returns PAGE_ACTIVATE for non-shmem, non-anon folios.
> > That assumption only covers the folio reclaim path.  kswapd can still
> > reach filesystem writeback through the inode shrinkers, and syzbot
> > reports exactly that on GFS2:
> >
> >   WARNING: (current->flags & PF_MEMALLOC) in iomap_writepages
> >   kswapd -> balance_pgdat -> shrink_node -> shrink_slab
> >   -> super_cache_scan -> prune_icache_sb -> evict
> >   -> gfs2_evict_inode -> evict_linked_inode -> gfs2_log_flush
> >   -> gfs2_ordered_write -> filemap_fdatawrite -> do_writepages
> >   -> gfs2_writepages -> iomap_writepages
>
> Oh, that's awful. Nothing should be calling into iomap_writepages
> from reclaim context.
>
> i.e. Doing data writeback from the inode cache shrinker is extremely
> suboptimal for many reasons, so I'd consider this a gfs2 bug, not an
> iomap issue. It's even worse when data writeback is being driven by
> an inode cache shrinker. I'm surprised that lockdep hasn't thrown a
> hissy-fit over this (i.e. inode locks taken in writeback appearing
> both above and below reclaim.
>
> This is the patch series that Jan Kara came up with to deal with
> these issues in inode eviction:
>
> https://lore.kernel.org/linux-fsdevel/20261009133253.20102-1-jack@suse.cz=
/
>
> This allows filesystems to defer inode eviction that might block
> (e.g. due to transaction reservations, journal commits, metadata
> read requirements, data writeback requirements, etc) to a context
> where the work is allowed to block and isn't running under memory
> reclaim context or restrictions.
>
> That patchset is needed for ext4, XFS alreayd does this, and it
> would seem that gfs2 needs it for glock reclaim....

Yes, Jan's deferred inode reclaim patch queue (plus a tiny gfs2 patch
on top) should take care of that.

I see that Jan wanted to send a v4 of this patch queue. Are there any
remaining serious problems?

> > Under memory pressure kswapd evicts GFS2 inodes whose glock is still
> > dirty, and gfs2_evict_inode() -> gfs2_log_flush() ->
> > gfs2_ordered_write() then writes back the ordered data of every inode
> > on sd_log_ordered.  This is long-standing, intentional behaviour: in
> > the default data=3Dordered mode GFS2 must flush dirty data before the
> > log commit that writes the metadata.
>
> It's also long standing, known broken behaviour w.r.t. shrinkers
> running in memory reclaim contexts.
>
> So, why doesn't this warning happen through the direct reclaim path?
> i.e.  what makes only kswapd trigger this?
>
> I see nothing that prevents direct reclaim doing inode eviction
> from triggering this same path through gfs2_evict_inode(). IOWs,
> direct reclaim should also be triggering the warning in
> iomap_writepages(), hence it is not clear to me why re-adding the
> kswapd guard is anything other than a band-aid over the broken code
> in gfs2....

It's also happening under direct reclaim. Here is an attempt at a fix
from before I was aware of Jan's patch queue that describes such a
scenario:

https://lore.kernel.org/gfs2/20260921211712.1563575-1-agruenba@redhat.com/

> > Writeback from kswapd has been
> > explicitly allowed since 2010, when the guard was still in XFS:
> > commit d4f7a5cbd544 ("xfs: allow writeback from kswapd"), because
> > the kswapd stack usage is low and it cannot deadlock on the
> > filesystem.
>
> No, that was a regression fix for turning off all writeback from
> reclaim in XFS as a 'what problems does stopping mm reclaim
> writeback actually cause' experiment. That was the first steps we
> took down the path to get rid of the problematic random dirty page
> writeback issues that memory reclaim had.
>
> IOWs, we didn't want to allow it, but we had to tolerate it because
> the MM behaviour was unfixable at the time. Now that the
> pageout()->.writepage() path for dirty filebacked page writeback is
> gone from the mm, we no longer have to tolerate this behaviour
> and so the guard got removed. It only took 15 years to get to this
> point....
>
> tl;dr: Writeback through iomap in memory reclaim context is -a bug-.
>
> > Beyond the noisy warning the new guard is actively harmful: it returns
> > -EIO on every hit (WARN_ON_ONCE only limits the report), while
> > gfs2_ordered_write() ignores the filemap_fdatawrite() return value, so
> > the log commit proceeds with metadata even though the ordered data was
> > never written, breaking the data-before-metadata ordering guarantee of
> > data=3Dordered mode.
>
> This is definitely a gfs2 bug - writeback can fail for -many-
> reasons, so ignoring IO submission failures when data integrity is
> required is a definitely filesystem bug.
>
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index d6e2f1ded5ca..324da0f5cb29 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -2082,7 +2082,7 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
> >        * Writeback from reclaim context should never happen except in t=
he case
> >        * of a VM regression so warn about it and refuse to write the da=
ta.
> >        */
> > -     if (WARN_ON_ONCE((current->flags & PF_MEMALLOC)))
> > +     if (WARN_ON_ONCE((current->flags & PF_MEMALLOC) && !current_is_ks=
wapd()))
> >               return -EIO;
>
> AFAICT, direct reclaim will still trigger this warning and the bad
> gfs2 behaviour, so I'm struggling to see this as anything other than
> shooting the messenger...
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> dgc@kernel.org

Thanks,
Andreas


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6090A37B025
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716264; cv=pass; b=DUDtWQm/+AArsM6V4BRK71tbNToqktpmUiari9kAR7ROfLCd8GmS5ZTSX4gfbZs+VIXOKzqxtkELeSpCys4+GoqHuzQ2Bhy21DDn0BiX+LLr0ZV7XjMGkKlHXhUEjAQzcFdRY/TX9CFzWQv+nAQXbVBqQ283/JkNvRjX32JxKhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716264; c=relaxed/simple;
	bh=ADXP7wseM6RB3b6apAqIV01cHzdmcUCzaLLwJYZCXMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Urxb9bSDeSw/uvDnVwxRNKyuNtO3iOpHbdjEPvo7wuEYog5qxS4uw923wko1s7OlMh8gT7PJget2UedHqHTkNZBGNKAoWrht02fpcvG2jK9s/pzWeDtC9ZXnmtnU71xtWRafkhcDWkt1SVO5cNuyd4SSkjEE67CYqZRX8eeRFPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKEReLvl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFuAQwcC; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKEReLvl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFuAQwcC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790716262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0avdwGRUerzew4pppHC0Kroikq1W4RaEB726c/pnxQs=;
	b=BKEReLvl79+HZLdXykWRpzMod/vL9QvFWFTBdtMIKLgpQkFb9J67FglMkPvLW4K6l6nM66
	Gbr/5O8x+uxsBBTj6B1r/YEG4HXhku9Bc7cMVJkdqYo8iJR3JOxtOdTpTGnQ0iTnVBSyQs
	wRL0jg/Khe8XiR5oL7xgcyh4/XyR1aE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-I2BA8wrfOsCQgsvBfGncFw-1; Tue, 29 Sep 2026 17:11:00 -0400
X-MC-Unique: I2BA8wrfOsCQgsvBfGncFw-1
X-Mimecast-MFC-AGG-ID: I2BA8wrfOsCQgsvBfGncFw_1790716260
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8a9977a4261so57134537b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 14:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790716260; cv=none;
        d=google.com; s=arc-20260327;
        b=ju0de5Jw3ywBdnMCYofZCSqJrU/9eLzjIdnnSZ8/DcGhHSM8YH7fGDrKcy4ock6ixd
         Cufff1CWFX3T0HueOR+xJ2/GhYeOga478a8zRJSqpOOzLb+HzeMVR8qoKw5EfNc1MNq9
         viDiushWcbGChspEPmz8GZ8RzXWeSIV5/kv2jNGJ/2oPpAh0uGCtM+y3xVOTurFGANYY
         3K4x4ecHAbVTJ6u6SbJl6Jsz93inajFXCfnK80n0MUMW1rbMw4m4jZ/t9AuM/pxcduQB
         bsFoa4fZZfXB+3+rQC51SHkXrhi1L8cw6CAOYiB0NV+80gOLBo/MUkLlExfyFxUjEaEi
         21mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0avdwGRUerzew4pppHC0Kroikq1W4RaEB726c/pnxQs=;
        fh=gf1Ng78XeOlY2q+AQBrzDwmgC0C8qhrPQjq3qH/D+sw=;
        b=ZevT+gIIb/2ChlB5xc31IL+C9IKHZM9iXOkV9rPMBBvLBrbVWGjK4f7ckIzPIwK+Py
         X9m1kVMAxhL3xbDcjSIoBxl0Mkaavq+huVbWfv4oxqhd24h0ei37vlkXIZawlYE0H7zk
         2MBjxp1/xTLnsZ8Z+Y/+DUUVgt3zxOQbLXKfZhzRymrJpPy8debL6h+vcfg7w5uWHWE7
         5fJPYqlY0cSznFm0wDfwWHBIhCQ3Bpral1AZcn7bLTFUFyjTjVLM1rwbbegnK3kQnZq0
         h2EIiZu7KrczAB9Avxo2k2m1d7B/Kg1qGuwMecagOHS7/ReAxqWSQ4N5oIUQqzyVfKe/
         Csxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790716260; x=1791321060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0avdwGRUerzew4pppHC0Kroikq1W4RaEB726c/pnxQs=;
        b=RFuAQwcCPQaqwDHpK6NvxIfGb+XJ5lO7FQ04Sel6gFe2FnQANzCXHwI9XwhI2ZRRMV
         BAALCbZLhxO3OcuQwiONHKLtvt8iUNH8pPGroqrbzxyKqCKdq9AqOTio9jxxnEikJMa4
         7aknZDE8WCr+QjYkDFaZcAOJRcLZ1QXCIieFnR2/L5rnD4ScN8uLakAk4qTuNLGC5enE
         6daY0KGu9aJksS5LwwqHJ9qWrS2JC0+YjcsRnMzKxAl4aGQV7bW3Y6XQP0ylRrJvLQVx
         EDjP72Xn2LW+A2T49xtI3n5oSnsqxnndQHUf3Yk8aXMu6Zus6wW6F0nLOcfoYkGE1paV
         CsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790716260; x=1791321060;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0avdwGRUerzew4pppHC0Kroikq1W4RaEB726c/pnxQs=;
        b=Q481TDYzfZKs91LkZjGA8k39kgiA4sBfKi41MoADiWAk0VJzVG4U5T9tVew70IWykb
         arXi/Q4xQOHg+4S6vz+yIG4gsm0YwScJD20k23u0u/x1Td+wICbaD89R3YpaMePfcp2M
         UfGzSyes8IRnbwh2TblE1eMzmFywyff2bO2wHi/bgr3dbjAFmeJiMcFH4fzvDq1VrzS7
         T4BJuomedNV8e+Ra3IIvXJmbUlB9VRRNckklywmjWJsl3lQaUL4itDePxkyozUKUZ38w
         PJ59PagkwM8oDc8/5ufqtSBCdy8ScYkoEPvuWpGd/6JggNcoXTY0QPYVhy+MQJfa2WJL
         8yzA==
X-Gm-Message-State: AFq9FYI/nMnogavze2c/GdxoYZ0ZkWfSBIExcB96Hu6mLEtyqbEXNkuW
	quIfjX2s69IXa8E1rEMYzo2WvPMsrfrbzWGBSv40t8NS6QFbnyn5YjX//78rMqAbj1+a28g9zRr
	I4yXOybY88tGcNb4Ocsh0WFIByhjmMD1MPoH6AFMwG0swvmGdkAEiOhPJV78bAvsLRq/EPXh/IB
	8oaKMCsC2xnWhp/++nqbJ3xNItkUNcbovF2MvVsj3bfA==
X-Gm-Gg: AYBFou0FogNfiBykoXof20p0yJs1aofDpfhnQSPNeRlprhe3oAreWX+J4R5GbMo4nHQ
	ibL+EzSzWMKd4LRYYvmyedYTPiR/irch4J51xljVpbdEc/lwYUdeDs1QNV97QQ+Hi4PuXpggADg
	UiIYRDMtdTf/ML5FwobwskDv9Gmm8AbZqQHB3sUjN5S+plF0NU76BbqYLarflIhessAHn4QlVES
	2lwva6jJdeW8gtPZhAHA73RLeOXa2Kjm5R0FLLGcse0og==
X-Received: by 2002:a53:d886:0:b0:675:5f54:9e75 with SMTP id 956f58d0204a3-67644171349mr158630d50.79.1790716259996;
        Tue, 29 Sep 2026 14:10:59 -0700 (PDT)
X-Received: by 2002:a53:d886:0:b0:675:5f54:9e75 with SMTP id
 956f58d0204a3-67644171349mr158620d50.79.1790716259511; Tue, 29 Sep 2026
 14:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911081309.14137-1-jack@suse.cz> <20260911085142.1774803-9-jack@suse.cz>
 <CAHc6FU6YT4EzM8VDX8V0+dhfRJtSrtWxbuwht+b8HG5yzyq7Lw@mail.gmail.com> <kgxyhbgbewpch7pc3auxthhbcfelq7lgi7mxazdo5wvg2ael3b@hilsbf4622sh>
In-Reply-To: <kgxyhbgbewpch7pc3auxthhbcfelq7lgi7mxazdo5wvg2ael3b@hilsbf4622sh>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 29 Sep 2026 23:10:48 +0200
X-Gm-Features: AclHuK9UqhWpM6SAUINx6rl63wXociZVUKWztTN75qMxxHCVsEZdA2U1AApCAYM
Message-ID: <CAHc6FU5uXnjhL9SgOX06xVdTXFP7DtWikwa0bn=bEW__is9bWw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fs: Add throttling to deferred inode reclaim
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Mikhail Rudenko <xyzzy@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 7:09=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> On Wed 23-09-26 23:24:48, Andreas Gruenbacher wrote:
> > On Fri, Sep 11, 2026 at 10:51=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > Deferring difficult inode reclaim from prune_icache_sb() to a workque=
ue
> > > removes the natural feedback loop of blocking tasks in direct reclaim
> > > until they make space for new allocations. This can result in the lis=
t
> > > of deferred inodes to grow beyond any bounds and possibly push the
> > > machine to a reclaim storm or OOM.
> > >
> > > Add a throttling mechanism slowing down tasks in
> > > mark_inode_reclaim_deferred() if the number of deferred inodes to
> > > reclaim for a superblock grows over limit. We measure average time it
> > > takes to reclaim inode on deferred list for a superblock and block ta=
sks
> > > proportionally to that.
> > >
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> ...
> > >  void mark_inode_reclaim_deferred(struct inode *inode)
> > >  {
> > > +       bool throttle =3D false;
> > > +
> > >         if (inode_state_read_once(inode) & I_DEFER_RECLAIM)
> > >                 return;
> > >
> > >         spin_lock(&inode->i_lock);
> > > -       inode_state_set(inode, I_DEFER_RECLAIM);
> > > +       if (!(inode_state_read(inode) & I_DEFER_RECLAIM)) {
> > > +               inode_state_set(inode, I_DEFER_RECLAIM);
> > > +               throttle =3D true;
> > > +       }
> > >         spin_unlock(&inode->i_lock);
> > > +
> > > +       if (throttle)
> > > +               throttle_inode_deferred_reclaim(inode);
> >
> > I would expect the throttling to happen when too many inodes marked
> > I_DEFER_RECLAIM are evicted, but not here. In my use case [*], inodes
> > would only require deferred reclaim intermittently, while they have
> > outstanding revokes. Once there are no more outstanding revokes, those
> > inodes can just be evicted directly.
> >
> > [*] https://lore.kernel.org/linux-fsdevel/CAHc6FU4Rf9-r8m8SSb=3De0k0zyo=
FhQAdjupHMWvT6rStBshntug@mail.gmail.com/T/#t
>
> Throttling during eviction doesn't make sense - you are punishing the wro=
ng
> task (the one trying to free memory, not the one actually making that
> memory hard to reclaim).
>
> Also note that the throttling kicks in only when the queue of inodes that
> we want to reclaim but worker didn't get to them yet grows above threshol=
d.
> This means there's significant memory pressure, significant amount of
> deferred inodes, *and* workers cannot keep up. Throttling marking of inod=
es
> for deferred reclaim is the best thing I was able to come up with to
> eventually reduce the pressure on the cleanup workers. But I'm open to
> better ideas.

Alright, I guess this should work. But the change from throttling in
prune_icache_sb() to trottling in mark_inode_reclaim_deferred() should
be rationalized in the commit message of this patch.

> I understand your objection about the need for deferal being only tempora=
ry
> but let's keep that discussion to the other thread.

Maybe we can get away without it.

Thanks,
Andreas


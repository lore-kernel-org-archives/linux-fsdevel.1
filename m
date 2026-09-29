Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2B3E16B9
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716521; cv=pass; b=ggd3Ki4jBpJzx2xr42nK9dW02kGd+pCkko+QN2fggpuAQN5uMES7zbpaIqXVsdT4YU8+LH7qnllW/gLao0SXuMd1U4VlDIQCYy133cmGfEcYLGPRFz5xBa/zpkFftnWJl1dXCBfU1YZnIYsJer6nr4+IWIoiFptCeh+7sxd8SmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716521; c=relaxed/simple;
	bh=N0Dp988DA5FrqQKAGAPeuZua2WfO2cuDyzKra12FUPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HN1Z5mn/Hjjp18khAjX/STmKO/bBF7VtT0hjgG8a3inOzZEplcVWwxMkVmw3Ja1TEh7LzuWHB2Fg8eomdk37CUosz2yA2wvbmuldcJDMvVv+UCu3UdOXw1tyGFcR9f5h9FQppN6T7JpTBYEnG8S4WiT6AF2oEBJAesVRvxBbIoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxKTWzOa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4HnSqW6; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxKTWzOa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4HnSqW6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790716516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FSuhGLAGqzfcOIaBu8CiLsYRpspmlLc9U2mEqKrqN4=;
	b=WxKTWzOa72ufoGIZOIDJvl15a92bQErKPv/urMgGUY9kYSH7m/ZOlYRaw/Z49syviDlzUb
	zhoUl3/imcfpOTxHntO5ssnHVd9YGX3l2dfzSFUIRDaMoGL6kXKVeLXspYC4ojaxUR3f7o
	qiZZeBBZiI5Sc7f4+OXcPLf69oPLick=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-GDcG0fppOnms0ldmLOeIRw-1; Tue, 29 Sep 2026 17:15:14 -0400
X-MC-Unique: GDcG0fppOnms0ldmLOeIRw-1
X-Mimecast-MFC-AGG-ID: GDcG0fppOnms0ldmLOeIRw_1790716514
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-879b1d03d5fso75742997b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 14:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790716514; cv=none;
        d=google.com; s=arc-20260327;
        b=PwQy/pulpw1qCveLNPaQIu1bj2xfypD040YDfGIPaGT3EGINhb5FG+EoUI866jxKMU
         voZkhf5fGJSzKo3xUEQG8A/0TM+LmXoz22fGdWRHlL7vtOIDIsGw4LqsRyt97UEsa1S2
         mJjyC0PZttOciSo9yXaoULa/lCY7MTZflNnDjpwSfB/HRFJeGHAAVCqmO4JdyW08FNK4
         GyaZtk0Bh5+2ELdYOUyE1re7sqL+zHfaTDetOCFtcTfC9UyTTZjzL0pHJoZZ/v4p4FZP
         IurIywJaWsMWz/MNus1xiJJRU9VdcUSzILT/hzOYAsWmFGZLgrqG96DDGR2tg74VE1a5
         yTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2FSuhGLAGqzfcOIaBu8CiLsYRpspmlLc9U2mEqKrqN4=;
        fh=Vx3pF/PWY4sxoML3nifIZQ9xQpTIerRUyNk4zdFZGok=;
        b=p2/gAvm/xdA9D5f1gnte5wXkEcQMMdYbVqEZfWqQhuhMNWZ0Kbj7caZgB1K4+b7vol
         PkAxkobv1+kJR/Lwefi1e046ZREr0pfgIv+p8ClBAdQYmfJkkRBk1F4KNwsindYoCqvk
         eTwWMeqcP5q8Fw6j1c84kWBESTFTvxCVY4fOLWsqiXzzffbEfTDIgxCPpUT20/tgmNgR
         PfBFf3uX/F1Q5XXXCPgDlKhY9cbnhbFDSLs181UR8uPxCPDIpbOg79HbTkdG20+xKFjb
         20ecCwC0ODvwztCC9pytx7E2wB5t9DE9h7+JLlB8/tDpE5ayTbNWIMHUk08a+73AvxLn
         TWUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790716514; x=1791321314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2FSuhGLAGqzfcOIaBu8CiLsYRpspmlLc9U2mEqKrqN4=;
        b=e4HnSqW6orNhRpzA1tPsFNsaaDh2ZLjfDpLIgJPo5l41x7dmQgfG+T7l/nZdxpIEPI
         4t0O6iJexA92kVqw3L3AAjU6I5sYnSCi6sTZ6rAbImD8ux/JZrixJDQwhkHVUCDt6wvi
         zViehRS83+ySFxuX3SDC9gWfBd42vonKzsE/uwTVkyCHCpNc1kM3b3l1sRynpUQ7m81q
         Z48ZrLB489Hgm+gTaw4SK+tdraFHQvSJAsSUuJ01Q3DJEZXQCTskr/HQDCU6K6RMM4MK
         2gTtwe68jlFFPq5Z3fWcCuVUJ2drp5tCigu512tOOvDvlcJcKRBYA6aBJUCy1uPrLwe1
         i5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790716514; x=1791321314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2FSuhGLAGqzfcOIaBu8CiLsYRpspmlLc9U2mEqKrqN4=;
        b=wcYigCFPNyW924SxyZIZpq1xfJzbLThLStNChWA9DftgF5MrKVWa+mF/O8bSxvOdpC
         q6vcrJR0ue1osuDOZfDzaf9FIoYaF+Vv+QcPWWkJZpTJaXWxpWdTxJe1m2KW0QsyCPAc
         aI7WhpGdcW+18fv3zpL+2epBYwk4ftbZSAKTpDyBz+8CEuBthH5HJRDlNlXQ8QNJvCzj
         4J4/4tGVGo+ml944VYpQZHYTyxUS63SOlgD2fEzNJ8ZkgQg9NjcopqTpE4c78fwi9Ku9
         1N7vAb/GPvqaTKvmdto/bykvxbiEqJOd2k1oShATsU4sX1S7M93a6PYE4x2CQLSYTjl1
         xz/g==
X-Forwarded-Encrypted: i=1; AKwUvBw494glt/pu6zHA0+ZqZNEMUVbFIp4IY5Pt23HXXlyEF4QY7fUzbsM0c/s1+Eu3KA9zEhxQWJFVYVC/DjtG@vger.kernel.org
X-Gm-Message-State: AFq9FYI5Wi4wOmqkD6Qu4z3BmKILID4rAfpFB22Fjjyf5FmrLGiKEcQn
	Ckg5Omt7F4PSUEukRjLAeVMzFBdfkeDymC3SbIcKX60OOs0Hpgnx44pyc7XyCdq+eXPE/Kdah84
	d+a3JglQen9j7nLWALc9w7/0TqqmOuMnYAICzCLRsJxFw3Zbjel8M1CUHZVao18HRulJO/EWSDx
	WFTSfIQztrvyPL38O8llHhMdeWdPfR03tX1gF9kT9/VA==
X-Gm-Gg: AYBFou1akKRTiAcbpCjkvWPvA9UdezE7VfstVFIaoA5q31XajoOPcRKBO8TUkCKwuJ7
	8qPFl5uYuf/JkMPNwuwYKl5h9ThLghrTJGjE7a6mbOx8/wv+5ZPojzj5/eEhylme5lrJrDVuJzk
	kl68Zya6q6Qn/3uITCo17K9guAweqOOTKmcAPyQR3E9TfsmvY4yM/DLDbdiXDuOZYIbVEghWesq
	t++cIG4L0b/LFhwgZ1W4Q0e9ee9mTWz19sv8RFt6DSBfw==
X-Received: by 2002:a53:c841:0:b0:675:3ad8:5725 with SMTP id 956f58d0204a3-67644063cc1mr146752d50.61.1790716513829;
        Tue, 29 Sep 2026 14:15:13 -0700 (PDT)
X-Received: by 2002:a53:c841:0:b0:675:3ad8:5725 with SMTP id
 956f58d0204a3-67644063cc1mr146746d50.61.1790716513294; Tue, 29 Sep 2026
 14:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921211712.1563575-1-agruenba@redhat.com> <rhj2uhowkjekxgi7tkxko5odxw3zikthtnlef5f5owrfjzrt3r@nul7b7ldcb2g>
 <CAHc6FU4Rf9-r8m8SSb=e0k0zyoFhQAdjupHMWvT6rStBshntug@mail.gmail.com> <v6c2tacifzt7e46fmlathfn5lgf54ae2qliq33ydhqkeudqnxc@r7dsaeww4yav>
In-Reply-To: <v6c2tacifzt7e46fmlathfn5lgf54ae2qliq33ydhqkeudqnxc@r7dsaeww4yav>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 29 Sep 2026 23:15:02 +0200
X-Gm-Features: AclHuK_m6BXsIjSqEKF55PqZUMBSueUTteabMNeQfNqLlUUx7SCdfvrnfRnhWCs
Message-ID: <CAHc6FU4X_2+J9R0rdBnuH5szyvJ0=Jm5U6-gTcU2-2ewnMO4uQ@mail.gmail.com>
Subject: Re: [PATCH] fs/gfs2: prevent premature evict in prune_icache_sb
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@infradead.org>, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 11:53=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> On Wed 23-09-26 23:01:52, Andreas Gruenbacher wrote:
> > On Tue, Sep 22, 2026 at 1:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > Hello Andreas!
> > >
> > > On Mon 21-09-26 23:17:11, Andreas Gruenbacher wrote:
> > > > Introduce a new I_NOPRUNE i_state flag for preventing prune_icache_=
sb()
> > > > from pruning specific inodes.
> > > >
> > > > prune_icache_sb() prunes clean inodes under memory pressure ("direc=
t
> > > > reclaim").  An inode is considered clean when none of the i_state f=
lags
> > > > are set; the assumption is that evicting inodes that don't have any
> > > > i_state flags set will be fairly cheap.
> > > >
> > > > Unfortunately, on gfs2, inodes can be clean in the sense that they =
won't
> > > > require writing back to disk, but they may still have outstanding
> > > > revokes (as indicated by the GLF_LFLUSH inode glock flag).  To evic=
t one
> > > > of those inodes, those outstanding revokes need to be written out f=
irst.
> > > >
> > > > This requires flushing the log, which is already an expensive opera=
tion.
> > > > When in data=3Dordered mode, all the ordered data needs to be writt=
en out
> > > > before the log can be flushed, which makes things even worse.
> > > >
> > > > As previously discussed [*], we are currently also running into the
> > > > following warning in iomap_writepages() when flushing ordered data:
> > > >
> > > >     /*
> > > >      * Writeback from reclaim context should never happen except in=
 the case
> > > >      * of a VM regression so warn about it and refuse to write the =
data.
> > > >      */
> > > >     if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC | PF_KSWAPD)) =
=3D=3D
> > > >                     PF_MEMALLOC))
> > > >             return -EIO;
> > > >
> > > > So we need to prevent prune_icache_sb() from evicting inodes that h=
ave
> > > > any outstanding revokes.  This patch achieves that by introducing a=
 new
> > > > I_NOPRUNE i_state flag.  When that new flag (or any other flag) is =
set,
> > > > prune_icache_sb() will skip those inodes.
> > > >
> > > > In the filesystem code, we set and clear the I_NOPRUNE flag in sync=
 with
> > > > the GLF_LFLUSH inode glock flag.
> > > >
> > > > An alternative approach might be to allow filesystems to refuse evi=
cting
> > > > inodes that prune_icache_sb() has already selected.  This could be
> > > > achieved by changing the ->evict_inode super operation to return a
> > > > lru_status code or similar.  prune_icache_sb() would then have to
> > > > resurrect inodes that were already marked I_FREEING and put them ba=
ck
> > > > onto the lru list.  This approach doesn't seem obviously better tha=
n
> > > > introducing I_NOPRUNE, so I haven't pursued this any further.
> > >
> > > So for situations like this I've written a patch set to allow filesys=
tem
> > > to mark inode for deferred reclaim (from a workqueue) [1]. Would that=
 work
> > > for you? It will definitely solve your problems with warnings in memo=
ry
> > > allocator.
> > >
> > > I don't want to have two different mechanisms for the same issue so i=
f my
> > > solution doesn't quite work for you, let's discuss how to make it bet=
ter
> > > :).
> >
> > thanks, this would solve some of my problems. In the gfs2 case, inodes
> > are only in "deferred reclaim" state for a while (while they have
> > outstanding revokes) before becoming directly reclaimable again. So
> > I'd also need a way to clear the I_DEFER_RECLAIM flag again.
>
> Well, that's kind of the case for other filesystems as well. But since
> deferred reclaim is relatively cheap my current thinking was that if
> somebody did something expensive to the inode like allocating blocks
> (that's what triggers this for ext4, not sure what exactly triggers the
> state for GFS2), then we can afford also the additional small cost of
> offloading the reclaim to a workqueue (regardless whether it is really
> needed at the time reclaim actually happens). We just don't want to
> unconditionally offload because if someone is just statting millions of
> inodes on some filesystem, he's basically bound by the speed of reclaim o=
n
> sufficiently fast storage and the additional delay of reclaim and the cos=
t
> of offloading would become visible.

Fair enough, let's see if we can get away without clearing I_DEFER_RECLAIM.

> > The I_DEFER_RECLAIM flag setting and clearing code would be racy and
> > ugly though, so I'm wondering if we can change the ->evict_inode()
> > super operation to return a DIRECT / DEFERRED status code instead. The
> > filesystem could then look at the filesystem-internal state and return
> > how to proceed with the inode. For example, fs2_evict_inode() would
> > probably request a DEFERED evict when GLF_LFLUSH is set, PF_MEMALLOC
> > is set, and PF_KSWAPD is not set.
>
> Right, but I really want filesystems to mess with process reclaim flags a=
s
> little as possible because that smells with layering violation and
> generally tends to be fragile. In some code paths such as iput_final()
> or evict_inodes() I really prefer to be sure that the filesystem just fre=
es
> the inode without having to check details of all the implementations maki=
ng
> sure they don't do something stupid and offload when they shouldn't.
>
> So if we do something like this, I'd probably prefer explicit flag to
> ->evict() telling that offloading is possible and in that case filesystem
> can return special value meaning it requests offloading and prune_icache(=
)
> would handle that.
>
> Another problem I see with this scheme is that VFS is completely obliviou=
s
> to the number of inodes for which reclaim will be deferred and so there's
> no chance for throttling places that create such inodes when the reclaim =
is
> getting overloaded.
>
> So overall I'd prefer we avoid all this complexity at least until we have=
 a
> real-world case where the performance impact of unnecessary offloading is
> visible.

Works for me.

Thanks,
Andreas


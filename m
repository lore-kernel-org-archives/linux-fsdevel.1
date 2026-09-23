Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AA284B37
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197330; cv=pass; b=HBCcsnlsrmopQmF7Hx6RCJ2Qr0TrUI2OehayPKgty27Xj67uW78Ji6e2SVA8aLRPTI4iKmyvQ8521UlJ8B+aQZE95lck/rOXl0inC61Kh4oN/Fj4NAI2ehjVHnSZkHybU7lo+xClJnJiw/oyu2c11jhwh+zGHHM++iaQK1tyDpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197330; c=relaxed/simple;
	bh=/ivY9I/EG9+DSzOaxxM5obfKFkrp4hNLEWa7/4iEB2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7Tz6WF6Q2SVr3ypMRINF7t+sCjzL1a6z+7wzt2gKI1US+DWdaRsq4eIxi829o4aY4D1vq1KGe5vsB4XsCLmSyVnGafNnFXlITF/fSzZ45cGRiHb2H5dJkGIDCdVWiubO7CT1PNXJyJqqyLVqxwA6I3+25FYTQ9g6FgHLURJk6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVa9EvIM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n/CmEFhY; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVa9EvIM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n/CmEFhY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790197326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=teMaf0NJPbuhvSvBaJzyDInJb+MTYgx/6C4I8crlQU8=;
	b=iVa9EvIMSOmnDA9b474bHGTgWhK9mWBlyGQKdZQE95Fl4XI9BIsnvggctghhWj+sy7pem6
	xGGy6iqdWcoKa7a0a2pYuF0GR1vTCxs9at+pTfTjxCJfE3MLhup9MRqLB8NNYBVVzD2C09
	JFu3I0BtsFSnHHXt4+KQDU6TfjFWhyU=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-h5C7OVhkNUyQ4mAfacZx4g-1; Wed, 23 Sep 2026 17:02:05 -0400
X-MC-Unique: h5C7OVhkNUyQ4mAfacZx4g-1
X-Mimecast-MFC-AGG-ID: h5C7OVhkNUyQ4mAfacZx4g_1790197324
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67109c1b071so2137904d50.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 14:02:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790197324; cv=none;
        d=google.com; s=arc-20260327;
        b=Z9EwXv1dL4AkuaQU6NzlhrKm/ieckTSRbISR3XBZsHR2mf1I+SbwxC5esikiM5qPCs
         aReRf7lATM09KghDhyA5auoPO9UzmmfJfucEKj3vHC9m9fLisN0UGHOXcy/JfqhypMrD
         OX3hxiM7kwpSKg+mZ02OP5zuw+dQSaKRSHeWG19Dnj9ElYTrOPz0XzLxMV+pLCSHIuCZ
         bRl6fq+9BAPZUewPeh2Z8LxmJErrMZ67O3hcJe9RPrP06YV7AZzDjO/XaWmf9XnViHxX
         Ar617O/pzylQSPZZnksZS1qo0EapYBkkXoaFKIXEp5kLBSZ8/HVU+HexCvaJShII5yLO
         j4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=teMaf0NJPbuhvSvBaJzyDInJb+MTYgx/6C4I8crlQU8=;
        fh=QQ6UgaVulKmAo3SK6fny4F7Z8QrZT8UY8b/ckriq1u0=;
        b=cVaTqHM9T6kG+tAjkM+BMoFlTS4OvpmmIwssKbXJio4k3cIYrRrLMtko9Y8jxBErrX
         dpFp+N5lEwARKxD4VHNWzmjVNyBi6iLkpF5taiG6TICVZjhj00OmjniFWSPzeqsuu3XA
         Fz9cf1Ru7FTkIF3v0hD23cnW9a1Trits7mcsCQ5po0hvoHvC46bfJEig5/oaIMUUUNTA
         0n4JNsWFBs/Ah4vIVgjkWbHZ5RlpUY4sh2nvvECjlIN5np8QGAYrNlsTxzj1hQJupxOY
         oroJF+lPmCDJJeR+qLUuP4rCBpfNAVegHKvyzODkWWimI3forQCsRrnqBxWUCxZnjbbo
         wd6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790197324; x=1790802124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=teMaf0NJPbuhvSvBaJzyDInJb+MTYgx/6C4I8crlQU8=;
        b=n/CmEFhYAJ6MW3O+wjQ17UzxqlCJ10jJz3Ge87DPMfsz+JewaXJ8mpe/bCrYblQt08
         AxEhkb5gsvAtL2gCZtzLKhAyvPkNDudpQh3h9nLMGOEldlf+KJYpfBQ0+CMP7/vyGGQH
         wsACfNLDGYY8fZLifo93OyIoYkXJIOr+ehjCzjCweIAi3uLpauw0oka1mxr2sJYITdAl
         02jWqtjWwa9MCGZFN39Wws+eKs8UhSzxeEBXPb5lN7HX6Mok71MujcLawfSktjCc97WP
         /8ZX+zot8DTfhFEszQJ+YuFMSmVn9thpkumAwZS8uTlZc2uEmVHsRC9HW5HZHljDGlS7
         bTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197324; x=1790802124;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=teMaf0NJPbuhvSvBaJzyDInJb+MTYgx/6C4I8crlQU8=;
        b=MoUfARIrpMAkzmqja/6Q9nn+01RdfQ1LL7W0p6wk5bN6FGUclYlWAJRIOMBzhtHm36
         YgQoME8yyX7qN0mx9tsIt+FzC2kIqFLrx+VvyQDJpKoIAvRQfxk1xKkWTfUkqE9VYH6I
         Qmlj32Yt0R9Q8jPzWJk9T4Q7C6WZ9+f+4G7Fd6SCpHmYKTfqGCNHiwRfGp2PY8cjJpVv
         2kjNjFhoCb9cwu51U1zHfX0S/68OADiKOmjBo+V5JWm7pJ52bEA/A+Kqvw4UMCGTxxq/
         p8CSFdcHCud0OB5QSrn07rjPwmTz1p2zCP2BOA+ExrS1XaGICN6mK1iYCmgWI9AUU4Fb
         OWdg==
X-Forwarded-Encrypted: i=1; AKwUvByu/cmLWvqFI8Z0yN+Oy75gsdv2qsITqiq/B1dt0LE/sW0ubAN4jcPaXET6YdN8iDplRjQvIpm5Q6ngnjLz@vger.kernel.org
X-Gm-Message-State: AFuF++nMnB7k1GCGpHrwQVwSmxWL09QRYKUUYO6p9ANRPY8J05napsw5
	6dsNGK8xdurkNgkEimIDUPnCyh/r8NjhygvvNzs16yeZVEvv56Hy9swtFvkjqbAnK50d+1u0DsJ
	NfcxKHppaYgmvSguMxu/68XNRjp/wpmZUhrNouPyyfeNmjaPVO6XyahO7cVxzgzG0MBq8zfDNIb
	LzHdst6QFyukmbLyJBx9eTOOLssT2a5Ciium/HGbOKQg==
X-Gm-Gg: AYBFou2KX4OY4Rx8SFv2JdMElDeFjQ/f/vqC8YfzdaQ/14El7wHlqUOy9Gxmyod8tQ1
	SFxC3R20sKwbenMWInfOPsVka5rbBU2y4ErmSm1uPmsm9IxEYCUIRqdPTtnIACjLyAEct5tpw3g
	cA30V9FnFaUOKpUNYE9Xyt5uD53EHZ6X2+Hy8rZ+kMogtglFBHzRjAIBsgiSx03m7FG5+nLIDbA
	ebGQUHOz8NapF5GSoIQFX6V2enfl1v7he3SS7d7lEsqKw==
X-Received: by 2002:a05:690e:408b:b0:671:70d1:d6d4 with SMTP id 956f58d0204a3-672ed8e80c4mr293368d50.70.1790197324224;
        Wed, 23 Sep 2026 14:02:04 -0700 (PDT)
X-Received: by 2002:a05:690e:408b:b0:671:70d1:d6d4 with SMTP id
 956f58d0204a3-672ed8e80c4mr293294d50.70.1790197323555; Wed, 23 Sep 2026
 14:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921211712.1563575-1-agruenba@redhat.com> <rhj2uhowkjekxgi7tkxko5odxw3zikthtnlef5f5owrfjzrt3r@nul7b7ldcb2g>
In-Reply-To: <rhj2uhowkjekxgi7tkxko5odxw3zikthtnlef5f5owrfjzrt3r@nul7b7ldcb2g>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 23 Sep 2026 23:01:52 +0200
X-Gm-Features: AcwNN1Wx3An96hJa8GxLoJV99l3BMwVJSGq56GeWtJeaT0vWl86MXKjtrRWGLfo
Message-ID: <CAHc6FU4Rf9-r8m8SSb=e0k0zyoFhQAdjupHMWvT6rStBshntug@mail.gmail.com>
Subject: Re: [PATCH] fs/gfs2: prevent premature evict in prune_icache_sb
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@infradead.org>, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan,

On Tue, Sep 22, 2026 at 1:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Hello Andreas!
>
> On Mon 21-09-26 23:17:11, Andreas Gruenbacher wrote:
> > Introduce a new I_NOPRUNE i_state flag for preventing prune_icache_sb()
> > from pruning specific inodes.
> >
> > prune_icache_sb() prunes clean inodes under memory pressure ("direct
> > reclaim").  An inode is considered clean when none of the i_state flags
> > are set; the assumption is that evicting inodes that don't have any
> > i_state flags set will be fairly cheap.
> >
> > Unfortunately, on gfs2, inodes can be clean in the sense that they won'=
t
> > require writing back to disk, but they may still have outstanding
> > revokes (as indicated by the GLF_LFLUSH inode glock flag).  To evict on=
e
> > of those inodes, those outstanding revokes need to be written out first=
.
> >
> > This requires flushing the log, which is already an expensive operation=
.
> > When in data=3Dordered mode, all the ordered data needs to be written o=
ut
> > before the log can be flushed, which makes things even worse.
> >
> > As previously discussed [*], we are currently also running into the
> > following warning in iomap_writepages() when flushing ordered data:
> >
> >     /*
> >      * Writeback from reclaim context should never happen except in the=
 case
> >      * of a VM regression so warn about it and refuse to write the data=
.
> >      */
> >     if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC | PF_KSWAPD)) =3D=
=3D
> >                     PF_MEMALLOC))
> >             return -EIO;
> >
> > So we need to prevent prune_icache_sb() from evicting inodes that have
> > any outstanding revokes.  This patch achieves that by introducing a new
> > I_NOPRUNE i_state flag.  When that new flag (or any other flag) is set,
> > prune_icache_sb() will skip those inodes.
> >
> > In the filesystem code, we set and clear the I_NOPRUNE flag in sync wit=
h
> > the GLF_LFLUSH inode glock flag.
> >
> > An alternative approach might be to allow filesystems to refuse evictin=
g
> > inodes that prune_icache_sb() has already selected.  This could be
> > achieved by changing the ->evict_inode super operation to return a
> > lru_status code or similar.  prune_icache_sb() would then have to
> > resurrect inodes that were already marked I_FREEING and put them back
> > onto the lru list.  This approach doesn't seem obviously better than
> > introducing I_NOPRUNE, so I haven't pursued this any further.
>
> So for situations like this I've written a patch set to allow filesystem
> to mark inode for deferred reclaim (from a workqueue) [1]. Would that wor=
k
> for you? It will definitely solve your problems with warnings in memory
> allocator.
>
> I don't want to have two different mechanisms for the same issue so if my
> solution doesn't quite work for you, let's discuss how to make it better
> :).

thanks, this would solve some of my problems. In the gfs2 case, inodes
are only in "deferred reclaim" state for a while (while they have
outstanding revokes) before becoming directly reclaimable again. So
I'd also need a way to clear the I_DEFER_RECLAIM flag again.

The I_DEFER_RECLAIM flag setting and clearing code would be racy and
ugly though, so I'm wondering if we can change the ->evict_inode()
super operation to return a DIRECT / DEFERRED status code instead. The
filesystem could then look at the filesystem-internal state and return
how to proceed with the inode. For example, fs2_evict_inode() would
probably request a DEFERED evict when GLF_LFLUSH is set, PF_MEMALLOC
is set, and PF_KSWAPD is not set.

Thanks,
Andreas


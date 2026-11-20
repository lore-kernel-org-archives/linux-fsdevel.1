Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795186767;
	b=2bPrSHk/5cwHTNJoTM7xH04RmKDuzUlakaAFOYA5MIYH+66hOB0BRAMQ5lVPgYBDeZJ5
	 2TQdTxoiFBo4faa+FEA3+qe6VjctzTeG9dgKwDHvR6uVyoN0eWfYLWWUeV4g3vkpsZbm+
	 OkgGznNZMvCkklqw1UYjh943YVNFYTYn86mnAseeaulUxmmq9in2QIRqqUK4FtQIbFxov
	 IUE+mK3TA9Z37v/NTILMOX4wXC7YtTCw16Jp2QM3zOuFRlqRpD4YFFRUge0g03JIoQGsF
	 5ib5O1peIxLinDFsVsfuimKbL22zMJBcbm34h2p25vST1YgMazUJM6F5oSJ8Ghpo4MA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186767;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
	b=UVVFZGl7k3eo0kCFzqQDMr72AWtOKN1LPuB8tD9WWIFWUfz+cAT7Nf0mmTIUaYga57tV
	 wcrpWxQgoa08FMPlk0YMighyH7007bDAXkhHh3vI1MrhqltJ765wUUv9Ir95kjkHGdsaC
	 QsBQmDzF/N+gThZUFWodRlr/dFXQPdBpgOkf5cG53CCzSva3eihBBbg8n7dkAL1uLHwlz
	 Ibojui3SybrA5mXktRBn2qEYuDdV6GN0WGbA89GBDwISGG5xWUAb7z2+qQrJVCggDvpBh
	 c6zLxZqCqZFqaLUHzXgIJxnYnC0K7T1oH9WX7ttEvPD6JhHl1GDQNju9DNSfpVtA+9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z89hm29S;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=B0zBjARr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF860A3813
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBF860A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z89hm29S;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=B0zBjARr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795186765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
	b=Z89hm29S5CRJTe7acG6K64lxDlw9xcGkpan2I3lFQ3cjGeNWOeTzeosu6UAtq3sKx2015+
	/QXmSToKPlRJBLvsUeURhVQJ4d72cR/Qc6jv8zK8euPwt3xop8GkRRopXODfwMJaB5sEg4
	yp3X1QTYRupI30Bfe/LdDi0czKb7xpU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-XYRXzYrIMh6D6P3MIgUsDg-1; Fri, 20 Nov 2026 14:59:23 +0000
X-MC-Unique: XYRXzYrIMh6D6P3MIgUsDg-1
X-Mimecast-MFC-AGG-ID: XYRXzYrIMh6D6P3MIgUsDg_1795186763
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b3342f229bso30194087b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:59:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795186763; cv=none;
        d=google.com; s=arc-20260327;
        b=g83azu0I/0xzyNDGF1fotspvRab1sPiKxuR5Nt8FBPD+ghRD0gfzTzEM7kHa/QDC6W
         vHOfaF35ZFUcG//DOPII4/Pcz2gpO692aFMM5FprH4E/Y8n89DfPUUNXlgrNdRDHV3Lv
         Z4Wa1+y1Sy0/srmYKQ1IWja3LU8AHfVeY93Szz3Sqbna0vQhqJMpNkXt3AAgEQf1uKk7
         nGBNB8pVsv8rekEPLvVhx6C7ww8wb6QS36uhwqBji8sX7YwiIzMPcOOozZD+Xhsr1KjP
         Q0sgp7HTjIN8vcA8B6fbr0DJEg3nIm1DyPZO2Af8WolhSCn/8C+6Sv6ixZjrCrR4PUPs
         rNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
        fh=pSEdko/pFndyI7qGAVzyx7Rf38+6aHn10/P7HtgqJHw=;
        b=DOQYcrsjDHyAECnnxFtH8VV0T7liGczwBHBywqXGCDEIx0vbCYvXnfdiiV15dILa5m
         RdZCriuN34q7edoifz40n8VjhuELl11/ueK7uXo3cObJAF3NrvG5y8CMDgqAA1FX8h1+
         RMdPcvA2WYibA3utRqUD9hN4j49gC1tXVuy32N8SydB8Q1Mc819A26KWpJvAhqoeCDg7
         2apVLvdZdepbhi1qNrCZQA8jRE/v8UcFVHOOqAWQek6NKDNd8g70CnzaKwINDlT297Qx
         L2hkNY8A3AsifjqwaOvkl+aWK+mADVwlf0Hk4s4Vz1kud5MulEwPPEyBLz7oW2av6W00
         duFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795186763; x=1795791563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
        b=B0zBjARrRRH2r0deOfQjVsuOqCKgolcPVXf+fD+/upNOm1SI2J0Fj+8hY+BByh77wi
         wIo6WP2LnzMYME0yMogIOBTnsGlCbXTUWkqCLZN/JjBfYyGQDmkk6dem+2zXSG4IUPU3
         sND/wM0H9VP8wTirnvgOKk/zDLalvg4W6C811EM3SZHhOhR26YoOGkQGlXbr8vBxl0Tz
         eVd24Zbi2NKaHoSIjtsPBgsJlBRlh4Hg2qkwO08OMdkfbZkDKRyTfNWChbo+Mqrw60e3
         PhGL+twPKIBOEX4iy9sNF7fJMakMUXlyuUxULFZvbAglQSPDpBzodxHyQ1ofF8MysWpW
         nSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186763; x=1795791563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
        b=azGzXQ5YmfGdOkzCFOmB2FtLmrOVu6EOcr3mtUgoVrJ/93HzwWZDzDVYnuQcwIFwKs
         zYOq2aHQVcn8Dvz6A45hGtKD49nNukodbMprnDn82ccTteXqCv8tyG9lhoMJTbj2Jj+1
         c/HJTUtvO+tRkFSot2JhS2RiDJMx1mRhXPiAQGMxHkFYwxW+NaB5ADxqF9fRUjmPOpMm
         LgaSZvZvPFs/rEDK+nlFLZH5TGDtjdwb69E/1EFdVghzqPzANti+lerCdI/9bJ8jcml3
         YnRLDekOS22+dLP41H8sU7hVhbnBxxZOo5eBbe3egkQDa1yOqYDTFlR4RKmwV/oO61b5
         4cvw==
X-Forwarded-Encrypted: i=1; AL+hErGlO6SJnuph05+srIwUHj0zMMKP8ru81uCU7/p8vdTHINzWNxMSO/LD2iY3T0Kf4GLZrf+E1AuqJhjULzWW@vger.kernel.org
X-Gm-Message-State: APuU4Z8QBbZD7U0j+3ozeudXEc7Ugp1PfKLxCHZ4/x9Uyd2K7jnKT8uI
	hM1FaEs6Exd6dgS9CRY2z0THtajQF34+z6tZxnHymUnwbR61MS0FXPhQV/C+TPEmI+FGPUpu+h+
	g+Hf9l6J0p0DaEqjzDgjoLEkXuI4Q6fGBXcfYAKU3C7YvS2Vel3JTtfgs/IhEBxpa84Vkjv/QQp
	wtSYd+adR2Qo1gAupqVnYiBzpI46W6sp4LLthBeo3UwQ==
X-Gm-Gg: AZFdTZdpyVqdcZxT7fEUIsJ0/vNHAnQy0hSi/CafB38FDvL0GfQpWhgMIn/yzpxkglU
	TsLVdeActXnnWJTfl16h5n/x1aULyxlCiB5QSG+qMjfTzJA3JFCDa3tI+4KD+IEk3b9dRHTgdEl
	ABfoouW7mISxCLaHsFms/kRbcb9j1+qH4qfMqo4SHP1hmTZYDdgmumRyvdM8cIXtH6rTdL5Hgql
	6/HlAtC198JMqh8cOFbtlbv8CvhGWGNWK3Lz1r59MVI6A==
X-Received: by 2002:a05:690c:6893:b0:8b0:8a77:e9b8 with SMTP id 00721157ae682-8b518d25cadmr18702467b3.4.1795186762639;
        Fri, 20 Nov 2026 06:59:22 -0800 (PST)
X-Received: by 2002:a05:690c:6893:b0:8b0:8a77:e9b8 with SMTP id
 00721157ae682-8b518d25cadmr18702267b3.4.1795186761947; Fri, 20 Nov 2026
 06:59:21 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120031305.3561045-1-huangsj@hygon.cn>
In-Reply-To: <20261120031305.3561045-1-huangsj@hygon.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 20 Nov 2026 15:59:10 +0100
X-Gm-Features: AclHuK92MT1vYW09O4Urhd7Yf7t3vir7SJ2k6LlnKDbNPNtVZYsZ96-h_yHunoE
Message-ID: <CAHc6FU7URHetBU9XgP0DSEGjWQfq0tX+ohK8xRVZLEYzgJBeEw@mail.gmail.com>
Subject: Re: [PATCH v3 0/11] vfs: add inode iteration methods
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 4:13=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
> This series adds two superblock inode iteration helpers,
> super_iter_inodes() and super_iter_inodes_locked(), and converts the
> open-coded sb->s_inodes walks in the VFS to them.  The design is based on
> Dave Chinner's patch set:
>   "vfs: improving inode cache iteration scalability"
>   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.co=
m/
>
> About the two helpers:
>
>   int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
>                         ino_iter_eligible_fn eligible, void *priv,
>                         int flags);
>
>   static inline int super_iter_inodes_locked(struct super_block *sb,
>                                              ino_iter_fn iter_fn,
>                                              void *priv);
>
>   - super_iter_inodes() runs @iter_fn with a referenced inode and with
>     sb->s_inode_list_lock __dropped__, so the callback is free to block a=
nd
>     to do whatever it wants with the inode except drop the reference the
>     iterator holds.  The iterator releases that one reference per inode
>     itself, so the callback cannot leave a dangling inode behind.
>     It is exported because GFS2 can be built as a module.
>
>   - super_iter_inodes_locked() keeps sb->s_inode_list_lock held for the
>     whole walk and takes no inode references at all.  Its callback
>     therefore only has an existence guarantee: it must not block and
>     must do its own inode state checks and its own reference handling.
>     It is internal to the VFS, being declared in fs/internal.h.
>
>   - The callback is separate from the caller's data, so a caller keeps
>     its state in its own structure instead of filling in a shared
>     context:
>
>       typedef int (*ino_iter_fn)(struct inode *inode, void *priv);
>
>   - %INO_ITER_F_REFERENCED restricts the safe iterator to inodes that
>     still have a reference.  It preserves the "only handle referenced
>     inodes" rule of landlock's sb-delete walk.
>
>   - %INO_ITER_F_NOREF does the opposite: only inodes whose reference
>     count has already reached zero are handed out.  %INO_ITER_F_NOIGET
>     suppresses the reference.  Neither keeps the inode alive, so the
>     caller must make it unclaimable itself.
>
>    Patch 1 adds super_iter_inodes().
>    Patch 2 adds super_iter_inodes_locked().
>    Patch 3-5 convert the callers which cannot use referenced inodes
>            (dquot removal, nr_blockdev_pages() and the
>            generic_shutdown_super() poisoning loop).
>    Patch 6-11 convert the remaining callers (inode eviction, sync_bdevs,
>            drop_pagecache_sb, add_dquot_ref, landlock's hook_sb_delete
>            and gfs2_evict_inodes()).
>
>
> BTW:
>   This patch set depends a small patch:
>   "fs/drop_caches: skip filesystems without fs writeback"
>   https://lkml.org/lkml/2026/9/23/675

That link doesn't work for me. When referring to other postings, can
you please use lore links?

There also is no posting of a patch with that title from that day on
https://lore.kernel.org/linux-fsdevel/. You may be referring to
https://lore.kernel.org/linux-fsdevel/20260920072811.2064247-2-huangsj@hygo=
n.cn/,
but that patch queue no longer applies. So please post patch queues in
a state that applies and optionally, make a git branch available.

(Also, enabling "git config --global format.useAutoBase whenAble" is a
possibility, but it wouldn't have helped in this case.

> v2-->v3:
>    -the callers' state no longer goes through a shared struct, the
>     callback now takes the caller's own @priv.
>
>    -super_iter_inodes() takes @eligible directly, so a caller can reject
>     an inode before the reference is paid for.
>
>    -rename super_iter_inodes_unsafe() to super_iter_inodes_locked() and
>     drop the rcu_read_lock(), which the list lock already covers.
>
>    -drop @ctx->prev; the resume point is gone with the unsafe iterator.
>
>    -evict_inodes() no longer goes through the locked iterator.
>     it now uses the unlocked iterator with INO_ITER_F_NOREF | INO_ITER_F_=
NOIGET.
>
>    -each caller gets its own patch.
>
>    v2: https://lore.kernel.org/all/20261113115702.586594-1-huangsj@hygon.=
cn/
>    v1: https://lore.kernel.org/all/20261015093854.2082600-1-huangsj@hygon=
.cn/
>
> Huang Shijie (11):
>   vfs: add super_iter_inodes()
>   vfs: add super_iter_inodes_locked()
>   fs/quota: convert remove_dquot_ref() to super_iter_inodes_locked()
>   block: convert nr_blockdev_pages() to super_iter_inodes_locked()
>   fs: convert generic_shutdown_super() poison loop
>   fs/inode: convert evict_inodes() to super_iter_inodes()
>   block: convert sync_bdevs() to super_iter_inodes()
>   fs/drop_caches: convert drop_pagecache_sb() to super_iter_inodes()
>   fs/quota: convert add_dquot_ref() to super_iter_inodes()
>   landlock: convert hook_sb_delete() to super_iter_inodes()
>   gfs2: convert gfs2_evict_inodes() to super_iter_inodes()
>
>  block/bdev.c                   | 101 ++++++++++--------------
>  fs/drop_caches.c               |  45 ++++-------
>  fs/gfs2/ops_fstype.c           |  29 ++-----
>  fs/inode.c                     |  61 ++++++---------
>  fs/internal.h                  |  31 ++++++++
>  fs/quota/dquot.c               | 139 ++++++++++++++++-----------------
>  fs/super.c                     | 106 ++++++++++++++++++++++---
>  include/linux/fs/super_types.h |  29 +++++++
>  security/landlock/fs.c         | 138 ++++++++++++--------------------
>  9 files changed, 370 insertions(+), 309 deletions(-)
>
> --
> 2.53.0

Thanks,
Andreas


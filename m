Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35613CD8C7
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236709; cv=none; b=CvrdjWsmlMhQQ8RpgSDQ4XdH8gE2tC+lgMzrK0/LMja93Sj2bHThrDR5XybvfiWsgg63h5A2Bq8ldNJYNvmy8/Z+INwEvP8Hb8Z5dcXd4C0qRvN//v0O9rHvEwjU2fTfuHmJFmGwgplYEc2NvUJa2Cgg7mYX+9lCPoS9OydUkpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236709; c=relaxed/simple;
	bh=Cvq5tuLj5ZY1DMhHPFEu+lE7/fw/C+ofjPzqyp3q+wU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WZjjGLH3HrGg4EEly2efl0sQw+PuLetNvXoBpLYipV9xDlYi+wpnTI9UltQKfce3DR8dxmpA9X5JvBhqLiJlY/tU7MoIoeiST8CtiSe9BydHWKF/bhM1Lhub3c/VLKi3sKWdv1l5BmueK0H9uQPYXSgKq4tmAbU+PAvmjQrk7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNGGs2Ul; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtGG9Fuc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNGGs2Ul";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtGG9Fuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775236707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTtM7wHX05jakm5x7iALH4OzPfU5pZiWtOLbV28TT+g=;
	b=fNGGs2UlN5izdB9OhYDKL3ltSU7qV+ANEljaxcJ0f1FBJg12J1Qxd3PbV1BuF/yKfPWOS2
	O1d2BHaRB0ytPJUurBRHzaaOchd7gI65+1YQazfMZD12Rpv0EH5ZBahzDGZIE9MR5I++VN
	U60miAeQ8HoGNKO4gJwPFikOQwY3CCo=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-oFaVz-LQOG6qmozlm0YcpA-1; Fri, 03 Apr 2026 13:18:26 -0400
X-MC-Unique: oFaVz-LQOG6qmozlm0YcpA-1
X-Mimecast-MFC-AGG-ID: oFaVz-LQOG6qmozlm0YcpA_1775236705
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-463a1cee56aso3745893b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775236705; x=1775841505; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QTtM7wHX05jakm5x7iALH4OzPfU5pZiWtOLbV28TT+g=;
        b=TtGG9Fucx42gRq8YjpM3ui2Nst/fsorIKywH60Rh4WbYVx96mVVhI/HT4BZD+3wZdn
         IB6AHTkwQUePPRMnemvnTRKs9jIfqMOm6HMnx7DXoAMXCfgBEWvb+RpDZ0uWIq8mLONC
         ZkuP2VmOFbzEc54BTqb4sxvcovtYLpPdm1OWQsfEmRo2YCMAmhKh8IWsLUXypYE1J+KM
         SoEm304HAzVibXjVzd9dQjCfhR/3Qmse0JY5KGT8x26wOOgbdvvLum2hQp+ZsbIVCZQj
         K/Nw8FKvPMNA4oTwsY09s5LNAiBi9zq0zQGcBzBwKdH0S0YpujaXqif6YaOBlB3SLqUM
         R8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775236705; x=1775841505;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTtM7wHX05jakm5x7iALH4OzPfU5pZiWtOLbV28TT+g=;
        b=SuWnhNPWL9uoCBnKjcguOf8ngiiuk4jP2cTrwQXW4ihsofAq+YFXdw1yGTg/zOo1i/
         1di7ixo+1UpU4eJbRG4qgfGNN1r+7BF6944CgPOD25LBPm4iBflKhBGxEAxokPdY2FS1
         exfInUweXd+1z4GZ7mReUJ5LluuZwzkMMb+kvD+XlqIgQ0APh//7sKscBK0p50SD8vhA
         1TPoecXvE7oo5h/eSr8p5PrzVCT4RjAb8NwDXWvDSSqovsCf6Vl/pCAG2vXJaPrhufOK
         TPwxHLBv3CBB3Go9/WzCPlTf4qYPHa76Gz3wHQFxhmD8CdCCAlHshF61TAHAHSxQemqo
         gcrg==
X-Forwarded-Encrypted: i=1; AJvYcCXN6ytcOTstTtIFG6mov0NQY8q4YfEb63LsmlfjzyVLixHkx3+PYoWQ58SGdUMsdyzelpNGWXzGuFM5VWem@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzP1Taq6L0qDW4esbhkIsyD4Ex7h72s8sqyQ2nq74agUDOetb
	glIKMagSqm5w0AePlPj0Ia0ixxgbHyoGy49SfUqoxRHNbvsAAsA9L/FZ1llnOSXVVDUAKDsyF+Y
	m+zxBV1jO7jiNOg7vv58dcz5T8WqdjQRYHkmjFzw178tU/4S6+mxKvY2s6+LiUWo6c6k=
X-Gm-Gg: ATEYQzzzPjX3Ye9xJ0XWiptzpdZRpQqEcKdq2dqATh6SdJHvAc31OBNrSTlcZpkxmX2
	hpXxAnAztbaxIx6jMvTTKsU+CDRsJV1BO19PrELDy770m4zOblPb0ynjXoJw5SS0HZSCsNWVZpq
	DZ2+zD/WzMxyqPLB28AA6s5ie3nyHyh2XH5rVt/wIuIVVFuQp1qyjhYvjs9J0xBmFCglN37+b4V
	VcgsLUQjH2mDTreezHy79fCJp4GKCKeMi79I7dugxdel72pkaRU5a1qlgAGweiEgbS6A8zYvpZZ
	rlZNBxP1oNdavtuyIdFXI+2+QoDteL8FYBOfIwwh/nDo4FIq0KNI00D8Xf9qsbOqnu3a7PeUbcp
	jS9dIgK7jXUmwFwHl5f5DsJt5UV/Kb08gtqilEe6b8XPNU0yibx2/
X-Received: by 2002:a05:6808:6503:b0:467:46e7:e6dd with SMTP id 5614622812f47-46ef5fed372mr1930296b6e.16.1775236705049;
        Fri, 03 Apr 2026 10:18:25 -0700 (PDT)
X-Received: by 2002:a05:6808:6503:b0:467:46e7:e6dd with SMTP id 5614622812f47-46ef5fed372mr1930282b6e.16.1775236704582;
        Fri, 03 Apr 2026 10:18:24 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46f0f4e16a9sm1611319b6e.4.2026.04.03.10.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 10:18:23 -0700 (PDT)
Message-ID: <ff8929f3cc1ceb1fef43f292c9c5926a25d8336a.camel@redhat.com>
Subject: Re: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 03 Apr 2026 10:18:21 -0700
In-Reply-To: <CAKPOu+9FvR-ZdhcQc-+KzVMgobCkrJpzEsJis2ekuz0zwC_qZQ@mail.gmail.com>
References: <20260401205613.2095623-1-max.kellermann@ionos.com>
	 <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
	 <CAKPOu+9FvR-ZdhcQc-+KzVMgobCkrJpzEsJis2ekuz0zwC_qZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-03 at 08:52 +0200, Max Kellermann wrote:
> On Thu, Apr 2, 2026 at 9:44=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redha=
t.com> wrote:
> > The Ceph write_begin path calls netfs_write_begin() but does not pass
> > IOCB_DONTCACHE through to trigger __folio_set_dropbehind. So,
> > folio_test_dropbehind() would never be true on the Ceph write path righ=
t now.
> > Does it make sense?
>=20
> Yes, see:
>=20
> > > ---
> > > Note: this is an additional feature on top of my Ceph-DONTCACHE patch=
,
> > > see https://lore.kernel.org/ceph-devel/20260401053109.1861724-1-max.k=
ellermann@ionos.com/
>=20
> The code in this patch is not reachable until my RWF_DONTCACHE patch
> is merged as well.
>=20
> > Are you sure that caching should be always true? All other calls checks=
 that
> > ceph_is_cache_enabled():
> >=20
> > bool caching =3D ceph_is_cache_enabled(inode);
>=20
> This function is only called if caching is enabled.

I think that such interface will be more clean and safe:

static inline void ceph_flush_fscache_write(struct inode *inode, u64 off, u=
64
*len, bool caching)

>=20
> >=20
> > > +     *len =3D 0;
> > > +}
> >=20
> >=20
> > The ceph_folio_is_cacheable() and ceph_flush_fscache_write() are out of
> > CONFIG_CEPH_FSCACHE. It doesn't look right.
>=20
> All of the old code is out of CONFIG_CEPH_FSCACHE, too. Does the old
> code look right?

As far as I can see, all fscache code is under CONFIG_CEPH_FSCACHE compilat=
ion
option. If we have some issues with old code, then it makes sense to fix it=
. But
this code is fscache related and it should be under CONFIG_CEPH_FSCACHE
protection, from my point of view. Moreover, other fscache related code is =
under
CONFIG_CEPH_FSCACHE protection pretty above the code of these functions.

>=20
> > > @@ -1412,11 +1427,14 @@ int ceph_submit_write(struct address_space *m=
apping,
> > >       bool caching =3D ceph_is_cache_enabled(inode);
> > >       u64 offset;
> > >       u64 len;
> > > +     u64 cache_offset, cache_len;
> >=20
> > Why do you need to introduce the cache_offset and cache_len? We already=
 have
> > offset and len.
>=20
> These keep track of the region that should be submitted to fscache.
> Folios without "dropbehind" need to be excluded from that.
>=20
> > >  new_request:
> > >       offset =3D ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
> > >       len =3D ceph_wbc->wsize;
> > > +     cache_offset =3D 0;
> >=20
> > Is it correct initialization? Frankly speaking, I don't quite follow wh=
y we need
> > such initialization.
>=20
> Technically, cache_offset does not need to be initialized as long as
> cache_len is zero because then its value is never used. Would you feel
> more comfortable if I remove the unnecessary initializer? I wasn't
> sure which approach would raise fewer eyebrows.

I am simply trying to follow why we need in cache_offset. We are using the
offset currently:

/* Kick off an fscache write with what we have so far. */
ceph_fscache_write_to_cache(inode, offset, len, caching);


Why the offset is not good enough?

Thanks,
Slava.


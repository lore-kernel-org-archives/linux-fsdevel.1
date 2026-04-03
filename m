Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AF299943
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199151; cv=pass; b=e97R0ga9jC9L4JZheiec9F/J7P/w5IItid/AXljsLAVCJ90Z9t44fmpoIKzjvc1Iw0dlLy6fGOHSzkL2GwhKA5xcGak7Ctj6019dVaWCZlNXihMi/HzkrCvqV841jnWNaPrMJ5G62jYeYa27J4Sff5Tv/Ac5DAzC7DklEjVW+ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199151; c=relaxed/simple;
	bh=bS9Dm9mhURUVbT1hegVPADxmmEiYALh89sOuz/kJvow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBy1zqFi94MEWOpQIXFk7Fgm6FYDjRhunyxfid6kJXI0X/JQdqN2fW5pIZPb8ZG+608jTpROkYOH5FFS2PF/zuO/kxtR4LPPXJyF7xrPqIujyOX7Z1buQqxWyUtXLox7xvNsTq/dy8lRoN8SzioSkxuXTRmWtrFjdLy6feFpzv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Mp5vOqTO; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Mp5vOqTO"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66ad907833dso2910796a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 23:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775199147; cv=none;
        d=google.com; s=arc-20240605;
        b=O/odzUlwgiH6902dR0J01G5ttZLjqH6xLQ3BbeWCBICgibbKg+sFLanAIcVJXdDsFd
         ri6pgBaGopfnBcRZ2wtLLsDRGcQu9s7QPfmqH42BxYhuk7bd0EDdLsnhTMcaJqRZu68I
         +A9BzpaRq3fqzjlg5W4rBFmaQqxZ/np4B8MNwgH3bu40YNiMKp0M8C6ZHdlda03fUHVV
         AKWDIyQUMBsBnJqvjGIMFwEt+W9s1uMb2Wf1WNLS3FuJ6BATjZjHVYVDfjyHHIMYaebK
         6kKXP3HufJQvaN1kpyebUmKCz/M8iPhKCho5WGOLQQ8yC2Hs33hk/f2zzkkf6y4jOKdJ
         K7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ju9ObbxxlTtmCQnctGQWBR1tyuAT12uiexHbbrJ0zf8=;
        fh=Z8s9mlo0uqp667ngw8bi3ATp7sOc/P8OQpMV68CeE54=;
        b=L/JjJ/FCa4tzUr4+JmMTgbm/eyzr7d0i9wQTE95aUhyD7wL0oVpULJYiKI7/rYvItB
         N37MPOj8i9vRlU0gOpifeAgPlyiL4lebWv6Knqw7ewVnjLGcL8matPUe4uMBOZCgsMXa
         z6cIvwabVlr/ZLZWu5RYOPGHH7v/hYN1QeZqE0VJ4bZnnf5QPLik8kUfRM3yu04opSA0
         sb+PTqxbpVcVDEl+A0qlUBLfSjgNQ9k/zWCIedFiQ033zakQZdBwxQpnhPhSDYDKo/TO
         xvjJMg4Oj/SEVobZdl/hD0eDAVY8T2Mne7xPR7yuqf2sjloFEiub54ghfsJ0/jIo/mex
         ai4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1775199147; x=1775803947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju9ObbxxlTtmCQnctGQWBR1tyuAT12uiexHbbrJ0zf8=;
        b=Mp5vOqTOyiVT2m5bItVFj7s8qfyonWlgwwALepzTddEVQR8UjCd+zIbbFiNqmnNUEY
         o1AcpIlNdqHhzNUZbQG78E3lYrZ6KvEmcBB7/iXwIF5MOGpaeOVrGRgQjOZGsRpBS13k
         7DpBJT6zpna+qUXpziTReEXXyGjaHFH0XgKq1oQ6MfYS75EyJWzwCfqVoo122lXJV7pE
         fccczniEtPAA7Cj2Xud8Gbd4rjd58AFFSw8nzRDev2MRg9NVWkg8czD3QjYZvsD/yTIe
         iI1DgFQLFfmmR0YLxigQf4n0B7zdCwFCzAyKz7GG9w0Z3FtZ/e4H41qX9YBiXXpBWObR
         rN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775199147; x=1775803947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ju9ObbxxlTtmCQnctGQWBR1tyuAT12uiexHbbrJ0zf8=;
        b=FVomps659sYmScEc7KM4sq2som+96zukmVS+uHEW9WY+rBqJZeSV0uF9d59sPmrJ1K
         WGLRdLTCn/RiYNMcor5oiWEFpYzmCmiRf9Fh0D5JJeD76o44m/syciYHJ1SQ+BQ4XafX
         wT9qn3zqL/rLJ2FM2v/ow5MVzd/BhBXtaBq37D8EIJM1WcUXFkaKL1/Cun0/YjTLNzEW
         ZYsOTM8BSi3hXa9rv+T1krAELjyLWR7ACt+q3J4CuevaW/i+GrFag2Ugfa9hl/VvH9sm
         Ie+Q/gN9WZDmRn153QREL6rh5q1HShfuuoOO+R+eJd98d8UktJrfHY4ecl88NNNndHoE
         geJA==
X-Forwarded-Encrypted: i=1; AJvYcCVORQq0pPCgZBxiMOl/+7bi9ONYChn3V8Rv+VN94usF0TLg6W7rxeqh+oxJQSmgwb14HKlA66LhK1OmLkl1@vger.kernel.org
X-Gm-Message-State: AOJu0YwNTMJHitFAjZb/gIXdPBvDrkS1eek+U1By9I13fmSW/YezpIPo
	/Zx9L3LLT2fPRZwihW4OXNpyAfxjU+OngyryaTHScYKgYeWtsFpxrZvtsNeBp++aUK1RshMjFFk
	bie5KWJg4t9KWr8wnKgxfh37R4u691i6LlW6EQsr7Qg==
X-Gm-Gg: ATEYQzyhSNP9RqDV9YQRyKKOcWWY7vSFKQ6GDkzzQ6w/0pSPiYPKOv/GsnJ/zDJb4DT
	zbg5iGCkET4S7nWHJzlAM9O3DqBjce+eKTup6NuRcFd+HLMWAqRZts21UCK+bSmKvko/Nm80mMU
	QVvisqbg5yVFlPxu/hOqfuJkPhSJq6ZwyBo6TQZqtD8wRaHomSmmJRxuLpAbob32qq6pvtBjs7U
	F3MH3b8ivq6/BKrMb8S+sFjY/FiTLKVe2uuLkUDohRDPTE7d2C61qjIneZ9FLfMldZT/HfBqI4h
	8U/K/gMPMt2rSWb5xXAyRi1BusS7IGeqQ/2f
X-Received: by 2002:a17:907:9705:b0:b98:13de:a16 with SMTP id
 a640c23a62f3a-b9c67a10a98mr105360466b.39.1775199147467; Thu, 02 Apr 2026
 23:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401205613.2095623-1-max.kellermann@ionos.com> <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
In-Reply-To: <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 3 Apr 2026 08:52:15 +0200
X-Gm-Features: AQROBzAb2FJMqz47kp_fUlVSscz-fuNH21mTcT0GdyVezs8Qc3TsiivUaE4x7DA
Message-ID: <CAKPOu+9FvR-ZdhcQc-+KzVMgobCkrJpzEsJis2ekuz0zwC_qZQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:44=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat.=
com> wrote:
> The Ceph write_begin path calls netfs_write_begin() but does not pass
> IOCB_DONTCACHE through to trigger __folio_set_dropbehind. So,
> folio_test_dropbehind() would never be true on the Ceph write path right =
now.
> Does it make sense?

Yes, see:

> > ---
> > Note: this is an additional feature on top of my Ceph-DONTCACHE patch,
> > see https://lore.kernel.org/ceph-devel/20260401053109.1861724-1-max.kel=
lermann@ionos.com/

The code in this patch is not reachable until my RWF_DONTCACHE patch
is merged as well.

> Are you sure that caching should be always true? All other calls checks t=
hat
> ceph_is_cache_enabled():
>
> bool caching =3D ceph_is_cache_enabled(inode);

This function is only called if caching is enabled.

>
> > +     *len =3D 0;
> > +}
>
>
> The ceph_folio_is_cacheable() and ceph_flush_fscache_write() are out of
> CONFIG_CEPH_FSCACHE. It doesn't look right.

All of the old code is out of CONFIG_CEPH_FSCACHE, too. Does the old
code look right?

> > @@ -1412,11 +1427,14 @@ int ceph_submit_write(struct address_space *map=
ping,
> >       bool caching =3D ceph_is_cache_enabled(inode);
> >       u64 offset;
> >       u64 len;
> > +     u64 cache_offset, cache_len;
>
> Why do you need to introduce the cache_offset and cache_len? We already h=
ave
> offset and len.

These keep track of the region that should be submitted to fscache.
Folios without "dropbehind" need to be excluded from that.

> >  new_request:
> >       offset =3D ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
> >       len =3D ceph_wbc->wsize;
> > +     cache_offset =3D 0;
>
> Is it correct initialization? Frankly speaking, I don't quite follow why =
we need
> such initialization.

Technically, cache_offset does not need to be initialized as long as
cache_len is zero because then its value is never used. Would you feel
more comfortable if I remove the unnecessary initializer? I wasn't
sure which approach would raise fewer eyebrows.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group

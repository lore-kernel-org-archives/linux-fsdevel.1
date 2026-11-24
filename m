Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795483371;
	b=h5UeSkCODPiBA4sEZMOcpaeTCMyRL45K13QG+Ceu/jnThDuJdUkVdfCUoTqd779Vk70O
	 SXLj9gfMamRnrHPn9wuJC6sbA9Ag7+KEkTVSEIIBLrlXZ7dupdIRB/fQJeHsBddoWlvYn
	 UmFBuKjgnBC6Eg7eQCykTAa0rTy/tGk7IVCUzriS+05BrMzJo4YbmBia9oRkz6Cscdv+m
	 8XFvvVRWMi9JQUSwQRyyeG0LnuBuwRhZcxyqsuACuZ3Mgl+v4dLIlQuh9SycFWVNW4X+u
	 ErzedDukZPYiWrSh0/6ThnzsB7JzU+jgxHcTd839hbZdvZe8nSEb3yNb1MOv/j1Z6Fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483371;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=o6hYnBwiFZNCgKvskv9vf2vEJ0wLJBN3T8leiCBivtA=;
	b=zeFE5sNCEF8QvXOBoZerbzkyEQqZ3uxi3RY+uJ1Ku4yuV/J95Kve6Sdk2wXP4yS4nuUY
	 K0xHJXSSuZOh8tF+8rfLJcUEU4SM8u1rxhR4ZPWOtK3tr2VJweOr9axvCuClsbi7+36It
	 ZIwzQXSBuU99vLXGSQpvRxNPkTILBs+M51sHI6Hh6Ta2eTupm4hcZ5RZCXdhfua3uuw7V
	 WJ8LuaQgNd8XpxCO3LJpaHZXEirNj1/HgPaNlHezGI8IDN30a1dlV7Avo8/7fEUW4YA3d
	 8ToUFL1Vw/4/prl9gpnMU0kijhZb9UBew+Rn+CXBhlPBzL8rWkIQEjbwRar81ns8buw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="a1vcX/T0";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=arOIfOgJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EEF606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 01:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62EEF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a1vcX/T0;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=arOIfOgJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795483369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o6hYnBwiFZNCgKvskv9vf2vEJ0wLJBN3T8leiCBivtA=;
	b=a1vcX/T0Sx8c8omryKOGdDu+8gIFpTqRxFI1KfNCOsI135H3WxoKyODw5aLfhIihaNZFOz
	4n6msE3GgXYOKks2h4dEO3A9683qMV+zw9P3jn4itrp63gEE6euzbyXdQgQVZnNEQ4RISY
	YFa9rHPK0ElEUUnALLQwpqcAMG4EucA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-Lyk3UtTNPDaPhri_x8QCRQ-1; Tue, 24 Nov 2026 01:22:47 +0000
X-MC-Unique: Lyk3UtTNPDaPhri_x8QCRQ-1
X-Mimecast-MFC-AGG-ID: Lyk3UtTNPDaPhri_x8QCRQ_1795483367
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b0f1c06332so61622277b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 17:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795483367; cv=none;
        d=google.com; s=arc-20260327;
        b=MjxRozD6BAfplh46ghZdnwu3zQC1pbafepkKgMwihAsKSerVCZ5C4aISPsSIGrb0vX
         aT9Ma13TaOevNlQxvQOrWxHVyShWQrKsA8pEJjSi8jke0CEKLrnOKYU6cnlAha0lLglg
         1TVOzbDvHi5CSXnMCa27+H+1dN+8DkbwEDvDPb6KxMQR8d7VLrpa1y2oBDKUalXeRIZR
         ++To9IYW043mtK0GPQJ6ndNlKwFPC6okevQrQ8kb2YsItoiLH3tKj+RYgm6k6ZwqBfqS
         mzXRjZSpsjFFx2UwO8d4CvGPGksKVnQED4dSNWqVxhFH5n2ojT4PlTHkaN7YKJ4oTLaj
         +PQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o6hYnBwiFZNCgKvskv9vf2vEJ0wLJBN3T8leiCBivtA=;
        fh=IE8z4R9pmOBPuL+uX7KR+P/R0SiSPrnQQRiyiwQOgkc=;
        b=ROdsraNyB3r4WswX5oy1p/4S8hfPm5i/c+XocvMQvJjtFgSH9xoS38I7aOkHzAPrwJ
         US/czCKeGizI/5sjsyEYMh3thXVeSJkVtC49+aGE76RkC1Rc0dSr9yoLcaUEKV5fBKGo
         U8/cE5fz9XuRlqiIuQezhVUPe+8vYZcZi7oh0q8W1BoAWQf/bbyhmIbhxaAbZb/EabMa
         Yo+TA6+wCc8NBb+ZMeyxLHDBwa7rPBDoMm7iNhezjaGuVWQ8K6SgF0M6vTr5pJ2EH6Gs
         VRVjSoly+3jnucUXB5Ep+GSI9wlYsOz4oWc2KrxooooI7v+xO8izcsJqgFB9CjDwSEG7
         czGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795483367; x=1796088167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o6hYnBwiFZNCgKvskv9vf2vEJ0wLJBN3T8leiCBivtA=;
        b=arOIfOgJjatsv80JVEpBvWV2cYjk1DFG529WBeqYVZMGb8G5XKgQX0BxBVyYjO6X89
         XU/iiLqAa6JKHr5+YiHrFFmch4rOngPaojA+UtDibrDQFOJpR6UKfX6wDrp950WQlRze
         RmGbYgjStorRu/XXsv9TV1Kng/eUkxkJiXEtOmxzq/3jG3MksuxpL8XIph4t30fkGtZl
         puDe2bcO90EXdG3rFz/3uyZ3UUqq/tihog9dlpwR3WZRn/KDZPlNZdkSegJf6afWl7Eb
         AsZR2uq1NPJYyaOaHJqtpmJvQ3hEJuKFLFuywQdHZG3XkvT+wvWNbS1vTf1CVSxIV0oQ
         eBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795483367; x=1796088167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6hYnBwiFZNCgKvskv9vf2vEJ0wLJBN3T8leiCBivtA=;
        b=ut+DU2xAenrXwz5J1uUFccDYa8pB6YAdelxN6t4M3ZTkx6WSVufaNUxMTG06YGxvNb
         7f5gHb50H2n9a+FU5Q2yLavjaaY0+i32ZFoHqDLKK3OkuLZJrg4x+FHkLjYC8ybyDMKy
         bUBMr0WYnkKSKwfKYM4TuBLUPOlRSp29RT/Xku2p35J2AUJ2qTTeSlhdumYMNV3mUBVt
         b2LjLsO6RKdyNLfLezuapxy1v+E7yBfJl5Y8qQllbSS4W/OIuxQh7ZdRrFONuLfrqhez
         R+Tc7wym+KR4hFb6J4gITZmcgm2zhORy/uKSh2ImQ4yc4MyhwgtxhfHrJVkKdLLf56aC
         v6Xw==
X-Forwarded-Encrypted: i=1; AL+hErHfcA3z752vG0XK3rBnqwMQuhDxGVJSBlkxm+1ucPwBUAVw5wNrnSUaBeWItKmL0hm9nUheQHd7Em+UYcqw@vger.kernel.org
X-Gm-Message-State: APuU4Z9k0RgBh8RI3bsDwky3f+nzlaCZct7D5Sx+0dN5kf+Gi1v0KQYf
	hEBzR/WVgcWFG0TtXuS/jqB6WWDWKOm54mqvXAmzV2cPmZRTDI/8O47yBbSuNesRizG8qLnWFKU
	Bt0eiSNJX4NrJYAzHMC/Ki3SRvxefL0Xm5xfKldplxiUoC+ViuECsiA/XfOTC8ZImUZ3S3sYkOV
	JQb0X9IEWQTX/O0SP7GSMcUmr+12Cos6eiOMdupuHx1A==
X-Gm-Gg: AZFdTZehSuMqYSspg9c0yyUDTsXWdPdHaRV3VlK/ly5CoZLt0Gnq2thlrGKiNTi1zev
	WzX81YJ/We6OoqtvlLZZt8tY+fHMEWvLkRSvpWloo4VV9oWir8U+gSjTQ9DyJcBCcOLTyh61Ldz
	WivmjWmxzDktm6ndVFoQNZx48/vhUUYm0knBY9Qv9AgS4mgjSTCOK7ZYHsmdI1FFolcbb1rDq+H
	sUdPCOfrAFf5F+93O9jboWdTcOCMioWbZkkQHkQfFdCkg==
X-Received: by 2002:a05:690c:c355:b0:8b5:4cff:d81d with SMTP id 00721157ae682-8b54cffe43bmr14262887b3.52.1795483367022;
        Mon, 23 Nov 2026 17:22:47 -0800 (PST)
X-Received: by 2002:a05:690c:c355:b0:8b5:4cff:d81d with SMTP id
 00721157ae682-8b54cffe43bmr14262807b3.52.1795483366524; Mon, 23 Nov 2026
 17:22:46 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260722151023.1308069-1-agruenba@redhat.com> <20260730-armband-reklamieren-heuchelei-6f67abb088de@brauner>
 <CAHc6FU4719z5crxP-ahSXs2qLachSL9GOiv4kXRZRifNxm-U_A@mail.gmail.com>
 <20260731-rustikal-revidieren-parolen-02b3e749e9cb@brauner> <CAHc6FU7JQsrqf064yzG8_nDovSFwNCd+-cfmJE=_9pQLLYLdXw@mail.gmail.com>
In-Reply-To: <CAHc6FU7JQsrqf064yzG8_nDovSFwNCd+-cfmJE=_9pQLLYLdXw@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 24 Nov 2026 02:22:35 +0100
X-Gm-Features: Aa3M54pK9ZdQ5UCTwrQed5DfOXgeoX3EWqsEowwcQtn42_zjFDDeV5ll4RqCoPo
Message-ID: <CAHc6FU4oKU0ojagHB__b9HTfTnn5_HG1N6MDpFHm=ZWA=Jk=cA@mail.gmail.com>
Subject: Re: [PATCH v2] xattrat: accept empty O_PATH file descriptors
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian,

On Fri, 31 Jul 2026 at 16:14, Andreas Gruenbacher <agruenba@redhat.com> wro=
te:
> On Fri, Jul 31, 2026 at 3:26=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> > On 2026-07-30 22:34 +0200, Andreas Gruenbacher wrote:
> > > On Thu, Jul 30, 2026 at 8:49=E2=80=AFPM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > > On 2026-07-22 17:10 +0200, Andreas Gruenbacher wrote:
> > > > > Christian,
> > > > >
> > > > > here's an updated patch for making the *xattrat() system calls ac=
cept
> > > > > O_PATH file descriptors.
> > > > >
> > > > > Compared to the previous version (see the discussion at [*]), thi=
s
> > > > > version adds a fd_maybe_raw cleanup class that uses either fdget(=
) or
> > > > > fdget_raw() depending on which kinds of file descriptors are acce=
ptable.
> > > > > That's still a but ugly, but all the alternatives I could come up=
 with
> > > > > are much worse.
> > > > >
> > > > > [*] https://lore.kernel.org/linux-fsdevel/20260701191649.175871-1=
-agruenba@redhat.com/
> > > >
> > > > Thank you. How do you feel about?
> > >
> > > I don't think it's an improvement; see below.
> >
> > Do you see other users outside of fs/xattr.c that would use this new fd
> > class. If not it might be useful to just have a local version of this i=
n
> > fs/xattr.c?
>
> I hope nothing else will use fd_maybe_raw, but hiding it in fs/xattr.c
> still doesn't seem like a good idea. Do you insist on having it moved?

this patch from the end of July is still pending. There have been no
changes in this area; the patch still applies cleanly. What are your
thoughts on this?

Thanks,
Andreas


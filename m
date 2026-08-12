Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C70469826
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545611; cv=pass; b=HLFyjNu9v0WhCsMsstx7Evy7AeSzCIzEjpyiQocceeKX3E6TRKn4flX2L5y6CAhctmF1FJ3Y9PgXsY77/6aWr0dN69786rPC0QKEt1erjxoAMIzGZodaNoQ+YRCeDbosnc3fxVHgs1RfZfCGdjeygpxfRtMkNBwvnoSfDv0JcUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545611; c=relaxed/simple;
	bh=8CdK4aAIC7mcIHPIYzvtW/2HqSiJbn5alOoec8aFw74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cP3Xe3GYNq/BDhWDNYeAWaDckO2BVKczQGjw8bDDg9RDL/uy0VNRFj5LvAW04LUYIRYhsn8qy3D023h8hEE0U9Kgul7zfHV7CnPu3497JYBzSdS5QMxRc6nvwZIwKhNqusc4N1+hVzULOHqw5JAXsd0HCwAES8OhB/Ldoruetjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBYHQp0N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBRQ10tI; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBYHQp0N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBRQ10tI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786545606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgQEXPTBEOAjmNXcUxzWeiUVVEpt0TAGVQPJcagJWa4=;
	b=CBYHQp0NL36OpMxsWv3TPRSwLqDtX/nX/y9bSec8slG1Xqfn4NXkNhnRPbwlduMtFl07h4
	aRDKpj+MqWgPaMUbJ0ZteVPIa4B7ecLXSuYhVs5qZrlsB2dhjReZVvHngIoK0Ei7Ybg0yw
	//2KBCNON19CgAdcSt1YajePhsCK6x8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-ohf5qmNnOAKRF2R0z7eA5Q-1; Wed, 12 Aug 2026 10:40:04 -0400
X-MC-Unique: ohf5qmNnOAKRF2R0z7eA5Q-1
X-Mimecast-MFC-AGG-ID: ohf5qmNnOAKRF2R0z7eA5Q_1786545604
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15e555a164so112024666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 07:40:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786545603; cv=none;
        d=google.com; s=arc-20260327;
        b=o6O8yT2F250/SnZdy1hUpcKV+2gDqiPcvIk/o1daMGSDE0OUgHylAeREDcPUfoImU2
         CVSo96RrXsZk638vQBDZkAC2tx1d6YCBpv1FBPIDaexyNUcD5g/seJN3FzHh71SS7jdQ
         r3TimnAt/1uiQ2OXkijskJ5NlzYY2qqCjS8NIAieOy/YWM6f0B7m/NTq/CQSR3eLifPO
         appD5wbkPZ3JVArcm4Cg+de4Q+4ytWzTpSdpc4FHp02BGAMYgCZ3A0/9xo9r8lDPG6lq
         3QrTUOsoPZJeY+W+SDpoheOAspFidzFTClcBBFM+mR5d85fATOl0WjgWAzwGzluecpgr
         JA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VgQEXPTBEOAjmNXcUxzWeiUVVEpt0TAGVQPJcagJWa4=;
        fh=gUyHxarFRCXTLW21h8MP6azXtkcpR7tIsyup73bf3oA=;
        b=jqkdDCXmnwGvirBoXkTEfzJXAFslep/QQD3nP5B8UbVou0hwOND/vEaQS30VTkC5a9
         EbJGYHga6A7/ODFGwH7M8x5as1D8CBlt8le4v3l0EIojU8230/84JWTUrSHlmvxWDqRM
         MwvxNqtOPih3XzKn1HFBVBT3a0bW6zBvBNAiy6WB7o57jwrJHfxbTXHp2pgR/FL1ngib
         8D1rQbKRDrANZkXveLR4b4I22B5+Ujd1mnOf2C0zKBofKv36BZTYOu5vzutiaB7Tz4/z
         aTF9+25i/yVaw4tGE04BR+MqUXWgdhv9fbddWoIuIQpOWGbXmtXcmlBPE9I4mV8VytFy
         vO3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786545603; x=1787150403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VgQEXPTBEOAjmNXcUxzWeiUVVEpt0TAGVQPJcagJWa4=;
        b=fBRQ10tIVZMko4X5ZvGuDC8WUweqVpiG2dMjPeKL+kf3KNrrgVYtePEjf+MYokp2W+
         K1gFTAyJUMLiQm1XZSB/rSCQ7lTqwKHbEWoUEgX83yk+pz5FHEm0qBhdLr18d7t1sHPn
         nFTAYSvF8YSlikHy1EL/9wL0v0XYHyLRfRhyWfYkZgIJw5jMLNVAky5nxvc5IXZLEuf3
         YIX4oWNBkNLEIu3ZyGk4onYc6Xs++n1OZSXhfWD/FBCYt7hBzYU/u7IqVHC+ZWNm1D78
         EFlImDGslFBtydidCfhiVvt8Hj40dH5NPy8jVpV/d+ogkd5/CO5pqzizcWEwq9J9AvS0
         /3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786545603; x=1787150403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VgQEXPTBEOAjmNXcUxzWeiUVVEpt0TAGVQPJcagJWa4=;
        b=Fs73gQfOyoYD2sQEG3kBbv/bG1J/CGoAFBMcSRc7MXkO3oXLqmGbWIrAMIexFRQAu2
         auEiaQLRUY0uyWU1yMzDD+h3MGVb8c4oIuzyut4uUfaevsCFqp9E8eQ2VeiWIcXTmHzK
         IYEF+9I44qi6gQQvnsaxmMJGYC9IwmroVV8t2asR5mY1d9yf3o5yAnSZxe4s1UhwHlFs
         68pTS9NdmZRGpAjfsCQ8VIdsaeTbVV7hpeOKtNgCbgEvZVXwcKg2Wbbmf+b5gNNgB9s3
         GrV8OlqNsBLruybEAYbEl+I48nIJ/3eIdafZ378V1V62Rbk28hrq2s4nhKQ/MpgRGjxn
         4XpA==
X-Forwarded-Encrypted: i=1; AHgh+RqxZEa6Iu8aqtZO+FbDVw2JmcHNkjltoCTmZlnYNQTKhj9e7U6+UAWdEqeQ4Nsoa7vK5OInDt1uGkf2Fga7@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQ+QQcVE2eyJ933SROEipwIIn0sPfjT9+pXAFWFqdxP4Qy1wZ
	2D4RbltsSRPj4FENQDmEEo4wJ7zTn8XTEGC2UnyCZ6YK8nDp5myyeQyh7oGgrwQ+o8kaMO34GbP
	ygQxFRS97XlK6JQ43QKQR7M59atI91GCnn3ATmTTlbPWNVBD1mvMeKhIVdGH67us1A+6B87pzLv
	jbhKmMdiFTqXm4MDNYtgp13SQE+iH8dnD6rfHo5ATsyu8Q4FBPhA==
X-Gm-Gg: AR+sD130CacOMc5HR+PAMXgcqIAlJOcmS8AETMwfZGP6hLEIg12+rqwtl8Ab/Yjj62t
	CSSbnqqTFZKZLfm7tPDSs2HENBylRgLtHjOo5pdtYsNkvvZlGBidd2p9ylojlE9AChqYX3brlzo
	qazCl6VfjOsDC0qY0NWe/0kZYeuJXwnAEV6KY5qw4CzkX1wN5SPwYEw6u3vB1UL0qRf3BTuYkqd
	+ZT8Rh+EFCMVZm0BHKDAIiMuNx4/pyzbUF0/GBpt6yePufIgheIW82ZZ8HJGHXgL0WGdomUXELZ
	Ago=
X-Received: by 2002:a17:907:d307:b0:c20:a243:9a52 with SMTP id a640c23a62f3a-c20f4ea80fcmr88400766b.0.1786545603508;
        Wed, 12 Aug 2026 07:40:03 -0700 (PDT)
X-Received: by 2002:a17:907:d307:b0:c20:a243:9a52 with SMTP id
 a640c23a62f3a-c20f4ea80fcmr88398566b.0.1786545603149; Wed, 12 Aug 2026
 07:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713170035.4073532-1-rrobaina@redhat.com> <CAHC9VhTR-qaU-WFiuWZLfxhNisTtKXahLMHrH7-Ts5o09VMYcw@mail.gmail.com>
In-Reply-To: <CAHC9VhTR-qaU-WFiuWZLfxhNisTtKXahLMHrH7-Ts5o09VMYcw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 12 Aug 2026 11:39:52 -0300
X-Gm-Features: AUfX_mwnybZDq79vyvt9hciCVBXIFAsKZAAqavu-6vxhVBt7hiB0e3ibAcyYOVw
Message-ID: <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com>
Subject: Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 6:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Jul 13, 2026 at 1:00=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> >
> > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> > syscall. The generic SYSCALL audit record logs the move_mount syscall
> > but does not capture the flags argument, creating an audit gap for
> > mount relocation operations.
> >
> > Add a MOVE_MOUNT auxiliary record that logs the flags argument passed
> > to move_mount(2). Pathnames and file descriptors are captured through
> > existing PATH records and SYSCALL record arguments.
> >
> >  ----
> >  type=3DPATH : item=3D0 name=3D/mnt/test_src inode=3D1 dev=3D00:41 ...
> >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> >  ----
> >  type=3DPATH : item=3D0 name=3D/mnt/test_dst inode=3D27460862 dev=3Dfc:=
00 ...
> >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  fs/namespace.c             |  3 +++
> >  include/linux/audit.h      | 10 ++++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/auditsc.c           | 13 +++++++++++++
> >  4 files changed, 27 insertions(+)
>

Thanks for reviewing this patch, Paul!

> This is because we only log the first four syscall parameters,
> correct?  To put this another way, if we logged all six syscall
> parameters this wouldn't be an issue, yes?

Yes, that's correct.

>
> I'm aware of the argument for only logging the first four parameters,
> but I've always thought it was a rather foolish decision.  Perhaps now
> is the time to spend to investigate adding those two missing
> parameters to the SYSCALL record so we don't have to worry about hacky
> workarounds like this (to be clear, I know this hacky workaround isn't
> your fault, you are just trying to make the best of a kludgy thing
> <g>).

I completely agree that's the right thing to do, and I'm happy to hear
that you'd be open to it.

I did a quick check and there are 100+ syscalls (~18% of the total)
with more than 4 arguments
 --around 67 of which pass audit-relevant scalars (flags, sizes,
modes) in the 5th or 6th position
that are currently lost.

I'll look into it. Please disregard this patch in the meantime.

>
> --
> paul-moore.com
>

-Ricardo


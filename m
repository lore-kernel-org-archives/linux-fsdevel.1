Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A03391E73
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880237; cv=none; b=WNZLLAdGO/582z4HzgX42QgXokbA6HHKZ6OWJ78RFBqbDuyta3C6+gkCfgkAWqvjYx6SBF9Z+VPcrH+2WOT7c0BqQh6E+VYADyO1t+iJJZP/iMOpCV9rsDnM9h/3BewfUMwjlLntbODfRqYXEkka0PzFL3J4MM32PB14y51MoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880237; c=relaxed/simple;
	bh=lCyAC0yS9GiNkxM4xhTPe9MOXTbsSITF477E6iLwGT0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWqYeNaihjubRrltsQIGugDu8V94xnoCE4EsXFMAHGlTw7K/LWl0D2qNkEKXZqwix9Xz/pLz5YihjQ4jYVzshi98jkNP+liOnuakmn1mKJ+mTh3h81pDoX6Tt2URW2zIhFy84l5AwKja4hleNFYAvbNzDfYgADjj71DO0tzUso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcxgFRsF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8jgYfkd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcxgFRsF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8jgYfkd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776880232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddF8/CPZBhhCoTMyfiMfDm8uotx7s8IuCAqy/kTZDwA=;
	b=KcxgFRsF8FCiG/nHXTnNL0d1Q3pDgCvGk6TFbshVhQc+GmDmjFOWyU/ddPiuoZC4qeJxnk
	i8oMOQ2ff3U9jdF0jfYIWbN598QxlZ0Z6IP+nc+BJVEAzfn0ntHYbHY805DH+wiKIuAU8g
	2ucVGdTkrjji5uhj3tr3WrsfvI9dLaM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479--PWiFU4gPwaXpsBTxTA3fQ-1; Wed, 22 Apr 2026 13:50:29 -0400
X-MC-Unique: -PWiFU4gPwaXpsBTxTA3fQ-1
X-Mimecast-MFC-AGG-ID: -PWiFU4gPwaXpsBTxTA3fQ_1776880228
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4718a1723a5so8236993b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 10:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776880228; x=1777485028; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ddF8/CPZBhhCoTMyfiMfDm8uotx7s8IuCAqy/kTZDwA=;
        b=K8jgYfkdCMAJ2ZwfiK7zyKEsPNkj04LDaZnY/Qvmq/vjbo2emfXydf4WIIqVB4ok3y
         +5SOjCLaPFTolNlYGLtYyCufUK0qqW/3p2b4vRVjPNslaDOfMnfPxtep9givwD4bDdI4
         KDedTnO2G4e5u4UdD0Jv3wNOxw63HI+Z+wlW3weosVSEweQ2y6XYlsY+hCLjRfPVYYr8
         3qC1oqkCW2hpVdmxnb2QHSPgdJWZgSuDrP0ff6Z2fbTjYmNJe7CcB/KBCb6n/GS7SJtR
         +PaEdAS6kDUU24mj7+qwSgzkImfs4Q6I6Rl2DY7Ter+2dfb8BoMtsJYKNBViVFRb+z9u
         VrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776880228; x=1777485028;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddF8/CPZBhhCoTMyfiMfDm8uotx7s8IuCAqy/kTZDwA=;
        b=mUekIKWZAF3HRKZYysSpyv4yhDtGO1zEShWO5fTRngLyDpQ7Z5AekH5EtwTTc1y8MS
         F3df8jF6Oui6rnefam01NcVfsrKWQe6UXjBUYJc5KEeNb79pd9LNoMGRW2B/UTjGVTCi
         dFfGLlfM8r0b8jFgVBR/+kGp6QD5RA6GUVzPcbFmsmcLnRcvwzXgIE8zfk6dpJqCoUGT
         SXDOgkZvVcrVFF8hj52reki1Ldl0LqzIw9eZrPyfUVnFF3MgCxh2TiKtg1FlcEflVyfB
         A/nsUjFt4/iIW5f44pc1BDZ/750kS4j4mJYTPPJ9i8/6lMK/suMwFB7EZgir8eFi+O+6
         D55g==
X-Forwarded-Encrypted: i=1; AFNElJ8Gqyv68WhYQQLz6K/HJ80h4ak6oJ+5ECmNQTSN927t94meeh4oW6j1bHART91Eqj9r+Bvu9N1CsVkoYMi3@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNtSJJocMYOLHlPEDD15sFZWb69mzhfZL2/Edu/6lxm5wqFQY
	HnKVgiUsCoNeEyymV+JeJZGgotXCji2HYGisWWMiQeiID8TQFGeaAOGeAFttnb8K1PqP+D6MeK2
	gLshJKpDjZfk3tzmx6WNUg1c3Ft5kIUfsjkEWst2qp3kbZ7kUprtdL5sQQ9ZwgVU1gY4=
X-Gm-Gg: AeBDiev9ehIOYzvfd1Au998LxKRizTiuW/Bk/UbubH5wlC4BXPMKL3BC2r6qzvHhQWN
	lk/M9mVj5gAsnQAUhc1Lw2c/TOEKiMHeGphtxpOGijvqaqJXqcYKa8qcn7/SjB1kugPE2P3GWwF
	LDEIqntpq2dulHuKqhlQdWbrQJ3VdPwhzc0pl2v4i78Gina2FTx0Pw6HIC3egpQ3zuo469Brm6s
	GXtBAnr5RJACl+9u5LxambAu5/2urVkvB4bQlc+rhsR81Aa3esh+yLwAzvn7db0Ic7/tUfS8rEE
	a1PN1fQK2LPmb85Dc1/BLRkZr4JYUm43Dn6n0HBC3KivNQ13R7vFxmsfuUe1YicVqUXuzmacZ4j
	WY2/gtLG4jGhsuPG6cvvccZzOeaxNxLhhiObQ7Nr0sTPjiQPTnpcJLUH0T826aXc=
X-Received: by 2002:a05:6808:4481:b0:479:f83e:bdb5 with SMTP id 5614622812f47-479f83ec62fmr3836369b6e.14.1776880228225;
        Wed, 22 Apr 2026 10:50:28 -0700 (PDT)
X-Received: by 2002:a05:6808:4481:b0:479:f83e:bdb5 with SMTP id 5614622812f47-479f83ec62fmr3836345b6e.14.1776880227731;
        Wed, 22 Apr 2026 10:50:27 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479fb5d5d9csm2592063b6e.13.2026.04.22.10.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:50:27 -0700 (PDT)
Message-ID: <cf579d8c61215bb32fe6f641c06ab6631a0e5a22.camel@redhat.com>
Subject: Re: [PATCH v3] hfsplus: fix null-ptr-deref in
 hfsplus_cat_write_inode
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Date: Wed, 22 Apr 2026 10:50:25 -0700
In-Reply-To: <CADhLXY7iAzy98LVpRuO92asNqyw6B7iCAt31-U0iy2G1+qLMDQ@mail.gmail.com>
References: <20260415014345.77796-1-kartikey406@gmail.com>
	 <1929bc40bee602937aac95a3d338614b5fe7e082.camel@redhat.com>
	 <CADhLXY7iAzy98LVpRuO92asNqyw6B7iCAt31-U0iy2G1+qLMDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-21 at 07:14 +0530, Deepanshu Kartikey wrote:
> On Thu, Apr 16, 2026 at 3:18=E2=80=AFAM Viacheslav Dubeyko <vdubeyko@redh=
at.com> wrote:
> >=20
> > As far as I can see, we have such logic in hfsplus_fill_super() [1]:
> >=20
> > if (!sb_rdonly(sb)) {
> > <skipped>
> >     if (!sbi->hidden_dir) {
> >         <create hidden dir>
> >     }
> > <skipped>
> > }
> >=20
> > So, I have two questions:
> > (1) If we mounted volume in READ-ONLY mode initially and we re-mount it=
 into
> > READ-WRITE mode, then we skip hidden directory creation. Should we proc=
ess this
> > in hfsplus_reconfigure()?
> > (2) Should we create hidden directory if corrupted volume hasn't hidden
> > directory?
> >=20
> > If we don't create the hidden dir, then we could have troubles in multi=
ple
> > places: hfsplus_rename_cat() [2,3], hfsplus_delete_cat() [4,5]. It look=
s like
> > that we need to create the hidden dir. Otherwise, we could trigger the =
kernel
> > crash in multiple places.
> >=20
> > Thanks,
> > Slava.
> >=20
> > [1] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/super.c#L58=
9
> > [2] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/dir.c#L326
> > [3] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/dir.c#L397
> > [4] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/dir.c#L418
> > [5] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/inode.c#L25=
7
> >=20
>=20
> Hi Vyacheslav,
>=20
> Thank you for the detailed feedback and for pointing out the deeper
> design issue.
>=20
> You are absolutely right on both counts.
>=20
> (1) hfsplus_reconfigure() does not create the hidden directory when
> remounting from read-only to read-write. This means sbi->hidden_dir
> can be NULL on a writable mount even if the volume is otherwise
> healthy. This needs to be fixed in hfsplus_reconfigure().
>=20
> (2) The correct approach is not to add NULL checks at individual
> call sites =E2=80=94 that is a band-aid. The real fix is to ensure
> sbi->hidden_dir is always valid on any read-write mount, enforcing
> this invariant at mount and remount time.
>=20
> My plan for v4:
> - Extract the hidden directory creation logic from hfsplus_fill_super()
>   into a helper function hfsplus_create_hidden_dir().
> - Call it from hfsplus_fill_super() as before.
> - Also call it from hfsplus_reconfigure() when switching from
>   read-only to read-write and hidden_dir is NULL.
>=20
> This way hidden_dir is guaranteed valid for all write operations
> and the individual call sites in dir.c and inode.c are safe
> without needing NULL guards.
>=20

Makes sense.

> I will send v4 shortly.
>=20
>=20

Sounds good.

Thanks,
Slava.


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457A36C59E
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059543; cv=none; b=QtMpIyTlr5WtfglqJtpKDuIyKmNGdDo41ykQwgJywTseXUFVwVRYl1FakpX6w9Vx3mcCYUXZoCeeoAAIRZP/xqDFrCuUDEvB0uUZIm48VbBWfGZCs5ZvLdQGP5Ljxq+2Sx/aH/sBkTw96s1BgWXgCL7x6vmDnMDwJVEuSNhWSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059543; c=relaxed/simple;
	bh=lPqFX0Yy0XAE/Rw/BAATs7v0SQyiUopmPVCSq+WVYWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qKmaKgfncZ4WgigWeSqtGG21960XNSX4e3M5MXNzkbr8uYg+as0eUQ4NFtKE0gAsmozrjLlfszk9JUEeU0e9NUR+cfRsF3yzNHYTkxPd0O5nziztPbubzJsTDyk0ib3fxcSGXE55xBHXkr0uxwZ3073M9HuwRogH4mCPoQJwfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WsXb92nE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qEPdFLqk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsXb92nE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qEPdFLqk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777059539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7VaufB6w1dJvFuFr1EOIEp5Ep8hIo8a4pkkuPUO7RM=;
	b=WsXb92nEOJ9HkExeul423+sDA7os96dgPrkCXQmxveCuJb+wmOxRiD93otNnevNdHdLgCh
	dkBIYKELH5EYvDn8NYeO+VxkbbtNsTtiGxzDelYIAXX72ctbkvteghblFjV96DXY3QydUq
	CAhs06hS82sAwy/kAka5tJjX1E5QKbk=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-urfK3O_cOuysJuljbLXpUw-1; Fri, 24 Apr 2026 15:38:57 -0400
X-MC-Unique: urfK3O_cOuysJuljbLXpUw-1
X-Mimecast-MFC-AGG-ID: urfK3O_cOuysJuljbLXpUw_1777059537
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-47bd318565dso1368135b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777059537; x=1777664337; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G7VaufB6w1dJvFuFr1EOIEp5Ep8hIo8a4pkkuPUO7RM=;
        b=qEPdFLqkQKnMCygqdPDxs0pjT5dW8R7Vka6thdHdveudGlN4UzQY9rEHbhy/Qo6f1S
         eW0FFClkUi2Vh01mrLMTOT6eEdP82seWaxfpjf9+jzobIE4hktIA/KKSeX7PWm0TBpRO
         jIaUiuSaAK3TYaLF5gGxdMGkp6H/lKOY6aU1rvKwimaQlWExj96/4hi5aX0Yl28smVVG
         DRZeH6KqQNkt5DVREpL6xbX7yl2iGjO/+uHqVBE4Bsn7zvZfqWfhItbJsPQnr/eIc5OR
         CRMCfKPGFsScH7tcygq33zsa53GWDg+C+WV8KtT1pseXztBAxnQ7oyUKjAjw8lWRkDMy
         niwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777059537; x=1777664337;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7VaufB6w1dJvFuFr1EOIEp5Ep8hIo8a4pkkuPUO7RM=;
        b=goS0T9+ZyfVrRCixbOiqGkujRocUkQJopbcF83zm3E+UgeKSRlk4SmzUBVE9rEDp65
         erIMcCyxQff6/gSqtdyDPIiop/qYBI0mC+NEz3h8xUcusIt5ZXdFCBnsmq0o/MBM8V1b
         0djAXbuMfHhBdrpxuc2CXyyyaMt7eRYWFJo7b1LwT1F6p040wAL9Se4ERFi9oVax5/Mg
         BLI/3bGeLvamlknMoLjsIASzZyOLjYkLDWv+5V6sHmYad3g6UWu3Uhk9qUsLC14ZnOYx
         F9oJeERDRYmtM/6MlA/8sCfIpz3Y1dSL4ux1nR0HgRlMxGyWcyT/XfXQFwVUk0MCBFhi
         YOJg==
X-Gm-Message-State: AOJu0Ywqoq3q+AH4YubkKkvP2JL/ijqD5DksT/LK7wDjj3DLOTqxEFA3
	HNWONmxJvF8OHUNT76IlRg/04H5ey2EY5GK8dIUD73Nlpb858us8T0JJ9hrYPK1qTDGkNDN1JEd
	ugUoHZ2fQwi6oPhbmyEbOKV3HDrZ5ktFnIt0ZWGrwpQBqXCWYClgS5bbdWCPKthBJUBw=
X-Gm-Gg: AeBDietXdqA6TEKFEVKo/qCnanHSeR3+UW856aLLbGfb1ZmS0zfdTC+ZfL2tT05PgUl
	78cWPeRubJhBFcqWy//LH4fRe8TCi6epnJXLI9yYDmoWua0UnxSt0gucgmXwAfgLnPNpSOVRjVQ
	ZZNJecIv/dtWZKqTA9wLu5V8ugmCsiWimLJLIr+qyrI8EJQQjT+mfqUYRtc2anTFlxQJEfp93v7
	YSac7rk3rBzevL/3URkak/7t3Se6r13IKOeAJzQMYPttD6GAIhArs1EWhFMmNgXgqfaH5AmKYXE
	i5+HYOc4qabdoKU8aZDDehoYSBNH07p92NzRJeiUMeTApC5F5UEUzUPjgzOWsCCoR8VgIOC7sb0
	31oVwjRLZO7cgCB1sH4jbfqCsI+A2xNY2Jlhv0o+6VgmP0HhvLA4T3K1HwjFYxoQ=
X-Received: by 2002:a05:6808:2e43:b0:479:f0a2:d23c with SMTP id 5614622812f47-479f0a2e5e2mr10848520b6e.27.1777059537138;
        Fri, 24 Apr 2026 12:38:57 -0700 (PDT)
X-Received: by 2002:a05:6808:2e43:b0:479:f0a2:d23c with SMTP id 5614622812f47-479f0a2e5e2mr10848501b6e.27.1777059536668;
        Fri, 24 Apr 2026 12:38:56 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a02097b6sm16156094b6e.14.2026.04.24.12.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:38:56 -0700 (PDT)
Message-ID: <a4d47cc47de0b887202fd73cb93bc02bff4095c8.camel@redhat.com>
Subject: Re: [PATCH] hfsplus: replace unbounded sprintf() in
 hfsplus_{lookup,link,unlink}
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Viacheslav Dubeyko	
 <slava@dubeyko.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 24 Apr 2026 12:38:54 -0700
In-Reply-To: <20260424090633.307300-3-thorsten.blum@linux.dev>
References: <20260424090633.307300-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 11:06 +0200, Thorsten Blum wrote:
> While the current code works correctly, replace unbounded sprintf()
> calls with the safer scnprintf() in hfsplus_lookup(), hfsplus_link(),
> and hfsplus_unlink() to follow secure coding best practices.

The patch makes sense. But I would like to request some refactoring work he=
re.
:)

>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/hfsplus/dir.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index 47194370c2c5..ff976995ef58 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -98,7 +98,7 @@ static struct dentry *hfsplus_lookup(struct inode *dir,=
 struct dentry *dentry,
>  				dentry->d_fsdata =3D (void *)(unsigned long)cnid;
>  				linkid =3D
>  					be32_to_cpu(entry.file.permissions.dev);
> -				str.len =3D sprintf(name, "iNode%d", linkid);
> +				str.len =3D scnprintf(name, sizeof(name), "iNode%d", linkid);
>  				str.name =3D name;
>  				err =3D hfsplus_cat_build_key(sb, fd.search_key,
>  					HFSPLUS_SB(sb)->hidden_dir->i_ino,

This piece of code looks like a static inline function. Could we rework thi=
s
piece of code?

char name[32];

This declaration looks not very well. I think we need to introduce some nam=
ed
constant for hardcoded 32 value. Could you please rework it?

> @@ -322,7 +322,7 @@ static int hfsplus_link(struct dentry *src_dentry, st=
ruct inode *dst_dir,
>  			get_random_bytes(&id, sizeof(cnid));
>  			id &=3D 0x3fffffff;
>  			str.name =3D name;
> -			str.len =3D sprintf(name, "iNode%d", id);
> +			str.len =3D scnprintf(name, sizeof(name), "iNode%d", id);
>  			res =3D hfsplus_rename_cat(inode->i_ino,
>  						 src_dir, &src_dentry->d_name,
>  						 sbi->hidden_dir, &str);

The same issue with name declaration here:

char name[32];

Also, I think it makes sense to initialize the local variables:

char name[32] =3D {0};

Maybe it makes sense to introduce some small function that execute this:

str.len =3D sprintf(name, "iNode%d", linkid);
str.name =3D name;

Something like this:

str =3D hfsplus_qstr_init(<arguments>);

What do you think?

> @@ -393,7 +393,7 @@ static int hfsplus_unlink(struct inode *dir, struct d=
entry *dentry)
>  	if (inode->i_ino =3D=3D cnid &&
>  	    atomic_read(&HFSPLUS_I(inode)->opencnt)) {
>  		str.name =3D name;
> -		str.len =3D sprintf(name, "temp%llu", inode->i_ino);
> +		str.len =3D scnprintf(name, sizeof(name), "temp%llu", inode->i_ino);
>  		res =3D hfsplus_rename_cat(inode->i_ino,
>  					 dir, &dentry->d_name,
>  					 sbi->hidden_dir, &str);

The same issues here too.

Thanks,
Slava.

[1] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/dir.c#L87


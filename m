Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09561156F45
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776735882; cv=pass; b=ceS6KVoIbcnDyc5vz2wUILgszcAuJF5H54DLPuJFZHYfEek9me1zaS4NkF0n+6JEIB0UwtAJ8cqn763ag654DrEEG5Kwkr7gG57bJA4vbI9+jfxzeGWvNNm7UqHXh80MB03RFjwSWB+F94YEuK+8ks3bTdfEK0SH4T0GFMLmSA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776735882; c=relaxed/simple;
	bh=LSO/W9B/fiVpT/IpbxZJw6EyJvPkcQ3Jvl14tcN3xgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uA/TA54V8C3keshSRbnfhlVZkxSuFcgdP9vNX+jfWklx2Uuv0iAGTlq/mHAUcIy7CDzBtVwDNuS6vd+eFytljPJklnUlsIJLroFROGy2BzZZ6R7LtKYgBE59g6R2uzBcKspwWcXPdKVpp+yEWPJZeC7o6t1/i8xAmfeXHQA5Zhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJHWM+K0; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJHWM+K0"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-794719afcd4so38717947b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 18:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776735880; cv=none;
        d=google.com; s=arc-20240605;
        b=FJWsYPLVLh60hc7k2sAvizAJ6j+OTK+pGSDIiuAG6ZrmQZggPHrt2UvtaVlHTQFp9a
         EOwOqKE3nR8Twlu29M3CFz+jul6dJ2QCm18bxy/+JcKdXJ5eyNP8l/UrjDy8l2KsPDp2
         +CcS6orsr1iYvkC1ZkCEYiCmvhezSexAArT1E6tkLLGTCtWrUMvVh0/rG4eF3vG/wgJU
         VVGF5vshr8H7EXztiTOxBC1eDldUt3oxuF35QwqIZU7sTZmfqNVbysFfS3HUD5hkeAmV
         A/SF3kj4srbROVZsS2MgND+KKjJ67sVUvXVVtSQvAeCnJVlikgnlKOudD5LU0G2QQblV
         /Otw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8hkIDXWOhgGvNZ6tIHX64E5jT0I9qdQrs/3aIYXMtoA=;
        fh=GKQGhKXzfoWqSyvyNaGxobw38i6fkJDckNY3OIlYBg0=;
        b=LC2ft/57s9ydATQaNO6xkAzFl/Ya2GAJfDE0GBK5gn2mId0PrLJtUtKRNMF/y6AQej
         SI6zoEv0yk0tqR3oEpdUlgC4APljqjias3S0bFXcaOH7nRfDrdKpULZh9Yke57gJduSr
         VJrEuO0A94C3vwWViZnZLtqIphlRlEEiZUsNquPsVlY+VlVXYmqmKO+ugZ9CTxOTJgTP
         vTa0jGz6j0kws3eoQZ6MYEhl8I38tgzebYZTfhrjsYx6pSaHVs6C0KF18mI2bkbCaUNO
         MQk0ZnPGh6qos8NXWJHAd21XTwWx5lKQ/quDX0F+KScn07z7gbZPjIAoNWx9kH2/K62w
         V25w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776735880; x=1777340680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hkIDXWOhgGvNZ6tIHX64E5jT0I9qdQrs/3aIYXMtoA=;
        b=TJHWM+K0ASGhu/aVpyylnYlWkZtii6QCf1RhnfyqZpTPzDDHxEV1xuuG2W3U2Mw5gZ
         xVuWislINU7QAk0AC1fXI1p6cVyHQPDJJMt8yVK9UDgLhkrShB/vAEBciROt4YaddJu2
         kgklAkL2bKoDfueD5JySoStBJVGz8V/8ib2ON2OSHOUCQadI1Hgvg9MOMFYmaanOwFP5
         C0PUdHJ6jFmaN1krCOwwmJdV5i2HsAbi5lH0XPXlpEyRv46uOOFMcAxqSLRM5w8t71Lh
         ObnMxx6knHFFGYpsIT4n9NrqogkgqgRHlJFb9ZkkY51C2c96Jvt27Am8wU+KeUdhoFnp
         X0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776735880; x=1777340680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8hkIDXWOhgGvNZ6tIHX64E5jT0I9qdQrs/3aIYXMtoA=;
        b=pRRXw+27uC7mHCAtuztd1iuOQRMAWTKGRCODyUY9rLs1PsUQISYGwchKZQJuTXTDTz
         cHLQsJ9AyBGmzWBc/5h9cbKyN9JK4+rZ1eAGcEak1Qs7Qsj6bwkkFdBodG47UIwG3yw3
         pXsKkZ3vAJKcM7DupmBqySrCTre0qDcLrBCrfhK1qa7e2qdghzBnzioogdv3iFBqme/E
         o/G/PtTod+4eDpMfockS9xzlJUK1D2iDA1vT1hdSTLSDEadI0n0+Wo/axJHPC/7F5naP
         wQBNCI0If+DZPwybui8UeMa3kuNYNbxUMHpvy8KX7iSquu+M35vjCVJ/uAGNmGAWql7b
         Gypw==
X-Forwarded-Encrypted: i=1; AFNElJ+/Iw8d+bl1ZbL5iThho5b19XR+AA6z7337Ah9KDM20FcJWbJ4Nwai9mbcvGL3gC/hBSfSJwY/pPN/+aDF5@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ84OPmVuDORO1yn91/o7xcvv3HeaY7sp3e6llvaLkf39B7PpI
	MvFQkq3pCONiFhjlfR7nk2cilf5Axh6SMku8yvDOFgUCasZKCaq7GwoXdSS2ibYiFCgiS89d9Zh
	3nXgOZao+WPwgKEoo/Ls+YnD8gEeMv8E=
X-Gm-Gg: AeBDiesrNqaC+Hd5G98ySuo9yZnz+ApQwdUZz1f/G27Y5CauflPncSLcJjV2EjUX9vF
	JzQAARkBAdwfd3dfFVgQ7WsponX8h9ooPjmj3vr8obr9GDB4Me2hxGXoqLybwzNkUKvqxBqOpa5
	zVUfRrL/RbIoAKaqxpXJmyqzTrZx0v59SZ2Z6d9rag7++YRxwSKLpFqC/up+XFo/WeJLvLNKD5w
	Vtw++vZxgH0BJoWLV2rjJNmruasw5FYKjIdFZcjh7P9qsYygBqnOiC3otA8dxmQhITC46xM9lZl
	ZfQwm2yu7+OqAk08ovy4MgH205I2UguPk1i3ckY3QBistfz/F8SO/O7oILis19igycREkVUcl55
	BkOsH
X-Received: by 2002:a05:690c:6d81:b0:7ba:f414:cd18 with SMTP id
 00721157ae682-7baf414d18cmr52660297b3.41.1776735879937; Mon, 20 Apr 2026
 18:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415014345.77796-1-kartikey406@gmail.com> <1929bc40bee602937aac95a3d338614b5fe7e082.camel@redhat.com>
In-Reply-To: <1929bc40bee602937aac95a3d338614b5fe7e082.camel@redhat.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 21 Apr 2026 07:14:22 +0530
X-Gm-Features: AQROBzCya7j51EmP5yuZ8W6ofb8ECUBaCAhELmu_L169vi2MmF38YzB5vcZyRHM
Message-ID: <CADhLXY7iAzy98LVpRuO92asNqyw6B7iCAt31-U0iy2G1+qLMDQ@mail.gmail.com>
Subject: Re: [PATCH v3] hfsplus: fix null-ptr-deref in hfsplus_cat_write_inode
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 3:18=E2=80=AFAM Viacheslav Dubeyko <vdubeyko@redhat=
.com> wrote:
>
> As far as I can see, we have such logic in hfsplus_fill_super() [1]:
>
> if (!sb_rdonly(sb)) {
> <skipped>
>     if (!sbi->hidden_dir) {
>         <create hidden dir>
>     }
> <skipped>
> }
>
> So, I have two questions:
> (1) If we mounted volume in READ-ONLY mode initially and we re-mount it i=
nto
> READ-WRITE mode, then we skip hidden directory creation. Should we proces=
s this
> in hfsplus_reconfigure()?
> (2) Should we create hidden directory if corrupted volume hasn't hidden
> directory?
>
> If we don't create the hidden dir, then we could have troubles in multipl=
e
> places: hfsplus_rename_cat() [2,3], hfsplus_delete_cat() [4,5]. It looks =
like
> that we need to create the hidden dir. Otherwise, we could trigger the ke=
rnel
> crash in multiple places.
>
> Thanks,
> Slava.
>
> [1] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/super.c#L589
> [2] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/dir.c#L326
> [3] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/dir.c#L397
> [4] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/dir.c#L418
> [5] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/inode.c#L257
>

Hi Vyacheslav,

Thank you for the detailed feedback and for pointing out the deeper
design issue.

You are absolutely right on both counts.

(1) hfsplus_reconfigure() does not create the hidden directory when
remounting from read-only to read-write. This means sbi->hidden_dir
can be NULL on a writable mount even if the volume is otherwise
healthy. This needs to be fixed in hfsplus_reconfigure().

(2) The correct approach is not to add NULL checks at individual
call sites =E2=80=94 that is a band-aid. The real fix is to ensure
sbi->hidden_dir is always valid on any read-write mount, enforcing
this invariant at mount and remount time.

My plan for v4:
- Extract the hidden directory creation logic from hfsplus_fill_super()
  into a helper function hfsplus_create_hidden_dir().
- Call it from hfsplus_fill_super() as before.
- Also call it from hfsplus_reconfigure() when switching from
  read-only to read-write and hidden_dir is NULL.

This way hidden_dir is guaranteed valid for all write operations
and the individual call sites in dir.c and inode.c are safe
without needing NULL guards.

I will send v4 shortly.

Regards,
Deeanshu Kartikey

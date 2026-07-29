Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810324921AF
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333600; cv=pass; b=XsjKYkHlhvWYJTNUjGzspPm0P2HHKaoHA6CYTvAfk8xx3R6S2kGMy5Kc08sdBsQ+2GrlsBhPpP/qurvHXO+aQ/d9NVz/EX1Uj5PMsLn4j4yv1fMi3m1p6VZSk3olvFBJcfXRQN38Iw9uuu4+3ku8y98kIvzfDMiI8EKe4l0A95E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333600; c=relaxed/simple;
	bh=4qe50KTIVPbM8CANycvSYRvypNB4O2/hGZYA+ySnSMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/8FlKpXwXS2AgdiX51fMKPQIlurU7krqlTc3fFSxkEGboI+gYhKEeZBEYAGx8F9VIw0rOkhe1ZZP7qqXJ79FHzKQdzEASsqCvgutbs3NqM8vNXg5n6g3TCA3zEJvTpEB58UtbWiNgLt1bZtnrBSVQ6v2DFb5KNpVc3MYqLBu58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVdWoWhy; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVdWoWhy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cacef7d299so103185ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 06:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785333596; cv=none;
        d=google.com; s=arc-20260327;
        b=Owr33CwFckozU2y3Gzy/oOZPOW8fZzGX/QmlWsMuWDKn5dfLN5aFfwWRiFknvprYAF
         1ljyWqiM7VzAJDlTh2AYH5Dy7sahzGwaUAME4qXeCyF4g1OnVFJcZeNbWcc2n5BaWrZs
         UBgiHkWzR2Y6WILeGq1AGSsixP4HN6o49SHM7YgePMPKHHkkkxkxtqpOGpNQmsyzw9K7
         k3Ar+f5nu8q/uzb/ib7g15xi9QmaJIOiEaflMaXBB4N5AOkUrcoh5wZ64KrHLc40Vn+Z
         Ia1CBXxehfoIqnLuiVIwQeTYdAPd1lY55Cc7FpHnRSO6XtBdvrEK7g8uUfJ0pTRRcbjb
         wIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dKcySLFaScFmr1bueu4Vh/oR9sazTcKBYENtIklzl98=;
        fh=bNkgEc2cgHuelJRsdGj18DTdszF7qjAOIzBbhnqFf+I=;
        b=LGc9bQ0+TlMjSX9SxEsH+mhn9+gypauR68ikxS1AHYuDs+riqMTF3w2Z1UzbPMDx+b
         zqBS+MJle5SZeX106+Vb84u0UErlFQRnIjSdbBRrn797cTRcMGiYCPjPcFOY+yTIepBn
         nFwJOKnwHuDMge83pZpDO6zN33cjWIC5fKH8xiXO7PEX+oVyaSztX9zGRhg0m6PartM6
         uIxcrtLnPTrZL3t/bZworX+s14O2YAap88haPHTz9F5BoTx5sOuWw6XP65+rBRKWrt+2
         EI8FyM1/wwG1GSJh1VzMrBLVJjk3w7Rxwdt+E42sMSlE+Iv05SirZJtI+MsCih+akhQa
         Id3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785333596; x=1785938396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dKcySLFaScFmr1bueu4Vh/oR9sazTcKBYENtIklzl98=;
        b=WVdWoWhyDq5hX/hsToB3l/zt2T8BZGo7bTDCnZRk2WvNvebSBKw79/kzuaIQSSsH0S
         r/0c0ZuzXL5EudZbl/6keoGaMRT2D9oO0vfhN5JnQyqguo9cUWoLr85T5PtHfiC3KmER
         i6HJjAyQmRDG84Wnrt+Naklw7frprCcLQfimY8FZ/PsGo857ibFXPMtoqI0vKPaXUzHa
         ySJ+ZqZwB/dXMNBHq73tdVftvPscFsyIg1rtgPoCqRA72TOQrEdxLHtz2ghoUN1zhj0K
         0fFL/uYn6IZtU4PMmvOu2YVKrDvb8RpRPLmWsompzTYR/389rR/0HtjyBkX12e/4QU8L
         2Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785333596; x=1785938396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dKcySLFaScFmr1bueu4Vh/oR9sazTcKBYENtIklzl98=;
        b=cemRRXg26Wo4ODgciCvzRqBfNl6drwSo5OPYjBULzzGqpP0QDzYiRVmlmPsl1ZNHUt
         pwdaq7CHy3jqlckrrhA5mbHEiM1pOROCCyTBNCkeA6SKRSiSGl6J0WTetQ7IaOyk3/ZH
         D1Sy6J9HbF7Kwp8qm1uXsmmO+h3KZeuaL2LSK2hstSSqO1BI850tuLo7IrKOgDCVP6j4
         ANAzQEj9QXOCWiQgFIq568qHZ2RExI3xYXiOXnrLDM9PWKfBWIn2+PxhMNzP7gONJ/aG
         T1nXYsL6DiZhDsjSlIZ9LzAIcZIQJAQHURi/roIm3su3iOYG0yYEAvQ8yzM7dIPprHwQ
         ISEw==
X-Forwarded-Encrypted: i=1; AHgh+Rq8lWqZn5aZ6j+WW9zXKiIYMfwKSekFXqkCRaicfOWmlCjvNdfSao8hMBMB+kVJREN/CLF4zsoalkYHwLmK@vger.kernel.org
X-Gm-Message-State: AOJu0YyQgZ2z27j3uzmR87guQLFgEc974p3bNcmVzxQ4rlxKX2Of+uVC
	EhaIAwK0aue1cjugCdM4jY3SmQ1r5kCaHcgZF4T9Qv72Z7YzZzrk2O0at6jIcDAhQvYezMy0hPo
	1MUnLbAHWXdorQcD9ZurNwglVqagtuIerWFjOlrQSXHnAdxX4x9+PHJ3O
X-Gm-Gg: AR+sD11p042/9UETaaqBTW4+CgRNv1kXZjhyhwPxtWL9G1mGJLizk3PEYoVYZCR1JRC
	klmDl7GqCyZQbmA4v6Ee5zpncXhTUgxasIvkY9rkEdyxNN8/Lz9Dh+DWITqC9wo267x0cewa+oP
	7l3XaZqxhrmmvupT+PJlhbZHP3VchQJWEU0Xl3DeqZTXvw3VLS3lBXGMTX8psdNECp7l92oJNQA
	Z4HOxko4KoXLi+cCsS0gBbsBr8mbULD10Y+4NerR2pSGnO20JytNK5KLmMtV/gKLRg2t6fHFqHO
	oLLyOUVn/0wnZqclhQiCF9KYtHoWZu9eX6yUJ3mo3RrO7t5KxkbzziiGwX811tVXSdJzMqCWzjC
	Ocm/gfNy3XpOSRXOYxQwg2LychDaw08o=
X-Received: by 2002:a17:902:ef06:b0:2bf:1000:d3ac with SMTP id
 d9443c01a7336-2d0287cf9c8mr4618065ad.11.1785333595219; Wed, 29 Jul 2026
 06:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHmU7G=Dsf31mJ1VH4+Tp-McSvXCg=GcO-eC+O52-_t5gc7Pyw@mail.gmail.com>
 <CAG48ez1UqV8E8nHGq50orS+3oqXbP80R6g7kVa3Hq-domHCSsQ@mail.gmail.com>
In-Reply-To: <CAG48ez1UqV8E8nHGq50orS+3oqXbP80R6g7kVa3Hq-domHCSsQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 29 Jul 2026 15:59:18 +0200
X-Gm-Features: AUfX_mxsSGeX5Wk7ttteu_H2elB1yzsLWm21TrFa_WMDUNzOOPYaOsNkMreMWbY
Message-ID: <CAG48ez1tUk+8b7-eWw-fHh2x_bJA1n3CTANVWKQuPW=J+inCrQ@mail.gmail.com>
Subject: Re: regress caused by upstream commit 6650527444dadc63d84aa939d14ecba4fadb2f69
To: Pasha Boroffski <hex.dec.bin.oct@gmail.com>, stable <stable@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: regressions@lists.linux.dev, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 3:45=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Wed, Jul 29, 2026 at 11:08=E2=80=AFAM Pasha Boroffski
> <hex.dec.bin.oct@gmail.com> wrote:
> > Hello.
> > I believe 6650527444dadc63d84aa939d14ecba4fadb2f69 has a bug in it as i=
t causes "kernel bug" with PREEMPT_RT enabled.
> > How to reproduce the bug:
> > i used 'find /proc/ | grep 123'. When scanning, the kernel triggers an =
"Oops".
> >
> >
> > [  344.465851][ T3715] BUG: kernel NULL pointer dereference, address: 0=
0000000000000f8
> [...]
> [  344.465888][ T3715] CPU: 0 UID: 0 PID: 3715 Comm: find Tainted: G
>    D    O       6.12.98 #9
> [...]
> > [  344.465905][ T3715] RIP: 0010:down_read_killable+0x9/0x40
> [...]
> > [  344.465974][ T3715]  proc_map_files_readdir+0xc7/0x500
> [...]
> > I think calls
> > mm =3D mm_access(task, PTRACE_MODE_READ_FSCREDS);
> > if (IS_ERR(mm)) {
> >   result =3D ERR_CAST(mm);
> >   goto out_put_task;
> > }
> >
> > should be fixed like
> > mm =3D mm_access(task, PTRACE_MODE_READ_FSCREDS);
> > if (IS_ERR_OR_NULL(mm)) {
> >   result =3D ERR_CAST(mm);
> >   goto out_put_task;
> > }
>
> Ugh, yes. This is not an issue on mainline, but the API contract of
> mm_access() changed in commit cd3f8467afd4 ("mm: refactor mm_access()
> to not return NULL"), which landed in 6.13. So we'll need a
> stable-specific fixup for 6.12 and lower.
>
> I'll try to come up with a patch for stable later today.

I've reproduced this, triggering this NULL deref on 6.12.98 is as easy
as "ls /proc/2/map_files"

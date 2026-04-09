Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871053A8736
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775725574; cv=pass; b=OdIvQ96YPZ755VAegeDxlydgKV1hLb7l6RbO7iY0toeIbbU8qWQCijnHB9dU+n5Xe/xPvMqq5N8hpI9pjpNQnWx2mH6aQINARu6zCGbuAsvOX0sbPw5mh9wtQCniINIF9FRg9n96Aeaf3U08NtPR+aplUTIqdXbjBAwXDa5X16k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775725574; c=relaxed/simple;
	bh=LwIGjIYN0jbye3LkeN82jaFy52xIDOtrW5pLnkrFDiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmgakVP4WnJepewQ0H3sQ6tN/wxYmXVjj3/U/tjBlWcoi+8AswJcVCp+xENXTY2OjejiHlHuH3uixTx0tLEqtJy9TVWuNs6007linGnkM6hY9wa51SbmJWdj7OntwD1DXjfurbFe/KeuSTeMxZdeghWe2FZClmmEN+gdyvJLx7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOjAIdQ1; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOjAIdQ1"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38def541b0bso5697381fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 02:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775725571; cv=none;
        d=google.com; s=arc-20240605;
        b=Ji6lnO51WybmzLNlWUUAiDSycHkrheoKnlCuCuLv1oIlXGC/A6hrfF5t+WAyqg9+bd
         KnOdwa+4jzDlI/ElTzpWBLtqWKRGQUy4o3iy49J3Jg0COdlM5ouN/OQKXerhf+mifuQK
         T4MrqYNJ2pLBe9Dm/46hTMQSyW7PcEVpqCR2lgsm0Ytcd+Eh5aJcmXCz2zoqCz6j/TDt
         1GlV73Ib8+3YbsGtAfn/USXUTqU2TYAu1UPF7Gwk7iN4UF8/JwKetfUSlbLyhoKTEDEV
         h25C91VzLjJjOOTv8xJe+2TNuDrrojhKwEk0r2oYTyMlCceQxFIpglVQ+o+2UISaihAw
         k6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ZryO0qKRF+cyo5NikEDT6axHoFUuS1poGw3MmfPXUU=;
        fh=hFtVTweXUXynTYUxsD8z3iyxTWDgucmaWjvI0q+Sgio=;
        b=LFoTt9ZLP+9DDd/kwwf+FNYvhHPYzt4ZKSefo3IxS3ucBC3o+s6JmA6xiENYOw8m20
         CFbGzJmPjQi8IC+TftKbJcTx11If4t1qMVUENcceX4FRalNj3+pxgSSeznHa1G8lSJ+F
         0NPkNPmZNuJoaoWQIe4yozwIoFkqQtSKNEVGJGhQiFRmM2GyvedVmCn/hc7/x+L8tpR0
         897AjAw1vwpkIpb2A18L82VKa5SW74d7wJp/fsXaf1H/BDIB5bIsQkmBUGorup5sGId7
         8n4Vb4m/vOWjwzYxbgo668HwPqTZG0+hN+gcn3k4H8mN2YNauxhv6jmQ2Scp4R8HJxxs
         nkbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775725571; x=1776330371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZryO0qKRF+cyo5NikEDT6axHoFUuS1poGw3MmfPXUU=;
        b=HOjAIdQ1SXZ08HS+ruzSmWS4gdy5bd67MPnBT8oFSgxEGipH1o2oHiKv/fD/m15D6r
         9iQuTj2oYxhDL37+Rrwrxiw5X+Kfj0AelAIHiIIG9bkJ7z75n+BFjtnY/137eXC0AswZ
         AAH7fNnMSUnY1pQc+oWxH0vEVEioeDAP1PVv8OximuqECjltber0+NJrp8iqLOftV1eB
         VAy4t6G6gzen+tT7JZfzP5DBW4XzkLYo5EDpcFxYxi48W8kGS7kImYE+NsrKwYR1/imP
         QlZUoi1EolJ5J+6sTY7yj+oTNyLvOACeUfcR8089+ZJSFTl7hgZ56yaNMEJaFQ0BL4IK
         SqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775725571; x=1776330371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ZryO0qKRF+cyo5NikEDT6axHoFUuS1poGw3MmfPXUU=;
        b=Sa82jIiKw4Yn5Tqnk1msQtf7VIMOnhuZyjrp3zMVuCKMUPXzMW1Rxez7a4nVVQhrUW
         WGxAW7u5nG91m9ynuYdYmRrUE7anEdiaX6ziWMBcUGNCu0xmFYnC7Ou88GergWOGGNAw
         FymnTJ46PDyYSp0criUTQVjcfOmFxaHSAJi9d6Z3i1fWl/YK40E103B3sct3VOpRb15A
         toG0I7t0jhnTbNquBdaG515+YFJ67IKzeTYlrZgggpt/bsid9Qwyt8xwsbpks73f1NNu
         gtfcx0e3SM8Qpt1zd52Wpc1h8V+8DGsY3yQTIckKH0ab5YlriK5aw4ltQStokqtEpjMb
         EVjA==
X-Forwarded-Encrypted: i=1; AJvYcCWi/NL5wAmAKExxOOxl4EAu8BDFL1XIYDy00Wq6JERPgA+qZP2XbP9OOud7bPqUvYNXKTXKIZoGoES8QBub@vger.kernel.org
X-Gm-Message-State: AOJu0Ywubsi6Nq7uQYNjmoHHsdFcHvQgLWCnC9liUdODG9ukPIhlgYVp
	/RDItRnW7v66/jdNWoM4ryo5MJpBCarfmwBwhwqRWiqywK0ereGGJbldjC8lUajDofVVlO64Nrr
	87yGHWd1FwNj/wXkd49h354lJHQCk9g4=
X-Gm-Gg: AeBDietDjXFKKgZ9X+NmOFE9YD0FKT0qcEU6YvqMwclBKAR/lCk/wOuxWFvl5MTB6aZ
	bWLsB/VRa++IyRhU652l+/WA4OSigEl1ZGYHFcI0Q+dCpXpabQxbE08nkUWFb7u+L6crC9NRcZ8
	/Y1023fLHNxjUimfkIBcjf+4zLUcokIAjf4O55hWsf72dKOmwsq2aBA6mkVgipccFDuCLx2R8Rq
	49hV3qfduzpRCE8FQmF4ZB91l5SrZxF6IxBTcIbAzUbCWp+Z/wN4qvpQUbVnn2UjhRo6poG32Bh
	3cuY8Xg=
X-Received: by 2002:a05:651c:1102:b0:38e:186e:350e with SMTP id
 38308e7fff4ca-38e335002e7mr9204291fa.7.1775725570037; Thu, 09 Apr 2026
 02:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407081442.6256-1-komlomal@gmail.com> <20260408123700.1596800-1-usama.arif@linux.dev>
 <addcUpxfuR2llaiW@lucifer>
In-Reply-To: <addcUpxfuR2llaiW@lucifer>
From: "Denis M. Karpov" <komlomal@gmail.com>
Date: Thu, 9 Apr 2026 12:05:58 +0300
X-Gm-Features: AQROBzDfRsi8mYNwNmhy9bUN0g1ZwnamyHPiBKvKGT9BZOgi64bSgj3u90hlgn8
Message-ID: <CADtiZd11b89Bt7-7N9xa6AHLKFX9D12X=tQan9VJLoZd6PtuYg@mail.gmail.com>
Subject: Re: [RFC PATCH] userfaultfd: allow registration of ranges below mmap_min_addr
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, rppt@kernel.org, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, vbabka@kernel.org, jannh@google.com, 
	peterx@redhat.com, pfalcato@suse.de, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(to Harry)
> Technically, it's less restrictive only if start < mmap_min_addr
> (setting aside the discussion of whether this is an appropriate check).
>
> Otherwise (start >=3D mmap_min_addr) it's more restrictive? (now, the pro=
cess
> should have the capability when registering an existing VMA to userfaultf=
d)
Hmm, I can't find any checks for addr >=3D mmap_min_addr in the security
subsystem,
only if addr < mmap_min_addr. Otherwise, one would need capabilities for
regular mmap() calls as well.

> Was it a private discussion? I can't find Andrea's emails on the thread.
Oh, it seems Andrea accidentally dropped some recipients from the CC list.
I have CC'd him here so he can clarify his points if he feels it is necessa=
ry.

(to Lorenzo)
>Duplicating this kind of logic in the already horribly duplicative (and mo=
re
>generally, horrible) UFFD implementation is actively buggy and incorrect I=
MO.
So, no security_mmap_addr check, no FIRST_USER_ADDRESS check.
Thank you both for the review. I'll prepare the patch.

On Thu, Apr 9, 2026 at 11:01=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Wed, Apr 08, 2026 at 05:36:59AM -0700, Usama Arif wrote:
> > On Tue,  7 Apr 2026 11:14:42 +0300 "Denis M. Karpov" <komlomal@gmail.co=
m> wrote:
> >
> > > The current implementation of validate_range() in fs/userfaultfd.c
> > > performs a hard check against mmap_min_addr without considering
> > > capabilities, but the mmap() syscall uses security_mmap_addr()
> > > which allows privileged processes (with CAP_SYS_RAWIO) to map below
> > > mmap_min_addr. Furthermore, security_mmap_addr()->cap_mmap_addr() use=
s
> > > dac_mmap_min_addr variable which can be changed with
> > > /proc/sys/vm/mmap_min_addr.
> > >
> > > Because userfaultfd uses a different check, UFFDIO_REGISTER may fail
> > > with -EINVAL for valid memory areas that were successfully mapped
> > > below mmap_min_addr even with appropriate capabilities.
> > >
> > > This prevents apps like binary compilers from using UFFD for valid me=
mory
> > > regions mapped by application.
> > >
> > > Replace the rigid mmap_min_addr check with security_mmap_addr() to al=
ign
> > > userfaultfd with the standard kernel memory mapping security policy.
> > >
> > > Signed-off-by: Denis M. Karpov <komlomal@gmail.com>
> > >
> > > ---
> > > Initial RFC following the discussion on the [BUG] thread.
> > > Link: https://lore.kernel.org/all/CADtiZd0tWysx5HMCUnOXfSHB7PXAuXg1Mh=
4eY_hUmH29S=3Dsejg@mail.gmail.com/
> > > ---
> > >  fs/userfaultfd.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index bdc84e521..dbfe5b2a0 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -1238,15 +1238,13 @@ static __always_inline int validate_unaligned=
_range(
> > >             return -EINVAL;
> > >     if (!len)
> > >             return -EINVAL;
> > > -   if (start < mmap_min_addr)
> > > -           return -EINVAL;
> > >     if (start >=3D task_size)
> > >             return -EINVAL;
> > >     if (len > task_size - start)
> > >             return -EINVAL;
> > >     if (start + len <=3D start)
> > >             return -EINVAL;
> > > -   return 0;
> > > +   return security_mmap_addr(start);
> >
> > Is this introducing an ABI change?
> >
> > The old code returned -EINVAL when start was below mmap_min_addr.
> > The new code calls security_mmap_addr() which returns -EPERM when
> > the caller lacks CAP_SYS_RAWIO. Existing userspace callers checking
> > specifically for -EINVAL would see different behavior start is
> > below mmap_min_addr.
>
> You mean API change? :) we don't guarantee ABI for kernel stuff anyway.
>
> Firstly, as with Harry, I don't believe we should be duplicating checks h=
ere
> anyway. UFFD is duplicative enough as it is.
>
> And this is such a silly edge case that I don't think it is valid or reas=
onable
> for us to account for whichever totally insane user relies on a pointless
> re-check being done there and _then_ relies on the error code
> being... -EINVAL... which is overloaded for a million other possible fail=
ures.
>
> Let's let it be -EFAULT and remove this silly check altogether.
>
> >
> > >  }
> > >
> > >  static __always_inline int validate_range(struct mm_struct *mm,
> > > --
> > > 2.47.3
> > >
> > >
>
> Thanks, Lorenzo

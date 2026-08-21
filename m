Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463429CE9
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341977; cv=pass; b=Rr2ZosnAX4NsL/gTJz0TShZfph3hkXn1Yo32eVVF7sacR35yZbupFNoMjgR2rgrmkBEdr3tltj6zmisFSmZEn9UVvNHZjH0J9mFFQ8Y/rEipE3EyUMTUVFnnVnrpNAAmilEsXjBXQgxPeuYWFAWFBFG1xMtxzP71Nse71MzsaC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341977; c=relaxed/simple;
	bh=SnKQAy4ryaVHU37EB0MreTs2voS4T4xBNuc5Ub8JIHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkTJakdZfeekJ/+bynljvLt8Zve3gw9ohPgy29yT5nD4IP9pb6HTuNkF3RT/NnjLHh6c2GIzd2RnxdIWThOQ60z12+8Ak6jwVhOHYWHjT0bIkrraix5IYmK3HaJd/UEzk2EjuwYGORu2/pLXzcoBZS4+igytmuL+GVBhbNOno6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXbz86LK; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXbz86LK"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1089504a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 12:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787341975; cv=none;
        d=google.com; s=arc-20260327;
        b=Ee8TdfOhMYNrdrKigkgZZ/CgntwKO2qWsgUYabS6quveDuuOxNwKAboQaNyt4H1ftt
         9Q6fdq05jVjdaRcnCyV0Z7XFOyGzZJkKrlolL6rtl/rV8Pydy4rjKQo1QnQJra/uQvTe
         gxbczCn8o7BfZT7DruuWsvTHWZ6N3wHcUsD/XIHjac8jhL7X/hIrJJkra098p72ToAkA
         2Z8EETouqCYf9/J0dzB2rhihzjZxGKnr2HOfqvcHQ28lKslgWBZDVFqUkny1xk0IDfxJ
         MWll3IHvIPXOIRvrBGbKebrq98nPT5KXbEWzSmShCwi6w/gR4J6T+ACx8qmP03s/F+Ua
         ji3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KidtnQB/eYDDRfHgfBWu/wvFzRWxKzN8GJX8+RxP7Rg=;
        fh=J4rFAV4OPQHfRtYiY98b82N/fbK0kxSnpqVIMTGSGes=;
        b=XjEapky3EsFJKnADCWSzXwgH8GQzEFuddUpXBOajlOGpQpOKv5bMTji2O/N67hRS7y
         /JVbKMZ5GO/upDf8VCT+A3nWok2F1oA3jQbBz1lIS+z9077Ws1qvRNgBegiagAghk+wn
         wb3twtpyhyu6VIdMVQ4NWfTSKTjcVlzY1LlXAjDOnqYyYVZBYjvckolDEbldg4hB8vAb
         ZEbp7zpM+eVXyxd569hh489oS/+VwXuK6iYIyJ0v4pwjz2u/EoFfQYaIIKnUdvA1dn1o
         holYRlAlVCI5G3e0tKEWhKohwCywCnesXm0qt6iTxuh5M1kX62HQJ9tjXXZIZMTr1Iu7
         lI5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787341975; x=1787946775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KidtnQB/eYDDRfHgfBWu/wvFzRWxKzN8GJX8+RxP7Rg=;
        b=bXbz86LK5KjNG5EcT5fxHHKkyhF/4R9FHatgg2zQafWVgEyfDra/0CygNwJrcY8EsT
         tLI/o4cnu8GxXWVRSLHguT5/VmJfqKwT0aEc4aa2sNyqwOQnxEavUaO4rqyrfmzDH27c
         nNJbFFp13eUPsRZtMrSt3UNDwbnQGL+oy9MrJSBarB6QBfKCyCGFn/SCJ2Rfe4XF9vGv
         AYssl7fwSF+r5j+o0e5ze730MiQl5OuvGcHLfLYlz3n8+PfYOcfcrEQfDzA2a6jyLRtT
         6+ZKJeVwycKw9E8CJKTYfuZREtoy0YKtRHjIF1JzIYhB035Vk/HvkqXUhTtg/PN4iIhP
         hl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787341975; x=1787946775;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KidtnQB/eYDDRfHgfBWu/wvFzRWxKzN8GJX8+RxP7Rg=;
        b=QMwcb8akQJsU8nEK708Vyn2nkCLvr66kcNR33FU0X2jLv3cwb51HIzZJFukwJxPZVw
         wMzjz/2Kxfz15C00X9XG7MegMJNLkklia3/zL4P25PK0pp/8YoaUyeT+QLmeWTcCPwpw
         1118v83otxHdt5fvxoCoxNqzfQXzQ68vSO1JU8LjbBS3dXFmey20i5F/ZJUzKlBwYWy4
         sswfx+cUrXW6joL1Uaha5B62ObYVuDYYzo4+CG0rmCuuU6NNt17bK3pN6nOjBeVWBKoC
         pm6Ym46WOeEczxweqNE0A3VZFfx7iRtE0StyQL/YXrQ5PAteNiJI+IY8Bpk2LAN1Q+EF
         +8HQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNcdDMbYhWPONYJkQebSF3VBOjxmXIEZuMq2LChDM7sWSj+vf8+g4kZVX+7R2PBoQgam/Kyv5aeDVKYRZA@vger.kernel.org
X-Gm-Message-State: AFuF++kQeHigOIaewQMhitos9QE3uxTLWfnd0qU31AvsdMDNqNMf18BL
	5s192yvAPQawPFt0H2ek0hDtdI4iZ3pHf/q7fmdLcuzkZaY8gWj8MsQlnYf7sjcLK3B5b1kEucd
	baR6ysHfBmdrrhK7DAlURwVKthJ1XEr0=
X-Gm-Gg: AR+sD11jL/iaMQIw/JaDVU0ig/b9faCQm2onsLKIrf2riPt4XWGN+aSnDKaNuFzB33j
	CXrlhOTlim0dxdHLDajNWTkiytxXmxHI55BY8aqzsztnhQ7WPMGSNncC2slLqebo2FV9EYU92jG
	KJ9K6Gc+QR6VdyQ2Mc/Odt+gGbK2DCiMvK64FJfrT4lWBdfOIDP+T7Smhb9ti6yoaKKIEVYkzoL
	0U3JIID4APNYSMqt4Dp2Fe6sgEXJZTEOPdrKEW63n2hAAr6LkjGQY87i18edyGrQNUHperXJDOw
	zp8K5Z+qXht/HFxz4MgLdPdIgbE9b2Gacyi81/r8LWdvp0e/ELIdxNhARcLOGkFqB+uvNWjCZ2p
	cOsb0m19buYhkLJ3LY8zGzWqkhQ==
X-Received: by 2002:a05:6a21:6492:b0:3cb:853e:850e with SMTP id
 adf61e73a8af0-3cd4bbe8aa6mr2217187637.13.1787341975075; Fri, 21 Aug 2026
 12:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820131801.68759-1-tasos.papagiannnis@gmail.com> <20260820131801.68759-2-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260820131801.68759-2-tasos.papagiannnis@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 12:52:42 -0700
X-Gm-Features: AcwNN1WiobjREO1ATp2ZQpfgWCtJVvDwcD8UEwKRu-9pDckvpVIFCNaWpSBtzYk
Message-ID: <CAEf4Bzb-43E7JSc5aNBEi4y1PKfQvjRi_FwTUyP7cYaQ+-JqXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] mm: Add copy_remote_mm_str()
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	kpsingh@kernel.org, matt@bobrowski.net, song@kernel.org, 
	utilityemal77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 6:18=E2=80=AFAM Anastasios Papagiannis
<tasos.papagiannnis@gmail.com> wrote:
>
> copy_remote_vm_str() gets the target address space from a struct
> task_struct. This does not work for an address space that exists but is
> not yet associated with a task_struct, such as the mm held by struct
> linux_binprm during exec.
>
> Add copy_remote_mm_str(), which operates directly on a struct mm_struct.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> ---
>  include/linux/mm.h |  2 ++
>  mm/memory.c        | 26 +++++++++++++++++++++++++-
>  mm/nommu.c         | 26 +++++++++++++++++++++++++-
>  3 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 485df9c2dbdd..eede435bf4a3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3222,6 +3222,8 @@ extern int access_remote_vm(struct mm_struct *mm, u=
nsigned long addr,
>                 void *buf, int len, unsigned int gup_flags);
>
>  #ifdef CONFIG_BPF_SYSCALL
> +extern int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +                             void *buf, int len, unsigned int gup_flags)=
;
>  extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long add=
r,
>                               void *buf, int len, unsigned int gup_flags)=
;
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index 6b8280cfc1db..da0010c4475d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7218,6 +7218,30 @@ static int __copy_remote_vm_str(struct mm_struct *=
mm, unsigned long addr,
>         return buf - old_buf;
>  }
>
> +/**
> + * copy_remote_mm_str - copy a string from a remote address space.
> + * @mm:        the remote address space
> + * @addr:      start address to read from
> + * @buf:       destination buffer
> + * @len:       number of bytes to copy
> + * @gup_flags: flags modifying lookup behaviour
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destinati=
on),
> + * not including the trailing NUL. If @len is zero, return 0 without acc=
essing
> + * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
> + * -EFAULT.
> + */
> +int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +                      void *buf, int len, unsigned int gup_flags)
> +{
> +       if (unlikely(len =3D=3D 0))
> +               return 0;
> +
> +       return __copy_remote_vm_str(mm, addr, buf, len, gup_flags);

we should rename __copy_remote_vm_str into __copy_remote_mm_str

> +}
> +
>  /**
>   * copy_remote_vm_str - copy a string from another process's address spa=
ce.
>   * @tsk:       the task of the target address space
> @@ -7247,7 +7271,7 @@ int copy_remote_vm_str(struct task_struct *tsk, uns=
igned long addr,
>                 return -EFAULT;
>         }
>
> -       ret =3D __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
> +       ret =3D copy_remote_mm_str(mm, addr, buf, len, gup_flags);
>
>         mmput(mm);
>
> diff --git a/mm/nommu.c b/mm/nommu.c
> index ed3934bc2de4..1fca0bb7f042 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1752,6 +1752,30 @@ static int __copy_remote_vm_str(struct mm_struct *=
mm, unsigned long addr,
>         return ret;
>  }
>
> +/**
> + * copy_remote_mm_str - copy a string from a remote address space.
> + * @mm:         the remote address space
> + * @addr:       start address to read from
> + * @buf:        destination buffer
> + * @len:        number of bytes to copy
> + * @gup_flags:  flags modifying lookup behaviour (unused)
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destinati=
on),
> + * not including the trailing NUL. If @len is zero, return 0 without acc=
essing
> + * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
> + * -EFAULT.
> + */
> +int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +                      void *buf, int len, unsigned int gup_flags)
> +{
> +       if (unlikely(len =3D=3D 0))
> +               return 0;

I'd just move this len check into __copy_remote_mm_str()


> +
> +       return __copy_remote_vm_str(mm, addr, buf, len);
> +}
> +
>  /**
>   * copy_remote_vm_str - copy a string from another process's address spa=
ce.
>   * @tsk:       the task of the target address space
> @@ -1781,7 +1805,7 @@ int copy_remote_vm_str(struct task_struct *tsk, uns=
igned long addr,
>                 return -EFAULT;
>         }
>
> -       ret =3D __copy_remote_vm_str(mm, addr, buf, len);
> +       ret =3D copy_remote_mm_str(mm, addr, buf, len, gup_flags);
>
>         mmput(mm);
>
> --
> 2.55.0
>

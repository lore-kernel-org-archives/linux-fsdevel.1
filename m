Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D4361DCB
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623761; cv=pass; b=Is6zDvy4LK/k8KFdPIae/lVuiLVzOaOZBJzqQfpE3Ee2VcL5f+asexFakUXGU47t09qKZt13ZmCgPn2ASFJKOLFsP2sQhsEYC4RmBSuiS7FCOObZs6+Pxq7Sol/rH0aioskbJgLQfvjmlSkBFV3lNuDVx+XhzuMtvg3w1AH4c8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623761; c=relaxed/simple;
	bh=kowWMHHsfxKQVxH1gCsYTEZqK5WmN5gUQOIysZ8mKPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tM+6tq6ONerZdpCYoyxHS6XDifgD1ByNnWQVuCczLnpw5JubocBmzCYK1ooe1wKreE+GKgwMvEYZ1Th5Jb6jXc/eWhYVGuHHVgOMB1fCMYMfmnx8SfbpGiXtC2/2g/ehc3aUuL62wTXbzM9+EGxlvjpNRktd5ZbpGqrdNkPyPU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb7cUHeO; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb7cUHeO"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dc2b658544so11926077b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 18:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780623750; cv=none;
        d=google.com; s=arc-20240605;
        b=gU37Wxdgos89WX1NVh3SQMn8qM8f/Hoh6KUgkUUyrTQu+t8DqSwYlQddZDeRor1fgC
         sY6jrEbj7zpYjNno1VtUHga+j6WgLleAYOO5IUJU+9ipDPIS6UDzF/e9Ec+ntT6QQxBD
         rq6PmBp9iQT6SZDucUp5qksSeyJll8dusevryTOFMweybXNjblTegp87T50lan5DXKB6
         O8TVIuPikA23PO54XwhPeaoYtLJjTTIgwAnrEzcrie3rLHnlqmuOk6gXXuBv32lsm9D1
         nTLz4egUnrr0+x81lgCq8WqhCQDwFmeRTZU6uhIUK/j3uEUe5tdmzivAIZSESPuy6p0T
         Vigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zA461QtkcjGieHEzF6uHxdDBMYEET0L4iyDbA5xKMuE=;
        fh=I1yJ7ZqG5wHPuBV94j6aZ+U5z4WGA+h+Icu7ypcGmQU=;
        b=EbAjxlE9aMvCES6MFMSAtrJxHPOb3fgsWuo7u/igw5B6xC9pdTBx8qpRVM4ZLyHLjH
         opDosG/OpPisAXku+Q8MT7h6b33Kg44Sv5NtryCjQfiReyTL9aUQwZx91GsHI5rn60sk
         Hw9Qs0zLCx5OoueDqjo/dSRtOCWk3ZPJo3sUUVE6o1sGUdgYdUNxs5XfHbtyrnZ1jykr
         GXDwshJZDpo6gQHs5xDDaSRXxxv2onjWv9au0M4ZLNQtPyqrNmMTM+cIA4CCJYTa2HhR
         8k/GVPsp+Garh9Qe66fnhYGrOggRcmAz5VNzhlpih3MSePr26/MUMs/+pHkIh24stiPb
         NhiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780623750; x=1781228550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA461QtkcjGieHEzF6uHxdDBMYEET0L4iyDbA5xKMuE=;
        b=Gb7cUHeOZYlmf5fHlH5PWgZfqJoYHdovcoxFfv1RoEdexAp0SKtGIqwW2iTzRGvx+S
         no9wThf8IC6IU4Ky4ywXSu6ra+dKYuociCxDRvPw+NYFDhoyA+8vkVb6lkvs2pmaak+j
         ApQyVU1anrkZaXotgBmBsnMV+QDshtd2D+jc10WajHSr0jMbeiRuzKCbklwK9bYsK58f
         XKYvKkwigXy/GqUBzylfE8Vgi0dakZeWocLwjzwK8+lnZ3ApRaqsLUZcWF9GnvdZOeMX
         gGQr7TzQrraR/23gDheCyQ4Lq9R7z8mC35RgzeNatF4RDCpqzTw+DZ9r9pwfQf2lC5TC
         tLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780623750; x=1781228550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zA461QtkcjGieHEzF6uHxdDBMYEET0L4iyDbA5xKMuE=;
        b=Kzhh44vNXVymHAjQQIW+GSa26uyzX+Cc5yEyTLiwlX6mY/wrfKnyEmvYDgUZQxV7Rn
         MKr3ZlBqpxnSpw/wf8fvZiYwfTU9HR4+oLwxEjE02ejMJv8r1QL35jgxev98nN9kNOZ0
         27GQae9uQZgcxgc+SAQeZ3gqpGGLgDQvGqfJJlaTdMBJWGC8pmxCXohhDUtfw6a3HAVX
         XO1yef1mJOpEWQgnlCTXY+KMQIkX+j0dMAXUdgKI3SkPlSNbguzco9q7fAV2XPhKxycA
         h6WMX3FLNFBAY7RVNYDDuTuyC4sFh+KiiZLwGgXXKFwzDNJT2Cx8YesR5tmSikHHOjUq
         tQjg==
X-Forwarded-Encrypted: i=1; AFNElJ/b3uC/q++3oJSjk/gOMFybNUPKuRuXzB/o9iJjn0eif8+h525Nlr29z6svlBCGUnJ8yQgmOtuIbrvt2j0z@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmGPJ+pFHY4dVUI2BlYNTO0C/41z+EO2zpq6upyNyc+bKT1+i
	k/CXH4xioOmpoFYGQ4XRAlfsTkeFUVOJ5mGAgYhuMyN0pNvnNimX1IDMJct3AvcBzxRZTkn5Y1Q
	MrB+4a2bo444ijZ8c12PFexQ6dMUDVFxCRmwqgnbM/Q==
X-Gm-Gg: Acq92OHrKnSAixvu2agrdB4jcqb+JqckKn6zkcui0mCKLX0+o7VliZaDshBt8VBSCft
	/Zo7H74RktyOiE6XO+7zx/IeDjeJruMyhG1mtsDik065iJcDhLv3SBRWczBrKYvH5uvPvZ1Dyzv
	7XlFRT16QENw0K3WodybSE4SkuAa8YC4J6pGSAmYBNrFN+P2BHr9QDGKCKJNhpdDUayaCaUr/K6
	Q27vzLMtaWs1D0EtULJYChM3sGV/9sCc/nSI9IJTxuA+3pU1Ur8j9SIh/6AqGcl+qbARmikGxoY
	qSFTAeSMXxq24wHq5g==
X-Received: by 2002:a05:690c:620a:b0:7c8:f80a:cb4e with SMTP id
 00721157ae682-7ed1128e98amr13636637b3.35.1780623749803; Thu, 04 Jun 2026
 18:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604202441.65226-1-m32285159@gmail.com> <20260604143040.61f70396c568b7433110fb3d@linux-foundation.org>
In-Reply-To: <20260604143040.61f70396c568b7433110fb3d@linux-foundation.org>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 4 Jun 2026 20:40:30 -0500
X-Gm-Features: AVVi8CcS5Wva-NZURkbG64aHMfw9ORcpEVLcknzIWAxedafDFCxHxL4GGj2q1SI
Message-ID: <CAKqfh0Eu=sp3rfAGzhTPcx1Vw5p=sjxTigAWhkzskYrAWB9iWQ@mail.gmail.com>
Subject: Re: [PATCH] fs: efs: Fix compilation bug and use pr_debug()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Fabian Frederick <fabf@skynet.be>, open list <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 4:30=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> (cc linux-fsdevel)
>

Whoops, I guess I'm too reliant on --cc-cmd :(

> On Thu,  4 Jun 2026 15:24:40 -0500 Maxwell Doose <m32285159@gmail.com> wr=
ote:
>
> > Firstly, the current code uses formatters that are incompatible with th=
e
> > most recent GCC for x86_64. Replace them and explicitly cast the
> > formatted variables to their respective forms of long long.
>
> Please quote the compiler output in the changelog.
>

It's rather lengthy:
fs/efs/file.c: In function =E2=80=98efs_get_block=E2=80=99:
fs/efs/file.c:26:35: error: =E2=80=98block=E2=80=99 undeclared (first use i=
n this
function); did you mean =E2=80=98iblock=E2=80=99?
  26 |                         __func__, block, inode->i_blocks, inode->i_s=
ize);
     |                                   ^~~~~
./include/linux/printk.h:483:33: note: in definition of macro
=E2=80=98printk_index_wrap=E2=80=99
 483 |                 _p_func(_fmt, ##__VA_ARGS__);                       =
    \
     |                                 ^~~~~~~~~~~
./include/linux/printk.h:564:9: note: in expansion of macro =E2=80=98printk=
=E2=80=99
 564 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
     |         ^~~~~~
fs/efs/file.c:25:17: note: in expansion of macro =E2=80=98pr_warn=E2=80=99
  25 |                 pr_warn("%s(): block %d >=3D %ld (filesize %ld)\n",
     |                 ^~~~~~~
fs/efs/file.c:26:35: note: each undeclared identifier is reported only
once for each function it appears i
n
./include/linux/printk.h:483:33: note: in definition of macro
=E2=80=98printk_index_wrap=E2=80=99
 483 |                 _p_func(_fmt, ##__VA_ARGS__);                       =
    \
     |                                 ^~~~~~~~~~~
./include/linux/printk.h:564:9: note: in expansion of macro =E2=80=98printk=
=E2=80=99
 564 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
     |         ^~~~~~
fs/efs/file.c:25:17: note: in expansion of macro =E2=80=98pr_warn=E2=80=99
  25 |                 pr_warn("%s(): block %d >=3D %ld (filesize %ld)\n",
     |                 ^~~~~~~
fs/efs/file.c: In function =E2=80=98efs_bmap=E2=80=99:
./include/linux/kern_levels.h:5:25: error: format =E2=80=98%ld=E2=80=99 exp=
ects
argument of type =E2=80=98long int=E2=80=99, but argument
4 has type =E2=80=98blkcnt_t=E2=80=99 {aka =E2=80=98long long unsigned int=
=E2=80=99} [-Werror=3Dformat=3D]
   5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
     |                         ^~~~~~
./include/linux/printk.h:483:25: note: in definition of macro
=E2=80=98printk_index_wrap=E2=80=99
 483 |                 _p_func(_fmt, ##__VA_ARGS__);                       =
    \
     |                         ^~~~
./include/linux/printk.h:564:9: note: in expansion of macro =E2=80=98printk=
=E2=80=99
 564 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
     |         ^~~~~~
./include/linux/kern_levels.h:12:25: note: in expansion of macro =E2=80=98K=
ERN_SOH=E2=80=99
  12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
     |                         ^~~~~~~~
./include/linux/printk.h:564:16: note: in expansion of macro =E2=80=98KERN_=
WARNING=E2=80=99
 564 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
     |                ^~~~~~~~~~~~
fs/efs/file.c:47:17: note: in expansion of macro =E2=80=98pr_warn=E2=80=99
  47 |                 pr_warn("%s(): block %d >=3D %ld (filesize %ld)\n",
     |                 ^~~~~~~
./include/linux/kern_levels.h:5:25: error: format =E2=80=98%ld=E2=80=99 exp=
ects
argument of type =E2=80=98long int=E2=80=99, but argument
5 has type =E2=80=98loff_t=E2=80=99 {aka =E2=80=98long long int=E2=80=99} [=
-Werror=3Dformat=3D]
   5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
     |                         ^~~~~~
./include/linux/printk.h:483:25: note: in definition of macro
=E2=80=98printk_index_wrap=E2=80=99
 483 |                 _p_func(_fmt, ##__VA_ARGS__);                       =
    \
     |                         ^~~~
./include/linux/printk.h:564:9: note: in expansion of macro =E2=80=98printk=
=E2=80=99
 564 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
     |         ^~~~~~
./include/linux/kern_levels.h:12:25: note: in expansion of macro =E2=80=98K=
ERN_SOH=E2=80=99
  12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
     |                         ^~~~~~~~
./include/linux/printk.h:564:16: note: in expansion of macro =E2=80=98KERN_=
WARNING=E2=80=99
 564 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
     |                ^~~~~~~~~~~~
fs/efs/file.c:47:17: note: in expansion of macro =E2=80=98pr_warn=E2=80=99
  47 |                 pr_warn("%s(): block %d >=3D %ld (filesize %ld)\n",
     |                 ^~~~~~~

(excuse the misalignment of some of this stuff, I'm using gmail to send thi=
s.)

> > Secondly, replace the legacy conditional compilation for DEBUG with the
> > more preferred pr_debug() to condense the code, while keeping the final
> > output functionally identical.
> >
> > Fixes: f403d1dbac6d ("fs/efs: add pr_fmt / use __func__")
> >
> > ...
> >
>
> >  Test compiled only with gcc 16.1.1 for x86_64.
>
> Compiled how?  DEBUG was defined in some fashion?
>

I cheated a little and removed the #ifdef DEBUG to compile-test it.

> > --- a/fs/efs/file.c
> > +++ b/fs/efs/file.c
> > @@ -19,13 +19,12 @@ int efs_get_block(struct inode *inode, sector_t ibl=
ock,
> >       if (create)
> >               return error;
> >       if (iblock >=3D inode->i_blocks) {
> > -#ifdef DEBUG
> >               /*
> >                * i have no idea why this happens as often as it does
> >                */
> > -             pr_warn("%s(): block %d >=3D %ld (filesize %ld)\n",
> > -                     __func__, block, inode->i_blocks, inode->i_size);
>
> That wouldn't have compiled anyway - `block' is undefined?
>

Correct, so we're fixing two bugs in one patch (this one is so trivial
to fix that I just included it).

> > -#endif
> > +             pr_debug("EFS: block %llu >=3D %llu (filesize %lld)\n",
> > +                      (unsigned long long)iblock, (unsigned long long)=
inode->i_blocks,
> > +                      (long long)inode->i_size);
>
> It seems that nowadays sector_t and blkcnt_t are unconditionally u64
> and loff_t is unconditionally `long long'.  I think, please check.
>
> If so, no casts are needed.
>

Looks like I got a bit sloppy:

fs/efs/file.c: In function =E2=80=98efs_bmap=E2=80=99:
./include/linux/kern_levels.h:5:25: error: format =E2=80=98%llu=E2=80=99 ex=
pects
argument of type =E2=80=98long long unsigned int=E2=80=99
, but argument 3 has type =E2=80=98efs_block_t=E2=80=99 {aka =E2=80=98int=
=E2=80=99} [-Werror=3Dformat=3D]
   5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
     |                         ^~~~~~

This is the one I'm worried about, it seems I casted to ULL in error
and the formatter should be %d. And I think we can remove the casting,
just double checked (all compilations were HEAD~2 (so e8c2f9fdadee
("Merge tag 'for-7.1/hpfs-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm")))

Will send a v2 tomorrow with that fix (unless you want to tweak while
applying, of course, but obviously bad practice to rely on that).

--=20
best regards,
max

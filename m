Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C234B147C
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857568; cv=pass; b=NBNHqQ3e43juk10tZdn9Cz2OVrKLJdo4zO5ABArmUbFecGNxwCAx3tFnj4q2+kzXYucwAimiQGIwX52PYEVvKbSKI21iXQUf8KSied7g3fRAhdnGexTtEwPVvDQ/qjZIeWk/15YVF1TSAg89/O3IcRrchKct66KMMzxKy+49IQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857568; c=relaxed/simple;
	bh=7+QAXGzBYBpJzxjDNrtSBQuyaTOBdqxbCzIS9nOmbTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rol/qq5FDduzEShaHt2v0Hy1XsGF7bTYgT+tCzYfQG23BcRnif1QWEtDhg1KgNLjIxh625UdikvSwIuHa9JthgzVA3N6s6DwY7u86w4XOZ3+3KaWTY147vA28j8lS4l69em6R9+BBj0zNKBKBARJgcF6dzc6epoYXurIG3vO7HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWRjHdxy; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWRjHdxy"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2fec39dc7so3212581fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 01:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788857551; cv=none;
        d=google.com; s=arc-20260327;
        b=SWuRngvQ6QDJSu1T5fE6jZNUhYok3yfxKYV1BCsfZS0Oirp7LAplhEOHet9SOMTUyo
         6bdcGHx1IAgEjYTIcPLR+rXPbzaa1kErAK0aoO/T0HsQ5G6fD0kQHKxkavaHYea2UCHL
         3yfZxuKW87POrwoJZ0Nq1lqlrx/tUuv2Ow4laJmZakNz1CkQelD0JGlHANTYhrCPJOyO
         e6ndGaCRJj1lTAEARzPuBv01t2qqf0k/97NmJ8SncDEQuvTseLQXb+qDfrKk4LtwPx6U
         uylu9GuIAyEPx/EOQbHPRF2CGFVyTz9gsENjEgG2JFQpWueLcvorbG7qUxJhyt6aBKWA
         dccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLC2NZjnn7tKn+yLWIbpSK/NQx1TlPN6P03Q7UFQsBA=;
        fh=W1Xy03oGrNh5iYT2zm9qPqxnKiSW+DeulCmV6eEOdls=;
        b=B6sqxmBAdjsgNg2yvIJ+kwXr5ENz04QSHuyI/srLPyqCaXdRq8L90WrlRl+aesp7+F
         Mi8yfV4ChH3IyxauqRk4FAvQx0gjyYA4G8ID4QPmpF7tTPaoThwfcHdvzYONVer51Rqj
         cx3sUBUkF4eZUVBy9BCkmDmOz4di3PMYmoMr9SdzZWS4xZQcT2HVdkZe5C8mtMuu3J7S
         /rNtluwuQywc5Ho7oDkW4gckrE65Zm/7wbp6Lles1Afnhlx0RxqdJq585EdI5cgG68Lv
         PPv7qRK6YWPV5B0KQHR8nBv4hBrBkC0jiqFeOhM4p936c//YkM2cxc5McaO5UtVIH9hx
         OtcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788857551; x=1789462351; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bLC2NZjnn7tKn+yLWIbpSK/NQx1TlPN6P03Q7UFQsBA=;
        b=eWRjHdxy6nw+Fzs4rMRX/CzFap7Ok9eg6MphRqfMIvyTOZrZsklE3U223uaBuiWlFP
         bpt9wGrbyReI3c1DAhpKyUC5mZR9m4iFsDjC4CtlbKn/+649coFKYJh9h2wSs1izb7EZ
         GBdTc3mfScSDm4xudYSs3uRFPfj5MJVd4+hPKe8zTNVCns8hR3Xq+b0V4OruC4KFQp+O
         U3jERx55qe64FmsTHYEQ04aMSZu6KdVpdpOQfaZH9CP5yVhR80I98tiM9YvtdRIem7TN
         Ov+YvBD90qRLM3Nbi6FCxNW0+uyTTFIoWCmLpY/Me47nOQ9EVk6aEz/JSekcHA5nv1MI
         DsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788857551; x=1789462351;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLC2NZjnn7tKn+yLWIbpSK/NQx1TlPN6P03Q7UFQsBA=;
        b=JfyvsuZyCROcwTAfrJI3i3MQ/WphM/WahJZBs51G8lFb5kIifvkNhwupir64AlEdNo
         9gsv2kWnGnC5i+cCT77bp3idQ0Rr8q8qWYI9wYaHXRCXtI12ovjANHw85HRXMkfRSMb8
         1EROFfml5mKPmIkl8M1yJ6fZEAMtcDFDyXydTO4ML6eYzDR7zZRC1r4XausIj1EMrdD8
         kdONDTqDkScUGGqvtsMaC9Ui26IGC4ykamdLneQ7ffncRVn05RwrV9ZKfwOiAH8o4L8V
         Z4AK8yrwOG4jOp8nEtBgojJbqZm28UV7may4lehE5JXuQQSFtJ2Tmjh7821B4jkaOdNc
         7Jaw==
X-Forwarded-Encrypted: i=1; AKwUvBxstH4VdsjB8QTNBsB0xmXRiiwakwXJjnvShVzsLANcoopoZVSNpN2p9XEQYMwkSS0NeSjpNLtbIRG11tZA@vger.kernel.org
X-Gm-Message-State: AFuF++kQuAp8A2/tmGL0iF1y4l6fRcnIHWz7g6HoNRATFqBLN/PYr6xL
	vZq7saovkJ51lmlcYiuau/I60Kk4+CKltjR4MXaPezRbOMDPpmJsdCli1yT+13wO3DCzlCsotu6
	gGruX8YUe1t709pUxb/2rXPeyfZH07fs=
X-Gm-Gg: AYBFou2/hppAbjulMaE/ZUJm7WeEZ6ERKXpyRgMfC303JDZ4+hI8QdYCRGTX96PatEt
	uZba4j0VFBK6Sc+qwrNsi3eLdvPhGAy/kfDkxI+Mm2dHwxJSmCta9arJsYH6T4/TeDh6lhwYBNo
	JvfN+WSnQA8apeJi51f69brRnvq58zmTG9wJisunw0h5AZ5tlAP8gBjVH6WG3X1/qowAWQr3AlV
	iFoNCIbabdhSbtefVuAk0P3iQo7H1754jQ4DXFtPpuGdhswj0He4XrzHWuWCATto186i5DWugTl
	QiFLYtIAmCFHnd1lgkVzCfpNcBdNSFliiuVIdi02GdYuBKiBFY9OalVafV2eN5ddqhVm5TyRu49
	4
X-Received: by 2002:a2e:8a96:0:b0:3a3:61ec:7db9 with SMTP id
 38308e7fff4ca-3a4882d39d4mr5921281fa.15.1788857551247; Tue, 08 Sep 2026
 01:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625031932.9412-1-skyexpoc@gmail.com> <CAOC0qyLj55itFPEurfNddWpzzcPJ4j3bvDxfWBRev_GzPLL+mw@mail.gmail.com>
 <74bcba1c-6bf4-43b0-bbb5-ef2f0490e3f7@paragon-software.com>
In-Reply-To: <74bcba1c-6bf4-43b0-bbb5-ef2f0490e3f7@paragon-software.com>
From: =?UTF-8?B?SEUgV0VJ77yI44Ku44Kr44Kv77yJ?= <skyexpoc@gmail.com>
Date: Tue, 8 Sep 2026 17:52:20 +0900
X-Gm-Features: AcwNN1XHobYU14yAHDwLGyDtqdEDR7tiASY5WHgtvOcElymufa-qIxPZqIfvEDM
Message-ID: <CAOC0qyKG=RG=7Nf0OpTYLQ5QZLhjNUMd2=YGQc4+S_SCoRBbcQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for clarifying. Since the upstream commit did not carry the
stable tag, could the stable team please consider backporting commit
7c4841e2a627 to the applicable supported stable trees? This fixes an
attacker-controlled on-disk slab-out-of-bounds write. My v2 carried
Cc: stable@vger.kernel.org, but the functionally identical v1 was the
version merged upstream.

Thanks,
He Wei=EF=BC=88=E3=82=AE=E3=82=AB=E3=82=AF=EF=BC=89

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
=E4=BA=8E2026=E5=B9=B49=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C 17:41=E5=86=99=
=E9=81=93=EF=BC=9A
>
> On 7/6/26 06:40, HE WEI=EF=BC=88=E3=82=AE=E3=82=AB=E3=82=AF=EF=BC=89 wrot=
e:
>
> > Hi Konstantin,
> >
> > Gentle ping on this v2. It's an attacker-controlled on-disk image heap
> > out-of-bounds write in ni_create_attr_list(),
> > reachable via setxattr on a crafted, loop-mounted NTFS image (KASAN
> > trace is in the commit message), which is why it's Cc'd to stable.
> >
> > For the record, the fix was first posted as v1 on 2026-06-10:
> > https://lore.kernel.org/ntfs3/20260610002929.51765-1-skyexpoc@gmail.com=
/
> > This v2 (2026-06-25) only adds Cc: stable and widens review to
> > linux-fsdevel; the fix itself is unchanged from v1.
> >
> > Could you let me know if you'd like any changes, or whether it can be
> > queued for a future bugfix pull? I'm happy to rebase or adjust as
> > needed.
> >
> > Thanks,
> > HE WEI (=E3=82=AE=E3=82=AB=E3=82=AF)
> >
> > hewei-gikaku <skyexpoc@gmail.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8825=E6=
=97=A5=E5=91=A8=E5=9B=9B 12:19=E5=86=99=E9=81=93=EF=BC=9A
> >> From: HE WEI (=E3=82=AE=E3=82=AB=E3=82=AF) <skyexpoc@gmail.com>
> >>
> >> ni_create_attr_list() allocates a fixed buffer of al_aligned(record_si=
ze)
> >> (=3D=3D record_size) bytes and then walks every attribute of the prima=
ry MFT
> >> record, writing one ATTR_LIST_ENTRY per attribute and advancing the cu=
rsor
> >> by le_size(name_len), with no check against the end of the buffer; the
> >> total size is only computed after the loop.
> >>
> >> A minimum-size resident attribute occupies SIZEOF_RESIDENT (0x18 =3D 2=
4)
> >> bytes on disk, but an unnamed attribute expands to le_size(0) (0x20 =
=3D 32)
> >> bytes in the list.  Because the number of attributes in a record is no=
t
> >> bounded (mi_enum_attr() accepts arbitrarily many equal-type, nameless
> >> minimum-size attributes), a crafted record packed with such attributes
> >> produces a list larger than record_size and overflows the heap buffer.
> >>
> >> This is reachable from a crafted, loop-mounted NTFS image: opening the=
 file
> >> and adding an attribute (e.g. via setxattr) drives ntfs_set_ea() ->
> >> ni_insert_resident() -> ni_insert_attr() -> ni_ins_attr_ext() ->
> >> ni_create_attr_list().
> >>
> >>    BUG: KASAN: slab-out-of-bounds in ni_create_attr_list+0xc48/0x1058
> >>    Write of size 4 at addr ffff000008984c00 by task setfattr/345
> >>     ni_create_attr_list+0xc48/0x1058
> >>     ni_ins_attr_ext+0x510/0x7c0
> >>     ni_insert_attr+0x3f8/0x70c
> >>     ni_insert_resident+0xc8/0x3b0
> >>     ntfs_set_ea+0x66c/0xd28
> >>     ntfs_setxattr+0x4d8/0x5b0
> >>     __arm64_sys_setxattr+0xa4/0x124
> >>    Allocated by task 345:
> >>     ni_create_attr_list+0x188/0x1058
> >>    The buggy address belongs to the cache kmalloc-1k of size 1024
> >>    (the write lands at object+1024).
> >>
> >> Size the buffer from the actual attributes instead of assuming a singl=
e
> >> record_size is always enough.
> >>
> >> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation=
")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: HE WEI (=E3=82=AE=E3=82=AB=E3=82=AF) <skyexpoc@gmail.co=
m>
> >> ---
> >> v2:
> >>   - Add Cc: stable@vger.kernel.org: this is an attacker-controlled on-=
disk
> >>     image heap out-of-bounds write and should be backported.
> >>   - No functional change from v1; widening Cc (linux-fsdevel, VFS) for
> >>     review, as the v1 posting received no response.
> >>   - Drop a redundant self Reported-by.
> >>
> >> v1: https://lore.kernel.org/all/20260610002929.51765-1-skyexpoc@gmail.=
com/
> >> ---
> >>   fs/ntfs3/frecord.c | 20 ++++++++++++++++----
> >>   1 file changed, 16 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> >> index 2e901d073fe9..6488d7a415c0 100644
> >> --- a/fs/ntfs3/frecord.c
> >> +++ b/fs/ntfs3/frecord.c
> >> @@ -768,10 +768,23 @@ int ni_create_attr_list(struct ntfs_inode *ni)
> >>          rs =3D sbi->record_size;
> >>
> >>          /*
> >> -        * Skip estimating exact memory requirement.
> >> -        * Looks like one record_size is always enough.
> >> +        * Compute the exact size of the attribute list.  Each attribu=
te in the
> >> +        * record yields one ATTR_LIST_ENTRY of le_size(name_len) byte=
s.  The
> >> +        * minimum on-disk attribute is SIZEOF_RESIDENT (0x18) bytes, =
but an
> >> +        * unnamed one expands to le_size(0) (0x20) here, so a record =
crafted
> >> +        * with many such attributes needs more than a single record_s=
ize; the
> >> +        * previous fixed kzalloc(record_size) could therefore be over=
flowed by
> >> +        * an attacker-controlled record.
> >>           */
> >> -       le =3D kzalloc(al_aligned(rs), GFP_NOFS);
> >> +       lsize =3D 0;
> >> +       attr =3D NULL;
> >> +       while ((attr =3D mi_enum_attr(ni, &ni->mi, attr)))
> >> +               lsize +=3D le_size(attr->name_len);
> >> +
> >> +       if (!lsize)
> >> +               return -EINVAL;
> >> +
> >> +       le =3D kzalloc(al_aligned(lsize), GFP_NOFS);
> >>          if (!le)
> >>                  return -ENOMEM;
> >>
> >> @@ -781,7 +794,6 @@ int ni_create_attr_list(struct ntfs_inode *ni)
> >>          attr =3D NULL;
> >>          nb =3D 0;
> >>          free_b =3D 0;
> >> -       attr =3D NULL;
> >>
> >>          for (; (attr =3D mi_enum_attr(ni, &ni->mi, attr)); le =3D Add=
2Ptr(le, sz)) {
> >>                  sz =3D le_size(attr->name_len);
> >> --
> >> 2.43.0
>
> Hello,
>
> Sorry for the confusion. The fix is already upstream: v1 was applied as
> commit 7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in
> ni_create_attr_list()"), in v7.3-rc1. v2 is functionally identical, so
> there is nothing further for me to apply.
>
> The applied commit does not carry Cc: stable, though, so it has not
> been backported.
>
> Thanks for the fix, and for following up on it.
>
> Regards,
> Konstantin
>

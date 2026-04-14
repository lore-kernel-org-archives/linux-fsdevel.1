Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5425EF9C
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 01:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776131865; cv=pass; b=sy2tSjP+t/RNeEwKDmU08r7nHjY296fUOiAYblIR16okmQLF01X7uQaqEBzfQCWX6U+gK2fRRh6zV3nEZSlPRm7QvsXKLkwq6ufXO0q5xU7XP/nG4FCvGfEHXxY5AEtedYEL+3VfWvqRccCNZ8K2ZZ3QxZ7rXh2MJv+uuBy2PLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776131865; c=relaxed/simple;
	bh=7z8VPBl0uyEme0x/C3OZ1AuHvf//58bMte5JYSE8OdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuCkvLLDxP17MQYqFwApXAPUYpjvG2k+OVeoNBHQwp+VGm7qsuUvo4QdpzYKSZAdoR5FYbEEb/3Vfct2MymkrvBntIH+Y2cOnwK1TI58E3H6lfcTVsWIdLZApY22wTd1F+S+83+JEdQRg701JSBsnlFMDPtEulknHsg+hcdOKSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ra1wFhqB; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra1wFhqB"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79ea87af213so71439507b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 18:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776131862; cv=none;
        d=google.com; s=arc-20240605;
        b=jigjBbMhbJg1vfJBrLuGrYrX68Ig+QCM7yrB7lKofd2ijtEz7x8KDVugf2DxgyFwI1
         QtV/vwateGuT2e+vh2YRglAl6c8ODKvDqylq8yrugRB6KozYVqMZ/c1t4SDTs+n1VcLh
         tuMNR+1jqH3OjePUu4F+S+AfgKaxnbMi6qz7ryt5ioeDGb9vt7bpKDxbg5bsuW0m7BgT
         XHIBlLzmGfZ/BgwlovOck/GX9ZSjP5cVOnEGpOzkcLiNFje2w7LVQxPOkravBsnR7E2x
         psxvVaOspxIbIzZILJR6vuNSsgzhN/2iVInEt1W+oXDQQKj7h11ioMFIrOzzMx9MzNxb
         JvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M5wP3kXy3jv1Ajs85Ixh4F5Dko192c5SMJqhckL629E=;
        fh=MlhpW8fuQ2EtyT6S4mUxKWY5863yRiCkxdr2GzNv9ok=;
        b=jMv8FINhdZW+A5YAYaQjdMGSGwRrz8pR3c+ldpbmFZWubcUI6snCvrsLVSGROiIQnh
         rpmTmnOy/GUXoph9Gvc0MoB4ZHAWsnUqa/J9HtXZkfIrVVR4nGlxrhFgKA203HXawHuM
         yoRg7zULigDBksiidwF66qqSRtRMI77/Fn7pauwsy0YcP4EGITsGu41Dicx8Z9wTpBT9
         evzANrlnaYutayK31wB/yjKYDEOhYFjL/RwFshFyXSxvyQsRIHtaVMjyjAwG9EfV4S51
         8EfoeEqKf46AWay5siHmxld4AV0yv06WOqLaQpG0CvFcsx3QyBOl9tbooU21U2DcCp2V
         HLYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776131862; x=1776736662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5wP3kXy3jv1Ajs85Ixh4F5Dko192c5SMJqhckL629E=;
        b=Ra1wFhqBojriMnrPRTqicqBDKKSxZ9wEXYQU1zxOIhFX8VVIqMljq6GxyWCFqQCmK0
         Wq0Nmv700MThgs7r02e1/FlUXEhlnMGwvr2yKB8RunbKBYcbsngtQw2ZBc9K0FNq/UhR
         iG+AxAGSA0b5WzpLMc/InDTTAttmIycfiDRSBggfOW6AaZgbfLl74j33hSB/DkeE/2xt
         ZR+/iBzeUJ4/p2wLukok4SHbBQelk5vECEebgEHJo39xwxP+JRvAM2yCtkVbFSLjU1AG
         6s+RYzX02QNNQ/OWIeBWPiLr5iCkVHMo7bBgLy0a8S4gVhz/j1xcW8jHoiyx/n/o2MU5
         Njcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776131862; x=1776736662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M5wP3kXy3jv1Ajs85Ixh4F5Dko192c5SMJqhckL629E=;
        b=lyZXkNgSUmXEjcztYlnJzi35SiQEShZlqy79dgi1PWCeC0PhBY+avZ1Co6HSplA+7c
         pAUTLTiJdoCofAeNworP/Eh32p9i8EIFQQRe10CSjV5PcnzH2BgA8Kvz0szd++uSJetI
         xUznZ85CvZydf8ifp3pVBym6xscKo8uPojbNf1F5CKfEia4T1O0VNPKlAzDlc19FcKWW
         iOABuNTOFjGJXLiAfF44ZHMCFAfxuCaYbjzUGu/FwXjSMyOztsQH8rg6MF4OMUxYp+dB
         GHYWcszN8ryPO4svZlT9QSxkheBKafneN8yQm+4zUSuGHnyW8Ytqg62ztndVC1gUu/Ei
         gxfA==
X-Forwarded-Encrypted: i=1; AFNElJ948sag90nQPGKXTRhiJRqr3ZaaYNVzto49efPAX1TmuUJ++0ipUI1vH1mQ+d7lVNQOJl9e4HlNQ9xlpsk1@vger.kernel.org
X-Gm-Message-State: AOJu0YwCao9AElnEy7Drn6qJGed7lkY2AdvhrRu6XL5txV5mckaXHvfl
	P/lzENzgwZsFxgizR8IzPB3TDnAZvLsR89MMpX6PtbBvF79GSnxRKYZZ74UAiBPj5c2kP8Ccxc6
	nz4aWPldVs24TwSI2oHtF3nJEB4V+ABU=
X-Gm-Gg: AeBDiesEoDesO28/027G3zAVRswl6uDB/xnLK0x7oHTZ1KpmtzdcQzlYfX2JUK01PO1
	sNBwRLa0+/a0SLQiJm/bQodj1imhiY7TyM72yCqLFQkm+ZDFGyR5zQLXtDvAGzsifxOuiMya8At
	DzPUZCI14I5l3TefLBlhSdtan9UBL/oB23yzHYfE64jTimT0p0uLugmTHIqoBfQXanev61QbTgW
	/ZPzK5zM+oULYXi8PpBtQQIrY+nvbp2DCWUZz+iubksk1uqEPv5iH0F7Ti6X5iQhv5owcY30JlH
	lTguc3Vm16giPu9rKfXwn0P3uOFB2bG5/2E0elbtTzPJn9dqzXPjwnVeDhzyp2d/6M8wT7tzakz
	Y5yOSxVZnFwEIMxvXDQ==
X-Received: by 2002:a05:690c:c50a:b0:79a:b49a:cb4e with SMTP id
 00721157ae682-7af76de9dddmr132925007b3.6.1776131861939; Mon, 13 Apr 2026
 18:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414015315.64954-1-kartikey406@gmail.com>
In-Reply-To: <20260414015315.64954-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 14 Apr 2026 07:27:31 +0530
X-Gm-Features: AQROBzATd1u6NyuADj1fnN-gfyWe_rgR1_n9vda2eYJ_W1CAiwAVYF8DxjSoIBE
Message-ID: <CADhLXY583ft1Okyp8y82j4jYmFoJpTN9ikym_Y4ufmy03JwkLQ@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: fix ignored error return in hfsplus_delete_cat
To: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 7:23=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> hfsplus_delete_cat() calls hfsplus_delete_all_attrs() to remove all
> extended attributes associated with a catalog entry, but silently
> discards its return value.
>
> When the xattr deletion fails on a corrupt filesystem image (as
> triggered by syzbot), hfsplus_delete_cat() incorrectly returns 0
> (success) to its callers, allowing execution to continue with the
> filesystem in an inconsistent state and eventually triggering a
> general protection fault in hfsplus_cat_write_inode().
>
> Fix this by capturing the return value of hfsplus_delete_all_attrs()
> and propagating genuine errors back to the caller. -ENOENT is
> excluded since it signals normal loop termination (no more xattrs
> left to delete) and is not an error condition.
>
> Fixes: 324ef39a8a4f ("hfsplus: add support of manipulation by attributes =
file")
> Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc0ba772a362e70937dfb
> Tested-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/hfsplus/catalog.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 02c1eee4a4b8..adbaeabc06ab 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -421,8 +421,15 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, =
const struct qstr *str)
>         hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
>
>         if (type =3D=3D HFSPLUS_FILE || type =3D=3D HFSPLUS_FOLDER) {
> -               if (HFSPLUS_SB(sb)->attr_tree)
> -                       hfsplus_delete_all_attrs(dir, cnid);
> +               if (HFSPLUS_SB(sb)->attr_tree) {
> +                       int attr_err =3D hfsplus_delete_all_attrs(dir, cn=
id);
> +
> +                       if (attr_err && attr_err !=3D -ENOENT) {
> +                               pr_err("hfsplus: failed to delete xattrs =
for cnid %u: %d\n",
> +                                      cnid, attr_err);
> +                               err =3D attr_err;
> +                       }
> +               }
>         }
>
>  out:
> --
> 2.43.0
>


I have sent pach v2.

Thanks
Deepanshu

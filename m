Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608B30EF80
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375665; cv=pass; b=NzxuwewF3TvNjY5h4fEsaahCe+evvFhqWx0UTbmb7iZ1enAnD4b9t3sOzOK144/i3p0V13x/gHt0rbWS/FV49915MdgAn7XmKroM1K9n1F9Pvo0MxoziD4on6obZDyG3Hc2tljvI+tR5IKO7wyD9m2d4nVkT5BtCprD10XYQ+GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375665; c=relaxed/simple;
	bh=IggNetAKBQKzEEO1qCEM7F3MDWMyav4UtNymFmP2+6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOm2+2XLZjptVD5LRZu0OJtF9ATz0En0dhcRCi3HUht1FkWqKZHEJpFSshtWL02eihCLOxMpz663UGdggnESR/HfcoNaF0U+1fZjvV37sWFi8uqeZvYzcJcjLG00K4HRE7X5mogJAH5wsMBpfO9iNCJBx8SLKP5Bs8dK/6lZB9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0x5WOCi; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0x5WOCi"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651b61116caso488530d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 08:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779375663; cv=none;
        d=google.com; s=arc-20240605;
        b=R7FEpYUNuQRJX822p64jlVcBzHe0HNxxFJsOrSUeLGQV/amKKpHyHTPf2QH37gcGPk
         yDd9a6Xzt2CJa4yiJqr2SFnPrlznBCV/YufVHOyUrE4WOdrj8AkxGXjB8hkXFQ8k1dKl
         0w4HKkD1PG4y9ALnzMEZ7CMqCbBUMvQuXUPb5RA6qAiX94LcJD3Ccaz6RH7V+ygYggAr
         X8evWglmPr+xvI7kmliLA8BPiBOHSCcU1bwauMOEIMz6vu2pEb64tyVVSKBinf2BmY9W
         K8nxuR0SrC1vA3LsNmSbys8BRtAu/FOjuYCNYkOdyrnYhCoZ4m6Am6/YF9RyZ+aJcu3i
         +Wzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3fiKRbVFXuwJ0WTbdG7O8TBO7enkQL8sYpoO3gFYEIA=;
        fh=mVJfDuCj0fiY7dYYZRWi37ThBMhGydYZzlRFoBP3DPI=;
        b=ImRj8P41jBwQIHLUPCWSuw5apE1lh1JqlTUUic4Q2pQ5Jt9KZ/9id65FExX2YYYkUf
         7wIxX0euDXK9tUxwl3zk/yeToCkaytmpJtBDUUQCsX21nutpxzEywZwvTGwJZEAIQdr3
         mYLn/wLpccfRVLAWoP3B4J4/MKXMAsgoyRYSjC2WYK58sbXpSv73filOhsv2zFjOhTMo
         B1l6JMS838j4zJCAYlylTs6o/YBbrWZaYxW8rowJ+41Ey16jaYiDuTfLVHcpUnSnb/Pu
         lqhCTnVhP89GAY6711VkRmRrJkS38wEvPGBJduys2qPIQOWHs6qJkp253MjBdKK2K+vA
         a6oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779375663; x=1779980463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fiKRbVFXuwJ0WTbdG7O8TBO7enkQL8sYpoO3gFYEIA=;
        b=X0x5WOCiCzBK/yBrougXYMEd+KhsjKC6ihcDiMXackWBRpoNuufubjHFElArDqwXf4
         zku+Guc7HwIUlJPZ0JyrbQpj5L+tEyC1RrbsnIBwgGgxY6x5wLn7WGadecn1tmYsBU3F
         L4qYpc00b/G34eoxa5h2f7i0IetRSMc1NKKPemRVzz7uzDI6t13hu09jXbrPUtXLRd6+
         Hj+FL65LgcO8lAgCQkl2ydQQS7A4rzqy9xBkPlxDeP11Pl1rlyv3XLI3vfSJvxXg/whq
         LZG7TpqTEt86lPzHh5dAVULFF/gDPRj7Ot4pL4DC25iclTvtuTul1E52JA/aVFVuG+op
         l5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779375663; x=1779980463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fiKRbVFXuwJ0WTbdG7O8TBO7enkQL8sYpoO3gFYEIA=;
        b=FMygf/uIh8/NipZDF1BoWVAl3T9UB017vgb9QQk7BDZ4c2Uh1zgnM8yEJgGzBD1xEj
         lA27oLdkZIAuxn0WWtukBLMQqpD9phVEYZznCPrv3XahF5/SKwkvyAE2mKBIPfA287jk
         yebhzGe6OAxAc8CXKMeMzmAkbNeqVrcHfSkR0fhvq8fUTTguxCpS/e/ZcEKBcrv7lOkS
         15/bvnEj0wWdjbSLJpj8EICztS4StnDkwmeH1c2LmK7kw2RLFW+mI/c2HhRNXU8RU+51
         9YcWc3sBSatWMDXgX+FxvHbm0Y+g1y0vpQnnZwehv00g9vjLcKTDsnEDILZk/2TboOmk
         NyKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vzcGE6NTUMZCwwig1kjZnvy1OPzEiVKgE9Xt3TGBA3DdVM4NbEgR97OBatbYBQ3Mneh4jT9Asdlk/jSNi@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNugD9ZEjJwIDmX7W39MZzCFDHIo5jphucJBx0eXyJ/8JWpvQ
	NhYX1j6elumcYgPJk3AlYMfGLtNqleoHhE/aBPKa7pQy7eXL6wJMV+1J6hq/WYOUITWEnR9Frjc
	2KryWUa+Dlp1Uw5cSdv2SCNf2z/6Zm6g=
X-Gm-Gg: Acq92OEVUVbIIC5y7/NFLbAWgMGfT7lT5Z/ZYnF2unXBKi9gYrf/0rcWDT9ez2mdFsS
	UUZWXIhyIvSPn3ipEWe39iWXve5MBCm4K62acy2+M81IXsAGGrRDkHX2+0sC5M9LfPBz1cWkSUS
	3r3O4l2VKTFOZ60eyvES8YSroZM9bYV7KB9y5mtpLrKxusYR8/3JxZ8h5oOh7+kRrXaj1oGWCz5
	m5iCknCQ7CXGWUMb5suI/h/UKcPwds+McV4fHn/fHOq1+B79NziQ/o5/OxqwYGn5+p3kib6Ng2+
	NvOzp6J8GydKAugpOI9B
X-Received: by 2002:a05:690e:11c2:b0:653:9e2:ec9 with SMTP id
 956f58d0204a3-65eadfc7b60mr1850286d50.2.1779375662332; Thu, 21 May 2026
 08:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520111555.79902-1-zenghongling@kylinos.cn>
 <CAMrLSE5LM1Okkh8zhBH1Pch=JF2U3e+B2H6ZqWo_NRaBcP_uYg@mail.gmail.com> <6A0E603B.7080603@126.com>
In-Reply-To: <6A0E603B.7080603@126.com>
From: CharSyam <charsyam@gmail.com>
Date: Fri, 22 May 2026 00:00:51 +0900
X-Gm-Features: AVHnY4LjiZEyojc_oJa6OmH-mxmvDS1Q88n5EbYFIe5D3hKrfX30NcL7fIsiM-8
Message-ID: <CAMrLSE6xFngy-C9wT4YjRy8WEeTgXT_TwHRSbLYs4gdaobDeTw@mail.gmail.com>
Subject: Re: [PATCH] ntfs: Validate error in ntfs_lookup()
To: Hongling Zeng <zhongling0719@126.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org, hyc.lee@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hongling.

My impression is that dropping the patch may be the cleaner option here,
unless we can identify a real path that produces ERR_MREF(0).

Thanks.
DaeMyung.

2026=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 10:31, =
Hongling Zeng <zhongling0719@126.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>    Hi, DaeMyung.
>    Thank you for the detailed review. You are absolutely right.
>
>    After looking at the code more carefully, I agree that:
>    1. ntfs_lookup_inode_by_name() already normalizes zero err to -EIO
>       before ERR_MREF(err), so MREF_ERR(mref) will never be 0 here.
>    2. Even if it were 0, returning NULL would be incorrect since this
>       is an error path.
>
>    The correct fix would be:
>        int err =3D MREF_ERR(mref);
>        return ERR_PTR(err ?: -EIO);
>
>    This ensures we return a proper error code instead of masking
>    the bug as success.
>    Should I submit a new version with this fix, or just drop this
>    patch entirely since the issue doesn't actually exist in practice?
>
>    Thanks for catching this.
>    Best regards,
> Hongling
>
>
> =E5=9C=A8 2026=E5=B9=B405=E6=9C=8820=E6=97=A5 23:10, CharSyam =E5=86=99=
=E9=81=93:
> > Hi, Hongling.
> >
> >   I don't think returning NULL is the right fallback here. This branch =
is
> > already the IS_ERR_MREF(mref) path, and -ENOENT has been handled above =
as
> > the negative-dentry case. If MREF_ERR(mref) ever decodes to 0 here, it
> > should probably remain an error, e.g. -EIO, rather than being converted
> > to a successful lookup return.
> >
> >    Also, I do not see a current producer for MREF_ERR(mref) =3D=3D 0:
> > ntfs_lookup_inode_by_name() normalizes zero err to -EIO before
> > ERR_MREF(err).
> >
> > The Fixes tag also seems wrong, since the same return is
> > already present in af0db57d4293^.
> >
> > Thanks.
> > DaeMyung.
> >
> > 2026=EB=85=84 5=EC=9B=94 20=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 8:1=
6, Hongling Zeng <zenghongling@kylinos.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> >> Check that MREF_ERR returns non-zero before using as error pointer.
> >> This prevents potential ERR_PTR(0) when error code is zero
> >>
> >> Fixes: af0db57d4293 ("ntfs: update inode operations")
> >> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> >> ---
> >>   fs/ntfs/namei.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> >> index 10894de519c3..bb075aa97b53 100644
> >> --- a/fs/ntfs/namei.c
> >> +++ b/fs/ntfs/namei.c
> >> @@ -236,7 +236,7 @@ static struct dentry *ntfs_lookup(struct inode *di=
r_ino, struct dentry *dent,
> >>          }
> >>          ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with er=
ror code %i.",
> >>                          -MREF_ERR(mref));
> >> -       return ERR_PTR(MREF_ERR(mref));
> >> +       return MREF_ERR(mref) ? ERR_PTR(MREF_ERR(mref)) : NULL;
> >>   handle_name:
> >>          {
> >>                  struct mft_record *m;
> >> --
> >> 2.25.1
> >>
> >>
>

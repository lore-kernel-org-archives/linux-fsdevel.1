Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816D43F7AA5
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252735; cv=pass; b=Ynu4/Yps0ZlDrBYl3kbwyHrqygj3Ws1GYnKaKWnKUcAsySgKa4Qnt33iJNL/oRRkHsp45Uou+5RtIcVABJbhX8ewvq2pLg6ROk0nX0/QusjZY0Q8RvWVZSWMZkAe7oETJUEofA6HGDsKjltfUZ7bSCG5nf+5go+OsdHAQ/35fuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252735; c=relaxed/simple;
	bh=txpzryawrc5SZZAMtz/RKvWscipaA+y5ujDVmyW+sxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRRY8GWAPzVPenOkrAs9adMm8LonUFFS9iRe8ZLXaM+me0ig/4gtfgKnKh26X6KbRTRTxkVsJauThLtUFU/0oxTCBzC9cpBKNgKXibSJVKihhe22j+O2+1PHYMg9s9M9AlgQVZQjvLyx40LRSLck5jhWCoskuxxz69MUWry6Qw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbCAZjFH; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbCAZjFH"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a860667fabso1977858e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 08:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778252732; cv=none;
        d=google.com; s=arc-20240605;
        b=lV/4xPc/5R3qFpSMI+mLpY1QZrpKJBZAvR8QMU02JxO4oEoYa/iCvomN6Bx8xMSSgu
         gUFkdw3vH4CJX4R4YyTsGwgLqq36utTviPGe2n7HeoofKd8CaEOWgb+KUgpuBo3kZmkD
         J2Q8oN47wK6qsRyPddvcOhjPxMH7nG7Dts6uLw/J1RGYddFwGZLvcXQKgnqLnWuumnk4
         APdt6JeK9NDLBB8UpCji7U8ZotMfT3UWuPlupB9f82l5WpQX/RYk1O4W60rq6Zm30ncV
         xhrcDfvYeQcA2Cd8oHZpjK2aLhO3bmJKKxV+lraONgcRT8zLsFYn5wnMqCv6G5/2zie5
         XHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IbYx+g9hs2rSghFOWQu81jAImWPgzoVPpn7nSEiXax8=;
        fh=jj/hLes1ofUoOgk7JXMGUIPHu8keRKfVPAnuzWHWEME=;
        b=RCLhT711cd08rKbJ53eYEpePVlvIeYYdOGjI3LuAKxCk3HtM+wJOSBbhJeUrY9pqsP
         6Ph0DE42iT3pXmLXU3uBQ6zaPjeFepC0IpAfi8xf84aDe7MWJoN+EfHXojfsQ518Kik1
         3TvJ0HR9SJGX54Fil2fkgAGX4+1++WgKLEQBAW3yARmm6axUYmm+n99MjJOsjXRg750p
         c3LYfMaIn/AjIMOsJ5nTNBQmWgKd7GjaPSYAC3GbhXBUXAPiCjmXyIrcxmK5VKbFU3S4
         5GXLkLfSMtcKXxHbjZHgNqzOwyqYnF4lP3jEvBrMFrAHPRJLdjulozqhvnCuKsa1GMZ3
         wW2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252732; x=1778857532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbYx+g9hs2rSghFOWQu81jAImWPgzoVPpn7nSEiXax8=;
        b=NbCAZjFHUfeLFkiEloSXx+94D+Yx5VZ53LmTOpPdyZLOMp3zFERNqCshwbrKr4K+3e
         e91MT8FCUUhNmR6BHqfrQL+uCW+p9+0WLzYY00m+g3SfINXkAj+x7Y0wbH9KkrBHYm8I
         mPYzwHaZjek4uQ91gJFHHjTUC71P17J4TZRPdd0/JrOmbk7272FSAzeeKPkC7jcozsZq
         OSD8DecssUpf5srRlDcW1uNlr7uJc2aXtYzSsDM3hi8Nti1W2RQ9phjRjkZa1md/soB8
         Yy29n44toKlDfOkvHzZ4fR6Av1PpBbo9sUe2SKvii18SuPbZtq11aS93jSY1Us6GuF0S
         w30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252732; x=1778857532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IbYx+g9hs2rSghFOWQu81jAImWPgzoVPpn7nSEiXax8=;
        b=jgMUtGBpuhdot/N2irH+oHGdBsunE0o7ZAMIdkP273/kOkeo3+vRYpVU6TspX8vfTo
         TC57tnqNO1ExXLGI+99ITSjew9ez5JSV4F03BULbIw9ZDtWEsUXrwiGUjGf4HdfPpUp+
         0YvDP7cNevlKctnrRtcfBgWA0i0tGpcsm+yHoHMiLMVssh+83zXgFrLqKAJ98Moup0c1
         3gBwjGBzouQXJpc5P+D8ZwmKtkTbqyikpNdM+oMXm1YB1MuxA1JZ1JJBxb8n+dP7/QDK
         CEYua+0l/wtZr66FWSkDQgUqJpUwEa4gYOpJ5gCz/0lf9Njweod+SEYSHA7GZ6+w/A1Q
         GvPw==
X-Forwarded-Encrypted: i=1; AFNElJ9tu2Iv7O/loTkUkzvKI41tLNn5uZLAsb9pPPG6/3im6iG9ozS35A9LoriL8CM1f3RaOKZ3pkGXlziM3faN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/V85eIdgrDmOyn2s1IGptEKSzL8g8bvS7DQuj5abNXsk1gXA
	On93GJhZTzfqLkbaxu8wQKnbrV72DEDuMqAl+rNSyhErewgri+9OnJo7m5gcQs1eXo5/no6Iq+0
	vHksyu4ESHF5RNItelSB1/yyoQOEe2pk=
X-Gm-Gg: Acq92OEzrSGoavXmPXQUTg/xSKwUBCWfPSpuBlSMZ6fh5NDhYizbQp65lNIwbxcmjaV
	ExxLk5OZdGgT3B7CzpZsEB5QxtDJT6/Sp1MheTbk6KdswPcSnCvEH+nZcxt2YB7M2KSMZlm6LqX
	rJFO+BwEARpd5abSS+nqCCeUXywVU3xI8577b4OSBQ2Qnm8uHNFkB//XJPAmXT0Gt3O/g1wx9fN
	oy7HIvjp1Bj3JTmb0+kA2Djb2j//A+Jt0N+70yGZL/5Oo20zxkqlvjz+2Ph3IX618fhfau18YUC
	U32MnqQt
X-Received: by 2002:a05:6512:3989:b0:5a8:763c:ab87 with SMTP id
 2adb3069b0e04-5a8a94bb9d2mr1032549e87.24.1778252731374; Fri, 08 May 2026
 08:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANFS6bYFbn_z7f3Maxze0GsZbsHnV7kS=q-gLw0U3Bwf+75s_g@mail.gmail.com>
 <20260508072934.75939-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260508072934.75939-1-zhanxusheng@xiaomi.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Sat, 9 May 2026 00:05:18 +0900
X-Gm-Features: AVHnY4KhNixqo4Y_MvvRKLlBzpc6ezZ498aJOHw7jq5xs5BGP2mF6trNNHRNX_s
Message-ID: <CANFS6bagUZ_NYTE31eC-DG03E_W8n=R0qimynxWKad6bMEQ6fQ@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix missing kstrdup() error check in ntfs_write_volume_label()
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 4:29, Zh=
an Xusheng <zhanxusheng1024@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> ntfs_write_volume_label() does not check the return value of
> kstrdup().  If the allocation fails, vol->volume_label is set to
> NULL while the function returns success.  A subsequent
> FS_IOC_GETFSLABEL then returns an empty string even though the
> on-disk label was updated correctly.
>
> Fix by allocating the new label before taking vol_ni->mrec_lock and
> updating any on-disk metadata, so an -ENOMEM from kstrdup() leaves
> both the in-memory and on-disk labels untouched and consistent.  On
> success the preallocated copy replaces the old vol->volume_label.
> Also move mark_inode_dirty_sync() into the success path so that it
> is not called when no metadata was actually modified.
>
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/super.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 22dc7865eca7..ba99c497ee38 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -413,6 +413,7 @@ int ntfs_write_volume_label(struct ntfs_volume *vol, =
char *label)
>  {
>         struct ntfs_inode *vol_ni =3D NTFS_I(vol->vol_ino);
>         struct ntfs_attr_search_ctx *ctx;
> +       char *new_label;
>         __le16 *uname;
>         int uname_len, ret;
>
> @@ -425,7 +426,7 @@ int ntfs_write_volume_label(struct ntfs_volume *vol, =
char *label)
>                 return uname_len;
>         }
>
> -       if (uname_len  > NTFS_MAX_LABEL_LEN) {
> +       if (uname_len > NTFS_MAX_LABEL_LEN) {
>                 ntfs_error(vol->sb,
>                            "Volume label is too long (max %d characters).=
",
>                            NTFS_MAX_LABEL_LEN);
> @@ -433,11 +434,22 @@ int ntfs_write_volume_label(struct ntfs_volume *vol=
, char *label)
>                 return -EINVAL;
>         }
>
> +       /*
> +        * Allocate the in-memory label copy up front. If kstrdup() fails=
 we
> +        * bail out before touching on-disk metadata, so the in-memory la=
bel
> +        * and the on-disk label stay in sync.
> +        */
> +       new_label =3D kstrdup(label, GFP_KERNEL);
> +       if (!new_label) {
> +               kvfree(uname);
> +               return -ENOMEM;
> +       }
> +
>         mutex_lock(&vol_ni->mrec_lock);
>         ctx =3D ntfs_attr_get_search_ctx(vol_ni, NULL);
>         if (!ctx) {
>                 ret =3D -ENOMEM;
> -               goto  out;
> +               goto out;
>         }
>
>         if (!ntfs_attr_lookup(AT_VOLUME_NAME, NULL, 0, 0, 0, NULL, 0,
> @@ -450,12 +462,14 @@ int ntfs_write_volume_label(struct ntfs_volume *vol=
, char *label)
>  out:
>         mutex_unlock(&vol_ni->mrec_lock);
>         kvfree(uname);
> -       mark_inode_dirty_sync(vol->vol_ino);
>
>         if (ret >=3D 0) {
>                 kfree(vol->volume_label);
> -               vol->volume_label =3D kstrdup(label, GFP_KERNEL);
> +               vol->volume_label =3D new_label;
> +               mark_inode_dirty_sync(vol->vol_ino);
>                 ret =3D 0;
> +       } else {
> +               kfree(new_label);
>         }
>         return ret;
>  }
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul

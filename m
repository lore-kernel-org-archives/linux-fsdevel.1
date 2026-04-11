Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE569258CD9
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775915384; cv=pass; b=SZTwITxWGNfimdnG3eyei2Q1IbG9uxU8HvymtldR5v9QLJy0Rpt24qkjMMDP6ri6FyJqOAp++IJxlwFYr5F3fOSJQbC278xrvsRmezSUcO7zwhZ+CjN/Vft9uYLuRFfTY/XuApEhp4+bzmRIgTVGei0TmDJ8M62Mt9WLe0gSFys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775915384; c=relaxed/simple;
	bh=b2ASPSjL6NsYzzQ0ErhmHZ0Qv+cjFrzu7TvEu9Dt8WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YN7sG28lFtAq+NQGWYg/4v9cOlwiFESPRVuFpA/y598zi09g7JAtWD8UNaN9r9ipSTW/yr7IPpK58oa7G/ZeQI+8k8VlsS808CTn68gC2X/SjjXV2Isgi5Wb+qkYMJvgLngjMpqlF+bJAsdGlvKhARSDWar8+xmnRDq9/jYEgoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUXKJpZW; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUXKJpZW"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso428018966b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 06:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775915381; cv=none;
        d=google.com; s=arc-20240605;
        b=VJCKAeFClvEsHQj0KLEdHlJhKTGa+8N0MJiCdgyidkFw+CrwN+xBRaXD7Po2GgxCzi
         RcwLcxF2U4+1o5JDtx7UvTQeZAPGoNV4yIrhrH2lNBgvkVrc925bQOOaxUaXkzuCmsWi
         Y2FIsEHCSivU8B4Ftwlv8FCpIej5DqH5VDtHbOUDWPP0qJ1VCtGQvvAQGBiYP0o7bysO
         UA9J3bEaY0k+Dxez9wMKp1mkfNXngOGCGj5Mccn7iBq6im9QY/bWCSsVCfyw0/yL8n9R
         E8EsV1rfsKhqKtOXqTJx++eneyGrbeDYNikciqhcT40isV7QZz4gy+uPQ9nrPbGWW2LH
         aFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TpYnmQg3J90D/DTbPfZ0SBbeSNJ+Xfr3TwIBHDSwmA8=;
        fh=N8N/G00MLJXvs3fPwUHXrVt3rgeMckWmtpYoABA9hZs=;
        b=OVVSSgc/o5mgWK6LjkamddiSUz+KjKZT2mSWMT83D/FSMRD5T9iukTVcFfuqJKPFAL
         CNnv3A1wde7tekD55n69ObM/SgchfuphMWYqPv1cLyDf2fJvnxijrOTxtDbBPcOdY5vZ
         qLduvWQ7qeoZ/8Vo6MwbKNjOgj1DN2F1POBX4Jkhljv2tWvoJPHJn6zwi5KaDr8auLRi
         f4i9ocomzzpCQgk4kfah6I7sBmg9d1mRsPxQRFYV6BtJs58uoicvAXhHuf7AP6nq3zI5
         rhfJDDrDKD/95DcJOJrnx36lCjJplC6hMhuswHBnDaqOhdwFKaZoByO47EwGZcztIGjp
         aLyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775915381; x=1776520181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpYnmQg3J90D/DTbPfZ0SBbeSNJ+Xfr3TwIBHDSwmA8=;
        b=eUXKJpZWnZi34qPXC5D3SHyVEwQtuYCYtUsddJPZlpEGRgmAypKJAirgr3mZhYDESt
         E4KuwV3LqhWoIYfOdQyK5by6cCmLGeZ/GIFctzZ5V7xpXc93STBAON2F52l1sceMKua0
         7fCTbuGo1GG8fhpBFsUTOexkmEqXWn0NDrOlpiKvmz7aTSmo+YxbaDCGWY78DZDlFPS4
         cu58fXlj9JuWnva+dmt33WWo+glW7s041XGlwbQYV8o9joujllL3CHqVWI22XyobuITf
         20ugIKycCBWPKAq61++lkNxJbz2eR8oNdSJPcAIRsNoIHmohvy5VO4uP30HGww6GsdFK
         dsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775915381; x=1776520181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpYnmQg3J90D/DTbPfZ0SBbeSNJ+Xfr3TwIBHDSwmA8=;
        b=n1PPpVB1PPux4mMZ5J+ntL3P9yB5S5kC3fCCqhyOi1oqLtJ8J0nHiIRBDwoc9saqL0
         2IbUvo6Ln9j3Uwp5MeCAsx1NJn2fE5dh3gIadwTwDakvztuuln6lkp2bkSjTLUiXkIJw
         /uY+zzE1OvYiK4DTj3wFEkQlH76d10U2v+uNKQd3FG/kUb7dOL33IsipX6icsyvQ3HB5
         4shFCq/VmIDJpm5tfNl3e1LtzMK+iG3uCYdQkR6FEYQF2Hi0eFu9Y4tXDCG/CT7doXdp
         kvek84ZQP0sstwqCsyV3o4lkuB2s2nC5JD299rRcyLiaGmYWX6Zky2G8RbOsiqjmP0Qx
         lrtw==
X-Gm-Message-State: AOJu0Yw6jQicd4y7737T7k6BvqJhYfsp+yXlVVOuskQ8duOk3Ku4oXvA
	s1COQLnYjsfhWVDEOiERVbnMxSYYlYD7ykIgpYt9EpuodYrj6kDY78JHnn4vFXezbWcD2GETIga
	si+zXGaHlfbeJ8QZVO2mR7w0QUjklNw4=
X-Gm-Gg: AeBDievs0TL6sGs0SieV3kfmhyHkZ7zWpvGaUxOzHZPRCxpl2OSY2Z410N3pAH9kOv1
	ve+wT8ZMSS+LNqLY6UAOCA6GRhdCLKv9oCjriGiPbGLihd6FjnkMHEiahICCKWdAafXe0EbVR3G
	4gr6U5lbOQGgootBqFWiVV7TFK9N1jlIIsOk1OiB/wM4Hvvhf4b1lySsXMVkEYP6atcEcal3HIr
	p2dJEu8zyKSwl/O1yeXnJ183qLq3vABARhJk9I+BMoRG4e6fUHdqj3pHuX8YUXX3+GVFQkXFXj5
	pTnU1pfVJcpehTDBGpyPbhPkkZXME9tQotu9zGHg4g==
X-Received: by 2002:a17:907:c996:b0:b9c:2f1d:7157 with SMTP id
 a640c23a62f3a-b9d72999807mr273907566b.39.1775915380746; Sat, 11 Apr 2026
 06:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410144950.156160-1-mszeredi@redhat.com>
In-Reply-To: <20260410144950.156160-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 11 Apr 2026 15:49:29 +0200
X-Gm-Features: AQROBzBqcQxwnBuDedInw9EPjIkKKCq-V24XTokpFlh_fmODd69QLr1MGzJWtos
Message-ID: <CAOQ4uxha9ki24wyW1z2AtQJ6kSPgGbSiTaPw7DcBWkhDeABoDA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: fix false positive on permission events
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 4:49=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> fsnotify_get_mark_safe() may return false for a mark on an unrelated grou=
p,
> which results in bypassing the permission check.
>
> Fix by skipping over detached marks that are not in the current group.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/notify/fsnotify.c             |  2 +-
>  fs/notify/mark.c                 | 18 +++++++++++-------
>  include/linux/fsnotify_backend.h |  1 +
>  3 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 9995de1710e5..b646a861a84c 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -388,7 +388,7 @@ static struct fsnotify_mark *fsnotify_first_mark(stru=
ct fsnotify_mark_connector
>         return hlist_entry_safe(node, struct fsnotify_mark, obj_list);
>  }
>
> -static struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *ma=
rk)
> +struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
>  {
>         struct hlist_node *node =3D NULL;
>
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index c2ed5b11b0fe..622f05977f86 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -457,9 +457,6 @@ EXPORT_SYMBOL_GPL(fsnotify_put_mark);
>   */
>  static bool fsnotify_get_mark_safe(struct fsnotify_mark *mark)
>  {
> -       if (!mark)
> -               return true;
> -
>         if (refcount_inc_not_zero(&mark->refcnt)) {
>                 spin_lock(&mark->lock);
>                 if (mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED) {
> @@ -500,15 +497,22 @@ bool fsnotify_prepare_user_wait(struct fsnotify_ite=
r_info *iter_info)
>         int type;
>
>         fsnotify_foreach_iter_type(type) {
> +               struct fsnotify_mark *mark =3D iter_info->marks[type];
> +
>                 /* This can fail if mark is being removed */
> -               if (!fsnotify_get_mark_safe(iter_info->marks[type])) {
> -                       __release(&fsnotify_mark_srcu);
> -                       goto fail;
> +               while (mark && !fsnotify_get_mark_safe(mark)) {
> +                       if (mark->group =3D=3D iter_info->current_group) =
{
> +                               __release(&fsnotify_mark_srcu);
> +                               goto fail;
> +                       }
> +                       /* This is a mark in an unrelated group, skip */
> +                       mark =3D fsnotify_next_mark(mark);
> +                       iter_info->marks[type] =3D mark;
>                 }
>         }
>

Locally, for mark iteration, the fix looks fine, but fsnotify_mark_srcu als=
o
protects lifetime of destroyed mark and connector and I have the eering fee=
ling
that some of that code may be relying of the detached mark to either
have a ref or fsnotify_mark_srcu.

It's not that I know of something wrong, I just feel that I need proof that=
 the
lifetime or mark and connector is not affected.

Jan, WDYT?

Thanks,
Amir.

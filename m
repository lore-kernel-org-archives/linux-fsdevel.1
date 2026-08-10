Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B807B41684B
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375281; cv=pass; b=jIhjA6UCnpTz22sd7f2Wa8NSR3o4xnho37j/ktQaPE9HnwG0BIYtqlVK39PqIU/wVcKQ8R3qkhKUgzpCuugcEeXcEIrEBfaFzAaUHKXftmCSGbwgHPdMH3xrUh8eP3uQKqtCaFfe9MsLJH6mYLQj03WpiFPapLrStCr7jQRTh4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375281; c=relaxed/simple;
	bh=JLiTDeMzBFxSxuaAl7jK76kR0NaXTrM7OrcAC393LLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJ3sHzXEAcXUqONqcSkflOMbBC420QPDRj+ZYNrFTN7/0gAsVRSeVeFllWx5neTfv/83ttjQWhQufXcAMsrxF7G5pcfqASBVwk1AT6QjIm8wVNTR1qLRHYLKh+XsoPGiDPJNGMfY+VpmLXOkmBm8cGBxHunFwOJYPCAyhQoH+Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20251104.gappssmtp.com header.i=@omnibond-com.20251104.gappssmtp.com header.b=ff+eN4yL; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20251104.gappssmtp.com header.i=@omnibond-com.20251104.gappssmtp.com header.b="ff+eN4yL"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb662575d3so1044494a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 08:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786375279; cv=none;
        d=google.com; s=arc-20260327;
        b=ATZyzsMr8/QM3frl0moUgyhMVWKo7djheZqVY/U6+bGQkEohNRjsOKEPwFqavo00yO
         6EbKEXer+eAo2N8s0yyDp7XfOae4zIN8kz65oPD25k4CZ2A1W03QokYs3lspHCOa9V3N
         dUWkBEs5YP22iH7tNxgcOHxIOlbjvR3Z+ci1X/E4U3tM4HEujzoOFztYjqlxOdePJKJu
         vOWNKZqLFVqf/56gcl+1BZPQITqth+JkoHZzpddjB4RoQmG/CcuzJLeAp2Tv23jhhhPN
         6222US0eHPAIE5b3rmzREIMMeF3AknIO2EiJxr7Z0qf+pmrIDsbAXDbJ0F0+OTFm/eKI
         O3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9G+CYtnNKgnDw1sHAAGOMtwcmJJQSss2vs4/7dI/HC8=;
        fh=SYMZWYesQ1yyi33s0QFaSfejPjJQdro8wwAVwZEfkpc=;
        b=rvcpEZSCystfWdSUOZ+KWnmba6StULeJxu8anAClSLSb7d/5StD+PJE9PplC+5Gw7a
         ol9JZwbLsjfJwrqfR+UazoXEi2310eREwzID0l5WVstAzsGXn+sEzQNoeJbMhKRzELQc
         ubx5lhwEXuQqID8+cYEnx0w6F2p0RxfOXE1BCR9DDkM0ZgKbKCOj4ejGHVn4nSTbhoAF
         efYfxzxEfV7aeEO7jFD8jZT6RtEnoUjpoQsBZmE8FU3+PKbmPjczbg9b/Zzj8Hv4aoim
         4Nzaa8K8pZ/62iTYR6sf4SVzSaQAtrRj7SKP5llTIq89e93jAEwE657bdoIIpcXzVqpF
         Yjew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20251104.gappssmtp.com; s=20251104; t=1786375279; x=1786980079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9G+CYtnNKgnDw1sHAAGOMtwcmJJQSss2vs4/7dI/HC8=;
        b=ff+eN4yLzuOlRiegO47s5SrSXesUjQTZMWluVuxuweMQ34/IZiM3HZsNEErp3lXeOR
         Y6VBQpX/GMaos1gcKoWgSWMc+ISWkBAJzFI5t18zM1/wWX4nHpiKwWuf8vXdAN1uvBlV
         nMj69CvA3pzZyQk+edKD2qkOtJqsqKUkYMWckxpubVas9HEk8hPHgP1IMbtjVDx61GHO
         QvlYk1jsBsWSjqD8Q/xcwp5ccpLejW462THAVU/JDLdS+OYZBvqXt8AeEASqZrIk+i1x
         k7QwDFQc6mcTxrDB79VIiYZPjM0NjSBZ/vpFvNf8mGSix30/X1SGBn/I01aOmRf6EuY3
         IhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786375279; x=1786980079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9G+CYtnNKgnDw1sHAAGOMtwcmJJQSss2vs4/7dI/HC8=;
        b=K3X/C7d3KaP5WIsCUNgpiWfeyWcytU+mT4uRNJn0r7XAfS78pOjqpAIVY4avFAE1D8
         Jtzo10pM/KyrOIjlo2KbAaGO1UraU+Z5EmaseR95J46Em54Y6VzO295G95EzH5xkoZug
         +di8mhY9QQAncO9wQU2ZcdtYlw7H6QCbalSsOZzZnv0QoL+M59nAuQl5z52xSEK4whwa
         4ba2or26PCP6ZT3CP5KwwG2jel9yNENs29WQGnpofDL66NtM5+Bc/DtWAeITsmeGX7kB
         1rVzrIm1ydTH3dZmWN5HVIy9OpCne4QfA/x2ezDvVWqZs589IIRgRoVe1Ee9Hg3gsy2Z
         cEDA==
X-Forwarded-Encrypted: i=1; AHgh+RqWuINyQfINAI3YISXyEu7xUfaEsnzJ+ysp8RsVE13mgwYwm/w5gWqiGvk/5dJB+F1UkIn2wmVTcCwRrj3p@vger.kernel.org
X-Gm-Message-State: AOJu0YznUxHtoiiAG7A6Wdi1iM09eo1cLS5e9WgNsS2KPnF7+WIBzrBX
	r1F4mAfhqH6/V0lf0eESmn32/aP/QH0kjRyWH28bua+WjwzEMFJ3f4Y/v7dUr+JERZWjp8mJE5s
	zTFcvJenNHPorbHbP9dfZmGsUFzOMjTlbCYyuTV/T
X-Gm-Gg: AR+sD112shlWB0ev+qZeDfXwo3XkDQxBP1uBpjq1wpbo5sEe8n8RsKXpP5/D8GO1bf4
	bleibLZAEQG70csiIVhDqc47aqL3URYhdnv0UUqGiEdmWs2QBObYpmxIaHsqtkweF9DaB8bReF9
	ya0Z5BjnfUUn5NJtDRvIY3hsBKYD7P7SefqRyFzI91jIgfjz51gj1794U0Tip2meQ9bt4bq+3HH
	+ZoKqi9+Y9VVuIwuxBlrYn4rvaUIQnMipOB2Y56meWbwEnnng+wT3GhhklVIqM7F+ykMlDDLCix
	FXDuxICF+7QIaK7zsSHPBCBZg/VbWanaRV+1LkPiYjUIj6vb/SGLZc+ySWCqpCCaSi0=
X-Received: by 2002:a05:6a21:6089:b0:3c4:2fe1:fa36 with SMTP id
 adf61e73a8af0-3cbadd74818mr37513695637.36.1786375278821; Mon, 10 Aug 2026
 08:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809-orangefs-mkwrite-folio-v1-1-4978a4239475@columbia.edu>
In-Reply-To: <20260809-orangefs-mkwrite-folio-v1-1-4978a4239475@columbia.edu>
From: Mike Marshall <hubcap@omnibond.com>
Date: Mon, 10 Aug 2026 11:21:08 -0400
X-Gm-Features: AUfX_mwMT-SaQdzR0ZfINBTfq178tpFiMr4KWQdIc-rp5PVy-6yaL0TY06ZVgko
Message-ID: <CAOg9mSSHk0eswQ9BdD7K=jutwOXUhAgacnf0tPBRNa8GWCg0zA@mail.gmail.com>
Subject: Re: [PATCH] orangefs: use folio_pos() and folio_size() in orangefs_page_mkwrite()
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, devel@lists.orangefs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks! I'm trying to finish up some stuff to get on
linux-next in time, I'll let you know when I've run your
patch through xfstests...

-Mike

On Sun, Aug 9, 2026 at 4:07=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> wr=
ote:
>
> orangefs_page_mkwrite() records the faulted range with
> page_offset(vmf->page) and PAGE_SIZE, although the write range it sets
> is attached to the folio and the rest of the function already operates
> on folios. Use folio_pos() and folio_size() instead. This gets rid of
> two calls to page_offset(), removing two calls to compound_head().
>
> No functional change. orangefs folios are always order-0, so the values
> are identical. However, if orangefs ever enables large folios, this
> change is necessary for correctness with the current write range
> tracking scheme. Tracking only a single page of a larger folio would
> leave the rest of the folio's dirty data outside the range that gets
> written back, leading to data loss.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/orangefs/inode.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 7143b64b5b25..cd3273c88e03 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -652,8 +652,8 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf=
)
>                 wr =3D folio_get_private(folio);
>                 if (uid_eq(wr->uid, current_fsuid()) &&
>                     gid_eq(wr->gid, current_fsgid())) {
> -                       wr->pos =3D page_offset(vmf->page);
> -                       wr->len =3D PAGE_SIZE;
> +                       wr->pos =3D folio_pos(folio);
> +                       wr->len =3D folio_size(folio);
>                         goto okay;
>                 } else {
>                         if (orangefs_launder_folio(folio)) {
> @@ -667,8 +667,8 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf=
)
>                 ret =3D VM_FAULT_LOCKED|VM_FAULT_RETRY;
>                 goto out;
>         }
> -       wr->pos =3D page_offset(vmf->page);
> -       wr->len =3D PAGE_SIZE;
> +       wr->pos =3D folio_pos(folio);
> +       wr->len =3D folio_size(folio);
>         wr->uid =3D current_fsuid();
>         wr->gid =3D current_fsgid();
>         folio_attach_private(folio, wr);
>
> ---
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> change-id: 20260809-orangefs-mkwrite-folio-ec562f7625b4
>
> Best regards,
> --
> Tal Zussman <tz2294@columbia.edu>
>

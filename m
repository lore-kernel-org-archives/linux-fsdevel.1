Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B23B9DBF
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501325; cv=pass; b=FxDs6DxNpE3X1/juvHMXmTpIL6LJOXZ4HKlx1hXqfzFOWVRvmYVrA9p39/CEE+/Jax7UOY2tXlmodiSCsSvpsfP+MNeu5kIme16SjMiP6x8nZKlRe6SFW+Dons0R5rUdKe+fox8IZ8ozsimMmBQ0sXDtDP1p6T85GHzlUz4LIjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501325; c=relaxed/simple;
	bh=UEXA2jz7/8V+cAKqn+ecsYKqLFIMPeiztSrq0J+wmAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5ePKsxAPCnJvce7PR29tCH/Ldu0oFZ236YhbqKdVGzM/5G2yUnJg5ZwQDcw8eRna/SFrzeU0AX5b+U5zRC/asuLWHOw5YUaEQXsY6rzr6FlpYSy0Zq1tKupWh+QRioVrQRKXUZHQgfNcqq0i+aWrP4Inc7VOTKzXbEOnEXuvRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REXVkRy3; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REXVkRy3"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6ab04bbcc8fso540192eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 05:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785501323; cv=none;
        d=google.com; s=arc-20260327;
        b=iQkjGvp3EIdDpg8EhtQe9iidGm3wUA287gwVcVnq89X1v4DtsKodHuMzfQpzLWM7O5
         tSz3osRV8axxPYVLE6yW0pBF3pci4O6gzR5rm3QZwA9MH26a4ToqEPdemDv0JtuN0sxE
         FMIYLB4ssu9VIQrn6JO9F2xXsXKp2mPJuXOMCw+HakJ1e5QCAgSxrss4jkctmHF2WiGj
         KPPjuRhuVzCYt+5YfJzhAx+A+K3OdJxZNAzLDUzug+gWrDK3y3a0HCha0lPjkR2zTRpW
         dkNmxRkh5oOGoVMR1hz26XD6Vz7UagR92fM3wUo17aeuNYIaLgX47n1idAgsUyKjlcsz
         w5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YFAI/9+RvNlaopRe0SqCEvXX6CBi05C4fAg0TyUNeEU=;
        fh=ZU61PCxGaOWgNFlS89KCH5sdZAFEBkoyEySDA7JVbyk=;
        b=nUGfBLz8tlyeknbKITk7/IUJTMUg4H+6f692QIIwcFp4C96VIQWIghZNKkHyCVhPc4
         PfL5X8N3yruE0HbejqvoXDecUL8UdeHFT9GRdIiyB3xHEQ9ZGm5KI8zln8ecr57haPBg
         sxmCgEzYZRN0LqCs9rtxtVUOTC6L+xLgbGokGc73AuQW/53J7dBnAAmy/Eu2SV8hE8Vb
         HthtmOOoyKoGPkbycS5aljc3I0+N6sk1sMM7snDGK+4I/qX/1Y15CrIpr/CQG8FI9lf8
         aECHgi0jsya/i26pGi3R/LLsO8T1AgcXxGSlvn0iq+HPtofmxnGqCevt1OGXtGj+rx9s
         dORA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785501323; x=1786106123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YFAI/9+RvNlaopRe0SqCEvXX6CBi05C4fAg0TyUNeEU=;
        b=REXVkRy3KxPSPr+1PvDbz53nE/VdaLuOmJyFOcwmV9/GnhNCzeZ+LKuWgCI1kLGTzz
         sA8noSXGop1VRy5mJv/qmiWYoURK89NTQQLd3e8h7t5tyCNKWx9c9b4aMDqIYPu7Ov6j
         w0PXfFUz70YrS2zcA6g05R8Ck+Pllf97q9vn+wbtNLoq48MOhER6RrH62c9Go9fA2Hc9
         IHdp/Kkxh2dsQYLJS7R5ebo3N8cABHgcasxljvAgQD3MMjQgxb19FSEkSnsoXoV4R+ql
         MJu/vwTHzM7ho03qU1J1SCjmcXrtJQ3tXsejZdwt9Jm7K5gw5nQFvzxaykrZr2VZ5sy0
         rnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785501323; x=1786106123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFAI/9+RvNlaopRe0SqCEvXX6CBi05C4fAg0TyUNeEU=;
        b=WxarY21hV6+eoCUlVz4FOi4P5zU7uS5nhafvFFm8Vty5MVcpEhRdSkMQ6DWMN80uCM
         KI0b5SD+9HQFCRnGGBCVwW1ICQ+u8DrirNVFxteZXDtW/Y4Ind+iXPfXecCo3J3Wb3D2
         kVNectkzZ9uYczhIGRm1r7yKzOlm1OpZ7Yp60TDeen+4rHmV4mXbqGxaqH/IqYkTOP8y
         6GecqNgcoZQsSNogbDt9jbabCseZhs+YboCBXbMLkKg3u6hw69Ehd86O9/2GrEj7yPjC
         RTQt71jK2WoE7uFxIY5bElSjXOvnVVH1g247ZnC0SMxO64wwM3dBCWqpr7P8l3qMI6fp
         D9nQ==
X-Forwarded-Encrypted: i=1; AHgh+RpB8OWD3H/LTPweSyGOuqrAH1lzL/nOoctSQB6qhLkfGdpbm5i4PK+fEZ9tXqr8WxGcAK62jtlpFSks0OUQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzzXFG5uGwSzRadBcZsX58FzV8fYQ7UCPT7uSqWkEsJbPn0sndI
	y1BhAp070uOVMSJ4NZPDswLO1gG4flU2p6cw51ZkoqbpU9bJOIf4/No9pFDxvOsiLYf+83ZpF6I
	Irbvf/lmyUL7YsBuR2Dd0AIY0MaVil4dzNw==
X-Gm-Gg: AR+sD12z8DXV8+FI1y5fM0lsSZ0U+aJRHe8AQfkfoPeNIPKW3NW7XN0uFUwBH1fQ1jL
	doGhdkUyLFA3aiCQFnVaMoNQUhGErBVFBM37e/94RUc+hPivBz3OnbQull/WS1nK/dUig2PR+1F
	TkC2Thzj1aJ6ruPFZuetwggTrPkpASbsAULTTPiGCGM0WIdxmmJEX5utt6Ep7OolmrEkkMUswRL
	xrH3jQEVv/cXVKGicUUzeZP2NEHnPqcX3LXhS4qE7IiF2wsRWFdXSsNCIEVpyRYl7u0SNVsElou
	V1GCLEM0seSlbk/N2DnJJGtcFObg0KzR2iTVQuvLnPQ7
X-Received: by 2002:a05:6820:c0c9:20b0:6aa:e252:dc59 with SMTP id
 006d021491bc7-6ae37cf9c54mr1615552eaf.5.1785501323220; Fri, 31 Jul 2026
 05:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com> <20260730221508.3846409-1-cmllamas@google.com>
In-Reply-To: <20260730221508.3846409-1-cmllamas@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 08:35:11 -0400
X-Gm-Features: AUfX_mwlKgyb6AEn20yiXH-27f3TnQmpcyFREg2qUfV_pjvNieyaRo-vjnWDeh8
Message-ID: <CAEjxPJ5PPyM+fkMnLj+FATHtoyYg4TK+tthGpudWnq52GSF6MA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: bpf: check SBLABEL_MNT before isec init
To: Carlos Llamas <cmllamas@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 6:15=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
>
> Do the SBLABEL_MNT check before the inode security is initialized.
>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Just re-affirming my Ack since the patch did change slightly.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2:
>   - Move the check further at the top per Paul's feedback.
>   - Collect Stephen's Ack.
>
> v1:
>   https://lore.kernel.org/all/20260730181008.3654413-1-cmllamas@google.co=
m/
>
>  security/selinux/hooks.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8d6945edae7a..18dd28b2bb13 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2974,6 +2974,10 @@ static int selinux_inode_init_security(struct inod=
e *inode, struct inode *dir,
>
>         sbsec =3D selinux_superblock(dir->i_sb);
>
> +       if (!selinux_initialized() ||
> +           !(sbsec->flags & SBLABEL_MNT))
> +               return -EOPNOTSUPP;
> +
>         newsid =3D crsec->create_sid;
>         newsclass =3D inode_mode_to_security_class(inode->i_mode);
>         rc =3D selinux_determine_inode_label(crsec, dir, qstr, newsclass,=
 &newsid);
> @@ -2988,10 +2992,6 @@ static int selinux_inode_init_security(struct inod=
e *inode, struct inode *dir,
>                 isec->initialized =3D LABEL_INITIALIZED;
>         }
>
> -       if (!selinux_initialized() ||
> -           !(sbsec->flags & SBLABEL_MNT))
> -               return -EOPNOTSUPP;
> -
>         xattr =3D lsm_get_xattr_slot(xattrs, xattr_count);
>         if (xattr) {
>                 rc =3D security_sid_to_context_force(newsid,
> --
> 2.55.0.508.g3f0d502094-goog
>

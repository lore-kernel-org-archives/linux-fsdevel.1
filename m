Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417E438FFB
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778067303; cv=none; b=X8bWGhex58PMWsz4EjXvrIvkIt95EI1FJrCeRWE8UJeaxV1Hn/At9EaxmcQkwkNoeY1YaN0dffYVJOTYTca+HLoZf/sJeLd1OVffeVu4DrXb2gxBo32B3V7Bem4SO3lHaOn4BVm+mprL1jnTLoJJ9QlMFfWdFXzRDmo03e2GIo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778067303; c=relaxed/simple;
	bh=I9lVILlm7BHTqUvwglOwuEOyYxL1cNPl/qBpAYcP8+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzGoEHvY95/T5D6zE3CmlQwc04lFlriorgzuac/epDDCXiAGNRpC6JeKuvcoWxot14ZIzSVmZsjfB1tDgZAcLwRNCBM7jhPOt++6rKPSRMsuHuX9ILTTwQk3FZ5zV71ufx8aR7bjwtCXeRgGpm8IQU6TmTA9GHD+yYTgOSMiIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYwiDxOg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYwiDxOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8549CC2BCC4
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 11:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778067303;
	bh=I9lVILlm7BHTqUvwglOwuEOyYxL1cNPl/qBpAYcP8+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eYwiDxOgJ2apZPsM+eP2uO3fMFZK4MFH/g+QOU3jI6Ixc9Cy9k+3JWNnwzzoCvkVN
	 fKreZy8kwEIvIbZhz3LMqjQP6Aj4IH1ZJnBpHGHY5ujNg4ouYfZZSy2AnDsRGZo2vV
	 rcjTGWKDAkCISSjWM4PMyFsGEMsTDsxGfkOmD2dk9axcTXwEWzQCbdbXzxh3nMopMw
	 zMy04tMwjRoU4LvX0JcZJ9Yi/7xICHXqIMJUBNtfkp+qJUeO5nE1CEnzqx/+4hZ5Nw
	 +m2DSdvWgejQRpee5TqoMcj9CkDQueJlR/0gUQceEC4zRkjpREhuXvmA5sLtPvXWdc
	 3Y5EPPJeYhP7g==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bdec52f48dso9551297b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 May 2026 04:35:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8hQXoSdFN1sZlgenE9+ddvHuivqPko9sYh2AUkbeXFHYiMoIA+uxgMeT8JGiOUL/HB82CFMc8rSBqgZEcc@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8NoCj/zKW+5LMHMNz7g9rvt8re1eEOcYJn/QU1yTprBua95V
	SuXJTsK/vxQlrKB1e5V1V/9qk4G1YgFxKTK5VOaGNPuSWFQZJq0rWaSWauByTbNHJIriy8wk5B1
	WbNWNm8LhDhMcxEfubIQ9KTNAoonFtXU=
X-Received: by 2002:a05:690c:6d81:b0:7b1:9036:a23a with SMTP id
 00721157ae682-7bda89a610emr69009307b3.14.1778067302711; Wed, 06 May 2026
 04:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505130752.3906509-1-charsyam@gmail.com>
In-Reply-To: <20260505130752.3906509-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 6 May 2026 20:34:49 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_ZusqWzR0kvVEfR6cTL3+ut4fKR8eKgz-LeqprKhuy=A@mail.gmail.com>
X-Gm-Features: AVHnY4JqOEVIEr5GaY35T39Tdfk-Lr9bS7CqOuI-6-U25njp8e3yqlGrBxSFGi8
Message-ID: <CAKYAXd_ZusqWzR0kvVEfR6cTL3+ut4fKR8eKgz-LeqprKhuy=A@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix default_upcase refcount underflow and UAF on
 fs_context teardown
To: DaeMyung Kang <charsyam@gmail.com>
Cc: hyc.lee@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 10:07=E2=80=AFPM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> ntfs_init_fs_context() allocates a fresh ntfs_volume with vol->upcase
> left as NULL. ntfs_free_fs_context() unconditionally calls
> ntfs_volume_free() during fs_context teardown, even when ntfs_fill_super(=
)
> never ran or already cleaned up. ntfs_volume_free() then executes:
>
>         mutex_lock(&ntfs_lock);
>         if (vol->upcase =3D=3D default_upcase) {
>                 ntfs_nr_upcase_users--;
>                 vol->upcase =3D NULL;
>         }
>
> When the global default_upcase is also NULL (very first mount attempt,
> or all prior mounts have released the table), the comparison is
> NULL =3D=3D NULL, and ntfs_nr_upcase_users is decremented even though thi=
s
> volume never claimed a reference. ntfs_nr_upcase_users is unsigned long,
> so the decrement wraps to ULONG_MAX.
>
> A subsequent successful mount can then free the shared table while the
> mounted volume still points at it:
>
>   1. ntfs_fill_super() does the temporary ntfs_nr_upcase_users++ at the
>      "Generate the global default upcase table if necessary" block. With
>      the prior wraparound this brings the counter back to 0.
>   2. If the volume's $UpCase matches the default, the match path does
>      ntfs_nr_upcase_users++ and sets vol->upcase =3D default_upcase. The
>      counter is now 1.
>   3. On the success path, !--ntfs_nr_upcase_users evaluates true and
>      default_upcase is kvfree()'d while vol->upcase still points at it.
>      Subsequent upcase comparisons through that mount touch freed
>      memory.
>
> This was reproduced with KASAN by closing a fresh fsopen("ntfs") context,
> then mounting an NTFS image whose $UpCase table matches
> generate_default_upcase(), and finally doing a case-insensitive lookup.
> KASAN reports the dangling vol->upcase access:
>
>   BUG: KASAN: use-after-free in ntfs_collate_names+0x3b4/0x420
>   Read of size 2 at addr ffff888008d40048 by task init/1
>    ntfs_collate_names+0x3b4/0x420
>    ntfs_lookup_inode_by_name+0x1921/0x3130
>    ntfs_lookup+0x193/0xc40
>    vfs_statx+0xc7/0x190
>    vfs_fstatat+0x4b/0xa0
>    __do_sys_newfstatat+0x92/0xf0
>
> The same QEMU reproducer was rerun after this change with KASAN
> enabled. It reached "reproducer finished", and the log contained no
> KASAN, use-after-free, Oops, or panic signatures.
>
> Guard each comparison with an explicit vol->upcase non-NULL check so a
> volume that never took a reference cannot decrement the global users
> counter. Apply the same guard to the other default_upcase release sites
> so all cleanup paths follow the same ownership rule: only volumes that
> actually hold a default_upcase reference may drop one.
>
> Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ntfs-next.
Thanks!

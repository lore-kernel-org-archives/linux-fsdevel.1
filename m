Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8964D346A1C
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100626; cv=pass; b=dhRurXb5I4GTzeZ71yiKVU1ivM3RWpjKB0/bkWmPjTvLEBOBuYGs/0iy8Tq2OF8F2b505swgo4kQ83dtRNBCFmTbfEbvHXwWULAy+Zs9mgsTij5qoGbbhFvMJlZ4ADAdrJdOJg31aWpaG7Biht/9VfHiQlzv1Bohbfqwq2kxjRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100626; c=relaxed/simple;
	bh=Z+b0ZECAqJfNW/F2wJOeNwpfdYXiYK+ERVdEdDe+Zms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GX0oHiQs+cFRrE+6+0TcgOljwxhVw3SavvNRTP2g44GqaOKdzdkC/NVavkOClI6EkUtHgKfCmCbBvefpNUCu5Lt67BHVzGKIfbGt3Dvw6voiJZ0x4JIA5M9p8i8nWFHGu2PUQLRIm3qZmUHm5+PqOQChCRxD39SAw8ZWQQx1LiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mg9yOP+a; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg9yOP+a"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8296dabef74so4726772b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 10:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776100624; cv=none;
        d=google.com; s=arc-20240605;
        b=aEYCRV/7DQGwlh6GJQRIY/WISI4hf0HCUGgzjLdR+lI32AomaJ5nsYhTQrlDSLCKrl
         tNP/rxYnAs/3BiV1LiHRGutoLx59jgbVe91CRQKsaD4nHVo44CgydTJ+CxB7glzTRIna
         YToq9t8EF4iFFzkDlbCnm8jYbfYdQE+XbRW5uuj5toixzKLS0MRv6tnCP5rY/QlGeM/5
         v6PEDBRjMK9pa7i/GcH1+DFABTJj4ZXUCUOqI/EZ3Fr0azyhJfcR3ZUr+A8qQDmLnmGz
         IA8OXA6C1qPsIHzkcPpxafF06Lq48lHkxdlekUVyV7qYKiTOhYtn3MIdhkYcN2iDWe6r
         ExRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BRAbh5NTmH7fPoUJt2iXhkljH90jFoJ00lEuAgJuvXo=;
        fh=g11HIRBYaICwDYymUEqcxECZdifE1n5T9SqvsG1XmSg=;
        b=dfvDvcSHIlD93lG9V0VIggm2qYzg0neusc5r+WsWc9t640zTbdzx5pWDuIoObyn/3Z
         WiN++QsR1tX9EtHXpOfxaMsd5Mo47ym4bnFpEFIslivEfQFCvtjKW0Se1X+qihI9IFjp
         dzAlEvJRvRKZtd04P9Oj123hJwdr93fxYM+K4kYxjD6xWAft6doiCI+3Nwo1GMwS3qsB
         uB1TYJv9uvV3dELfej3r+2N3ZrUgoCW1ijHAEr4bpA/uP/XqqFzhlreHpNVDhAIk4dnQ
         Ztx6NMXdZHll3Lu3vAN8U+PNt0qPcZ03wRwBlQO5qGQ5xMLyRAPnmDCi7WAOHLicsUum
         YCrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100624; x=1776705424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRAbh5NTmH7fPoUJt2iXhkljH90jFoJ00lEuAgJuvXo=;
        b=mg9yOP+aAdi9JL4gAaBghM3CSTkqAHQhe/NqMu/v5a4EKu/UYxDhF22zW2WGJXB4vb
         7LtCysAvS5QvrEo5JrbLKKiepmxSwrWwJgDdC8oRD/7+0RVe2pGDnXlFpSCsQ+DI2VFm
         /SSljwPCGkOSp29sUFIycWEWEbL5TqJkGAOrPq3OlOzuBiNaAE5JAqTQ3S/buc92OKw9
         TLFzsW7lFbsAaY3UpljzYcaG88O1rqy8VwHK1WCUnoUqtpfHVQhAcU7iGYHHUW3s503d
         hcw3gKI/ykxXG8EdqTOEu2IDAK8yf1uagWc9i6pWdM0eRTr+pSXt5nqIKBxCIy5KorQn
         Ua6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100624; x=1776705424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BRAbh5NTmH7fPoUJt2iXhkljH90jFoJ00lEuAgJuvXo=;
        b=tTg9fhTi8cFr/b0xpyXBIJrYmsa0Mf10BoreIUqTnNT/B1b3baIhfeO05VP7LMxByW
         /qtKy3ySZVhGh03fCbOCS9g5fitDSmyOCV+R1MsxgtavKoktEeytyvuZRbsF80a0KH99
         3UCzd9tXF4O4sPeCZ2FFSFRpVOxrNMW62BagTy9JRub/9a0xefBnxM+FH0/uCGtYUFQC
         dFLEGBzoe6knWiM8iTupQaXJUNBK/PaNGRCE4p+VCL4p90mkqLtV5xU5fkNFzIkcAXyd
         p+eMR3mq3MADZw4HvRdMzhb1FXW+MlD63xfIfJOWDnuXlwOiLChtTRxfi9baNdyRWaBv
         J9iQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ynEb960JhwCek39UcnO0TyvkQFRohMgVrMMHq89Z8Qfah2fuTOCm1HtMHG30J+Owr3O/OglKwUO7/NMk+@vger.kernel.org
X-Gm-Message-State: AOJu0YyruS+2Py57SuGUeWoGAFdLgUzZt8Ibli9zBQhs0eTL8P0XcxVA
	xqNv1tbuaIeIKCkjW37pC9QJTunqZfkKuZSYeM4kGFLQtP8GLQ/90YWPECrUXI3+QbAQ3U8f+Kz
	s49JmJhB/sSCCJP6sIYD5U2bjx5wiE7Y=
X-Gm-Gg: AeBDievAy894dsIDCwOWp7d+s8wFWK4k4XekV46jZAg1zrGauJ/i2PkXE8/twlLNm6e
	lbJUKT4gbwsknX4ABSwMXc897mIJiYB52EZ1pQBTl/mrDUg0ZYjdDfZJJpuaoX/W6VILBdSvbhx
	uJskwB3TbpVVpfZhSRiTRqoB8+rXxdAqWjuXMwKpm6fd7ntG5VrvZ9T0wpMcZhF+fyZgnZorZXi
	czxTCJgW/M/YdzxJnV/xcMzEnROdcipHJZCLhyRUmXDOC0a3PqMRMoOqNhUqtE2OioHAI18DuPN
	a5DUklY=
X-Received: by 2002:a05:6a00:1f0e:b0:82f:5125:a327 with SMTP id
 d2e1a72fcca58-82f5125a71emr888914b3a.27.1776100623918; Mon, 13 Apr 2026
 10:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <20260318184400.3502908-5-song@kernel.org>
In-Reply-To: <20260318184400.3502908-5-song@kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 13 Apr 2026 13:16:52 -0400
X-Gm-Features: AQROBzD6lyXWHoKW5RWqw1gdlCZn4rvcVErICJ7ENPulk3A0gDivj2NjCp7Gp1A
Message-ID: <CAEjxPJ5iDbnZj9gXb=GHORoXGwRP4EG0yUEH8MPmGqJWZEONWQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] selinux: Convert from sb_mount to granular mount hooks
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, john.johansen@canonical.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 2:44=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Replace selinux_mount() with granular mount hooks, preserving the
> same permission checks:
>
> - mount_bind, mount_new, mount_change_type: FILE__MOUNTON
> - mount_remount, mount_reconfigure: FILESYSTEM__REMOUNT
> - mount_move: FILE__MOUNTON (reuses selinux_move_mount)
>
> The flags and data parameters are unused by SELinux.
>
> Code generated with the assistance of Claude, reviewed by human.
>
> Signed-off-by: Song Liu <song@kernel.org>

Not expecting you to do this, but after this lands, I think it would
make sense to revisit the SELinux checks and further specialize them
while providing backward compatibility.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com

> ---
>  security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d8224ea113d1..415b5541ab9e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2778,19 +2778,37 @@ static int selinux_sb_statfs(struct dentry *dentr=
y)
>         return superblock_has_perm(cred, dentry->d_sb, FILESYSTEM__GETATT=
R, &ad);
>  }
>
> -static int selinux_mount(const char *dev_name,
> -                        const struct path *path,
> -                        const char *type,
> -                        unsigned long flags,
> -                        void *data)
> +static int selinux_mount_bind(const struct path *from, const struct path=
 *to,
> +                             bool recurse)
>  {
> -       const struct cred *cred =3D current_cred();
> +       return path_has_perm(current_cred(), to, FILE__MOUNTON);
> +}
>
> -       if (flags & MS_REMOUNT)
> -               return superblock_has_perm(cred, path->dentry->d_sb,
> -                                          FILESYSTEM__REMOUNT, NULL);
> -       else
> -               return path_has_perm(cred, path, FILE__MOUNTON);
> +static int selinux_mount_new(struct fs_context *fc, const struct path *m=
p,
> +                            int mnt_flags, unsigned long flags, void *da=
ta)
> +{
> +       return path_has_perm(current_cred(), mp, FILE__MOUNTON);
> +}
> +
> +static int selinux_mount_remount(struct fs_context *fc, const struct pat=
h *mp,
> +                                int mnt_flags, unsigned long flags,
> +                                void *data)
> +{
> +       return superblock_has_perm(current_cred(), fc->root->d_sb,
> +                                  FILESYSTEM__REMOUNT, NULL);
> +}
> +
> +static int selinux_mount_reconfigure(const struct path *mp,
> +                                    unsigned int mnt_flags,
> +                                    unsigned long flags)
> +{
> +       return superblock_has_perm(current_cred(), mp->dentry->d_sb,
> +                                  FILESYSTEM__REMOUNT, NULL);
> +}
> +
> +static int selinux_mount_change_type(const struct path *mp, int ms_flags=
)
> +{
> +       return path_has_perm(current_cred(), mp, FILE__MOUNTON);
>  }
>
>  static int selinux_move_mount(const struct path *from_path,
> @@ -7449,7 +7467,12 @@ static struct security_hook_list selinux_hooks[] _=
_ro_after_init =3D {
>         LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>         LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
>         LSM_HOOK_INIT(sb_statfs, selinux_sb_statfs),
> -       LSM_HOOK_INIT(sb_mount, selinux_mount),
> +       LSM_HOOK_INIT(mount_bind, selinux_mount_bind),
> +       LSM_HOOK_INIT(mount_new, selinux_mount_new),
> +       LSM_HOOK_INIT(mount_remount, selinux_mount_remount),
> +       LSM_HOOK_INIT(mount_reconfigure, selinux_mount_reconfigure),
> +       LSM_HOOK_INIT(mount_change_type, selinux_mount_change_type),
> +       LSM_HOOK_INIT(mount_move, selinux_move_mount),
>         LSM_HOOK_INIT(sb_umount, selinux_umount),
>         LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
>         LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
> --
> 2.52.0
>

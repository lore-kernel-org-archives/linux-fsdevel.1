Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C312DB78B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778047067; cv=pass; b=PdZO/fCryRhRYKHt+YD1dxtffGH/SsMqXoyJOwnY/uLQ4A9AtTdhIAcuto2Mt9h30yrjbaVikJ7ikqDHjeZ0q3bYoc5jcWzgKsdGdyfQuGFv2O6fcbD2qVXaKsLAVgFpFPS4b2nsjhyS6n1u0J+sI0KfbbxAuh0j8fPgemWl4fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778047067; c=relaxed/simple;
	bh=9Gz0VXEYz8ivrvRk4N5fyzyfNAsEa1NrfoP6IHnNU1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIi3ElAkYezztrZcxLteYjZB3iZqoI9d7l87im2ilEQPLF7zhdDqM3i7D1ScW++pxx5A6FV6J3Dh9F22hn9AkxejHq0FVngzur8RrET/nzx2qDHR6uO75AaC2y0EgPryQCl39VBIaufPk2s8l6EcmtkIM5hPlM4bJ25reGjfmBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnRos5G1; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnRos5G1"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e5eb0fabaso66298151cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 22:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778047065; cv=none;
        d=google.com; s=arc-20240605;
        b=KGyAqEmFzuaLcIfClIloHQ+V67B/kW0aeaEd+AgCzGu8BhjyQvfAyE7UfO1DDfAO4+
         UmR76bBdRQYv6ZcUNIp3qOA2u6Nu3EkBnUECwhDIKHIvceaYVXpUlgI7cROzPNvFyFJ5
         XhbdvA+s/K/DcvEr4YXbdD4Cvqx/F8hQemPm8F3ObSut5raMBXqGYsOCL/P9ynUfZKpG
         j9RJWCJce2xp9bIe5D489TWTJ+ykKZMlO0qVKdfX2DdvqXWNeA7tSiKTLEOH/xd1xxn/
         hDHbjQOIbMOrVNR4sRh2WukqBld/sV3VZ1MnnPk807kZDSVQzhdgtgy2p0E9IDvEKyFJ
         5Ckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6u5hAe2UWqlYycomVBABPtKgFySJnWOHi3B83Oe9m/M=;
        fh=WK3iQ2jfMu/W7U2Qx/YH8iZFJqw8f6S6BGMYi/2fJpw=;
        b=GtIaM0IRZFYiUYEBsDZeb8rW/62N0iG+MzlDnMNEF0y4nzZcNEFLqrrUFCN4/Z0iZf
         1Qce6ztPP3lblEU/4N9/slgaQntQJbHf9nFofQltvFGe3mHXYEU7Ug6JhmJxpFswHX2w
         d96pHWD+EsY5eViEqwqotc71P9o8xsZ8Nh1bbnV/STbDwiGNDRP2ptu4fuzAFDwhNoiT
         y6sHFGpYc/zJm0s4CKlyUjo5I2gCB7RFr0IQhjuv0rYA4fVUr0iWtUoxhmdkCKwhnCoS
         625RmMxpkk6yqnelzWiBcXfebYi77x4i3oWRctr297aigaydBVvNHaalFEhmELUxQ5su
         xLJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778047065; x=1778651865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u5hAe2UWqlYycomVBABPtKgFySJnWOHi3B83Oe9m/M=;
        b=AnRos5G1DztfJbIAEEYoTvRSu2yUsYk4sFvzM8IueC5omPYV11KkNHOAXyPv28fzU8
         px83X70BJEqJKZNO2C14HBHBRiqYDanVzW//0XGZq4hj9ONZ1gwaD2LJukUXKwdJyDOr
         PU/XggbIdB4cczMqnzILEkdwYF0RTiYrgDSYD7pwOn4rCrmhiENbMMyQpg4rNPcqPLGQ
         i9HrSrK2wA3qAPd/5FzlxD7N0SjfA0ApMg6a5RRGsIECLbr17mjbCSDQoPUqKRE49R2o
         J63hdtuY6KBXJzmvjvXLt+hQrGeEt/RswIi0PC0I7Yv2EJgwuZxR6IwVDsvfk8uIy7Mr
         dNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778047065; x=1778651865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6u5hAe2UWqlYycomVBABPtKgFySJnWOHi3B83Oe9m/M=;
        b=gjBjDfUbhE4kXO5x58wm2yPSze5VYeNfRvnHbXuJ1xMUFZm8wsvZbu1elxnshOrx9f
         m5hb/sLDWd9FmY2XgHgqyreZsq9PUyoIqJhQa3tWsk+hyAqvQAaF6liAxCKNbLITeu/k
         rX7g+H0zfaYzVN6c9c8YvPINXPUlN1NRChCXrV71kT6WDQjqbH5A0CMZkpWyOtyNBSDa
         xNhbWi/jTh4pzD6rwIDWtgJRQ5jJfN6X+pjztgWGIZSzZ+5XLEbGuYG31mSoIqHuz+IO
         Tjo5CLceIMu+dX7/Ej0MjvU1jMrhMZlrK2l0x8n5gLi+CdKaHzNgd3+aDnUEx8Ct+UDk
         lYGw==
X-Forwarded-Encrypted: i=1; AFNElJ89zPBsV8unsrsMa/AaqGOYkrxk79+cFccuTH1zfRsedfdVrKQyc5OUiK+vK1191FBLAhD1ie6qKSbuXVzV@vger.kernel.org
X-Gm-Message-State: AOJu0YwGbn5IvbyQJ+s1MDg0EpR86/3mvmB8n/fM4N0yt4+2RL6ZMQal
	iAAFftkzpFMnZun36i1iXdgRxvrai9bA1sl4jdkAodFvnXOI3WP6FSCce8yAH2i4c4DLmlS014V
	CHl0riNB84VI9VQWX8VcUffjZ32UPaX4=
X-Gm-Gg: AeBDietkBHU0hy/ux2rudjpHu5NypqjWAx1G8FsqdNOXU/s8aSJUIii/JS4AXYKyGzM
	PGjT+rBjJlSojBBmluq2C+bLhE1VDj4qPqAxBv5UW73a8GEVfgutLZIHHu+VVf4qL3uREUz7mN9
	vlFlGERjLHtQp6bRB0Vyusx1+Jj4jAH4MzQkqGsT2gJBOAQC4o3kniLUsikIIxkXSgvKQGrn/gi
	vwqFkI8fKUXN0l+1VPYRor1y2aPXe4rFKZQH0optXz1f/KBG6uKrG1VLaZWe0hmcvX83Ej9OXZi
	TNNkoegHQB1Rmsa5Qg==
X-Received: by 2002:a05:622a:8c3:b0:50e:5f71:62c3 with SMTP id
 d75a77b69052e-514621dffb4mr26141841cf.42.1778047065414; Tue, 05 May 2026
 22:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505130752.3906509-1-charsyam@gmail.com>
In-Reply-To: <20260505130752.3906509-1-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Wed, 6 May 2026 14:57:30 +0900
X-Gm-Features: AVHnY4IkycZoRvs2jj2zPq5dtqOglkwPu1xkSJnR-eU0yuteCGg-cbo5luowNMk
Message-ID: <CANFS6baeiT9Lagx9z6OOaXXtcna_fKuHKfT4=4fM7JwT-P1V1g@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix default_upcase refcount underflow and UAF on
 fs_context teardown
To: DaeMyung Kang <charsyam@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 5=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:07, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
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

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>


> ---
>  fs/ntfs/super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 22dc7865eca7..e9de84fb8297 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -1671,7 +1671,7 @@ static bool load_system_files(struct ntfs_volume *v=
ol)
>  iput_upcase_err_out:
>         vol->upcase_len =3D 0;
>         mutex_lock(&ntfs_lock);
> -       if (vol->upcase =3D=3D default_upcase) {
> +       if (vol->upcase && vol->upcase =3D=3D default_upcase) {
>                 ntfs_nr_upcase_users--;
>                 vol->upcase =3D NULL;
>         }
> @@ -1701,7 +1701,7 @@ static void ntfs_volume_free(struct ntfs_volume *vo=
l)
>          * the number of upcase users if we are a user.
>          */
>         mutex_lock(&ntfs_lock);
> -       if (vol->upcase =3D=3D default_upcase) {
> +       if (vol->upcase && vol->upcase =3D=3D default_upcase) {
>                 ntfs_nr_upcase_users--;
>                 vol->upcase =3D NULL;
>         }
> @@ -2494,7 +2494,7 @@ static int ntfs_fill_super(struct super_block *sb, =
struct fs_context *fc)
>         }
>         vol->upcase_len =3D 0;
>         mutex_lock(&ntfs_lock);
> -       if (vol->upcase =3D=3D default_upcase) {
> +       if (vol->upcase && vol->upcase =3D=3D default_upcase) {
>                 ntfs_nr_upcase_users--;
>                 vol->upcase =3D NULL;
>         }
> --
> 2.43.0



--
Thanks,
Hyunchul

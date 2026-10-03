Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51A3AE704
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Oct 2026 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791031939; cv=pass; b=iXxTpp493f442K3eoCmpYhek4CuwHxJ0bfG39GD7OxVjRDu/Iimrk3MWZaC+QiV/KaeQGhSdvKy7DSNgYhVQmyBvVuo9ZRhi228MnCeZzqz2kh1GYJgRhYyfCWOc3oUTF+lHWVQ738uIeMD/h/h7BF48YMEK7EZK9WKedRH1fys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791031939; c=relaxed/simple;
	bh=EMg0iZLqE1q5GwPhLKtP+vs+jdaQ+jYCv0GJbajIiKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzNOY/gLoPUb+71vHwsbCZBfTX6gXjO51McmJbiRilmuwVmUNjMQZwvsGon6i/yy7RRRsbkUDESzzBJKHGzcDCBuryfZ7Qmkd7UYMXMiqN0i1LZmAyB7op7Ld9JZNIH0/sKs1ElG+mSiNueVQfVKz+ksqvKurXHtSVQ8FitPDV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgazUr6K; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgazUr6K"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so357092a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Oct 2026 05:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791031934; cv=none;
        d=google.com; s=arc-20260327;
        b=U6zSvFOumIpi3yjAFUJZ4JBU5qgVm8VZ7ktMDb6VTjfl4aYCYLWcFvJElJsqISdz1m
         5XbOq1wBsMG82fTJvHmahBwICih+4Gn54PmPeuasIwYIasNuNEGxpaXkW0Qi0k3+tqvw
         0aoGSY0lvo/89wy1D/T/z2p90CtH88GK3m0uAGFNvtBt9D+U6DHYhJTUqlpRBiMhWkgf
         zp7fJOoNAJCTv+XVxyYeD7H0eBd0FOVdAslNSL95U9dm27RHoqY6a0Eu6HwIrAVbx7ZX
         h3RrdZW0+6GXyTPpe149SBv0tRUDozfXBEgpGdshC1nHOOMFc88UnecBooGXrrrv6Y6s
         ckeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jC4QXmzH8+Kbh78tKNullBc08DCcnSBR6lcMVv+hZK0=;
        fh=dfWgoPLr6/5nX0xKjrDfL/iFWjWYmDaYQ6XPLni/VaU=;
        b=Rx1WzVPHPrcv6KkKxJbpAHZFxC00O+LalRP+1JtEDTdu1iMyF1N004m/UZyv9qT0Er
         0BGpyhoMqi7SQ9T3rAeGEPf8v/YJjvFT8C2S/0jJNNNM0vvwUpBzZTOZpMjYiuSox3eb
         tmw9O18Mx6Sx4aXHvNBjYbSaWaHXoWbn7yNi62jkaTkm2eM3Ojt3HC+J4W2P2DFkGtX9
         eeSF3gHENcAh/hCrK2Ds5WHQdzYcqF60Ch7i1E0qFUK2SDv6cSUnqezBtGU6AWHnRlzR
         l7PeuD4W+e3WBBDY1bjQP1BbEEUt0sSYTGqE70MAoVrqsl6WU4KFF7kiH82+8QWeqRJ1
         mQlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791031934; x=1791636734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jC4QXmzH8+Kbh78tKNullBc08DCcnSBR6lcMVv+hZK0=;
        b=kgazUr6KrvAYhpdpYLgaRVPwJ0GuFXh9eDKZzSqd+NR2KJyp2Licwbxz8/zjKoiohK
         EtmjhZvbpuQWGKnpBg2vBFJfzWuubFyyGlsUZzRWKqv5cu7tEjSxq6KG+lHnjbcKnSLu
         rxz1MFZ7F3Z6rGlSOyLONwcMexxlAMtmDqsLV7siiCDaZ3aL9gqAUs2rL+fvh05CjGUk
         hPv0UMJ5qCH+1gC+1Dlw2LL1tqJODv9PF6gr5mHXoCt+6hxYLIBACNFKefJtct4rQMSL
         Gjld6NmtJFeA70OXGKkC3Lb0AUwI4ahWfWECxYp2nyv0PpCraN/U9AIoS34tgpddOygW
         wgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791031934; x=1791636734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jC4QXmzH8+Kbh78tKNullBc08DCcnSBR6lcMVv+hZK0=;
        b=ALS9qsaWoptBpV86YldB28VIK5kc56x+kAmNi6q9/1J47ShDg8q69IlMI2jVGttHHQ
         BKQIfmjbHczmmhpHRyQG15M+JhzxNisAaVtrG28Y0w3HtWdeI1ZxbwEocDvP01a4a3B8
         dhthzvEJ4Wbrn8JPaerCaD3GEJafWf9NtiR5+ekEUl0YcpOdsukdubZ6elguAFOyN1AX
         n4T49yvpU/XoPV6ZZrKkLZYVS3dHRQQkC94Sy37EGRiHKa/+oMVSYeo5e1DRTZmaWP0m
         wvqZhORxUVGiaO78ml5YUsfECpxTy2nVlyS46DZW5EhhyiPJyqp5OLEdn5jZpxvzsaG+
         XorA==
X-Forwarded-Encrypted: i=1; AKwUvBwgs/8jvH37iUZpyEb4SWQbolNc/b+qZUV0ORx+eyXyBFyKcLokmeM0ZmcjpA47liv+FhIf3MDv94c/hI3+@vger.kernel.org
X-Gm-Message-State: AFq9FYKojg8m3DO8Fr7Lm4D7s0N9i9xvlhZqUoY8/RWxodgAqbPhpqgS
	1MdJnSU6RxxLv2F9lZJDKvsM6PAPBwQkUXn5SHuzk++BsxQ3QkTA0esnjP3FvhvndfUOjY/fw0N
	Oz309WJ+gdjdNf8R7ZFz+wBPTIlYjAyk=
X-Gm-Gg: AYBFou0qKoJZ0WqGO7kUyDiwSAuYfQwNZtn7un5prRjcx3S61X3ffVbscNoT06AYoOl
	iEvLd2JXotfBtmU5ZxhyyHWHvXS6p4z1zKs2WCSAXjCyvZqOCpus11KCOp7Xw1d8++/0Fb1xaR2
	hI+kyM+CbTHH26N8D0mkPFOFVnD10e1kklOXcK+yQ/F5CmexaE0IOAG1EbamQbTMnl9J5dEg6Ve
	FmwJaM4eskBvNxxqWAf3kndUHLd3ZlMNqivGuIMWlSHNBLwRjJhiKdbsx39IDOmCZbaqdId+RGf
	13qH5G1MC7d4Mk8I2mmkBelJA3EZfd2bvHGjF8C8gF6xjxxwxKBcF79itQ==
X-Received: by 2002:a05:6402:438c:b0:6a9:ab6a:640f with SMTP id
 4fb4d7f45d1cf-6afada27183mr1987242a12.37.1791031933759; Sat, 03 Oct 2026
 05:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002223746.3248726-1-neilb@ownmail.net> <20261002223746.3248726-4-neilb@ownmail.net>
In-Reply-To: <20261002223746.3248726-4-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 3 Oct 2026 14:52:02 +0200
X-Gm-Features: AclHuK9ISQ-1vvQI-BXB_46po9ulhXoF9Pdu-FZttgWgTuI6ZQiJn9eAeFPCxrc
Message-ID: <CAOQ4uxiBf+4EJak7r5440oHuvxd4FZKE=9Je13N8zTNNZCDJmQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ovl: provide private lockdep class for dentry->dep_map
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, 
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, Jeff Layton <jlayton@kernel.org>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 12:42=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Now that d_alloc_parallel() locking is tracked by lockdep, ovl needs to
> take care that it doesn't trigger on deliberate recursion into
> subordinate filesystems.  As ovl can stack over itself, the use
> of the per-file_system_type d_lookup_key is not enough.
>
> So provide a .d_init() function to update the map as it already done for
> i_rwsem and ovl_inode.lock.
>
> Reported-and-tested-by: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@i=
ntel.com>
> Link: https://lore.kernel.org/all/e3772a51-eabc-4c31-b73d-f3187bf1b3b2@in=
tel.com/
> Fixes: 59492f9991dc ("VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP lo=
ck.")
> Signed-off-by: NeilBrown <neil@brown.name>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/inode.c     |  1 -
>  fs/overlayfs/overlayfs.h |  2 ++
>  fs/overlayfs/super.c     | 19 +++++++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 401cb8c75520..bf40198c8b8a 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -816,7 +816,6 @@ static const struct address_space_operations ovl_aops=
 =3D {
>   * - OVL_I(inode)->lock                        (ovl_inode_lock[1])
>   * - upper_mnt->mnt_sb->s_writers      (ovl_want_write[0])
>   */
> -#define OVL_MAX_NESTING FILESYSTEM_MAX_STACK_DEPTH
>
>  static inline void ovl_lockdep_annotate_inode_mutex_key(struct inode *in=
ode)
>  {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index e0d8c6152e9f..64cbe4c4bd3e 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -16,6 +16,8 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt) "overlayfs: " fmt
>
> +#define OVL_MAX_NESTING FILESYSTEM_MAX_STACK_DEPTH
> +
>  enum ovl_path_type {
>         __OVL_PATH_UPPER        =3D (1 << 0),
>         __OVL_PATH_MERGE        =3D (1 << 1),
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index e487597337e8..08147799e47c 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -163,10 +163,28 @@ static int ovl_dentry_weak_revalidate(struct dentry=
 *dentry, unsigned int flags)
>         return ovl_dentry_revalidate_common(dentry, flags, true);
>  }
>
> +#ifdef CONFIG_LOCKDEP
> +static int ovl_dentry_init(struct dentry *dentry)
> +{
> +       static struct lock_class_key ovl_d_lock_key[OVL_MAX_NESTING];
> +       int depth =3D dentry->d_sb->s_stack_depth - 1;
> +
> +       if (WARN_ON_ONCE(depth < 0 || depth >=3D OVL_MAX_NESTING))
> +               depth =3D 0;
> +
> +       lockdep_set_class(dentry, &ovl_d_lock_key[depth]);
> +
> +       return 0;
> +}
> +#else
> +#define ovl_dentry_init NULL
> +#endif
> +
>  static const struct dentry_operations ovl_dentry_operations =3D {
>         .d_real =3D ovl_d_real,
>         .d_revalidate =3D ovl_dentry_revalidate,
>         .d_weak_revalidate =3D ovl_dentry_weak_revalidate,
> +       .d_init =3D ovl_dentry_init,
>  };
>
>  #if IS_ENABLED(CONFIG_UNICODE)
> @@ -176,6 +194,7 @@ static const struct dentry_operations ovl_dentry_ci_o=
perations =3D {
>         .d_weak_revalidate =3D ovl_dentry_weak_revalidate,
>         .d_hash =3D generic_ci_d_hash,
>         .d_compare =3D generic_ci_d_compare,
> +       .d_init =3D ovl_dentry_init,
>  };
>  #endif
>
> --
> 2.50.0.107.gf914562f5916.dirty
>

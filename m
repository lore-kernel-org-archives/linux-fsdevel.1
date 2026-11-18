Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795024824;
	b=llVTQMRypPFgfJasEWVms8hzE+Lf0Aap7rO0JORQTHtI1n0xU1ngCvesEAYUTa4XiES3
	 nRC4oZBSfEurJ9MIdFBAsp3l5n8sW7ElG3So8Qz928xo2TwIopENw0PCDE1tjFwg4fAUs
	 wqpba61V/G4w2d81v1LhAMIUeXADIhAkWZW0s/XfjfQIc6qGJwtoDKh3sd8QWOfaELoYJ
	 W1Io4YDPrR9YAV9+fcQbRo8TAxqQ8upXn0jL3KvZERiGIfDOnjKBjOsvn68y6c1AyJqMg
	 lnjzZiu8I52BDJTjg2nW13VsSyKEKueYGAxxSNsawlLUz+u5UXaouWh0mF/g6Ts761Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u4qdZCxQUja0NlcjEdDck3V1blA80itO4i7W2ltfseg=;
	b=iOFir4aaStYBzRAgBrSUdPypd0mypXIVAkVtGCqv5T68bx2hNBYcI9Jt2E9QwNSr8GpD
	 V0nF4zq4JeBr4m6lKns2qjIONz65yzZqPl6Yg2dyGDO5VH9e017orOcobhu2bfKh/8sJ2
	 oaD86s++v0Nnseyg127hsOyTIuvis7JrsHcrRVuSjXyj1tZmrljexO7wXIvv33IjHtc5u
	 5R4knfyK/5VVDdVu55+0poJAjhYtrWQbWiPvfWN4hIfGlf2EWWdDseK6GwvOi3SJbupsY
	 Cdq8zheWTdKqc3WzEA073xzzIIAuawxo6cyo8jOc5g5XvjHIzq6SVraVpu1tAlfePow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K+Mjuum7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87B606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 18:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B87B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K+Mjuum7
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b8786bb305so2011378a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 10:00:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795024823; cv=none;
        d=google.com; s=arc-20260327;
        b=BjEcQ0mkH4+w3lXg+KEbcmj5pv30SOkvVRg3ElLKROh5c4LJJ8bX6duchfZaX3iErD
         0afioJQAjuw74CVh2xhfv8UyCkTSoSjb9GjW3yN/vYnJgL0PI961GW2gfVZfzsZAMrHF
         JFM6WjkM1lkFr2wWLBYPF+oW1O4jElIa0iQWY18pssh8koOZI+R5nzuBrrI5FcWn86Yb
         2y6ZkbSXIXno995PXEXukk4Ix9gb2vzu7EBgyyGyY1CqCotMuMu8jmaGBt+33/riFcz8
         v/Z54U3jZKdqyAAzDMOL2OUsGS7C3hKujF0/UCd1sXvC//NDtD+n67Bs/lKbMRgXJDpg
         qxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u4qdZCxQUja0NlcjEdDck3V1blA80itO4i7W2ltfseg=;
        fh=FvgHkbdk6IQa4YR3WShtTFu3ZzMhXHKQ8DG+SPkkVTM=;
        b=PCXInP+1RsLEj2cDqlUh4szRUH7APCzdXISAZ+GFHRE+p4CUHbezk2BJ1gGfSK3wh2
         D1hm+sV/ZJpGjkeVtThtFekzLTMtvWfEoR9Gtouwi20G71Y/9oLTcoCSzYSO7OiWSyVc
         UUvEKI5+bh3XgCTNn+ylQLK/hVF6me8nd2QzqL6LK88gyR9rDUpAFxfda1qQDMCK2rX8
         NoQnhO3H8kw4TPjl4k4OWfvvvc5BvBt0TjKCm75J43/r0IAsrO6Y4x4JTcjF9lAKXGi2
         pxQhK1CVAiXd5+HA458WFHIthGWOu/bf6FB8jiwRnQCkwjG9infckAkm2hVEztjKJDR7
         IQ+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795024823; x=1795629623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u4qdZCxQUja0NlcjEdDck3V1blA80itO4i7W2ltfseg=;
        b=K+Mjuum7DZlbzQhj44dxy5A6maxZYAyZ29Ulwd8z8W13r5opinN8nQyga6gKKUTIn3
         irv8hTc3j4/gaqyiAXmOT+UTNk6HC+MY7Uf7a9b6WNEm5JkkOxWWEAKop9rvi+cr5sej
         mDDYfE32YCXVoQGoWcdnmed36eW/gsmlzt59+Dy3/XgVziXonW9SrTYu/k8rkGTUf3LD
         8YkjfAu0RpO36JcNXYdFoZwXhxqjZj12t2gRgljQWUSsmQJ05Bx1gGIw0cTe2lfCYBki
         DxIOJYRPP+azMglgRqXMkXmo+hGpR6ZcpcRAi7arTWNZ3zrHbx/75jBgltZUXBNNLpuB
         QlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795024823; x=1795629623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u4qdZCxQUja0NlcjEdDck3V1blA80itO4i7W2ltfseg=;
        b=PLFO69gjXMyGdgMqfkTdR4W9LjaD4x3kYPsFoQwwF3WbKsBTiowbgV45lHDGi/aWVF
         wG/ST2QgzznCHGLEv916B6e3vSO6Pdi3EXBK+fgttU2zK1hsQNnAnFjGAuvs7xgTsIl1
         /c+xZHHrjOZ2PEKF1dwkQZ/IzYrdH1OLDXPpibc4DgkEULKQjb4jpUOVH0Dr67Kh9IVw
         Duor0bpP/J4Z3wFtaQWI31GUt/6r4WMd9z+TBrHHNS3njozZJ7cTLCCPb52rI1ngj8Mp
         +fNdwN6d0FWV+a9Rrz7RlKal+RC+QEYfUQqPVXPNwQ0GhAvnx1LZVdsrfr9jY8ODF6dI
         8WCQ==
X-Forwarded-Encrypted: i=1; AL+hErGcFqlsy0Pd9rAA8Zq909DkuIlcILx+jHj0kYhL34rNbax/NSz0ieo9t1biE2YMA9OmrQxSnp/YFUxSQK9a@vger.kernel.org
X-Gm-Message-State: APuU4Z+dWdoZFqd6VHR3Pg0b0mkcMo9QvWDzQugmUGlxAqzz/YsWoNmw
	1UEURsEpmlroonjCiwDiISb08bwNvbmrXyvhlX1NIMC6yzn4mdvuqC5LhWLoHfqXQZr7Q9X9nB8
	3c0TKDFVT44qF3DSj5sAlniyH5PnjCoY=
X-Gm-Gg: AYBFou3/qQhhZQHp0iXRJQQhMkjz6+trwF/Bi+a+vxyzILkNRCkyPfQRRhDwF110MmX
	Fm7xkygU6HU+sqCaH5Yk/ObENFY3EN6NJKEWJLTrkX4PASSJHKXgtKIGsDJsTfk/RpgWvLRKIMC
	tlMjfU6T7MkwpuIQjCtpRj7B1yzShClPu0VZBBrw/yWwkuNQ/PEs2Z/XuOXXN2tznaj8HbmXSYh
	5aQhUz/YjLb6kei+VHtyL6E/jJgto9Mpc4tpvGlF5ZSCy2KEdoQaFnrXTIIPq4FivrtrHZBCkOc
	hL0zSogYFIchXjNMIvkenPERIOzA6LUhRYe+ldQG/sqwwqSdQdfDCvMIp8vHIQrXk9VI65fa+gJ
	Qg6Tn8jLdqxndfzXnFK0phj737nhaKrRmAitDwiSzRS2AAdotreWoMDjplI4QPet+vvsl3oI=
X-Received: by 2002:a05:6402:1607:b0:6b6:4dcd:967e with SMTP id
 4fb4d7f45d1cf-6b887ebebb8mr2374799a12.20.1795024822234; Wed, 18 Nov 2026
 10:00:22 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-b4-ovl-containerized-sync-v7-0-54f45743fe55@toxicpanda.com>
 <20261118-b4-ovl-containerized-sync-v7-2-54f45743fe55@toxicpanda.com>
In-Reply-To: <20261118-b4-ovl-containerized-sync-v7-2-54f45743fe55@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Nov 2026 19:00:09 +0100
X-Gm-Features: AclHuK_YmUY-cyrn8sPqESOYVBMGy_5scGhTZjCC06dq4P7IzI17kYjTkaWbeHw
Message-ID: <CAOQ4uxhp73OkM9-OUKXeO6Hrq2sV2oYYJ7CCzD=-mXHtRjBxDw@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] ovl: no fsync=relaxed without data integrity
To: Josef Bacik <josef@toxicpanda.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
	Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 6:03=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> A sync does not wait for a filesystem with SB_I_NO_DATA_INTEGRITY, which =
is
> fuse, so that a server that does not answer cannot block it.
>
> With fsync=3Drelaxed, syncfs() and unmount of the overlay are going to wr=
ite
> the upper inodes one by one and wait for each.  fuse_write_inode() waits
> for the server whatever the sync mode is, so they would wait for the
> server once for every inode.
>
> Do not resolve fsync=3Dauto to fsync=3Drelaxed on such an upper filesyste=
m, and
> fall back to fsync=3Don if fsync=3Drelaxed was asked for.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Ha I very much didn't want to include FUSE in this exclusive club
This was an oversight on my part.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  Documentation/filesystems/overlayfs.rst |  4 ++++
>  fs/overlayfs/super.c                    | 13 ++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/file=
systems/overlayfs.rst
> index 1a59500834a1..8a007fbc5257 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -870,6 +870,10 @@ The default is "fsync=3Don" instead of "fsync=3Dauto=
" with the module option
>  "fsync_auto=3DN" or with the kernel config option
>  CONFIG_OVERLAY_FS_FSYNC_AUTO=3Dn.
>
> +An upper filesystem that cannot guarantee data persistence on sync (fuse=
)
> +does not get "fsync=3Drelaxed".  "fsync=3Dauto" means "fsync=3Don" there=
, and
> +"fsync=3Drelaxed" falls back to it.
> +
>  If the upper filesystem has no writeback (e.g. tmpfs), a non-default mod=
e
>  falls back to "fsync=3Doff".
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 5960974c5af2..31a58e28968c 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -765,7 +765,8 @@ static int ovl_make_workdir(struct super_block *sb, s=
truct ovl_fs *ofs,
>
>         /* fsync=3Dauto that is not resolved to fsync=3Drelaxed means fsy=
nc=3Don */
>         if (ofs->config.fsync_mode =3D=3D OVL_FSYNC_AUTO && rename_whiteo=
ut &&
> -           mnt->mnt_sb->s_bdi !=3D &noop_backing_dev_info)
> +           mnt->mnt_sb->s_bdi !=3D &noop_backing_dev_info &&
> +           !(mnt->mnt_sb->s_iflags & SB_I_NO_DATA_INTEGRITY))
>                 ofs->config.fsync_mode =3D OVL_FSYNC_RELAXED;
>
>         /*
> @@ -1499,6 +1500,16 @@ static int ovl_fill_super_creds(struct fs_context =
*fc, struct super_block *sb)
>                         ofs->config.fsync_mode =3D OVL_FSYNC_OFF;
>                 }
>
> +               /*
> +                * A sync does not wait for such an upper fs, whose serve=
r may
> +                * not answer.  A relaxed overlay waits for each upper in=
ode.
> +                */
> +               if ((upper_sb->s_iflags & SB_I_NO_DATA_INTEGRITY) &&
> +                   ofs->config.fsync_mode =3D=3D OVL_FSYNC_RELAXED) {
> +                       pr_warn("upper fs does not guarantee data integri=
ty, falling back to fsync=3Don.\n");
> +                       ofs->config.fsync_mode =3D OVL_FSYNC_ON;
> +               }
> +
>                 if (!ovl_should_sync(ofs)) {
>                         ofs->errseq =3D errseq_sample(&upper_sb->s_wb_err=
);
>                         if (errseq_check(&upper_sb->s_wb_err, ofs->errseq=
)) {
>
> --
> 2.55.0
>

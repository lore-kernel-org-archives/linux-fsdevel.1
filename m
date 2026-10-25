Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792960223;
	b=TlJ8mW3r6MdSUp46wrEuQ375IG7xiPrP7l9XS7h8Pvz9XV99iUzOhIJwEsgdVTvZOtjG
	 8n28cPX5SgXMZJnFeK1ajnqZB4tWxuPqPYzxpX+MgI6ueyPzFVv9lDAC7/khRoG/QgYo3
	 qv4b8q31MBq3HGVGFAFUXVmNP2HZpv9Af98UBriCPr4rgGdmt1hNcwon+5FgiP+H7FNDv
	 /fLF/5QITuy+8pfYjA09rB+bMmw8LwD9SYnPF7Yq+vFSNj8zGjx8PG9u2lC0/uWPo19EE
	 Ucu5HRLZ4HlNybqTNMSbUE7C1EWbfNZ2metgthiUNm3ILGPbD6nqTNgDeAui8dejz7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SnxUHRjoVYyks0WRSGwEHiGHDW6d1lV4rjEkpWbA8dc=;
	b=s3Z5vD4aP17TjHJ4Ryu2lppha6qd9tR/al787qj5WAH1AjuMpIqI/BkZJ0WQL/g/FSlI
	 GAkEM6jkOH2CpXKDNvIBBKXxaRhsJ1cJo04seF9MWujBH5gOM4xtXKLDdHw/2/sjuHYIA
	 vuJk0s5jqcP1ybz96Dk3kY95vDizUHcm7Sd2G6yPe0JL7pLDzzJVfakkOZw4vIyfD/8AW
	 87c6enxg1w+cJVsgAQbmpgUdrp5ErvcYPglCJ8PtnmhM0GkXMBTMDBJkR2FkptJidAFKv
	 WcaKey6W5IKYd7teOKX80KZL9sNR2xiw5wFwpmNZL7oK6W4iWM6E1z+LKwCwnNpXh1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BJwEzZeU;
	arc=fail smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D7606A31D
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 20:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 474D7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BJwEzZeU
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4326803b54so112355966b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 13:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792960222; cv=none;
        d=google.com; s=arc-20260327;
        b=O3lzUrsK0l70w16l6FjFEkCuSHIpc2sIX7QtW1CE8/9FENOrr0T+ywPlaNKM40JfTR
         efoiS0ybGOl2htWA9anFdVUricR/7niVtCTs++FILS7U7cosI/tZc0PnglyrlP1Dt4ti
         kH9xKdSc0prPFkFbdp7GCGQm2m+0naW8kCVjYsetXRjuU579PLqnp9ScShEFukNnHBJo
         qtDTQDAEHERc7tPAk9CUQoo4s/gim9cJm0yPjgTL/L1FIS1e0IlE255ZRvYQBQqfmLgW
         /sXMhukxh7i/miFvhuC9NmMDqZ4a6MPDxnqF9Q1nYhyCUTO8Vdwvz0mxlpjSrF6h5M2o
         HfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SnxUHRjoVYyks0WRSGwEHiGHDW6d1lV4rjEkpWbA8dc=;
        fh=PFkLd6mQsrj9zqRKvJ0OzHo8EFj1o8B6dPiK3JySXw4=;
        b=iP6uyRkQ/LtThfELsBN7VDiHotN01XKedPA6PacYwFbdScwFVqGWKXDhnU2/IhbNz2
         LVV24b3/ZYOMOgUCtkPmn1FIRT73e0GKAgINCcgkrplC12ekC0QDljHCN5zL/seKKp+O
         sl96BfsGr0194iPqA6TS+r87mlG1tPb9yQaujZaLHD4RRGEA58tuNqAAgDRLBx3R7uaB
         actE5DoW7vd7FH1x1F+j6+BDe9G3FGXX6L2n36m0JmdSCiNgHaXZTOqmVrFc8/YgmSn5
         TKsOkTEdlK7ghUAC54x5vpgKNrJnSgefVoMcHijdyobusE63p6sGoLQfEFk2bO+7cVhK
         cuOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792960222; x=1793565022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SnxUHRjoVYyks0WRSGwEHiGHDW6d1lV4rjEkpWbA8dc=;
        b=BJwEzZeU+3M3JBvlvMaYtZ6ACtVLTb0o/qGcUb0ZCzQCY1lRn9QreCBV4WNl5jvozq
         ssqFV9gv3LpKsFeXGKcyyjZauChus10JHUgICucTBN8VL0wllBRLOqMfh2IAlsdeRRK8
         GyCIVtilUVg4IOISA3MERCbmxfKpSzKI3TAEBbxaNAvyZjnNXUFb+mgbL1mRTWwELHjm
         QYrDkc1SD9kpSrbKeZJSDkFomPUuDcMnAFtiiNd2pgugeNXKw33us3WYZUBAOqe/EaqJ
         1P6UBjCGyClswqiJp6y6sEcqkx2wSJ4p81x4eQT6Y5aIpNTKjQClaR/umJpTPUGG4mDy
         qWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792960222; x=1793565022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SnxUHRjoVYyks0WRSGwEHiGHDW6d1lV4rjEkpWbA8dc=;
        b=wns5SgBtm11bkrXVA+4HUxs213MM428b0CIVgGpzfa1AwFnW7Gc8EHNgirTbasyVPY
         FVMefsisWPrnve5Pp5p8QHNI11Bgmw91H5QiKXkwoPtqnCkILoATjQbiSGCMtANEEVCN
         36WCt/6WkP18CRH0N2PpP9ZVez87QZ1+8YgeKTVe64kfGXuGhnc/8/gcaRvZNK7Is0hE
         jo3wSyOHIoFBIpESMyFmfewFlmGeKF6QmRWeLI3Zc0DoH1fXit7xAPDi4fpiS1dS7M1/
         WuosIKzumbUUoaKu03P+h4viLO9kDu5lh6ZlcNzZf2hg26K4/SmmOo1Z2W1PB0DqoWdP
         N+Cg==
X-Forwarded-Encrypted: i=1; AKwUvBy7cTOtDZgVDkRCws3vKCNEVBsG9nMdEzXg7oe4sFCXjcM+LjWHXXBTvttwgZ02d9oxnEdoUrbyP1752hcx@vger.kernel.org
X-Gm-Message-State: AFq9FYIjxsbe6VdrK2uDnUk8YzNp7fDXcZermNp0VsYqrALX2P95Dgkw
	Edl6o3+9KQBoutats384cqNrDKl0in1rkNWdagTD9JsuQzRM8UrTaVu1/aUot4R4QiEJHmPW5ve
	lizn+tZ9CLW7r34RkJcTQS73dNSG19y3ctx0q
X-Gm-Gg: AYBFou23auH2hkviuryHtoGcocqz6Ib58d+oR7y3+7zZHOWBaQ9Dudb19td0xZzvFzJ
	4QvTRqiLEuMr/iDk/ZRk8lXkZ92dQaZruf4xYciSDrrzV9/QfE+3OwArMFnASprBoj/1FgOZJiZ
	6HiaZfdU4JR1s5CH/YboqUFHG+0uG6yfhkCiHu2vepLgaEVSgdK0MWV2sFdGCZVsdSuDX+D8YBi
	Lz3wj9lLYhDu1/nkLHi5r5SawIkdEGnHpkImOAt1irkiHaF8s/8GPtnqtDRIU9+6dphqLkw/84W
	J+m89/eOZf06wQ6QKj9ZMCOmLUnaXaTfQAXCvRV1jH5suOi5ZK4BsWVGZkuaaritMnJ5SDkBAW7
	eq9ZGfwbwpQ9tSrBGRpvTLblf3xYhZKg3bkTlx6cmbQS2KKiF3g9yVJmcBsW81f4rodi+CzheZ0
	ouwWUpCZnUyLs75Yntl7RQHNTsnac=
X-Received: by 2002:a17:907:e93:b0:c46:ca2b:84bd with SMTP id
 a640c23a62f3a-c46ca2b8958mr437657566b.30.1792960221334; Sun, 25 Oct 2026
 13:30:21 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017165125.2450059-1-amir73il@gmail.com>
In-Reply-To: <20261017165125.2450059-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 25 Oct 2026 22:30:10 +0200
X-Gm-Features: AclHuK80xTSaZ7UMyzLVVcvdzci2HUVT8XZYJ1-ejqxEYesoleURHNE9cYXHQSI
Message-ID: <CAOQ4uxhqQgv=WquPEtJcj5_LzOmfJ5mJagWN0H0UEQ1tjhL3aA@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix mount setup failing when override_creds drops CAP_SYS_ADMIN
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 7:51=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> When a process drops CAP_SYS_ADMIN and calls fsconfig(FSCONFIG_SET_FLAG,
> "override_creds"), overlayfs saves those restricted credentials in
> ofs->creator_cred. ovl_fill_super() then wraps the entire mount setup in
> with_ovl_creds(), switching to those restricted credentials for the
> duration.
>
> Mount setup calls clone_private_mount(), which checks CAP_SYS_ADMIN
> against current credentials. With restricted credentials active, this
> check fails with -EPERM even though the task issuing
> FSCONFIG_CMD_CREATE is fully privileged.
>
> Use the mounter's real credentials only for cloning the private layer
> mounts. Keep all other backing filesystem operations during mount setup
> under the stashed credentials.
>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-unionfs/20260924112858.51392-1-disg=
oel@linux.ibm.com
> Fixes: c28f922c9dcee ("clone_private_mnt(): make sure that caller has CAP=
_SYS_ADMIN in the right userns")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/overlayfs/super.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index bd0a3f9039d25..c8145b62ea99d 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -497,6 +497,20 @@ static int ovl_report_in_use(struct ovl_fs *ofs, con=
st char *name)
>         }
>  }
>
> +/*
> + * clone_private_mount() checks CAP_SYS_ADMIN in current->cred.
> + * ovl_fill_super_creds() runs under the stashed creator cred, which
> + * override_creds may have dropped.
> + * The task that issued FSCONFIG_CMD_CREATE is still current->real_cred,=
 so
> + * use that only for the clone. creator_cred stays in effect for every o=
ther
> + * backing-fs operation.
> + */
> +static struct vfsmount *ovl_clone_private_mount(const struct path *path)
> +{
> +       scoped_with_creds(current_real_cred())
> +               return clone_private_mount(path);
> +}
> +
>  static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
>                          struct ovl_layer *upper_layer,
>                          const struct path *upperpath)
> @@ -520,7 +534,7 @@ static int ovl_get_upper(struct super_block *sb, stru=
ct ovl_fs *ofs,
>         if (err)
>                 goto out;
>
> -       upper_mnt =3D clone_private_mount(upperpath);
> +       upper_mnt =3D ovl_clone_private_mount(upperpath);
>         err =3D PTR_ERR(upper_mnt);
>         if (IS_ERR(upper_mnt)) {
>                 pr_err("failed to clone upperpath\n");
> @@ -1093,7 +1107,7 @@ static int ovl_get_layers(struct super_block *sb, s=
truct ovl_fs *ofs,
>                         }
>                 }
>
> -               mnt =3D clone_private_mount(&l->path);
> +               mnt =3D ovl_clone_private_mount(&l->path);
>                 err =3D PTR_ERR(mnt);
>                 if (IS_ERR(mnt)) {
>                         pr_err("failed to clone lowerpath\n");
> --
> 2.55.0
>

Christian,

Could you say if you agree with this solution.

Thanks,
Amir.

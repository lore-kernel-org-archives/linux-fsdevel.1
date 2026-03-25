Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F00337BB0
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463767; cv=pass; b=oGrUq4LbxVIk7beDETD5hkNJGitPvRMoCFxb01dCg/R4eEgiyVVT8ibvVW+G9UgTSK9IpwB+E3A1hTFUXeIcXaqaTM1knt3QIKKrP7QP+zmNb2j0aFYN7sWxlVKd0YoR33HFxSifNmwgr6EWN+s8qcQquy7Ae3KdZeZJFBaCz0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463767; c=relaxed/simple;
	bh=DU09dneRr/GRbp2qrwsAbEux7gUhzS7AtKG/4sqMSBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYtVLonyzLaRZPPT7A/XZwwEvHnCGnXtbKXX4e+gRvWWwjEQa2mpVNNb21rlwPbyH8VSWAukDjQyULI8bwzSU7WfYCERqOdE0/x4SCX4sTQ8LJ3a0moQJa4kyjOeN+oW4WqZPlVcRZdmOHD1RmVcAUL8WoP1ssqniUmHnUSQzV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYj9J+tR; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYj9J+tR"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b9144790dso68823f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 11:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774463759; cv=none;
        d=google.com; s=arc-20240605;
        b=E4WPmSSjmzPOpyS6uqu8pUZ4649DWT909PQQ7pBmjEkNUuw8RR6Ioo1jTGxDdksvql
         Qmvw0xyhdzqvYOJTw+lOn6XLUuEuPK7bj0TZwKWnMkjfJDMm0XrUJH6Pwqjt+g2KDHwl
         0IJ7D9y9J/uzdu4hnaGD85oVTW9ClUmHqJe6BhWpL4L7DO5Dlaj2NmIuNnQn3+s9Xa1k
         U++kC8RSqpBPQTaESQiJR2GHHFbGI3ioQE5mpYjesi7r/5LJtnrTNhfuqTur8JB58gb4
         FfmVDfz7xXm2dqjQ/msSSWeI9pvlpqXfhyjAhcilj210YPdiqfc3q05j+o5sNuGmyjs9
         pOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9QtV8GBTb6YR4jdqHUX7Sv2eVsBl1fbWiLDxSj4EukQ=;
        fh=d0o7ZIgQsBTIuF6YtjJwX+tA0Su04jQ9qyvz5FCQAlw=;
        b=IBi/tj5iznNrcz3NSGokxK0jZMb9dxo1zci2oFFPBvbeNJQtCLIQRAWDKyPQAgjsck
         ihWVILXgSSTjjdl4Z5c6tSSAyQfpsnso0wvKofHuuA+m9Mghip5LNLmAAIE7Z/bkCWOs
         cEVfXDzu4OiW7GjcICWSN5ZfbpaYeltpsHYiHOGE9QKZW09vOsMR0vlK2yCx1bIr/THo
         ZNsHBoEP7zSnoAkJaf+fhUnGO0KQCyU12Cl59fBNj/QIz5LdQYsqsqObO3w6uaLpWbEn
         g8ibF1uaA/kB8GS5nofWUYgbiPMD2vJzxMHrvAbcQ0WWLw1Knf9/zKfC2HbS2D/IfYHO
         1sQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774463759; x=1775068559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QtV8GBTb6YR4jdqHUX7Sv2eVsBl1fbWiLDxSj4EukQ=;
        b=VYj9J+tRwEhyTKu1jFztIIyyKnSDqOC+nG/430snVSAMKZ23q3hy+/SYZlM77fAD43
         E0PZ5FG6eiApjsCDYocstimrEeDBoQ5UlxRPdT7k/PiHutdlTGzN2FHJrQSCe2rnP09/
         OARSS14vSE/zkQXqPAxP//9aclw+5uvv6/g8NELs8z/XKedJ96lKjOHcmzhGN7bRoI7F
         nj/rqFYtA0qMq5gq9nFt+wuxkMPL13zAh1Pdx36ImO2BdFb7P2YmO9Y+24fAu81Cg8sB
         M2VCdB97L+oxY+5+rZV73XMAGiPSbNRbEi6o2Shqh+6Bnk1vo2uhfDbgFIK8xaxZ1hBB
         VFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774463759; x=1775068559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9QtV8GBTb6YR4jdqHUX7Sv2eVsBl1fbWiLDxSj4EukQ=;
        b=HZJKw+4HZX8IvQdgJ0MWg/B8DlM7cSi0ZL5yGMQAAsgEHv9exqn6+3DdmJQs3kwTUm
         nSimGVCoGO8Rke2IkSbYQRSH5uiiBglXCgB8g6v/P2mn+bMFkyPE8xsl0scaKEb/U6LU
         gbAdq0BDl2bB7WpSskbrYinUHn8Jm3sCh7H5DdRSfhOOoiA8DIms67wUv9LBlSd2LNxx
         GB6idk3/7oeWbpoIM/mgTAup9YJ6awnSKpZJlleLaE7JhTduWbjfj0HmJaVS/6zzJlqw
         oIuTt/sPuNTpi7cDFEkGr3efyf+ivFAP0c+v5YIANCxy9BJDGdm618n3zGmkDpyQptT+
         LbPg==
X-Forwarded-Encrypted: i=1; AJvYcCUQvrX3BNocnAusyOGNeheWJHKS0IPZkdfbryZFLW1GcbpT3I//M91EoLJXKOTNHEg2MYWkOy1AcJwXo8gM@vger.kernel.org
X-Gm-Message-State: AOJu0YzFXFz4KM+YqMyz2xmDNGL6+v7WwoKiwVepInx3hZOUHGF6RYtI
	6EkjyJOiuZp9vIuTCpoLpWqB1RH4KqwxYFrCDZ1KtnCMyUE7xaalAXvAUBvSXTSyGsukbmgdoT9
	S184eM/NUXeEwcfg/kbv22hz71rhy+zc=
X-Gm-Gg: ATEYQzwj8xe8nIHwXS+sylRxQrw9zaE98DFIvRLOEvNZ/ulx4utnSoVXrg9mc5/OXYW
	XQKcgkmtYNVDF+94WglBNFsZAwanC22BULbbzjvNMZ9S4k1MlTYSMUJr/0uYWGf/vtRpQsg4HTC
	wpRuzeZaGrnCm4pJ+Fe6KXh69t9XbUwqKypUVoV25AM8em+rT/T9N2BZ4/ztcKiS66likJ+GpBY
	HB7A0qjl27MPgyH0sXzooHsFODYnrTONIS3C6hP6GiE9T2DayCfh7kbICYHHdnxqIzCvG9j05LN
	be7S1w==
X-Received: by 2002:a05:6000:4381:b0:439:b6f1:cd8d with SMTP id
 ffacd0b85a97d-43b88a100a3mr6484733f8f.28.1774463758965; Wed, 25 Mar 2026
 11:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733175.3935219.14499232455997407711.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733175.3935219.14499232455997407711.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 25 Mar 2026 11:35:47 -0700
X-Gm-Features: AQROBzAsyuIOQL6cuDHl9wKI-61KU4hUBnmgoj2gOGt1Tina83tHjQ4Mtdg7-gk
Message-ID: <CAJnrk1ZZV=nf2ZvsFz2gCEdFanK2c=_4X8hH5PyZ4ys-b5T8kQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bpf@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 3:07=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Actually copy the attributes/attributes_mask from userspace.  Ignore
> file attributes bits that the VFS sets (or doesn't set) on its own.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/fuse_i.h |   37 +++++++++++++++++++++++++++++++++++++
>  fs/fuse/dir.c    |    4 ++++
>  fs/fuse/inode.c  |    4 ++++
>  3 files changed, 45 insertions(+)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 1d4beca5c7018d..79793db3e9a743 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -147,6 +147,10 @@ struct fuse_inode {
>         /** Version of last attribute change */
>         u64 attr_version;
>
> +       /** statx file attributes */
> +       u64 statx_attributes;
> +       u64 statx_attributes_mask;
> +
>         union {
>                 /* read/write io cache (regular file only) */
>                 struct {
> @@ -1236,6 +1240,39 @@ void fuse_change_attributes_common(struct inode *i=
node, struct fuse_attr *attr,
>                                    u64 attr_valid, u32 cache_mask,
>                                    u64 evict_ctr);
>
> +/*
> + * These statx attribute flags are set by the VFS so mask them out of re=
plies
> + * from the fuse server for local filesystems.  Nonlocal filesystems are
> + * responsible for enforcing and advertising these flags themselves.
> + */
> +#define FUSE_STATX_LOCAL_VFS_ATTRIBUTES (STATX_ATTR_IMMUTABLE | \
> +                                        STATX_ATTR_APPEND)
> +
> +/*
> + * These statx attribute flags are set by the VFS so mask them out of re=
plies
> + * from the fuse server.
> + */
> +#define FUSE_STATX_VFS_ATTRIBUTES (STATX_ATTR_AUTOMOUNT | STATX_ATTR_DAX=
 | \
> +                                  STATX_ATTR_MOUNT_ROOT)
> +
> +static inline u64 fuse_statx_attributes_mask(const struct inode *inode,
> +                                            const struct fuse_statx *sx)
> +{
> +       if (fuse_inode_is_exclusive(inode))
> +               return sx->attributes_mask & ~(FUSE_STATX_VFS_ATTRIBUTES =
|
> +                                              FUSE_STATX_LOCAL_VFS_ATTRI=
BUTES);
> +       return sx->attributes_mask & ~FUSE_STATX_VFS_ATTRIBUTES;
> +}
> +
> +static inline u64 fuse_statx_attributes(const struct inode *inode,
> +                                       const struct fuse_statx *sx)
> +{
> +       if (fuse_inode_is_exclusive(inode))
> +               return sx->attributes & ~(FUSE_STATX_VFS_ATTRIBUTES |
> +                                         FUSE_STATX_LOCAL_VFS_ATTRIBUTES=
);
> +       return sx->attributes & ~FUSE_STATX_VFS_ATTRIBUTES;
> +}
> +
>  u32 fuse_get_cache_mask(struct inode *inode);
>
>  /**
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 7ac6b232ef1232..10fa47e969292f 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1464,6 +1464,8 @@ static int fuse_do_statx(struct mnt_idmap *idmap, s=
truct inode *inode,
>                 stat->result_mask =3D sx->mask & (STATX_BASIC_STATS | STA=
TX_BTIME);
>                 stat->btime.tv_sec =3D sx->btime.tv_sec;
>                 stat->btime.tv_nsec =3D min_t(u32, sx->btime.tv_nsec, NSE=
C_PER_SEC - 1);
> +               stat->attributes |=3D fuse_statx_attributes(inode, sx);
> +               stat->attributes_mask |=3D fuse_statx_attributes_mask(ino=
de, sx);
>                 fuse_fillattr(idmap, inode, &attr, stat);
>                 stat->result_mask |=3D STATX_TYPE;
>         }
> @@ -1568,6 +1570,8 @@ static int fuse_update_get_attr(struct mnt_idmap *i=
dmap, struct inode *inode,
>                         stat->btime =3D fi->i_btime;
>                         stat->result_mask |=3D STATX_BTIME;
>                 }
> +               stat->attributes =3D fi->statx_attributes;
> +               stat->attributes_mask =3D fi->statx_attributes_mask;

Do these need to be |=3D so we don't overwrite any vfs attributes stored
in stat already?

Thanks,
Joanne

>         }
>
>         return err;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 58c3351b467221..ff8b94cb02e63c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -286,6 +286,10 @@ void fuse_change_attributes_common(struct inode *ino=
de, struct fuse_attr *attr,
>                         fi->i_btime.tv_sec =3D sx->btime.tv_sec;
>                         fi->i_btime.tv_nsec =3D sx->btime.tv_nsec;
>                 }
> +
> +               fi->statx_attributes =3D fuse_statx_attributes(inode, sx)=
;
> +               fi->statx_attributes_mask =3D fuse_statx_attributes_mask(=
inode,
> +                                                                      sx=
);
>         }
>
>         if (attr->blksize)
>

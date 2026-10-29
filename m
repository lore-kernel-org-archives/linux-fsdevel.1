Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793271808;
	b=rwBAR1J0Ek+mbYB9kdAnmpnVVRq0skSyGL3QlYQmlynKYTastOaIFZm+gxHncRui878P
	 5AwWijT/y2bZnTT87KpFEE6Ri43okAlzAD2swCjja6PJ5UOOhlUGMRl9YVTTvYfrbYDvC
	 Ty7HTcjZ9WXXzLI1/LFdqjGCMb/4tTQP/pCXPXdXI2wbRg3i3lnSCV1d9Pqxm9qAqHmrB
	 D9j5FhSzbK6El+Iu3fAjrgr7VW9qj2YlATtqL0PM8a10cDdA3DrXIpQZLZ/X3f31s3c5m
	 1Tfp31qgZsTdPgz/SSGZXhmwXbGTMDinrQeUDtfcSRnl5ft+z/4pRqBAFckz2fGG6sQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+oFxDAll8dGtyrd+E10y47gRwGYiWN3UeaM2jcZ9GXw=;
	b=JZ+JhT3+V8AFe9HY4MjHahxJgfWGZP7sAVG3VGZ1EJrQjnUp5K6XupEQsvnP5aYYbTla
	 QVGB8dDDO9U29Yx8RFM/t92T3HmOPZJkllIkLkLYdRT+nj/rl9Dbs0Tax1UkkHknv6+OF
	 UyLu/lZ33//88wMObZerXV9cgJ+maVCMirwUEx6g1qrgAN2qJR7bOFWTdndBKAWHt9ukm
	 wXzAeGCpcCQQt4x8U+iIS48RZ1xzyZSjdSJDHUfALB2ToS3QLzHdQE6mQUgMeqa8X34Nl
	 UQ0R0q8sAjZgtT5z0oixjeJAQB3Yd4+im+R+hGcGMJJGiOcqbrjVTAI/5YdujKqFRCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAmXfFyx;
	arc=fail smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B40606A31F
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B40606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAmXfFyx
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso2453141a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 04:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793271807; cv=none;
        d=google.com; s=arc-20260327;
        b=UD4GoYwbScKno+duc31GiNfJtj13kCUWmeBLRJs/nfiDsC91ldQGszxGBJMh4Y3r3J
         2wDdHnEQvsAaK3Z3bqLY72QSE0lZZOvnvjMsZWsYuzhdYYelPAH5+dSLKcLUao3eYvhu
         RLn+1QHK6EF5AkCeAtBZGlcLPmA7hZSpOPPTSNqSSffbbfNnVZGtk5QJ8vJto6iSkRF2
         FJiZKg8Re9eMqWAQjwQODaF/GZOz00tdllCAMjREsWIMYsvCcYsvMSJJr/IOrXlqDNJt
         WACHMmwI6CAugcfjnjxDdSJMj0pyYH3aspK/qYXv0VRVsH3qT+xyC7/p/7Twu/WvIko+
         3mtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+oFxDAll8dGtyrd+E10y47gRwGYiWN3UeaM2jcZ9GXw=;
        fh=svp+BGNwFLCE4GGnLccJSbJGjZya52S7xWlgEVHK4xI=;
        b=kQAeyuhaV0b1K3nFZ/uUjSQswraFKvPPDdhIiYdnhMbAWIMyOmFxOAZgwuwl5+Sn9W
         1EbFN0tGrVUtCRM7+CtMhrJrmocrjgktlssO8tvST5zYtsftwPV8XtItR8LX55yS2jVO
         TW1M4z9B64rBO0Z3hgM173HH9JxjyWPCsQuTkesZRgv4cvfA2O+L0a9cJMETO4TLuyik
         3cQpKzsHzjZPmHo9X6aMt/SL8HUxrAKSsZCHjcoPe2IMXH7Y7az14qX1YXlZ/3B6axAs
         gtHMzH5uDHrm6yySGxf87kbHz9Yz/R9Nu0zGavI9NiJXoAgOTnqxExAgZDifGa5BIyTM
         52gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271807; x=1793876607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+oFxDAll8dGtyrd+E10y47gRwGYiWN3UeaM2jcZ9GXw=;
        b=XAmXfFyxR37ur5ieYkpUjtc0G8B7XfPmNN/QJVLMm40nz0G3ycyjyEIPX5tjlf59il
         CMGtoROgxaFWYpUVFtqBpQDXWF1CsXLq+YWIoYLDA0ssMCFszt51ULbe/IWEYIFWg+Jo
         wePXQyzQIx1rz/BHtW0ZJjKH28dy6w1RgznDWiXhbKjdwaVbeVDt2iYCTqZzqf5IKows
         udP5s/lqTK7Zj/ZnB2Eozd+J+NE4iBmFlcY7jskXteh+vNhjd9YO5jz3M5dvrhRH4TUk
         aGo418N0Lq/giIhsVKwF6I+PbWa84+LNxtGwB5VavIQgheX3c9hpH2FaguMfjlY1Nx+k
         q8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271807; x=1793876607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+oFxDAll8dGtyrd+E10y47gRwGYiWN3UeaM2jcZ9GXw=;
        b=oRRu9KVGUAQxSHjiCUCqAjn83muDXoQFqarWT595ZzB1RNrYrhOiM6hXlWWVDlldch
         NAfLCIDusjfL25KsvM4voPBMdydlY7e+27BkwQIyiCRULhHOJvEk0aDbuMipyWXFsV9N
         VnnM9uE04L05jmfIfj9fMi/ishAVFmCzelJeaBVYOo1mEHK6v+esdccms0Cq4DLXMGt7
         vBlLexRrM8kXjryC1Q5r3gybcGmko+t0LTqPPCzQqXcFcyIVemY0+CoFw6z26ndweohs
         iGpowPVx909oZvSHhnPKAoFFfFtK6ZaK1k0MZt+a8RSQZEXOI7JrxxoC9HywqLrtPWYZ
         lQvw==
X-Forwarded-Encrypted: i=1; AKwUvByRyc5bws8Yy7VRV9PV0IV1Jbs8YIWA4rF7Vmkjfks7Fws/ZXCoBCwZ/FpHArKcouAVRD0wYXBK4HkwQg4f@vger.kernel.org
X-Gm-Message-State: AFq9FYJ18RzpnkC27C/KewLaerKU+hlKZKMc6N1gcCuGhlfSVn+KmTGB
	MXoPyjw/WGDOZTN9rXxKTUcEN0lQ8LF5/UZ4jcMRWmGLQ+xNg6Qv39QuQj4VSfn0iqfyqKlGRy8
	2YMummXBdB1ucH7qOnnQnPK30/XuwHgE=
X-Gm-Gg: AYBFou2kQURSONhrORzZ/e/+ycTGTvDA3eapfw6suWC00iChyW+zUuk6+0CYkx9/mWA
	tq/eqhCfZVgGMyUCrg97FYhMlD1AI6+JP79eCMCD96fsFUBPS/w9c4haparcSSPHNMKqm31QkrU
	svES8mioJNbq+2Hh4moNjgMbO3Ot1WKJKgsfiHLR2rJEEkC0XScGk2dLx5SeZaNoWGpvfFN8kIy
	Gahb5uj+Yagl2tmq8TTHWRM9oPHu3j5hku+Q/K/JKb9Jpch+toFyo/f+mjslrAfMBblswE0wIBe
	sm2X5KIohQYbIF1Ux62aHdXL/ppmlyaR7TUlmQwR5VDnVo16WizlT5dlT2l57a5b+JEq8l15w1f
	wRHiUAsSdM4AUYXLGqoL2O1twt2vUfXRqeMnAS951WmaZRCWQOLiSJxienlZ8iEjCnn1VgA==
X-Received: by 2002:a05:6402:34a:b0:6b4:1037:2bb1 with SMTP id
 4fb4d7f45d1cf-6b49cbe7cedmr2797089a12.22.1793271806191; Thu, 29 Oct 2026
 04:03:26 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028154008.67451-1-dennylin0707@gmail.com>
In-Reply-To: <20261028154008.67451-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Oct 2026 12:03:13 +0100
X-Gm-Features: AclHuK_jPOxWwcTntrGiyWxXQmQ4_F2fFzrd1WHf0WA2kaDI5_4JgryUKHV6fdI
Message-ID: <CAOQ4uxgDmhddqpFawaK874cfWCp4jVDnE67eqXyDA9eumpMEpg@mail.gmail.com>
Subject: Re: [PATCH] ovl: restrict casefold consistency checks to directories
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: miklos@szeredi.hu, andrealmeid@igalia.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 4:40=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> ovl_lookup_single() compares every positive child's casefold flag with
> that of the overlay. On casefolded ext4, regular files do not inherit
> the casefold flag from their parent directory. Looking up an existing
> regular file on a casefolded overlay therefore fails with EREMOTE.
> Symlinks, FIFOs and whiteouts are rejected by the same check.
>
> Restrict the child consistency check to directories, along with the
> corresponding assertion in ovl_get_inode(). This allows nondirectory
> objects to be looked up without rejecting them or warning about their
> flags, while directories with inconsistent casefold settings are still
> rejected.
>
> Fixes: 16754d61dc69 ("ovl: Support mounting case-insensitive enabled laye=
rs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  fs/overlayfs/inode.c | 2 +-
>  fs/overlayfs/namei.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 63906b3dafcb..4428c50c3185 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -1278,7 +1278,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
>         }
>         ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev);
>         ovl_inode_init(inode, oip, ino, fsid);
> -       WARN_ON_ONCE(!!IS_CASEFOLDED(inode) !=3D ofs->casefold);
> +       WARN_ON_ONCE(is_dir && !!IS_CASEFOLDED(inode) !=3D ofs->casefold)=
;
>
>         if (upperdentry && ovl_is_impuredir(sb, upperdentry))
>                 ovl_set_flag(OVL_IMPURE, inode);
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index ca899fdfaafd..023966d89f74 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -266,7 +266,7 @@ static int ovl_lookup_single(struct dentry *base, str=
uct ovl_lookup_data *d,
>                 goto out_err;
>         }
>
> -       if (ofs->casefold !=3D ovl_dentry_casefolded(this)) {
> +       if (d_is_dir(this) && ofs->casefold !=3D ovl_dentry_casefolded(th=
is)) {
>                 warn =3D "child wrong casefold";
>                 err =3D -EREMOTE;
>                 goto out_warn;
> --
> 2.43.0
>

Applied to ovl-fixes.

Hungyu,

Thank you for the overlayfs patches.

I see that you are sending patches to several subsystem, so I assume that y=
ou
do not have any specific interest in overlayfs casefold issues particularly=
?

I am asking because I got some patches for overlayfs casefold which I do no=
t
prioritize because I do not know how widely the feature is really in use.

If you are interested in reviewing or testing said patches, let me know
and I will send them to you.

Thanks,
Amir.

Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793877398;
	b=ywwWID4vT3xeEKk16kPM8+I07Ent5t0zekxwtHg5paxnq8s6HRoxYuzRUK3qRWisy/AE
	 H3pqs7xleAPfE5MwkYvPtysvA8TsttDJrqYnV68BAiA+lK9kXkRAGFXlu+x7hH4QpNYVF
	 CxbH76jc7HPfnY0bbZqsEWM064Rw5+tIWVAmlMEJLvJHtcaWIcgG0txvrk+pMZtc0MYVv
	 LXk9dG9MC5mdLBQGB9YmDpe/6bPDmJXj4ZDatpQRxgb1qPNGMbVzv3YTXrJ6uKnH8Jeqv
	 Y/OhVGboWpXhrpJBLnb3Pyz3FVnk1ssRa+CM6dM8mUrTBrtrvj1f+0xHBE7EhJLNRrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mbuO71RAfzZg4eV/uh/nLbsBTf1bF5h60PMcEHEZE5o=;
	b=IF6nJQvKeHGs10kJU31a7Jvi7x2odHPjTuFr0HKFgv43BQqqu6fahQlGHpPFY9R3F2on
	 XJfqYRhnu5irQBHKLmW/mumDbNg+S/MXC8uSEQoRJfHO3odBsBMkv7T0gh9gDKNujtXmp
	 VNZMU9EIvLj7REFJz/3NozHvtHd271IAbgMZNqH3cBEC93KCtP96qwEgTVIQosxVwp7Vw
	 cYP8ErSn4+++EPcDAoMKpe9rQir14W22pXW7r8gKReykbev8HIw3p8lale4JC/7uNST5w
	 axo2xhgLmMSwmtSEkuElW6IKOJ20Gn3Oh+tu90zf0NQzlBfliRIAVy1R4g3WEyVeoMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JnrWOJm0;
	arc=fail smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA41606A32C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 11:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AA41606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JnrWOJm0
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b566cf56c1so1444047a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 03:16:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793877396; cv=none;
        d=google.com; s=arc-20260327;
        b=ANkMCGfXpVPAEmSVbzjvBoQvs86k/tKlsnBIArH/iwz2j4aRsflck0hrHq43gxlFjF
         AEgLl47s7QoJvZNjUakxNHxENziAEP7HIiGK9O7JlEHbw8AmL9CZ36XOr7PLxxY740oe
         rKkto575RKj5LcRSPt0RfydcHE1AWtFoRrliWDO+LBt4rC5AIZAUpYx6NiQgPqap9J/q
         9DHJqaYe95uDLEXgg61xnKYyibZVrur8BtOsO8XYIXNUmCbtlphTEI45rKn9r14w91Oc
         OE9cvTuYuWtkzQifaLeC63shZuDAsMM16pOmzkLxKMMc7G9iDGd1jwCsnGisYxmlYwp0
         guDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mbuO71RAfzZg4eV/uh/nLbsBTf1bF5h60PMcEHEZE5o=;
        fh=dUGL0d1+J7o6g27zV0uXoJ5cVxJkpe4PXNUiT5CHOVQ=;
        b=WwkT+/MWy7gaC30h1gd3wQLlysl2kJisEUkAu4xouCVyG6ey/dxPLfiBU3w6c+BNWN
         nmdCKCU+OhcHBaUCQ+KhBFyb4INwyltscIkaLUYX+mCiGpc6aFJ7hDZ5OIH3PtaRvGyE
         NOyDkGe9dgxKJlKIKr8ec23+TENKQ3S0Y3MYPhQrltVqOqmpieG2GVbbnQO8C5kkW+wo
         gjOj5L12Gy8PrmWfo561xDKV5/HROpAjGik2D4FDRFjNE+Q3GnmM+dmCS66REiKvcerV
         xyVHgXaBkhdysmqc+VD6iD1fF00cH+ad3EaRKMqZG0xDJBwwZ0jjtaHgECNjyHXwVlhm
         Z8WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793877396; x=1794482196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mbuO71RAfzZg4eV/uh/nLbsBTf1bF5h60PMcEHEZE5o=;
        b=JnrWOJm06ylNQjuznyd8sqofcdiseURgioYzHNPkK56kFeQBc+fp+psRX11elRJPEK
         jMNr3qRq3IfPex1/zda/0UOVMTgogLeykFQrVcjk8H16PVxgZVKi8W/cb7GW2BawEwdK
         BtAtd0vDi7SpE4WSnhSuE+uBuC+Agr8byE25I7FWTC1kqNUDGpt5VNxjfNi9QadpWASq
         14CkgmgfPo35WLEeYg82Oi24Gz88HYVXuzL3AL3avLLNzR30YCEsgU/LMo1obCFihjuy
         4QAzrNeCwK9Go34L+UnoNgtDa8F+FDQTHGWb/zzOKUFJ8V/U7A+MmltvnTVeglc+7lNo
         8WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877396; x=1794482196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbuO71RAfzZg4eV/uh/nLbsBTf1bF5h60PMcEHEZE5o=;
        b=uXBpT0KmdCyrcaApcDHbtv4mhcqc8yaDlWZFImUay1Hv9K2H8Yy3XvvZEZZ5w4lfO0
         qfWTQoOQmx3XuQTSwUWhBmzADiWYuvArcORo8yNutyk1r3EkZdj5ie6wJPV57HxU1xlO
         EsignJS5Vh9MvOQRsCHE69NhLOydSKhouf0chujFrZucn/M0OSR3sc+AIjT02+pLdeVm
         3sCZsjAzC/JH760iEcHjY5qguKYPREYA4beCpDoaW2ukuYLBcBVYro4kYjzn8GufiADL
         yXok2loJeoIeg8Q/TfZLqcbKE8qTAAb1BuwbZ7Md1JJ90AUygiPIqlig4IaLwQdvNIdc
         ObJA==
X-Forwarded-Encrypted: i=1; AKwUvBwOCNfr5WvCRxTGzdQCbHvTHD0ra2rPtTaBSKDIp6J/ok60C56P8or518/u3yIZz/Eb3aXGcGcgwepVcG+5@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ehdbwd5pkLK8fgUm8VeJyQohN+7cwYclAMBkvnLhLzfmusLoa
	QRee1XheBZRzQ2gMvFNrCxc5eVJG6M7DnugYW/yIA/oXbXwiC+4NGsSEZAmL9WY08P6XMHxzgsd
	cDzPj6mqbwLMomSJfqYyXotW/r5cofA0=
X-Gm-Gg: AYBFou2h/6A1iwYbOuazL06BcYltQLCURcLLf6tlI5wtAKF6CF5kH4b5QT84J9/zUX3
	8j8213KfVL1CBkP0bd0jZH1rWZmNOwx0Tf39QAAhkXW8jySSiH/KjtAjiv4nGg+qV0JrobofBUG
	y4ntt6R+qCE5dH+CF9wyoaIPEO/cBQ+gEKlusW7CepIhGhCWUkGcmM+OBo2EguVAppjcJXg1+Kq
	cjYAakmS4n4JyOyXzHts7xWjaGCj4R3EwlHxLmmJs+Jzc4wlzHTC837ljnnFew981Crg9qo5GOx
	1X04cYsaGlPhxrc0AQ3ggAyOA9UrNFAE8i38FIZBluxY62Ko2Q+464ndMQiRY5/OvdIA3DRaxuM
	7z/auHJfam0qaS7UTmMwcsCWxatO7r0dImLG5E8j+wbYrIzBE4I9AKEj4p4FpHiueNBbyvw==
X-Received: by 2002:a05:6402:90c:b0:6b1:cd52:5798 with SMTP id
 4fb4d7f45d1cf-6b4d5fdf3a4mr14456258a12.42.1793877395601; Thu, 05 Nov 2026
 03:16:35 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-b4-ovl-containerized-sync-v3-0-8daa20144f53@toxicpanda.com>
 <20261104-b4-ovl-containerized-sync-v3-2-8daa20144f53@toxicpanda.com>
In-Reply-To: <20261104-b4-ovl-containerized-sync-v3-2-8daa20144f53@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Nov 2026 12:16:24 +0100
X-Gm-Features: AclHuK-spGnE8QR5SMxi-c64TQxC-LWK8IrBlPJQdILHTMjL8cI4wsf9q4-duS4
Message-ID: <CAOQ4uxirA3FC8gukL_o-SE5dgD8LFxQZotXGMiE62VpnOosj=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] ovl: setup overlayfs' private bdi
To: Josef Bacik <josef@toxicpanda.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
	Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chengguang Xu <charliecgxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 9:45=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> From: Chengguang Xu <charliecgxu@tencent.com>
>
> Setup overlayfs' private bdi so that we can collect
> overlayfs' own dirty inodes.
>
> Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
> [josef: only for an overlay that tracks dirty inodes, add
>  ovl_tracks_dirty()]
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/overlayfs/overlayfs.h | 18 ++++++++++++++++++
>  fs/overlayfs/super.c     | 10 ++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 444e28c09145..0ef81c7a9701 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -7,6 +7,7 @@
>  #include <linux/kernel.h>
>  #include <linux/uuid.h>
>  #include <linux/fs.h>
> +#include <linux/backing-dev.h>
>  #include <linux/fsverity.h>
>  #include <linux/namei.h>
>  #include <linux/posix_acl.h>
> @@ -683,6 +684,23 @@ static inline bool ovl_should_sync_upper_fs(struct o=
vl_fs *ofs)
>                ofs->config.fsync_mode =3D=3D OVL_FSYNC_STRICT;
>  }
>
> +/*
> + * Does this overlay track the upper inodes that are modified through it=
, so
> + * that syncfs() and unmount only have to sync those?
> + *
> + * Only with fsync=3Drelaxed.  In the other modes the overlay never sync=
s, or it
> + * syncs the entire upper filesystem.  fsync=3Dauto does not count until=
 it has
> + * been resolved.  sync_filesystem() does not write any inodes of a file=
system
> + * that has no writeback, like tmpfs, and nothing ever clears their dirt=
y flags.
> + */
> +static inline bool ovl_tracks_dirty(struct ovl_fs *ofs)
> +{
> +       if (!ovl_upper_mnt(ofs) || ofs->config.fsync_mode !=3D OVL_FSYNC_=
RELAXED)
> +               return false;
> +
> +       return ovl_upper_mnt(ofs)->mnt_sb->s_bdi !=3D &noop_backing_dev_i=
nfo;
> +}
> +

I had concerns that this is not the exact opposite of ovl_should_sync_upper=
_fs()
and testing noop_backing_dev_info here is not optimal.

It is better to set the fsync mode correctly for noop_backing_dev_info
at mount time (non-upper ovl cannot have non default fsync mode already).

So I sent you v2 of my patch with my own version of ovl_tracks_dirty().

Other than that the series looks good to me but I am lacking familiarity wi=
th
writeback to be able to properly assess the vfs correctness.

I ran fstests on overlayfs nothing popped out, but it doesn't say much
on the implementation.

FYI overalyfs fstests supports {,_require}_scratch_shutdown{,_and_syncfs}
and there are 2 tests that make use of those overlay/078 overlay/087
maybe that's a start for some test that could exercise this code.

Thanks,
Amir.

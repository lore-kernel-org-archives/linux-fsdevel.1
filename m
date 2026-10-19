Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792449965;
	b=OBdbbc6TaG+EN6QY9jqP+S4JANKfhCmK8FIie+CzDvWC+1KToNRRb2GcDIbPoqDgJ9zN
	 EMjLO5e3aJtVsz7bCmSP+sdql7boHncguV/isk8FjlweNmfqqcSGGYxdmnciKRb6LjJFb
	 XTHASlVFl8XPQzXTFmWV8oQs07waAIIOz/Ex0bpufhM+k5z9U9jbqsaAS6q30fiKQb9FR
	 iXsjVBtuJpk57fOQD0vr9zR3MbBv+GAJ5QLW8t+FqDuZ0xlgEPmTmk0S9ct4pWGq/uaYM
	 yWYrGNCqVbEU4KmIEUNPofMp+kgWk9hGZIgghm+VvRvidUbiQDZhlBzWwpkgh/7fR9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792449965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=D+7k2BcGFKfl9vkREhKXPJioddH9mZ6Bo1MP1qgEEWo=;
	b=iqKMwIMPOvMvJgeSUEnFGVZVUcwrhXCJh6FS6MlQvcmTPghkSqZHjWl6/wNo/m+cXtMV
	 6UouVB66L112XeJNk6t9bpPa7eS2YhbxEt7YrrVbHERxOG7QKKNNT7jsVf8DuMR0cLxxo
	 VmuFsq37okdeM8gM9W9iOja4iNS6xTPtrwU5ItTezN907nuim9Du1bNNP23FqjybZMukM
	 lFZ6wchdulhJ8xO4UKpxuQbCfzhLOpFsq3Jd7INini4oqwj9vCfT0c8EpQCIud5wCk/7d
	 PtXVh3HItB/W+t1QLrHQtn/nd+jvCr2TvosZx4QNRfqPPwKt49RVd59RLMGcD8J/WnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=RDqJicOo;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC14606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 22:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AC14606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=RDqJicOo
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b0d63f60bcso20916307b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 15:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792449963; x=1793054763; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D+7k2BcGFKfl9vkREhKXPJioddH9mZ6Bo1MP1qgEEWo=;
        b=RDqJicOomt9XbQibjLRjtRbaBGUhCfX+j3NN6hFCE9Wvtj3loQfVBbW99e8Egre33J
         gyCc4luiLmGRy4BLZAnijILzU41/0DuTYq9EhfV/e/iJoolXDBw93HDFLoVG/WSE17Te
         JoAw1t+wlPZ6YMi4j6muUecOZunxQQ2eWIZf9jRQpQkBNQHHGDzeM/r4slfOSZ1tDMI3
         cG0pxnoMGoyeurLb3Xr1duYHlDAEFEFOHcbzoGSy0V2Yskio9Q+BdvE4ths1z+6FG/oC
         VtfDPlhCbkEPNtVtrXWnsPcWhZ4sC3xSFrRUZx1+pv9KY6nEhqeV3hDc5SrhYy+wQ10h
         61fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792449963; x=1793054763;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D+7k2BcGFKfl9vkREhKXPJioddH9mZ6Bo1MP1qgEEWo=;
        b=lmdujhYo9ElJAx/+a8jkmYGiWbQqLl9WAoqUN+/1jvSqGxyOJ2wNKvNgPE6H3eP1U0
         Nbb0kzYA9vNSmj2aFrUeRD0+k9ic7kVS5UAqfTwAi/Hbkrxn7j10NYaHRccNs4gFEP9P
         eLXDdrbeTy9QBjkrVtmiK8zq5Pk+jwamiD1ZC+nMBAYXPyevqnrKuQwdPuT3huDnYvk9
         YfAq3X1Y4Casm0rNCMh2Fbm4EmxWQPaPCHX6v4/qEI3EtlAIMHutZj5jI/tKPZkOIsWs
         zlw3qAvs1BcbqAczr/MpawJRJUFpa/jhAbA8eHagXYSCw04WRpJ+k1QiakhTnoA51FNX
         Y7/w==
X-Forwarded-Encrypted: i=1; AKwUvBy3UARCxbvCYhqdEbt1WZfLoEU7a6vt00btXUMgGWrM/RNsRwkUN1lFE30xGxy0+wg23brvIcGQ62bpyoLs@vger.kernel.org
X-Gm-Message-State: AFq9FYJtw60JvHjv7rYgHlNCAc0Pgz79awl4K4Urvro0PHEgFgEVpxBh
	E23FRsojwJLoPZFxjvJopfjrpPo+6C5eAe/N5gGXl/WIVqQ/5oraGy0izo6Z3fp46baIbCZA4kQ
	RAdPp0yg=
X-Gm-Gg: AYBFou0U8ug27LLNz23Bb/aeCboznt8ebTYhJvDhWJ+Zde3PxExm0nExFPsXLtKMRTy
	A9QQ7msXNmHPFTIEk2svjd7VM8VktyycLR8rFXqLUX2EE9ZxqaoGzJktzplVx0+BFZ3P6hpQI4t
	gznosAotseJlQZkvbsd0ti5WOrnNeSmAoyzoJgbZiFSGtqGn5qjxMCNYxRvK3UgU0hKtSJyxMFa
	U0d3FQkJ3qSLSqviCWAVxffLrY0MTwlcjb4RSkpdn/nqDolACaIs2Iw/ngUUheqwrx4h713Hiv7
	1e0xP/XiYKIhTRFBIjIRoWHyvwD2uH4w2giEbLB9FkYxeOpoFPOVy4CGYqoBirkR7gTG2Aim1to
	rSqP/ii3yjJbS1jWFJfT6GdNuplafdxnbmsk5a5qXpFN0u/v6q2qRQuxQLpKA9U0ylbmWGxI1x/
	g30hQa9MexFDoXecSaFzvyykURUtjPMzIRJVV7xC4PZYLReqmvzHosXYS7iR8r1gU8P+fWXf8P+
	745wSaZnenU2tjnBrNacHp+elzSXVjWOKyXqaGNCyN674e0VWjlSXQED9tOkI9/XM/nZeQn+43C
	P74rp7h7k+oLJeQsC5jeiuEBpmDQktopCV8csNXeZ78OPzHbWb0/rpy/HDZEatW/
X-Received: by 2002:a05:690c:698b:b0:8b1:e7c:cdd0 with SMTP id 00721157ae682-8b10e7cd146mr14516227b3.64.1792449963155;
        Mon, 19 Oct 2026 15:46:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:3d77:96bd:4263:c77d? ([2600:1700:6476:1430:3d77:96bd:4263:c77d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b11b9cbf44sm5915427b3.44.2026.10.19.15.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 15:46:02 -0700 (PDT)
Message-ID: <209bd8166668e2ca3edce092c0480ec7f56a1fd8.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: report errors when extending files with setattr
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: hengyul@cs.unc.edu
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 15:45:59 -0700
In-Reply-To: <20261017160612.3740256-1-hengyul@cs.unc.edu>
References: <20261017160612.3740256-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, 2026-10-17 at 12:06 -0400, hengyul@cs.unc.edu wrote:
> From: Hengyu Liang <hengyul@cs.unc.edu>
>=20
> hfs_inode_setattr() sets i_size and calls hfs_file_truncate() to
> change
> the allocation. If expansion fails, hfs_file_truncate() restores
> i_size
> to the allocated size, but its void return type leaves setattr
> reporting
> success.
>=20
> On a freshly formatted 64 MiB HFS volume, ftruncate() to 128 MiB
> returns
> zero while the file remains empty. When the requested size fits
> within
> the volume but exceeds the free space, it also returns zero, leaving
> the file only partially extended.
>=20
> Call generic_cont_expand_simple() before truncate_setsize() when
> growing
> a file, and propagate its error. This makes failed extensions report
> EFBIG or ENOSPC.
>=20
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Mostly, patch looks good and it mimics the HFS+ logic but I have
several comments.

> ---
> Compared unpatched and patched v7.3-rc7 in KVM with GCC 10.5 and
> identical KASAN configurations:
> - 36 growth/shrink/error cases per kernel on 32/64/128 MiB HFS
> volumes;
> =C2=A0 content, zeroing and read-only remount checks passed.
> - fsx (10,000 operations) and generic/736 (10 runs) passed on both
> =C2=A0 kernels; post-test fsck.hfs -fn was clean.

I don't see any relation of this fix to generic/736. So, this comment
is not very useful. It will be much better to run the whole set of
xfstests and to check that this fix decrease, increase or keep the same
the number of failures. This run results could be really good to have.

> - fsck.hfs -fn was also clean for ordinary and recovery cases.
>=20
> No kernel BUG, WARN or KASAN report was observed.
>=20
> =C2=A0fs/hfs/inode.c | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 2aef3c36a150..44b1735a54c2 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -684,6 +684,12 @@ int hfs_inode_setattr(struct mnt_idmap *idmap,
> struct dentry *dentry,
> =C2=A0		if (error)
> =C2=A0			return error;
> =C2=A0
> +		if (attr->ia_size > inode->i_size) {
> +			error =3D generic_cont_expand_simple(inode,
> attr->ia_size);
> +			if (error)
> +				return error;
> +		}
> +
> =C2=A0		truncate_setsize(inode, attr->ia_size);
> =C2=A0		hfs_file_truncate(inode);

Probably, we don't need to call the hfs_file_truncate() for the case of
attr->ia_size > inode->i_size. We have the same code in HFS+ logic. Do
you think this improvement makes sense?

Thanks,
Slava.

> =C2=A0		inode_set_mtime_to_ts(inode,
> inode_set_ctime_current(inode));

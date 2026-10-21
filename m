Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792587657;
	b=vEC5+ZuYk0121tDTAFH+wpJqHp+VwLMsRJtp7mZQcP7Kza8ZLRkEhvfQ67q553875gZk
	 o0k5hgWbbQUyXj5HItFR67N+ruynFvHPxD2lc0ReKB93e6l/fOPMoxztKGQmxMhcrVPo+
	 NelQ6EtYD31hBHfLyfN61ALaN+7ynZH4zaOsFklO69yiNzazBAf7mIP5bmRiVDcjYm5zx
	 AEDrBJVemmhz38jZRGU6sHpv2n5G+jb5UwthQFOhGBeLwLSXTtdPHbaeL+kFGR25JVIEV
	 tECj6oY13PEwnUryyv/GDjRpoeZy+iMhwv8/3pcdcxPOFZln5jueY483UG8FgEGdHjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kXoYys6AGDFdddNSuFyoTToCIugSJAhRAIJkUtxGkCM=;
	b=maRonstzG150PDGe9IQ0Po2CrUtv8AoinygzM9tQKkuhWMppYwRk1tvqmkkHZnJhWDom
	 1qW+Xs4J9HrC1XpnyYJuA6/9WGRE4rSf9YO9xmqdufIW3i4ZOrqP68rfJfXeI7qdlCJqD
	 qkJ17GVG6tAgl0YkCseJRIJEFjpUxis/FH6noljh+rDO6cSdJhOCtEK8JirvBSV8it5Np
	 /v0H0oo4xF3OJXsy11nOIRzSVUYOBZS4nerFH5CBmxnG7oUIb0KA+UCrTSlwQTIJrXfTZ
	 0eiRlgUUSshoIZglbIM5a4kzGPzPkKCqbkchcUGftyX9vejiORASVdceI/st+PpPgAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ATuLUQhC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F578606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 13:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F578606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ATuLUQhC
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6af8620a7d2so688960a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 06:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792587655; cv=none;
        d=google.com; s=arc-20260327;
        b=Wa/WkxjOAIflPsHcQVxfGGtV3bH5DTQUqr4VPh1qOAQEqFLS9VTKG7E1X7LDsHz8gH
         vU+NqQGTfPRtRT+kVfA/9sVmlSc5iXZQmtAOsZJ+iJ1WT1wgb97VM9B09sUwQ/N4CNLk
         4mA4fkRDlk23t6cPsdZ5wYRWPX48KBM3CuYpAjED0UHkCKDwsx0EtvtgvqjCuCm527ju
         mZ1yyoLDwVARzrJsrj5UEHCx1xaYHe6YfShYNrRwE14n3BH2B4T042zi1hbtRAr/WUD8
         yinxwz/SZeynOsWzE5alAC8Od62jzneCtWyLJ1RxeBejWTCUdEZo9tJYt/5ClEx6fnIA
         sN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kXoYys6AGDFdddNSuFyoTToCIugSJAhRAIJkUtxGkCM=;
        fh=Te665bsRiEKl1NclpQF/GbBj1kBKlicGkPYqg6DUHAc=;
        b=CRjUN5/kRR2rIuVaQkVr571nbDVFWoMWcsJAhTmn9InoNMfNyo7VQc1+jdConXSHz6
         vgZwkNTbzGq5BNiLKScj/0e7Eb4nf0YrC6K8cI1w21ZSZZhHI+Y6cURZyYfEl65+HvI7
         3j8dA7tYWsnf6ym0MDiHLRAw/iHfU10ymCQRGtf+UJj4PhqbBu6r9VFiyeQNJFV/NPjL
         seBTV8M/fx+gZJ1UZUoGCPOhNBf9PV6JqWi5Y68wnX90F9JO8KFFnL9pAh6kGF3pYBiE
         rhz/QqRDJyE2kwKJjd+v8eA/x8iynfoKGRH7pngmqDCmihoKujd9ywmA5QBzJWCwY6tx
         XYUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587655; x=1793192455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kXoYys6AGDFdddNSuFyoTToCIugSJAhRAIJkUtxGkCM=;
        b=ATuLUQhCm7bNIC7Md6XGQY4GFQFK3oqAfo6awLZkDZVz5OvwY3So3XmmwcXFeZlTQc
         BgK6u3qgRI7hnMYXmWm8GvYPSVi3782HLsc5x9MxY5zGwodRLFAjVgituIjKB7igSnfw
         HkYxVqgGTrc5cbJcX8MLQnQ1MXbYv0Om6QUndvOcu/XjVIRX8hwCj47gXOVGdXEMru0I
         BRPD3BDq0VVn/hf9bKWIHRLb0UsfBQjmTMIVWtBLCJTVvLojZnoSUiWMxnQQj/ldGL7n
         eCXROZHcz0+5Bbj/i4GK+B1jzceI04aRQUhDIepgcD+2NA4Fkf3XPCK+2MPcL5tA5C0j
         MAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587655; x=1793192455;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXoYys6AGDFdddNSuFyoTToCIugSJAhRAIJkUtxGkCM=;
        b=PbqEJJ5xVsdXFNcLfxd4JDXr1qnS42+RniH4O4QSI9n1z8OhA8EFFjb7LLVADjGTaV
         3lcEYo2+sEko7bGXJRiEGEokFa1x5XLfrUPSoZ7IXhc0yrjkuDJ7Wrdd7+HW1qJVxZUr
         4/E8ACW2ycdG8TKbCgWrVYAD/aQl77gU3WlqB1enOXpeAbFeooicg77kdXADSHmEXEO8
         HiA+I+A92P1AwQF0JWoizqm1t69qDTHiHYB9Efyrz8znyE267Gzc7uOns9gk5gQK7+TQ
         9+mrGItO35CNJjyGfc4BSXKWXfZah1PcxpKImpu0xelf1RTmwteyu2tH/E8iGkYmiRaV
         csEg==
X-Forwarded-Encrypted: i=1; AKwUvBy9k4nNAQ2x+P6wVPVvPZtWbE14uDIDpafVaHdTlj3CdsgatxnNm2vdprSCzaBvCubToa8fcKz0T7lmhIiO@vger.kernel.org
X-Gm-Message-State: AFq9FYI+pSEsHQBH5BuL4aK/26Sgy40SsyT9hYxh72yjG+HDfKRZmeiq
	A+YVsQr4xOSBFHejA7I1KezakdZeNZh+G+WGK+LZ8YoUa74/9QmvSnATOjYZBUTp+sb6Eeuyq6f
	sSbDxzVrdF38833Mf8wVxQB4XIQaKjrc=
X-Gm-Gg: AYBFou0Zq8KEct/Xx5FSE8BH2M+0SvbWtG4B2C3w4dYsl2lgyINTlKzMwWtmaS2yyJR
	CZW5hi81bgG4zFmemsN+Ke0q/tdfYFqV8rUpTYjPGLe0F2LXJkk45GF4rns6S0LkFBjIaupCCyh
	HjuSYIQu30Ck699nCLxpKo3exE4gYOY5frOeyJsyzDL1ygFlHwPDnOSO/qk4w7JAnCJ4z3Hr35V
	Itxmm7WiwgRN2au8ucmwAWJ0f03u3CPONmfK+s7ruIO9HP2szaR6jLETfq7gp74GO5SLGPbt3uk
	4Q71Q22IY7VwvObkOWZnWgignmHDZFPZ/XZtkN4HKDnAaTMZA/TXg2ryO2Gn3uvVrzoDsnEAL6M
	256VwTVN3PAiad80VHli45PXfgDd8R9LG34/e
X-Received: by 2002:a05:6402:280f:b0:6b4:16fb:b9ba with SMTP id
 4fb4d7f45d1cf-6b416fbbe8emr581616a12.36.1792587653646; Wed, 21 Oct 2026
 06:00:53 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260924112858.51392-1-disgoel@linux.ibm.com> <20260924112858.51392-2-disgoel@linux.ibm.com>
 <20261021-erbschaft-gefahndet-erklangen-085a518222a3@brauner>
In-Reply-To: <20261021-erbschaft-gefahndet-erklangen-085a518222a3@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Oct 2026 15:00:40 +0200
X-Gm-Features: AclHuK9WcoBrCyRwmmWQl42Ua6CkryoBn_QB6lJW1f-3Kmj5TuvGleJ2mOxIsU0
Message-ID: <CAOQ4uxgO5xW39SfBEfM5yS4uV7M6_zZu7kVP++bNwML2s6ZPsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ovl: fix wrong layer paths in mountinfo for detached
 mount FDs
To: Christian Brauner <brauner@kernel.org>
Cc: Disha Goel <disgoel@linux.ibm.com>, miklos@szeredi.hu, viro@zeniv.linux.org.uk, 
	jack@suse.cz, shuah@kernel.org, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:56=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Sep 24, 2026 at 04:58:58PM +0530, Disha Goel wrote:
> > When overlayfs layers are passed as detached mount file descriptors
> > (opened with open_tree(OPEN_TREE_CLONE)), ovl_parse_layer() uses d_path=
()
> > to record the layer's path for display in mountinfo.
> >
> > d_path() walks up the mount tree to the process's filesystem root.  For
> > detached mounts this walk stops at the anonymous namespace root instead
> > of the real system root, producing a short incorrect path like "/l1"
> > instead of the full absolute path.
> >
> > Export mnt_is_anon() from fs/namespace.c to detect detached mounts.  In
> > ovl_parse_layer(), use dentry_path_raw() for detached mounts instead of
> > d_path().  dentry_path_raw() walks the dentry chain independent of moun=
t
> > namespace and returns the correct fs-relative path.  The path is
> > display-only; the actual layer_path used for mounting is always correct=
.
>
> I think that's nonsensical you might end up with complete garbage. We
> should think about a custom format so userspace can "label" the file
> descriptors instead? Amir?

I wouldn't bother with that.

I posted a patch (you will see it soon...) to fix the test:
https://lore.kernel.org/linux-fsdevel/20261017165103.2450042-1-amir73il@gma=
il.com/

"/" is an established fdinfo path for a "disconnected path" so I can live
with the existing code as is.

We could also label those paths as empty path "" to make sure that nobody
tries to replay those bogus mount options from mountinfo, but really I am
not sure it is worth the effort, considering that it is very easy to
see mountinfo
with paths that are useless for replay (e.g.
upperdir=3Du,workdir=3Dw,lowerdir=3Dl1:l2)

Thanks,
Amir.

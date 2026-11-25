Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610996;
	b=ZYerTfVp5PXBrN6TZjRZTdg6wR4oGluVZ35V1m6KkmN1EWSPDRABUbI6cUOQkcYAg3SE
	 o+AGfzObUXhQHHCb4bMmZirtWmVzthdAphAzM3O5i4JBi8bpXvtJVJtZmLebR6ylcCHGo
	 3YyN6YvRqEaFISeKJhbHjOq0iH1aJx0Z2qHJTqesyQU8MmNn6/B3WrelfGz91/9myXV9V
	 SP6iZY7gAMb5igcWr6SMS0vR8bKrbypx81Z5bweP3a4yiz/KfCh5y/Z7Gw4Qq5xcckcTu
	 mo9nZTJX6QHDGyMfIiMHNiog7/xYt2GNJmizPDKNyFtn6G9+A0pypc6rPkIb/SSbD5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
	b=wp8LWPnO/2obMeZ+ahVaF1XctATKKBZB/LwazKFI6l1OZ3lBGxycwdit0hqU2ulE3z1l
	 C1c1F/bgc0N910vecTS/15a72G8TYZ6DpztwFPh6CLb0CSosM74VNRr72sX8NCfSIShzH
	 XLwSl/NwI0GkEEGVKEQThb+mcUhLh41PZy+jICvbRdC2HrHvtQ21fqcgDLXzuJcQRDHi0
	 xD3uUHTDc7pXFKp19fvFzztdG3IXD7IG6yDKR642E7zo5i7Un4eVOlI1tm4Xd4mMt1mKa
	 aCahbS4eU1yh6k5bak12HN/CIHxo1da1o1Ap+UeqXS46pkqGKVbwn5hJ2begDo0YJ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ijrvPjrs;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11766606A327
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 12:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11766606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ijrvPjrs
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e3b22e971so3005038f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795610993; x=1796215793; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
        b=ijrvPjrs4XPMGxLv2/cLDzYf1DTkp26koBrs+YwuqX5elYJruc4hClaOIjF62Q3+YN
         LRHIUBC22PWGF/rAGALu7SoOt5zqUHESVTCa5vHMQJoFy4B5gkLHeV5hugIirMLPKc1z
         lwkIjSkykztPQpKhyKTDraxT5P3oaH7NzwApTcr02ARr2hT5KerzhwRvxghSP1A3P/Bp
         EtgDED95aoU7Ek6mxljMaLWO6Bx5amJKRdXl3ABZkqxCYsSCC5SlDmTZNR4DGfcavrRk
         HtSpSZ/UepV+pwNgpwEHfsqbflJPpiVU5KOF/FpJhp5lP9+HVdK4ulKpQ0NMqA1E55T/
         7WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610993; x=1796215793;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
        b=roBQ/3EtMz0Ax9GxFGWi+QNSl2XQTvKt3F7EIiTp+3r/VEChDdQU2fbzscAJygpDsZ
         BJsb+89Wb3tOy2YZc+9SuT1mF5kVcaPBdESNAIaoon4gyEM0mNeSdtYfBgIjUjIAfN3h
         eZgTaIld9J5UQMrUjsJJCKEfWXJj97z41o/wjiZF9004hm+vNQc2hKWsRC25hcBFBKw7
         0BeVGpxEwbzmDkJlRRkackqh/YzPb6u4An+Gao/uiGo1lTuUQq19KMOt7OBMWWOcbvqL
         4yg0KE6GnZT3ICb0xDmQq4ubTfcabRpxabJ1CLSXg0o7LPSTd3b6b1Zre2aSDEMpCcx9
         UsgA==
X-Forwarded-Encrypted: i=1; AL+hErG9/Zv9z3bngRWeEI6UBiH7rhJu1kU7kWpK6o+LK1jDFbLwjo8ywN19X7WjM/jxrYdGcFXWUP75oXWOaANk@vger.kernel.org
X-Gm-Message-State: APuU4Z9/f3ZxEV7c79CIzhoNH1K+9ZMULDdPGaIzOgEM+hxPeYy6QLtu
	ZGNun3M6Dh1uBsgrjsMiWDk3EuZAF+hhwFEk68JOl71oNo1ESCq2WsWXJqdvO3NV88L6
X-Gm-Gg: AZFdTZfknAfXAyqp62OvOi6Ip5IzRxG6Bx91MjelwpCmW1hkYwzM+VtqjAQlxGEsiHo
	GYXdfPysDQg30gFk7v3jzABifov1TX7vVp/AN9b5oe4vYGC2oaDhErzepDMiqDp8xBMVvktgJGk
	hNaDKvHNaJHUAx8+OazlghkuJdQUAIO2y9KyA6nw6zTbzyy3lyGxQJq0F1TOm1azZkhbGPWYzml
	zjhsw+DnfRvNhbiObKEOt+QisHketZGfsjbWd84PiIDjquGIt0xi4/bZmwiLZ56Gavgl5TSJqcM
	U/qdrcx5Eos53OX+GwYxNgB8JdcsGGFjjNeor9fOS/g/ofN/J4L1OW0IErVuJvKr4nUyVlU2xXT
	Iils1Gb3E1xrbpMVBgzRhhiWAvRG/fNID50uco1b7ld3orlATz0rNyhe3OuKL08CY0Clowux3wT
	Ar2qgMMmQ9DoojiAD0EW1SMrdJ7Amcfer0Kgx6cAAj38svsBlwmHtGyfTB3EKPhOaXwdFwKVgAe
	EuTefYmVN99ci7KYB2gQpZ4IJ/4pv3U5uGJm7447oV6YlpIvNtVyXV06gGHKNog2WM7X0Rpo91d
	bf4eQ0Z8/n/KvLzdeL1ovYWdJj7xaiuoGUkN6rBiBE5ok5/rUsubAgkpFv1zRPx9AjPwpnMa28G
	gzMggnYIVJ7mdjwG8zT1zzR78b611Jgn7gjXGfdoqKnrXPezekkfG7w==
X-Received: by 2002:a05:600c:a11:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4bb888120famr364999585e9.16.1795610993400;
        Wed, 25 Nov 2026 04:49:53 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm710678895e9.13.2026.11.25.04.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:49:53 -0800 (PST)
Message-ID: <34297f66e07c1a64d81205c7669801738676f356.camel@amutable.com>
Subject: Re: [PATCH v2 11/13] fs: remove d_real_inode()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org
Date: Wed, 25 Nov 2026 13:49:52 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-11-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-11-90564c4ae347@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 10:44 +0100, Christian Brauner wrote:
> All callers have been converted to d_real_data_inode() or
> d_real_metadata_inode(). Remove d_real_inode() so that any user we
> missed, or one that gets added in another tree, fails to build
> instead
> of passing an ERR_PTR() from d_real() to d_inode().
>=20
> Add a porting.rst entry.
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0Documentation/filesystems/porting.rst | 10 ++++++++++
> =C2=A0include/linux/dcache.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 -------------
> =C2=A02 files changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/filesystems/porting.rst
> b/Documentation/filesystems/porting.rst
> index c38f5df755bb5..aa0fc43907017 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1422,3 +1422,13 @@ helpers take a const struct mnt_idmap *.
> mnt_idmap() and file_mnt_idmap()
> =C2=A0return one. The idmapping is immutable so nothing should have
> modified it
> =C2=A0anyway. References are taken and dropped via mnt_idmap_get() and
> =C2=A0mnt_idmap_put() as before, both accept a const pointer.
> +
> +---
> +
> +**mandatory**
> +
> +d_real_inode() is gone. d_real() can fail for D_REAL_DATA now and
> returns an
> +ERR_PTR() then, e.g., when overlayfs can't look up the data of a
> metacopy file
> +in a data-only layer. Use d_real_data_inode(), which returns the
> inode hosting
> +the data or an ERR_PTR(), and handle the error. Use
> d_real_metadata_inode() for
> +the inode hosting the metadata and handle its errors as well.
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index fd8853622f250..fe1aa8fea0c7a 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -654,19 +654,6 @@ static inline struct dentry *d_real(struct
> dentry *dentry, enum d_real_type type
> =C2=A0		return dentry;
> =C2=A0}
> =C2=A0
> -/**
> - * d_real_inode - Return the real inode hosting the data
> - * @dentry: The dentry to query
> - *
> - * If dentry is on a union/overlay, then return the underlying, real
> inode.
> - * Otherwise return d_inode().
> - */
> -static inline struct inode *d_real_inode(const struct dentry
> *dentry)
> -{
> -	/* This usage of d_real() results in const dentry */
> -	return d_inode(d_real((struct dentry *) dentry,
> D_REAL_DATA));
> -}
> -
> =C2=A0/**
> =C2=A0 * d_real_data_inode - Return the real inode hosting the data
> =C2=A0 * @dentry: The dentry to query

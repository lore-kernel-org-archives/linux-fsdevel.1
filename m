Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610732;
	b=pWKKN8LA3lBoEyBLV4b5gwyrdZo+TlFzCQ3W2Rn0kWCqNk6CdFAqs6b6HWw5Z9Knr0yz
	 0qLFjiIjF/WOQrnjpcHiy41pKOh3tXfD3wj6OgtQpVazE/H0wLK9h1Vla8XfffTUuAzeL
	 ZU6XXnnz0sLV1wykJ4btsPSYDXBhnd9157pCGKShX0h2FOWmYJWjf7wU/ZDwNZqPHxniH
	 7iThyRqSGowAY8OAQ+nQyB+yPjrrEd38Q5Y5IrlwQ1vSNZCmVPPUcnVVOINsk1lOIVxjW
	 ObU2e40hTEs1uNz/WDrWXHgRc9H83wfdLbHjyK8++yBNio/6xANNsoYKRDDpIw5ga+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=j8tGJOMZL0j/KUQBnDfeHMeTQs27ZK0iqIQ4+ayeZUU=;
	b=BTEfoEVeHoQaG+I4ig+XP+blEBCNAYUqus6SHUer+gxPeKWYAi2Z/y/x5d86f9FDgNqd
	 VqCuL/OldPfZ82SRWKGLDk95zbPVcFHZkCXB5BAalqc+PjbW3f3kK8KyPIPtfeNjJVuoz
	 xXRWHsF+q45+2PIcJ4sASvCTqnS4txH+ksVvxJOlcT07bPeR+uNNSuuLfHLR6Jn6iGjxU
	 s968SwRjCnEWYujayPX2lm91lzDfl1RVto+hjk2WcziihYMKWtn7e0I6GHgyPwtVzHlT5
	 88CCI2jyiHay4PUMJDHM6i4MIKnsCtutRBOckIJ2pglfNkjmIZnkVME6UrChVnoAXPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Dn8fSjUJ;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F5606A329
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 12:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E44F5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Dn8fSjUJ
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso53013045e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 04:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795610730; x=1796215530; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=j8tGJOMZL0j/KUQBnDfeHMeTQs27ZK0iqIQ4+ayeZUU=;
        b=Dn8fSjUJZ0W18CxI0+QBCtqPSCauc1BDi2lAYnZcUk/CGqeLcNTTMRBQW33oo9lIRF
         +qyvu2+iBnTdmOFaW8crfcRdDgjN3stD2TkOd+qiSFU64QZ91RZmDEemG0ULNn1RY3iC
         YFRu8prBJbwhpYRseFCHzdI0Xy1Rs6KvgbX+GhlEhKqDdK0OiWEd9dn9waUHZAoXcjMT
         SsjAuOt7MYheWutuyfu5btVDQIYz6unWA7QWHe6zy/Iegke+cOWGKKoWX05Ks4iYqUbX
         fZKTbaTyilEi/ETmhcznlr4c5D33jgH/U5Dd3FRA2SHdt5WUlH57N475qAk82MjsS/J+
         uPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610730; x=1796215530;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j8tGJOMZL0j/KUQBnDfeHMeTQs27ZK0iqIQ4+ayeZUU=;
        b=1PF1+6nvksoXmS+RlTlmZQFkY6FAaprH4IueQ+x3EmKV/zV1p9pFNHhG270ZlXGR89
         sCG1eMTQZZ8vFzqIky5jcj65oLiWN/gcF1VWW9Ldbax6i7XZWiTOUeWEOrPZcStqg4tW
         cAP66A+qs1Lb6Qtzw7vIk28KhBqpcUXg5aBYB3RO/p65qdzauS3Mv8WA+Loc6wxve7nS
         nBhF1o442O2T74Qe/jOusM+rhQyDSaIV1B73yiIHdpMNu1XBBwFB7KLaP4pgAZ+DD+tr
         0+hjfXfs51f6IxPD1HP80Hlif5GOIPu/04MGE/oSwxtfzdOolV4sDy2Kst4JkZJyt9s9
         GR+Q==
X-Forwarded-Encrypted: i=1; AL+hErFEqsQRQwbwEkT4rvwmZq5B41PzsgZTpcBMZjUVKxr3Gz8IRvSBR0HajoiPs/RWPcpNM+JOtiXMzwqpmI5n@vger.kernel.org
X-Gm-Message-State: APuU4Z+eLJuvb8KjfUzcfIYlDMEHVkix5ndpPeUo0jkZgjLRaaNft2Mp
	OXMLJpVqm8hATmeY8UwBGcGJuXwZhzjBEHdeNaD4jFxs77/j/BzfC2F5UP+d5mdhfKt8
X-Gm-Gg: AZFdTZdapXwUkfgwCnv2bkt2QNMxUBumgudZPecmWZhp79sienO5xlxEvh9GgCAerqp
	0OJ2HDPxUon4q1UirU7REDDOImi7QNLwMEsB7UwrAIHsjKku4wfUyJUfmwAgR4iXEKwkuxj3Bay
	zAq56VyqiICQYOsGYNqb5rbUck5+wz9jeBNCNYf6zl6mPLo0JCXC9GTmlC+7Sd18JDrT5SAySFc
	l7HP3nsqEq9MAQWuwPSKneLjiE1qTtm23Ohg/4K7QZmML8XZhdEhPBf/SWlwsWO0LOO/+kptNZq
	tXEMH24EOVZ9GTp5AysL00In0vLZxJUsdjtLTw5d44ZBAoY37Vl2p4tVoHxLhaysXfCix/pI4f8
	KkKkfrlJ6HeK+6AeOPidE0w4UFE9FyJPMGx1aF2kI0xK+JmjiND32FUS/hUYogMFJgOeOlHl4vJ
	T1+LGRD9+CH5dChECMuEKn6yjOyMGtdxwIPzUFxsGclCyqEQghfkY7J3AbzFb2LVn+W2MRDL7w9
	anD/2grwZ7VYdooZSJ80JSG9xJdAbSQ9toECbSxuQrkzoib8PL6974nZQBu/WIOlRY9msaRZcKw
	03e1/AJLp/cDzej2Fr42W+jAV5xcL9614peU7qYroBvmxNmgHhehOcBh5bgZbA89wBkOn47Q2U8
	WUv290Pl7IwL55zrWNAxu0zhiMTg2hfYcJhEgFXTsXnyFPsZ19qxhcQ==
X-Received: by 2002:a05:600c:8184:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4bb8881e969mr338093175e9.28.1795610730212;
        Wed, 25 Nov 2026 04:45:30 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba3d3679bsm34001885e9.2.2026.11.25.04.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:45:29 -0800 (PST)
Message-ID: <9f460569c2d4236f470231a5cce0b6086c612e19.camel@amutable.com>
Subject: Re: [PATCH v2 02/13] fs: add d_real_data_inode() and
 d_real_metadata_inode()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org
Date: Wed, 25 Nov 2026 13:45:27 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-2-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-2-90564c4ae347@kernel.org>
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

On Mon, 2026-11-16 at 10:43 +0100, Christian Brauner wrote:
> Currently, d_real() can't fail. When overlayfs fails to look up the
> data
> of a metacopy file in a data-only layer it hands back the overlayfs
> dentry and callers silently work with the overlayfs inode. That's
> more
> problematic than current callers realize.
>=20
> For trace_uprobe and bpf's uprobe_multi it means uprobe_register()
> fails
> with an -EIO that has nothing to do with the actual problem. For IMA
> it
> means the stacked change detection is skipped and for IPE the file is
> evaluated against an inode that has none of the properties of the
> real
> file.
>=20
> Teach d_real() to fail and teach all callers to handle errors. This
> adds
> two helpers for the callers to switch over to:
>=20
> - d_real_data_inode() returns the inode hosting the data or an
> ERR_PTR()
> =C2=A0 if that can't be resolved.
>=20
> - d_real_metadata_inode() returns the inode hosting the metadata or
> an
> =C2=A0 ERR_PTR(). overlayfs never has to look anything up for the metadat=
a
> =C2=A0 but we don't want to promise that it never fails. So callers handl=
e
> =C2=A0 errors for it as well.
>=20
> d_real() can't fail yet so this is a pure preparation. d_real_inode()
> stays around until all callers are converted.
>=20
> No functional changes.
>=20
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link:
> https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJH=
H9T_Yw@mail.gmail.com
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0include/linux/dcache.h | 45
> +++++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 45 insertions(+)
>=20
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 84b0cfe4ed0e7..a75016a713d4a 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -3,6 +3,7 @@
> =C2=A0#define __LINUX_DCACHE_H
> =C2=A0
> =C2=A0#include <linux/atomic.h>
> +#include <linux/err.h>
> =C2=A0#include <linux/list.h>
> =C2=A0#include <linux/math.h>
> =C2=A0#include <linux/rculist.h>
> @@ -660,6 +661,50 @@ static inline struct inode *d_real_inode(const
> struct dentry *dentry)
> =C2=A0	return d_inode(d_real((struct dentry *) dentry,
> D_REAL_DATA));
> =C2=A0}
> =C2=A0
> +/**
> + * d_real_data_inode - Return the real inode hosting the data
> + * @dentry: The dentry to query
> + *
> + * If @dentry is a regular file on a union/overlay, then return the
> + * underlying, real inode that hosts its data. Otherwise return
> d_inode().
> + *
> + * The union/overlay may have to look up the data first. This can
> sleep and it
> + * can fail, e.g., because the data is missing or because its verity
> digest
> + * doesn't match.
> + *
> + * Return: The real inode hosting the data of @dentry, or an
> ERR_PTR() if it
> + * can't be resolved.
> + */
> +static inline struct inode *d_real_data_inode(struct dentry *dentry)
> +{
> +	struct dentry *real;
> +
> +	real =3D d_real(dentry, D_REAL_DATA);
> +	if (IS_ERR(real))
> +		return ERR_CAST(real);
> +	return d_inode(real);
> +}
> +
> +/**
> + * d_real_metadata_inode - Return the real inode hosting the
> metadata
> + * @dentry: The dentry to query
> + *
> + * If @dentry is a regular file on a union/overlay, then return the
> + * underlying, real inode that hosts its metadata. Otherwise return
> d_inode().
> + *
> + * Return: The real inode hosting the metadata of @dentry, or an
> ERR_PTR() if
> + * it can't be resolved.
> + */
> +static inline struct inode *d_real_metadata_inode(struct dentry
> *dentry)
> +{
> +	struct dentry *real;
> +
> +	real =3D d_real(dentry, D_REAL_METADATA);
> +	if (IS_ERR(real))
> +		return ERR_CAST(real);
> +	return d_inode(real);
> +}
> +
> =C2=A0struct name_snapshot {
> =C2=A0	struct qstr name;
> =C2=A0	union shortname_store inline_name;

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597256;
	b=lW3SFyHjU1p+cnwIjMj/SaHbz8W18zaJHZceK6eZxaONkdz6EW1ubBKrwZro3FudRk9P
	 s5jFo0Y+M+0e4uMdJhGZEZMR+3CQpJeLZhD5WxgVLqeIdcAsOpRDLeEvaWPUYtF+4rF8r
	 CDnRWWwAHeEPeLNQwz2NBt38viHBzZQhccNScpYjtJqCz7ugVhY4s3i5OBDKvKSsZF1cB
	 fC+RQ+Irefmbs1EW6M8vrWai+2JaaagzVB0255rk8w11sSVAbbyA4Oi5UIqY630FTFIWR
	 MpGqW8Gcloggegot0mcMuunmxFvm6+QjtIws6NAwtd4PGZEiTpLEYPj9L1pTCDaqblw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=naomhjRVZ+IJsznibpYW1bEFswFz05AA59NadPrGXtI=;
	b=j//X+K/c0kdIsKj4UVnQ1Fac8Lw/40uvEFGOw5XSWJezCuYO0zRBPMVw0nLS9l8LNVR/
	 OqjwmrkhkbpCqHpcT5biUXosM+SzMCumARrCJu9c8waDt6BqGr6x3pkP55BnWqrP5KX7Q
	 0KvlhP1plStJtwaqZpTHQbbJA0Y3Z9QEg/32g1OriuodCpTkchN46TwBu7WAOkQelwupD
	 q+xzN2HmQ/o5DDvlJOzktOO6+tBABdtSys+2LQGu4nDhzXPC/aFswtCoxI61LufbvXnRf
	 lDfaKU/sJEfzkecRrhjJX1Mw/oq2RBl46iv97gxAdqJqtGZjliPUrihsA3jzaoTqK5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jm+wy5yg;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A615606A882
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 19:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A615606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jm+wy5yg
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b30cbfa628so13883257b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 11:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794597255; x=1795202055; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=naomhjRVZ+IJsznibpYW1bEFswFz05AA59NadPrGXtI=;
        b=jm+wy5ygWGsdY+Ma+99qkE8tcIX0YUU2ekNVzRJEIKwI8g5X0mZlvtaSJRJW3sV7Pv
         DUGnWRWzb3Lkx4JaDT3Ebx8ecJItSNiUOp5HA45GTWTPRwQ2AuANnucylGfv8H7NJCUS
         BVilqj4f4Futpa8fT1Mt/lS6IRv3ST07SGUj+mJkytFAZlzfbIvZReMU/VZJSGuhY1xx
         EkBRgR68kFfGEuobFKAgoyvOoe5TeCB3r5cDMfKsRB8cPHVqt9LO8/mF15gcBpeyUnwT
         6hq5YiCoV/CBJjuWHLxlnFRkpM9Jd2bj83D4CP5nFjqvNZMqJoQbV976KtVyEbwE1/tO
         72Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794597255; x=1795202055;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=naomhjRVZ+IJsznibpYW1bEFswFz05AA59NadPrGXtI=;
        b=YtXi4dy3MDCYMIvXqCNzXJZuI5O4tIjqdzC+VH2l8Ln3ouUcVgfBEewdpE3sqVrRrl
         pmLYKLFR4KdGlSl0BOdUuEgDiDsZV1DyHOThF6JJgYrKvlXIXjDfSkf8AwUyDy9uG5j0
         lxXJsAUlDiD1deT9oidMqphrp/WwDl9owhQRn1FcL5+tN9BclWvwepcT3kJZg7FJpa5N
         6G5edoK21OlKsrV8Do+xy6GUvFPvwo0ecBJiSllCyAaambeVkchNfDfLbXeWGw6GObw9
         Y8plxP6h+qFd/y7Ral2neib3OmaJHuaHKDjo1hgok8IPVtKjPVHrSHmz57hb6lIC1A5d
         O4Ug==
X-Forwarded-Encrypted: i=1; AL+hErEERZwDGSaRJMjTN4On7A46F9RJ51Xyjctw4IkIuIBoksKMpbdThdR2vZnlDy4N0ry1d4+f3vPMbiksfTML@vger.kernel.org
X-Gm-Message-State: APuU4Z+SkKJKHpl6p+mpGcNUGZwYtDdM6CdzkHd0+sJVpG1TIVzI/11l
	AlIeSBrhWXcQaSk58IhRnfptf/KANNmZHiSKPsjGMjbNmnNR7PdMGR9IZkkAV9Ho9zEAIkkOIeb
	R2m6bqO4=
X-Gm-Gg: AYBFou1yswe3ZG8Gd8e6F/PQGa+pcUMFqrTV4M47kKu1JFN5jrOhNKeOM+Kn1SbpVGZ
	gEsA6IA78chhwBtzfOW9s1efAJAhd6KU3T7XoQRa/GsHVNbrhAX316yV1Q8goSvPIr58DvpKPGj
	XIt3bGkUveNGTm++eaHZB2CpvZpxwPy6JdcOunhQ85QX7L1CJCeSerqkJ5TLcdq7qmA5evEWyYA
	KnzPfp2AcZ6fi2VkvvSvI+Q5YudcPYVkOOT2zkMTuup3o0Zn5t0o8y7oatHDvk9qlkVjG0jSsDh
	0G7OyCkuqxkygSxkuMgJ4TMQr+EMNbKVlvLf4M9zUULS8ncZIGxM7OTuI5QSWQKJ5w/mhiY8Svd
	mHJUmiLV9N3wmjlwtdw1su7NvDIRfCbnXZ/p5AePx5npXp/KGmEaQuRUJpIzyt3h1N0nZINZWVq
	8QiqcXc8JMpZGRTYGGN9JAASanqyVC+AeLcZV7cmdaJzKC1f113qvjk9ZhS7MUkOP6EO3kKyeoB
	W/ljnJFQq3ThCgA6H1yRPPPdzrmhb3YQ7GjYpp10H5iBMyS4xfxWfoi+tJyNZzNOLtdVYvC/RUn
	zp9PQZd4KWWp+cZfxOOJ8fWRBv/9CsjDuK4kU5E+GCfN6k7roAs8GlXVqohns1bXGbYsvU8wKhZ
	EkW1FVMWdihvkR2rMw476U5w58mPy42mOlSDqStgyYR6StlITYgt9nhxqRbXI+tbMR6dAG4vH3U
	tiYetnBMD4URkdnNehYCI=
X-Received: by 2002:a05:690c:e3e7:b0:8b0:ecb2:8861 with SMTP id 00721157ae682-8b4aa327872mr23049057b3.63.1794597255053;
        Fri, 13 Nov 2026 11:14:15 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:93fe:5aa0:2dc4:7807? ([2600:1700:6476:1430:93fe:5aa0:2dc4:7807])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aaa0ea50sm26909557b3.42.2026.11.13.11.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:14:14 -0800 (PST)
Message-ID: <0a8b94b8985ca42018f840eaee7c8b4fb90b21ca.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 13 Nov 2026 11:14:13 -0800
In-Reply-To: <2bbc10eb1dd5ee69329a9307f14fd15b1815b898.camel@dubeyko.com>
References: <20261112110128.4082071-1-hengyul@cs.unc.edu>
	 <2bbc10eb1dd5ee69329a9307f14fd15b1815b898.camel@dubeyko.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Hengyu,

On Thu, 2026-11-12 at 14:34 -0800, Viacheslav Dubeyko wrote:
> On Thu, 2026-11-12 at 06:01 -0500, Hengyu Liang wrote:
> > Commit a06ec283e125 ("hfs: add logic of correcting a next unused
> > CNID")
> > made hfs_correct_next_unused_CNID() lower the next CNID after the
> > newest file or directory is deleted. It takes the CNID of the last
> > file or directory record in the catalog as the largest CNID in use.
> >=20
> > However, catalog records are sorted by parent ID and name, not by
> > CNID, so the next CNID can be one that is still in use. As of now,
> > creating a file after deleting the newest one can fail with EEXIST.
> > Commit 6592287869bf ("hfs: fix incorrect inode ID assignment in
> > hfs_new_inode()") exposed this issue.
> >=20
> > The issue can be reproduced on a freshly formatted HFS volume with:
> >=20
> > =C2=A0=C2=A0=C2=A0 mkdir z
> > =C2=A0=C2=A0=C2=A0 touch a b
> > =C2=A0=C2=A0=C2=A0 rm b
> > =C2=A0=C2=A0=C2=A0 touch c
> >=20
> > Without this change, the result is:
> >=20
> > =C2=A0=C2=A0=C2=A0 touch: cannot touch 'c': File exists
> >=20
> > With it, c is created.
> >=20
> > Keep the largest CNID of the records in and below each catalog node
> > in memory, in leaf nodes and in index nodes, so that the root node
> > gives the largest CNID in use. Adding a record raises it in the
> > nodes
> > above, and removing the record with the largest CNID makes them
> > compute it again.
>=20
> I am still not sure that this approach could work. If we haven't the
> thread records in the b-tree, then we sort records by parent CNID.
> But
> folder can contain child with any CNID. So, if we keep the largest
> CNID
> in use, then, technically speaking largest CNID - 1 can be located at
> any node (it doesn't matter if it is used or not). Even if we found
> node #1 with largest CNID, then it doesn't mean that largest CNID - 1
> is located at the same node #1. And even if we cannot find the
> largest
> CNID - 1 value, then it doesn't mean that this value hasn't been
> allocated already as child CNID of some parent CNID (because records
> are ordered by parent CNID). Are you sure that this approach will
> finally work? This is why I started to guess that maybe we need to
> think about Red-Black tree that can keep deleted CNIDs (however, it
> could be not efficient way).
>=20
> So, I would like to be convinced that this approach can definitely
> work
> before taking a deeper code review. I suspect that we still is not
> good
> shape yet.=20
>=20
> >=20

I've spent more time considering this patch. Probably, my worries could
be wrong. But the main issue of the commit message that it contains not
enough details about the problem and how implemented approach is
solving the problem. Could you explain it in more details? It could
help anyone to understand the correctness of solution.

Thanks,
Slava.

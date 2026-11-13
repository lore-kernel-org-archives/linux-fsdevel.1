Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564237;
	b=yGh1daTaxMAPCQfJF8xbtCJ+lR4B/Hwi375uv0Gh5f39lBkFxqfjMeyp8Ih3nH33sVBU
	 nn3jZH7oZleRnVsW5GB36eh6uqhvG1uq3Cl1H/jyi1qE8ef+ZjK43fa2UGoB+7BHDN/D5
	 kXljoryY6zQEHh6NjrdzrZpl32ODOTKXIQjf79lJ4m8k1+TOX1E4/cdSZAUzn6p4Vor7X
	 uuzlCRQEXBP9ec1uyaohm0TfMgIqV0/lDCemKC57FrThgWdQNppgAIl1VgyNGkducw2eX
	 KawGZRSnFXiog/W98V3w1qNqMr3IjR5DsYiKgCePsdHp92+3hOho1Y04FqXZEGIgXWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
	b=meU0ChmcBH0sq6xSMgBNa+G4SZl7kSw27KM+Ica6bPwpF2F2WvXDXArmENyGlJV9AtwA
	 ori8e8f6yKstJlFWyiuFbj78IRIbRtKs7EJ55zTjt3YBnQ/vNSBvztcOLEs5W39QHp2uT
	 617dKeVA+hHueu/tU7UYpZ8aRLiFSBuIYbogjcdKcKCyKRprZx89oQMe3zgDTQX+pg3Hg
	 ftN1lFd1w8QUeUPUFAUc/yt5p6MafpXv1x9JUnw5Ps5nf+mx3Er9chWmwPQ5/2IVtQH1E
	 gFC6Ck/8SGxHPQurBu6wYnuAiQw3ACqLhDKe9tkot/fsoASoCtP181vqxd+A1TGaQXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HmOhZp1a;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6EC606A886
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE6EC606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HmOhZp1a
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b704171bc9so1238363a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564235; x=1795169035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
        b=HmOhZp1aysVRSGcApaAZDLI81xyeSldeu7ePLUPKkH54FsFfnK+QDVFY4+VQQZDD5I
         H2HloBZm5LZmO+0yz1W9rfEhaL+YICMUwpLNmuFaGXNfAv5LYB2fsAN36refSeHGX9fO
         cryYVQ+kM2KCw8u+OcP3112ltvgpCHGvfl9d9GfdLtqmNcwNDmKz3KTPAT46qO03zj8M
         uuWZNkUaGTWe7Ooua9eiEAKQiiHx3qf0rn/l3lNWMOa2sfege5hzg+R5XNTSj8AN0bpY
         dCBAZCrR4vjcQdomnF2hzC3FA98LaruL1WYTiCQ1DC9kzlEXZqoLyeQdM7U6VrMRD1VV
         Lr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564235; x=1795169035;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
        b=Ci26IBy0bkvOTqp9EeGYOLzETC+xIuQJbIXCyj1SpiKAHxod/uGVfs7XwaG4wj+o7F
         UAH71AAvvwNn/X5xd2xvYBZRoZnqHccesAJhywRDoSynSaND2Bh8UK2efOXOJQ/3+pV7
         pI+5ddhdm+PjbKZL3SVvuwhEDfedbaSwgLM4M5Updi45Wi1rCpWAGi9luxSBmBj2J6Rt
         uzG3OmDlcscGH8bXt9sBOhvT+/kkI4Ocj5/4jOSSiDxcjemqnHisw/rNQ+g1jIpPj4gg
         K+cEMwdDc0wQvi3yOJ+b38BnrdP/1SRRg7cX2vDWes/7B/OKKXP9FD1BVbrVccB4Onpo
         rdFw==
X-Forwarded-Encrypted: i=1; AL+hErEQVYFo97EJu2fADwOla0AyQthYKuppsq2Gfzlhpb11tWJNYqFZT83gKdEByFc1n1iq07s3Gu/p3AZLnTKJ@vger.kernel.org
X-Gm-Message-State: APuU4Z9quIuvXijZ1aNyhFieZPw1MKHHwSaXr531rc0xoKksmsqusaHv
	yUqqsujTJ1D603pWPlzHiA6zKqJW7Z23/r4C1AfDhDOlxVV3Ab0UaWkWVsadQ+Y8zU13
X-Gm-Gg: AYBFou0ZAYNzZ8VhpGa+YGCEkUzGbCcdUWGm4Ez2ik+4IuDVO0B9SZr1yzvq9WBbTjv
	WXg63hTjhOF1UmgbBU341fH1yJETxxZRL6koSQfAtT6d3PlrH29V5oSq3+6oaWnHwEgA9acN3uZ
	ufOPrkZbQRqlJ6Id2sSJUqaCiLrgpMxjxEK7wqDw6gGDntx86hG797ph9a6KOhSefNxZtw4xkKB
	t89ch4WzYJAwDDL8RocS3aBoa6fomKCcMJnD31D9g75VNmOC3EOnc7xASVS628GTPLaRls/hGsg
	8p2+WKC2y4cWWH+0xM+euXhSQKFLlgIWxdiXaCj5LOlKK62zrrP+g8s2y096qRve3uL3xV0IVvQ
	gABxaU/xSS327B2Rj3VmsVHS0oBbl2+xD8fnP67NGuys/6MfbVf1PVffg0FTPC5V7eg+3emV+ot
	GVWeZA2l1jSF0ZCSStJVElsZtwiWalF/AZr+N5AYhp2P2BsLdN/3vxzSc8dFIfnVjlNkFHNBR6r
	y76H8dNZUAL6UbPGBeSWhRdOaWCjY1jqplC1LP+28Hmkl3m1YLKveCPGAMc0BF8FHcHhANK96yx
	B3o+e0OcQDVIX/cJ5SxPiRXRyZicKxSGBky0Ldb7qb0R+UB9cgQwrnOBbzpppPc=
X-Received: by 2002:aa7:d556:0:b0:6b5:96e9:ae97 with SMTP id 4fb4d7f45d1cf-6b7c0ccaafdmr1234919a12.34.1794564235160;
        Fri, 13 Nov 2026 02:03:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm766458a12.9.2026.11.13.02.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:54 -0800 (PST)
Message-ID: <16dbddeb5cbb9613dc806b43fc681eb26aa3b0dd.camel@amutable.com>
Subject: Re: [PATCH RFC 10/41] nullfs: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:03:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
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

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize nullfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/nullfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nullfs.c b/fs/nullfs.c
> index 319c2f5c5a67..2fe24cb97160 100644
> --- a/fs/nullfs.c
> +++ b/fs/nullfs.c
> @@ -2,6 +2,7 @@
> =C2=A0/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/splice.h>
> =C2=A0#include <linux/uio.h>
> @@ -174,7 +175,7 @@ static int nullfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	fc->ops		=3D &nullfs_fs_context_ops;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

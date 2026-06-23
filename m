Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD33A9636
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194213; cv=none; b=VzXN8HFrc5ulye2DUPHe0mpXJIyMZB5v+YRSMhVTSsW+UrQgfa8UlLw9j9TlXbybG8G189Y/H2UEUI7n6LLYxX38w2ytWZGmr6r0ZeUrueEYE6GHHG3uuAzv29sTNRmRqCb/u18Y1MmYQQXj8Zf7FFo6j/bGR5JT054A78TRsdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194213; c=relaxed/simple;
	bh=+jf6FCPhULaYM7x3WdOhcPmt+O8EwtPmzY59JSYi2kU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=keVcdmWOarxUhAsH+veCaHCK+e2sd5CNTBYsUt7GTWmfdfkUjuxnnKd/K6NI6ta48CV1pNfHEbxUu25go45qveXwBXoMvSYsbR99ZWkJ7/Sa/jwU+K9KlPk/bsLM0AIFPapf7HpeJTKaMvXCeepX2mxikxTP9WUoop1HgK0dNKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Yy1iPVfH; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Yy1iPVfH"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-396775c26e0so49541871fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 22:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782194210; x=1782799010; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y6lTr4KEWrxbE6naabst6mdKqXSyHQxKSAsNHVTHLYE=;
        b=Yy1iPVfHWstcoYT7P0sa5BB945MMlDkX6inoSr/frPpC5Hna1UTMOFsOIbMZDbpIVX
         HiWLMh5Ryrb1HIWJwjBsgEk81vvSL7uUSQywkt5Y/+3gWXqw1giGpRz4YLyoVQFpb2IT
         Gh78MB1P3vzDRP8dsSLFUruFALq1bMJKbkyNMl2Kx7PQHjxUikZyCAfnIzquR7seaivR
         rEk4LFz1ATgDJiodZ/3UBuAdIhE2QlFCZ/hgj4e8BpNlN05/BvUEO9uAh4khQMdibOo2
         51wU70tqGUObgjHQVOW0A95DE3tiyMP+st6DxXUybdjTV0iseI8nvDowBcAni7ZzLSLW
         K7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782194210; x=1782799010;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6lTr4KEWrxbE6naabst6mdKqXSyHQxKSAsNHVTHLYE=;
        b=s4xHMGGLaBZa0msKPdk+oPSKSs86iQsTK9q5nP2Z8KJeY2yludHwxuMvzC/zLG/U7c
         kBB0NWx7NmykFQMYeRJrACHgN7siLFwbK+y407pWNPZAPA5M+cSdaFKsmpNEJe/VAqM2
         VWM4jV5Bxdc0AhrXIwn3j9v7UEgG2NP146A4os9sm5zhQ0hLWLWs2bKxrn7fgXiSM6uh
         lF4WhUqX7ifKnOWokhT6UpK/ch5eN0B4KVKMTLM65zHlj0RfSIWdL3hkzxNKS7r3o+mB
         ghTSCIs4g3S5giS1fbpYeIvVsneJglcQzeSBPs8RWyzlWRKBEdlxNsVErv9eYdlI8Lrm
         GcEw==
X-Gm-Message-State: AOJu0Yxfd8GQrc4hVnsQx8F53wm3cfpCe27JNv1CKpmfBibUa3Qi4aw0
	Z1spgCrlus9gXDjNY1K3BC7H4N+pfoihI7U7zARBVUuKceJFNBKoIbr29bDEPuJMmQs=
X-Gm-Gg: AfdE7cnoGhijwzcwUF/5Dr+vTNZZVbHn+CFHdPrmNlhcyKYfuwLBnbVQSZFGdfmUhBC
	e8LyVZPMks10Kjha+uCKRTH64rSaNq/ODtXVPqvbBVZwQpKMDI42KsSn8gjDOl2MygBOBCmCj9w
	8pG89lklOI4FNewuCqsAvUPBjwriBcO8NFjKIfRRuJF0ojNzV0iMTpf4G/qJsBqWIW6HZQnK/Z9
	HUgFNoUwvJl2NqVLYUtwiGDqzkFsyaux8/M8UcLQvHbchS80hp2TeWMWaFfBrHcDJBxugOE8/Mg
	KTT54GmzRQlWHQtRK0pQ1EtPEYzB1+TwyognsFyV3gebX1akf2NNH6N58bzvuuYsM3uU3V27xz8
	7jZAbCNEQZbZ2Cc2x14FL6p5wZ+WeIoZZ3DZbpGUP0G5foYym0xR3oY8J6Ctv08Ehrc9hwAom7C
	FGAdL3c6eD+BxoleKY9QK4oTHCPxDZLkCusH7dRE41edaACzP/luf6u0TgYqw3mUjIk01hziqpK
	vjcRDScqoiPMCck/Xkv1PCnyYKsl6tOPXSy
X-Received: by 2002:a05:6512:ac3:b0:5aa:63c2:2cbb with SMTP id 2adb3069b0e04-5addb8161f0mr262032e87.9.1782194210009;
        Mon, 22 Jun 2026 22:56:50 -0700 (PDT)
Received: from [10.182.218.44] ([178.176.72.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a8b6sm479882e87.39.2026.06.22.22.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:56:49 -0700 (PDT)
Message-ID: <5d8bf7aeebb3dbad5640d99784942201212eef4f.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fix duplicate bnode creation in
 hfs_bnode_create
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Sainath Manda <sainathmanda777@gmail.com>, glaubitz@physik.fu-berlin.de,
 	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f83fa2cf571bd7650422@syzkaller.appspotmail.com
Date: Mon, 22 Jun 2026 22:56:48 -0700
In-Reply-To: <20260621090448.13108-1-sainathmanda777@gmail.com>
References: <20260621090448.13108-1-sainathmanda777@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-06-21 at 14:34 +0530, Sainath Manda wrote:
> Syzbot reported a WARNING in hfsplus_bnode_create. A maliciously
> crafted
> HFS+ image can request the creation of a duplicate bnode (e.g., bnode
> 0)
> that is mathematically within the tree->node_count bounds, but has
> already been hashed in memory. This bypasses initial boundary checks
> and
> triggers a WARN_ON(1) upon a duplicate hash collision.
>=20
> This patch adds a clean state check in hfs_bnode_create. If a
> requested
> node is already hashed, the driver now safely rejects the operation
> with -EEXIST instead of tripping the kernel warning.
>=20
> Reported-by: syzbot+f83fa2cf571bd7650422@syzkaller.appspotmail.com
> Signed-off-by: Sainath Manda sainathmanda777@gmail.com
> ---
> =C2=A0fs/hfsplus/bnode.c | 10 ++++++++--
> =C2=A01 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index f8b5a8ae5..5946baad2 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -626,12 +626,18 @@ struct hfs_bnode *hfs_bnode_create(struct
> hfs_btree *tree, u32 num)
> =C2=A0	struct page **pagep;
> =C2=A0	int i;
> =C2=A0
> +	if (num >=3D tree->node_count) {
> +		pr_err("hfsplus: attempted to create invalid bnode
> %u (max %u)\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num, tree->node_count);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> =C2=A0	spin_lock(&tree->hash_lock);
> =C2=A0	node =3D hfs_bnode_findhash(tree, num);
> =C2=A0	spin_unlock(&tree->hash_lock);
> =C2=A0	if (node) {
> -		pr_crit("new node %u already hashed?\n", num);
> -		WARN_ON(1);
> +		pr_err("hfsplus: attempted to create already hashed
> bnode %u\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num);
> =C2=A0		return ERR_PTR(-EEXIST);
> =C2=A0	}
> =C2=A0	node =3D __hfs_bnode_create(tree, num);

If we have corrupted HFS+ image, then we should not mount it. If I
remember correctly, we already have patch that fixes this issue by
checking b-tree's map during mount operation. Are you sure that you are
running the latest state of the Linux kernel?

Thanks,
Slava.

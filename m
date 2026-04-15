Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F865386564
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291081; cv=none; b=eeglvbUCGsdAahrUY/ks5yuuMdApVqCHXeJAqZvM9EVQEXkras3NH1mHknBD0S8bKnd6l970T31DI4t7/fp0lyj9WDzi4TJT7O8GRuvL5C8WfECBeNUI+IGp++aTUbG/OuQJqFgruCVmE84bEKrTJDwzxU/OTfauzFZgfgUyRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291081; c=relaxed/simple;
	bh=sn7uNBMsVGeD1q/yHzV2diMou3qX3CKF36e76jXrEqs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ol39OS9HJlPEPzD/gvmFQMPTSP/08DKeOv586ySf3VYB5YELUo5iA6puElS2FHStfMVoSU+ieL4E3LKnwcyj2cEJDa3S91m+pVCTFj+FcHB4E4T7gZYlK0e8AF5TgCc4S6a7hTabbRxcZEE9auxo+xEkvrvHyHfSyx1d25/xzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=An4xdLUf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=parLuQRv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="An4xdLUf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="parLuQRv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776291077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSuQfOIX5vRRmLHy35oUYTRs2YJvIFqtRJchC7Fd6/s=;
	b=An4xdLUfszmShKyXHEvAtWkyYgCUJa+wDNTmr4zQ6XkQ7j2QCXj6FRzgEoMxLOiflFc5ls
	AjXetR5I0N+GD5Ayl3zVc0Ey+bzN3KbGEi7Xz5eIXcfrZwKosyMx6BLJw/c09dpDGqewYp
	aDWAKxfPMz7xFpuCZJVXndXc/rEZqW8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-VXgWH23zPVKkSPReo0ws1Q-1; Wed, 15 Apr 2026 18:11:16 -0400
X-MC-Unique: VXgWH23zPVKkSPReo0ws1Q-1
X-Mimecast-MFC-AGG-ID: VXgWH23zPVKkSPReo0ws1Q_1776291075
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7987861595eso213304017b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 15:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776291075; x=1776895875; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WSuQfOIX5vRRmLHy35oUYTRs2YJvIFqtRJchC7Fd6/s=;
        b=parLuQRvoHA3XFNsxenGPt8spXXC0Lp5n3DGe+j8m2QbR0V4CDZBXzn7lrLk73Kok+
         3xyYQwfY3Oeqhi7f7GsWb74Rtvk5vYsOX3GTPexgPT1JMWgvWXAbPocKFCXfgyEj+eRt
         fXCxr2FLSYXYs7WfVxCG3MY8sCTMIKPOrQEadCnPOXPMLNdfvSI19XgLBDn1hHlt71g8
         Mdfkr+dnuBj8ThhhcWzMMCY+uN7LPiYue9Ity76ADCOCs57NpXr3RACOXvtyvcB3XwJ3
         6B9Y+qPPBGOXpfOtEEG5lCsz47nMh0srdgFRQBvE2ZBNo5JjVvBc5bunhbCilrSA9T8z
         2b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291075; x=1776895875;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSuQfOIX5vRRmLHy35oUYTRs2YJvIFqtRJchC7Fd6/s=;
        b=au1o4tBUAom7L0uUwXzq4sllBAC7obNOvpcKQ61jRKbvFHMderhOlVoyTte+H3A1MT
         OzvLdyRsviJli1sFBmDcnJIbibiYNPGF94lP3LJbqGR+dGLN2dkh1OsDNEAmz/LtwmNk
         2VBaaecgPPLc49Aqn0jxVUbwzyKdliMjtz2jegITU8MrO4NhMTxOyGCVoNpJLtvVQRvn
         K/nZqK/jgeGSBONRnmNzhXyRTtNLMDFsTCq65JOZcs2zgaIhfGgtaQ6ttQeK/Bc+g9La
         gu6TBhRI5pf90m4DvrDtfhxs20C/8R5AII9t1Iub3aE1cmXJtGqCFrgMd8u/gAxzCrL4
         IX/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/u3m3qhh1i1HA4UR3Ijmf9Y2/X4aIHdEoH5MafVGWyp+35gz6Q6EvaULvCbZJiYFQ3gQmxqKmRmqEpvyS7@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxXjj7e+gOhGbApgI/wyGB2c1neN3z9u6tBBAwDydlyX6DU2p
	gCewF24QPP9v+oCERszQrscSg6z5qXdDxu45mHjmq4EU2XQTXGbeFKoK3SG1A1Qi6rkeCw9MaH4
	n3KNwmaSvQa/VkordEs0bDk0mXHL7GjpWToT0R93qVTqqvRa3s/nJjYQ/SWQe1GWIQ84=
X-Gm-Gg: AeBDietiZoz5JaKFYH1CQjXOzbWyDYZefKysr9fqQUOiEstiOnCLFUSyKeG9d3GdJRl
	dyqOwYkZnyPsFl68uy+BdawtO1OV7rE2utEDsEs03s6epJ6GeIbzq/4HYct2L9tnN1IPJDwUm9N
	qGrHVfLF86oA8isVrk4hoqIThuZy+OFYa6TA2lRQFvkTz5JYtrkYhKDiIeQevZF8jDDMbKejeIU
	JUf2GEbZWB1RN54oP1uiNnilKP36PhXqd1MX1W3jC0XLC3GtQ/Q2TSAWTeJcz/8e7BXrg9hM4XY
	Ba8U1cSkBNeO3EZpAfU1ACHbum5nmxlurvGuPdgdHm8fs522LsCyu5x5V7Tvn+n48R1q2JZ/Gd9
	Xz6YRr49XnUSZSUOzjDo5B0MuYGVgGjcaEKhpHoMOEx26dHormizXC33f38XFqsA=
X-Received: by 2002:a05:690c:9404:b0:79f:b903:88be with SMTP id 00721157ae682-7af6fceccf3mr207247257b3.16.1776291075448;
        Wed, 15 Apr 2026 15:11:15 -0700 (PDT)
X-Received: by 2002:a05:690c:9404:b0:79f:b903:88be with SMTP id 00721157ae682-7af6fceccf3mr207247077b3.16.1776291075068;
        Wed, 15 Apr 2026 15:11:15 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b768d3b1besm14366597b3.32.2026.04.15.15.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:11:14 -0700 (PDT)
Message-ID: <4ca511af88f86e0b8bfb45ccc8e460ac773804e1.camel@redhat.com>
Subject: Re: [PATCH] hfsplus: set attributes inode dirty at correct position
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Edward Adam Davis <eadavis@qq.com>, 
	syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 slava@dubeyko.com, 	syzkaller-bugs@googlegroups.com
Date: Wed, 15 Apr 2026 15:11:13 -0700
In-Reply-To: <tencent_42B2972A36284B9A7555774B66843D4F3609@qq.com>
References: <69decbcf.a00a0220.468cb.0069.GAE@google.com>
	 <tencent_42B2972A36284B9A7555774B66843D4F3609@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 16:45 +0800, Edward Adam Davis wrote:
> Syzbot reported a null-ptr-deref in [1].
> If the attributes file is not loaded during system mount, a trigger
> occurs [1] when setxattr is executed in userspace.
>=20
> Move the mark inode dirty operation to a point after the attr_tree has
> been successfully acquired.
>=20
> [1]
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> Call Trace:
>  hfsplus_setxattr+0x124/0x340 fs/hfsplus/xattr.c:555
>  hfsplus_trusted_setxattr+0x40/0x60 fs/hfsplus/xattr_trusted.c:30
>  __vfs_setxattr+0x43c/0x480 fs/xattr.c:218
>  __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:252
>  vfs_setxattr+0x163/0x360 fs/xattr.c:339
>  do_setxattr fs/xattr.c:654 [inline]
>=20
> Reported-by: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
> Fixes: ee8422d00b7c ("hfsplus: fix potential Allocation File corruption a=
fter fsync")
> Closes: https://syzkaller.appspot.com/bug?extid=3Dbc70a12e438dadba4fb4
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/hfsplus/xattr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 452a1f9becb2..3e6f45b3259d 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -317,12 +317,14 @@ static int hfsplus_create_attributes_file(struct su=
per_block *sb)
>  		next_node++;
>  	}
> =20
> -	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY)=
;

It's really strange that xfstests didn't catch the issue. Probably, we need=
 to
have the specialized HFS+ tests.

>  	hfsplus_mark_inode_dirty(attr_file, HFSPLUS_I_ATTR_DIRTY);
> =20
>  	sbi->attr_tree =3D hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
>  	if (!sbi->attr_tree)
>  		pr_err("failed to load attributes file\n");
> +	else
> +		hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb),
> +					 HFSPLUS_I_ATTR_DIRTY);

As far as I can see, HFSPLUS_ATTR_TREE_I(sb) and attr_file are the same
entities. Am I right here? :) So, we can simply remove the first
hfsplus_mark_inode_dirty(). Does it make sense?

Thanks,
Slava.

> =20
>  failed_header_node_init:
>  	kfree(buf);


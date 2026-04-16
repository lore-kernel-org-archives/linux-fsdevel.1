Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D54330EF63
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376376; cv=none; b=RMkVi8+ZOpgFoO+4Jn4fcSroThF2K86S3fCg/66mmn17Y69WdmgV/66fO/tDCYEhzliyBDvKB9QFM+uk8yqfhZEuSOLo/qafC1QH1/Z0tujqRmXOrIuuFDo/msfTQgCiFXvrD/Yj0YUHutNHnkJ3MGe20vu+c06e+brDG5Yw2DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376376; c=relaxed/simple;
	bh=74wbVYw3bk/SlVyJvtnKHLStqq8FWhOqHbrE9chtJe0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dfaRymE7/LofnRDQ4VXHXdMEHfzlzCJwEVkqSF1XOhm3ITkO+EmQWdk+wBs8WCDISLUpiykrL6mJGmpjI4jAhTPlPoNaHVC6yxNRL40R/yEiD/QEOVjHG4uDqGGt6hZwzd/+Hohw41cHRHCMM7bzYu0UVLe46EatWtpCk1lKyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHobzV7T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZOAm1VH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHobzV7T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZOAm1VH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776376374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVW0a704vgQNQLDb2tuoO+3gdW557mnA3SO9ZLbQt0E=;
	b=WHobzV7Th0Sq1bydXy0xkq+HZv8V496FNhZVbJYHuMiRy2W1Cw772CzmaDxa/dzEOTbXn2
	0qh+zL29k6BJrr3r6+m0HIlCun3eJiAhKar5IQIkncHUTqrIwgjpRB/CGECptlMPafo1eG
	NaMWdZg4UtcI1EVyDApOMV5RvQ4v2RI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-ROKoCMRtN9Cv6kfpxFyBBg-1; Thu, 16 Apr 2026 17:52:53 -0400
X-MC-Unique: ROKoCMRtN9Cv6kfpxFyBBg-1
X-Mimecast-MFC-AGG-ID: ROKoCMRtN9Cv6kfpxFyBBg_1776376373
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-799003e8a77so279445997b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 14:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776376373; x=1776981173; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yVW0a704vgQNQLDb2tuoO+3gdW557mnA3SO9ZLbQt0E=;
        b=BZOAm1VHr1afGPxzIYKnM/A/aKc0JKzG05ESSMxbaJR27tQEFBisW+C08CdM9KiLU2
         yu+yAxWiH0BqWUlooDm7J6BsJD6JupbVySAVW5ARfL+M3kZyvFhEnQJUh88UhXDAWdQH
         wqJ6o/wuaaFFqcWur7TyKw8vYNtEGCV9DmtJFDkB4M8qEdxMjQKbfm/WF4FImLKEue0j
         I3Vzx1us81AuOwnEaPzA9m0HguKEggmBAxWLTdF3+3D0WsvRuBYp4XixD8N2yX1YC03P
         sVdZ9Zhx53Kx4Lp0lTHkKBBXKdP5Z+8+jCi/muyUvojqttR5DdHo1M0U0dhCaLUp+kE7
         nGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776376373; x=1776981173;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVW0a704vgQNQLDb2tuoO+3gdW557mnA3SO9ZLbQt0E=;
        b=JV8XkfoU8+h4fJsUsrpdCAYwjWvqELe0SX86tLavXDmaObGdQNx75E3+gsysn+8IoE
         oDc+TNJaRik3a942gn1n/36lNrgQga0JbPBonUELR5MITO8OI0XpXbASRrn8F7bMXv9i
         RY4z3aghhbjR6IFsPXQ3gqxVWLaQ/kkAimryJq7Dd8j7D3tzTUGS2tEdAfWOb4mC9Hd7
         uDmAlyi3ZOxjSRxlACOg0YbsD7shKppq4qJVr/tfune3khgPEAmxuktFyoExH/oKjFTk
         mF23zJqx1jNI9v64MJoIQHaZgrNmGzuhGzInowVkH72kzyh6xlVGWlzOFGvZvaSvbOkP
         tOBA==
X-Forwarded-Encrypted: i=1; AFNElJ9ghaR4s0NHSY0/5SVd0KWZnzt1bIj1kjQx1i161AnwfvTeefpJEhDqC07I58K/ISKjrRwVhb9K4VVVJZw0@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwSi1IAwNd99Czi3WASUXIfoCbEGwOSnkxEF1yj7XCDJAoWjm
	66VZfkhTauCAyzXDEG7zZVEhNMHybW1au08pL2+p8XJNefwYy1ZTwVe38iSiWJqT7t3vsTxIwpQ
	QOl2vngJJtkunF/fxXxzfuSun0pQgPmR3GuKjtf0jyzBgzCagiLRlXQafF3PQEwIdS2k=
X-Gm-Gg: AeBDiesLMOng4QElqVtXtj0l31sW10mswDgL5diAO4678x3I8lXJhtU/hYPGYTF3snl
	y4T0vd/Q8rl6TbxZMrs23nYLZVU6YeUbrtFnKl6WfXUUmBCsmItk0sCtkWBlw8TFnSvvfVwSrrm
	X32407P7hRr0f4HJopIX2gk17BJUt8uoTx6RB/ahf2qUMYvFWzE26c5Wjz6XFDAcFuNa/vu87O0
	hP2tIyZpwNMfaLbS/BllRsFTseuaPVNYJ2uG9AzaxWbGLk1rxLIh/UpA16LlqLwCoJcm+2ijwMG
	txzVbZrFj/V9gmwoD47QVl01Tn/yKVTp+QU7Sl2TGVYpEYafodeEHpYSg1mNYij86Nl7iU1BvQs
	4GHOJzkcMR7I5n6xs/3YmqgyAt/vqMPD3QNAmJkhJ5cq4UW6XXBmKs9dDk5s1SMM=
X-Received: by 2002:a05:690c:110:b0:7b8:338d:7d80 with SMTP id 00721157ae682-7b9ecf86517mr3308667b3.31.1776376372803;
        Thu, 16 Apr 2026 14:52:52 -0700 (PDT)
X-Received: by 2002:a05:690c:110:b0:7b8:338d:7d80 with SMTP id 00721157ae682-7b9ecf86517mr3308477b3.31.1776376372420;
        Thu, 16 Apr 2026 14:52:52 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b7693176c4sm30238937b3.34.2026.04.16.14.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 14:52:51 -0700 (PDT)
Message-ID: <6601b6ec0de087674f60566db950449c4e821bfc.camel@redhat.com>
Subject: Re: [PATCH v2] hfsplus: Remove the duplicate attr inode dirty
 marking action
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 slava@dubeyko.com, 	syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Date: Thu, 16 Apr 2026 14:52:50 -0700
In-Reply-To: <tencent_A8D47429765566CC3C8B378496D036664A09@qq.com>
References: <4ca511af88f86e0b8bfb45ccc8e460ac773804e1.camel@redhat.com>
	 <tencent_A8D47429765566CC3C8B378496D036664A09@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-16 at 11:37 +0800, Edward Adam Davis wrote:
> Syzbot reported a null-ptr-deref in [1].
> If the attributes file is not loaded during system mount, a trigger
> occurs [1] when setxattr is executed in userspace.
>=20
> Remove the first mark attr inode dirty operation.
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
> v1 -> v2: just remove first mark dirty
>=20
>  fs/hfsplus/xattr.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 452a1f9becb2..21a1c196c71f 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -317,7 +317,6 @@ static int hfsplus_create_attributes_file(struct supe=
r_block *sb)
>  		next_node++;
>  	}
> =20
> -	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY)=
;
>  	hfsplus_mark_inode_dirty(attr_file, HFSPLUS_I_ATTR_DIRTY);
> =20
>  	sbi->attr_tree =3D hfs_btree_open(sb, HFSPLUS_ATTR_CNID);

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5903932F4
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937513; cv=none; b=Wp5dTH/2abvRucyP62SGrNWpkji9JKlTV3mUNyzF8upHnEstbzYdy0YaRYb2XdG42sqSlwbcmI1dM4UaryKanHj04vkfrsQoPCim2K8KrW1J99+fIcsIFDIr3cIRTwhxBapWia9T4/x8i3adrcNtUvQyET98RJxjjClmfYVMeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937513; c=relaxed/simple;
	bh=mLVFdp5TspvCCdHUC34Lqoaa6WJY8K3YQB6d/Orv8/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQUXDOm+lPC5BuLH8SE3WpjFFQFNySWOtVXlCI6sPFJ5Q5WrYR/5zQoQXKDsHBZ46u+0ut+VPPWZOn3CY0+GW8KCydxJ18CiNxsNdHu9eeFxNFvXJFDESwk/JcP4uh7O1szlZCi9QpZUbzPazeNiSC8EM2Wjzc1qbyVLliDbpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAGFA+0H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Te1uBzM0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAGFA+0H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Te1uBzM0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777937511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIdi3Vf7s14TiGM2SJEWnXo9lX3vBp55691Ki3YV0NY=;
	b=QAGFA+0HVXG77RiZqgUngoMrGNDVs4Sx1aPjV0r5Mzb33sNNQTtJKYyOFcCFFWYMWa3Icb
	7ynDrSc21zatwsQzJnJvscYvC3feVF/n79qFuhyahmICwgmPu0weXGpTFz122pd6SIxn/J
	FaU/eG0urkv2g5uZrJVchYsw71q1bvQ=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-Ai6eLQ0sMN6gcFK5bMb3EA-1; Mon, 04 May 2026 19:31:49 -0400
X-MC-Unique: Ai6eLQ0sMN6gcFK5bMb3EA-1
X-Mimecast-MFC-AGG-ID: Ai6eLQ0sMN6gcFK5bMb3EA_1777937509
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-65c53d7c36bso3674383d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 16:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777937509; x=1778542309; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WIdi3Vf7s14TiGM2SJEWnXo9lX3vBp55691Ki3YV0NY=;
        b=Te1uBzM0W2x754eDmKozP8TKE9c5VIjH7naS59PDvhFmC7USJ9p6obQynvZUV/FpnI
         xtFU6284//rgij/XuApyBxiQoMI4sB1keRd0PFYPEE9CGF1d+Nywh0E7r9/uU9JGkipT
         HD9ViAwOwTCjnZJpLBfGKJaNIbhLi5mjKdPwxbaDsblVzpznToRnW/bbhileWK1Ctw6H
         ezp54Lgi1rrrtCfpH6wArAsHC8Ik61+5PM/TYQqO9V8GpTEowZxiE8vDqgAxyGJmL8ck
         FrgcPHwainy3R2rmvVfoRNHqZwLNihs9dDnIRMoRt+K1WFeI0qumVCrzYwRrLTo5195P
         68PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777937509; x=1778542309;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIdi3Vf7s14TiGM2SJEWnXo9lX3vBp55691Ki3YV0NY=;
        b=T3nIR1la/Mzm4M3xgAQyFUlDnAZ3cFkrI1svMvoeXlAy9cTZXxbJcf6xg4WUN+P6AY
         k/k//tYe7j/xtjfJu+8cR5RzY2xjUAtX49Ngkb9WPAslcrdsq5/m547UNWThe5Lw00Hc
         mWlNVlLydgWDB65gh8hI1OILzLXfeXl8cTsS1xkKdTjHR1peb2gzZ3OHzBK/L4QYGO9v
         nJSYQGHJie3eqKS5GjQaRMluL6iYbs20XqIsYL/yPKpJ6SnnfhOexb18LHOP/pms4RrX
         35t0MuMyjKKPWEo4aA4TjEgfIeSuw9R17VRVEKKqFKi3jqdMO1CpfFMjy58nsI3uRf3c
         uAYg==
X-Gm-Message-State: AOJu0YwjYmEhBqNDN0QB+W0lIGTrqdjqgBCCEFJ4Qb7TLreWQzB5yvxG
	Wq4v1j5IpQvwR3NOmzFF21lZbJ/MitUJ0/ChMJex3x4XjE7EpK00N55gV+/nyMbZwkylE95GjPh
	qpmbIBcmCHLecLCw54bjlciMPAYO9EEqwCWHRpCeeay77GnAtHL74Bxxxk1W8v70MYw0=
X-Gm-Gg: AeBDiesoCLbCT+ekrKVrY6PRsTlfQN+MsDiG/IW3Uq354UjD7w7bI9T73eS80YOhtkj
	FdzwX2rXJtR7YlJAlrvPJCSXjrf5bC25mKO3pRkM+BNk5Ggu/W5iS9OkMl4PLsP/xi6HK1IumVq
	LqLKAWJPz0ssH+LQYAIekbKCovuV1LN7kKKl4m5N48BheENVvBG+6TNpp7iYT46obFaQsPJ5upy
	AMNzYUzN68CvsOJT80QxEBL/IVGB/JoDbEZDGqBeaMRhIS+gVy3w37wBLGGBmTqwIAuAwnF2Y4V
	nJu21UAvvr+PW8IjU08AVrxO8eOOIRbvxMBLmeE1TsmP0NUk87d/5XwIN4u+PezwVmouNw0AM8k
	MhFPDujEvNIhUd12GGXdtG/S8DhvCin/46wTQrD1tTOTFWQ7y+Y1uQM6GDjJ+W+Q=
X-Received: by 2002:a05:690e:480c:b0:65c:2066:a9c1 with SMTP id 956f58d0204a3-65c69ecfc79mr685830d50.42.1777937509203;
        Mon, 04 May 2026 16:31:49 -0700 (PDT)
X-Received: by 2002:a05:690e:480c:b0:65c:2066:a9c1 with SMTP id 956f58d0204a3-65c69ecfc79mr685812d50.42.1777937508761;
        Mon, 04 May 2026 16:31:48 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2df83478sm6167827d50.2.2026.05.04.16.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:31:47 -0700 (PDT)
Message-ID: <af3e5c699e80c0462351cd900458901ada932bd0.camel@redhat.com>
Subject: Re: [PATCH 3/3] hfsplus: fix null pointer dereference in
 hfsplus_create_attributes_file
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>, 
	syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
Date: Mon, 04 May 2026 16:31:46 -0700
In-Reply-To: <20260501110218.29906-3-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
	 <20260501110218.29906-3-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-01 at 11:02 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> hfsplus_create_attributes_file() calls hfsplus_mark_inode_dirty() with
> HFSPLUS_ATTR_TREE_I(sb) before sbi->attr_tree has been set by
> hfs_btree_open().  HFSPLUS_ATTR_TREE_I dereferences sbi->attr_tree to
> reach ->inode, causing a null pointer dereference when attr_tree is
> still NULL.
>=20
> Move the mark_dirty call to after hfs_btree_open() and guard it with a
> NULL check on sbi->attr_tree.
>=20
> Reported-by: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dbc70a12e438dadba4fb4
> Tested-by: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
> Fixes: ee8422d00b7c ("hfsplus: fix potential Allocation File corruption a=
fter fsync")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfsplus/xattr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 452a1f9becb2d..1ea9f313368c5 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -317,12 +317,13 @@ static int hfsplus_create_attributes_file(struct su=
per_block *sb)
>  		next_node++;
>  	}
> =20
> -	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY)=
;
>  	hfsplus_mark_inode_dirty(attr_file, HFSPLUS_I_ATTR_DIRTY);
> =20
>  	sbi->attr_tree =3D hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
>  	if (!sbi->attr_tree)
>  		pr_err("failed to load attributes file\n");
> +	else
> +		hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY=
);
> =20
>  failed_header_node_init:
>  	kfree(buf);


This patch already fixes the issue:

https://lore.kernel.org/linux-fsdevel/6601b6ec0de087674f60566db950449c4e821=
bfc.camel@redhat.com/

Thanks,
Slava.


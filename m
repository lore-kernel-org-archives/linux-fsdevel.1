Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245083;
	b=BXal/sIfZlU8wqDyow9+4cMAlRwDh8+u4J7yrIuOHwnCkS7MRqlUOQnoMu1VFQGvRA90
	 EmNGyL4aznge55Dox0kkG+ITKoiJ0Rv+z8BoQQkVYMgsT0m/Lu95fxRgdXpHpT189SToY
	 ii4dVc8ao2S5Ln0OjH2IKdeZKGl1cSHUiGkQKxAtDCpCMdNGtQkosr06hP1Gilj17WJng
	 srw28qZgXf5/y8LX9vO+RFRZL/LSY3yAyf1rzJl9yxL4vXAqabUl2wfF7Q3W/lfopW5+U
	 3wht0YIXH2kNzlPs+25ya3j6P+XAytA2nEqdpoANkTt35H778mv8vSA3mYBMOTl/ldA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xO9Nyz7qNv6/W8x13yiKzl4aUpp1maF5hp5hkOon6bI=;
	b=XadrqjPGiX3+M7gyWjOtmTinEl6qOVr+J6F2VS9NYf79SU7+qqP1Pd1OdJcpk2Uxzrgx
	 L/vbi1DxijGO8VJjyPgmEIjFBGdacCLgShlpDhJRLHSEo4vMkDx8o5eqw6Evseg5DqGWC
	 OGFJpRSUKEXaP0tOhLVjUJzPQgtqYRVIvfpAclR1kYWVZFSQgLb+JSSULYKF0w/xe2kLx
	 FHtZUFIgNeDFCp/n8JTqmE/MaAQJFdAz9xPPRxiHnO5sSEYFuVI4r5/sLimcxmkvtBXAG
	 4tY4FldtrwqYmhI8rm8MuCzP1R4xJLK/eW1JjNWP1lPJoueYA+1pI/0aX1fPHm6Yleg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WFLmRQ7/";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4C606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6B4C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WFLmRQ7/
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535a54bed9so2462124eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 20:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793245082; x=1793849882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xO9Nyz7qNv6/W8x13yiKzl4aUpp1maF5hp5hkOon6bI=;
        b=WFLmRQ7/qaxPbNl/TuSOqkTHrpNTYj7NZxvnoYJUb4bgXxt0QJDfVE76lbtQLu6Qt4
         QHwJa1MIS1cppWBM36DCc/w9XcteBY8Qebu7GoSNkh0p+XExprGcc6oca+9+76pMf+q/
         2kWY7Bm76jSvcgE4/4c7hwPZBNb3R3bqEWAFH8iK8a+J9gL6NufXvLRkcUFyVvhIwtlk
         q2lJdj0UbiE/aClIfswY8YU7AB//IeRtbd/anFJogxUdcqmZ357N/A5xDuVBg0sgq72m
         +WWgq4yFuhuEN03RC+X6k6wwnglXlwY7ARwVDb41cQ8c3ORhd035LfgAqLO3oopj9NEL
         4ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793245082; x=1793849882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xO9Nyz7qNv6/W8x13yiKzl4aUpp1maF5hp5hkOon6bI=;
        b=Ir6gsVEMV6dNY1zpAGQdtwi4Ac/JqhKcyndPOw/lKq+l695jm+WoZZolmOG4W877nu
         JjNoCahph5HxrUjjmwbMnD/7t2ulo8aWd3Q7NAifV/ptDaDbz+QutXlKfYGGliB+xkc+
         bTUl4PX8cZt3e2nCtgC3hjLBwqp+0itkxMoQJYpV7p0Z6cxTsE2PYmYjRketeFMYANLB
         2ocG5tv0AT3CeaXhCuYQQ2O680Ol5R2Hz6LL4CsH9Q5dlRtw5m52z+rOuMm2utMhhSdg
         niWQH1WfLeYk+z6OBLFcrN42bMR//4bEY2Ob74vUTtNj6oWD33tAhK34FQcj8J3D3qou
         xOoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzC2A3dxT4t3cR+bF1nNx3yVLMqwdmPM2S7/Dl4qOW5RdkJUXN1kDsITas9XvMWFPpWhxWOxlnl2M709HDB@vger.kernel.org
X-Gm-Message-State: AFq9FYKdKRrzZEWO1CytNNPehDQtWePETiTcQvHqwue+7xerTeIjvmJ7
	Vx9+/yKBvhzxZ7G0ibt4yiPSDoHHgQDIr3kfRdkwhxY8lalqY3TVFw+P
X-Gm-Gg: AYBFou22Pj60mFKZ1hjEv3iMWEDs3wrx5lzefL/wwX1J+BrdEp8wdac7KGXw5dcCjIQ
	F6954GObcQNRd9MxXzeZ3LR1c/fkB8+VuA7VP1FuKyqno5/r9x5fMdHWUVfrhyldtLROYzyaek9
	wRJYSPWarJkt7uswIKgR6eMEUJXlnr8RWk3CpxVrGq3LJI8sZ1L7zAfPYFaxxX2M7rFsYYA9G93
	1ttdhQ9tWBZ+U2oeMUx0sUWlChK72M0AzlUHST7hLrx8Vob1zTtdH9k24YHUl8AC6FRP3W5gs5Y
	o4NSdtWh4yflBOCNyradsTPK+b7HD/jp4msRucorKpVd7XAfaokNom5XxZert+TlbcegT/kApKI
	WYuQWQnEreqQaLnGMSkqJ/h7I8Ss/YK2MrAPSsGUrsjuGZMEr9DFyynTLXphk3vu2wsljUVedW9
	2gF4+bj5bcfUfC0DO1oJvDo6/CrsP1NMDIVExnKIeDgoT+5bYfoug4EJ0ZruYGHo+jg1MIOtdEW
	XnGfXMEr/JzkJH4f3S4z5EfUMCOUil4owficyrGziHbNr+Bs/0wh0Ah1RGRdwC5m58dRHr+fL4m
	ysiqFw8QmDq0WKfDPud72o3BsXyqpeAVE4cQGdKbFsZhqw==
X-Received: by 2002:a05:701b:4288:10b0:136:b50c:c0e9 with SMTP id a92af1059eb24-1a6ce9bba59mr5791183c88.21.1793245081698;
        Wed, 28 Oct 2026 20:38:01 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75e0098basm10196922c88.12.2026.10.28.20.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 20:38:01 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: wdhh6@aliyun.com
Cc: syzbot+49c659b5564b2a44083c@syzkaller.appspotmail.com,
	dwmw2@infradead.org,
	richard@nod.at,
	linux-mtd@lists.infradead.org,
	syzkaller-bugs@googlegroups.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH] jffs2: don't start the GC thread on a read-only superblock
Date: Thu, 29 Oct 2026 11:37:56 +0800
Message-ID: <20261029033756.3959915-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028080955.290774-1-wdhh6@aliyun.com>
References: <20261028080955.290774-1-wdhh6@aliyun.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chaohai,

On Wed, Oct 28, 2026 at 04:09:55PM +0800, Chaohai Chen wrote:
> fspick() builds its fs_context with sb_flags=0 and sb_flags_mask=0,
> which means "leave every superblock flag alone"; JFFS2 misreads that
> as "the filesystem is becoming read-write" and starts jffs2_gcd_mtdX
> although the superblock stays read-only, and reconfigure_super()
> then leaves sb->s_flags untouched.

This is fixed for all filesystems by fa6c71988168 ("super: keep the
read-only state if a reconfiguration doesn't change it") in
vfs-7.5.super, tagged for stable.  With it, the steps from the syzbot
log (read-only mount, fspick(), FSCONFIG_CMD_RECONFIGURE, umount) no
longer start the GC thread; on mainline they hit the use-after-free.

Thanks,
Zhan Xusheng

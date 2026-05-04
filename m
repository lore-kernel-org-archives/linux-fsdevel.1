Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C0391E44
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892451; cv=none; b=gN1aG7JOhDxnVuYW8XaCR6Iz5Vo7MuOW+9sosP9DuRCKnu2gjI8ABGBwDxG2U5MP2C/hrHgDrUi8nH1CwTeYAgP1v9clXGSmYn7kdOWDcongzZwQgBep6corNmiL/emZwPpKueAQDiUIPJ9vkDONhJcaNE196fQuwQTDsbEiwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892451; c=relaxed/simple;
	bh=a8Oo1SwuoKvN71r8fdLG5B+2c7kgoLp0LMVE46Y7RkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SB8kaJz7eM5C3yo/szfSVv5EatTWxRGqBQzOQMb2yZEYB+qBjTIVQ7SGc7UMbkvWWHS/r77gfxEoxhMe3fVmbhizjE8yjmRynXSa6Qb32VAODDxkPPHcOqHNmapnRzoMN01gxooYzQQ0Y/hZQCEt6I3OKMWtynJPaArlmuw4eTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/QGARsK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/QGARsK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E98C2BCF5
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777892450;
	bh=a8Oo1SwuoKvN71r8fdLG5B+2c7kgoLp0LMVE46Y7RkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I/QGARsKDnREALal7/B9silgcCL8i+I8H3wmRmM7ssG6oFgQDepv5uNJhx2lWQqWG
	 wnu+//93UtBvWe5F0ta8DQZvT8Kugg4py8PhVPuOp6ztccdyn7k1P4c4YpjfNeZ1Kv
	 sfjoO8gyMDrPn5KtaKTxSZEUBDOBg1jiwKtATdMwbb5Pzzl76RG60GYMXYW68g18nP
	 ApNE6enok39nxTqTGJEblIsoBDc5CKwFcTE7U1gS2W4QYAk3uALDiC8jIHAFZbepEI
	 +NEwVniLAbNDCP/Gbm8oe9fF2kdmOsoj+jUtD6FgEx6N3tBTsw2DdEt1w8k+jRA+cG
	 S63s4uomL+w6A==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67b6dc50b61so5677440a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 04:00:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9fADO9/voOxR5bPdn1zbPuLNGyuveLKsORxBXQGTpDjVDKYUExOs8hhgPXsLy8Jt+kfhU9DjzQ27pOZ5U8@vger.kernel.org
X-Gm-Message-State: AOJu0YwQOsNoCnDFbW8l3wL4ql+MnC4WiiiOBpRRJJdUCGz+qJf8N2fH
	xCyI0gkFEpjpkMHqrrEREs6choSWHNPS3gg3nFWcxPeVdZB0WRR2ORILgQa15QgOkuwcOCrKS33
	r59fgWswbwYk3N2kbWsThlx0WX0HoM98=
X-Received: by 2002:aa7:cd58:0:b0:670:d548:da79 with SMTP id
 4fb4d7f45d1cf-67c17f30ff3mr2966951a12.3.1777892449344; Mon, 04 May 2026
 04:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430115447.2604683-1-charsyam@gmail.com>
In-Reply-To: <20260430115447.2604683-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 4 May 2026 20:00:35 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9d+gmsWHxD6Tpm7iWr_jmXk-Oy_hqHZVEMPQQRYcksDA@mail.gmail.com>
X-Gm-Features: AVHnY4IkIm_HmBSyEoZobvGdNfaegI76M8x-x99B6dyk63rtmviNm_GLQQ_XQC0
Message-ID: <CAKYAXd9d+gmsWHxD6Tpm7iWr_jmXk-Oy_hqHZVEMPQQRYcksDA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: use base mft_no when looking up base inode for
 extent record
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 8:54=E2=80=AFPM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> When the mft record is an extent record, ntfs_may_write_mft_record()
> looks up its base inode in the icache. The hash key passed to
> find_inode_nowait() must be the base inode's mft number (na.mft_no,
> set just above to MREF_LE(m->base_mft_record)), but the code passes
> @mft_no, the extent record's own number.
>
> find_inode_nowait() uses its second argument as the hashval, so the
> lookup lands in the wrong bucket and almost always returns NULL.
> ntfs_may_write_mft_record() then returns false and the writeback
> path (ntfs_write_mft_block()) skips that extent record, leaving the
> on-disk copy permanently out of sync with the in-memory one.
>
> The original ilookup5_nowait() call this conversion replaced used
> na.mft_no.  Restore that.
>
> Fixes: 115380f9a2f9 ("ntfs: update mft operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ntfs-next
Thanks!

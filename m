Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942634CFDE
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889795; cv=pass; b=nCpmC/WRClC5wh2hYPj7tiVEp2ekS0zkgkLywfUfmMDQ+R7F/hfvoMlxpcpvsw9EZvPsyBi62jec5kYnJnqbaIhBPGg73xmGp2b9PK1OBIiOnTILkjng7i30WZgV3+AXLyDf1hrKx5XQDx8QPFIC3Zc1HU3+sW6MNtN6cCmdd20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889795; c=relaxed/simple;
	bh=DLs/KIZ5/ycwSa0SN3niPNJWgFMiQFCmcvqsb0nclfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+VvyJy7Y7z2GMdDI0uiJRHtvZbqP6u+dTrguIzn3A87ytIrKosceDi6h+COrzEZw9LuJjw/0rSt/fFfKxXoW/4sthGgiY3r0E6XctCDNCmKj8xqoDSlyiye9ROAy32mRW2vmD7b3Sbr+hfCSydTf3vH4EfR0Cq60Nc9COZvR+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TLUBHtM4; arc=pass smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLUBHtM4"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e30a06b59so295299566b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 14:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790889792; cv=none;
        d=google.com; s=arc-20260327;
        b=YI3O4gMX+FQfmb07LBIXimg+A0HXwh6+pG/x5WY3w8wtx9sJu6OmvO2iWOxKIHNnJc
         O7PRwCZczcqIzgrgi1ODnOKfIr8canUpfmt1AAL1Qa0HY8MxOVZy4J50PjM06D8w6Tus
         yuhQmQnoj6z1QiJVsptOuzRvnmuWmGUqLV3DzsMqv7jMfDvj5jdpsYAl7BjJkc8Eh/eF
         YbKMg9+gcXC6HlyP5yQ5ujEKs++8AwEod1qVFSGaCV8nfTA2it6HGZFJAOGrU+ynK4UK
         4xTb9+CNgMBJdoqfwgNgbwVZRrJMJnLPu6a6j6MLO4ss5bixzcKMPqU+HH38L4L0VU8A
         IatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bGDIIilh263XLFQkrjj0HvyT95v71lu9sg14IVq4dQQ=;
        fh=qMzrm4+hWF6had4SzLL6ou6/dFQhBEGRyKYRZZG+3l8=;
        b=OKKEcyY+ociyND6tR6Xl5Kk4TrkZjKqdfr6ZKRTjIRh2TtBc+r4v8P4i2cJOrk+Nz6
         JxwUdKRnR3XQ3d65/yXzKgeiK6oVwLyu+ZQAqMAn+KGFxbcomiVBVK2sEmxi3CGYoHBB
         03tYGvmOMHCAlYLpCZlqlAhQSZWjGAhunAV7oqnjvc7H9oiXoYi9RBXTuK6GE28aCZ+s
         7sy5NyibnKDVYu4KJ1BJaqjsemULVZgKphBASJlpprdR6ItSkSZ4DPwzrYpJ4lp5BKMl
         pGgIHnWThFCUpm2iSXGLE+gvge/aqn8A8230qlRXaFrlAo+mpGPqRL0nwjY+FwOVGxAr
         lmlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790889792; x=1791494592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bGDIIilh263XLFQkrjj0HvyT95v71lu9sg14IVq4dQQ=;
        b=TLUBHtM4X9DfCuZ+6UdOl6Pymyz9MySlWXhFPcefNzL8k2Gq8fs+jKPTLkk0Sv4vWe
         TUHEzMiqAqdbdFmatWRgOhwKRlrqN207xBYbZ/R19XlEKJoOmFCuj4A/cU3y1wXDGgMb
         Vq7LOg2k2JSXkwHKZuyngZqcsAn14vS5eZtj1w9M5Y6oWQowL7z5wpQJ0PRVR17N4IcW
         ky2ZGWnqpeKVQBri8a3SkK4xTareftW5LaJetdwtXbW37sDgTWqC130B7o+gD4s/FD88
         ak7U3SUgN251Ey66LpsgCLt0xPdEYfovtlK1wb/X2RtE5zpETwrLlpu/CTxnXdsz7clu
         zB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790889792; x=1791494592;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bGDIIilh263XLFQkrjj0HvyT95v71lu9sg14IVq4dQQ=;
        b=1uLnZ9iuWSNMZN7INYJRxCbSbKWScqcRNO5cz3XZ4DGgZ1MsP91FJQa7GbCi+dig5S
         CrBL8yqK7YEOR2Zphk24Z2a3H3MbL9FnBM4IlHDFcfytLnPG/2Y4BIfXwuY60I34mhYK
         C8PAUF8w2ue2yevS4XJAST798ly/RBeKUeSnNgRovWu2oVRIP/qGScbYtQjfJV9ZB1NC
         cs3Itx6fszhjzYH6EPx43jwwHpmPm9/OZwBWrrrONDOhAxk8C8VX6tv2/KZRdmXJM9oD
         zDAfN27NB+wDgmNaoLUZ1fnrfJ7tRBWqEUZ6nEAjASZBGUaFwJk6X/Snp51W678f7Axv
         smwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzm+3qPonLJp6Si6jbCcrO6SuMYR/6ts7Rqo/mv2cAo3yru446RY16Kf7a8J/1viWVy/q9v3y7dqAVB2qqz@vger.kernel.org
X-Gm-Message-State: AFq9FYLaBvmJLV8YOC8OWXWT2PHSKGlb8D0AZkcjaX8W5k8HbbW+TqGF
	hYx0MvTgZe1UIhK+ciJxxG7LQA3GRs71tOOsTKbJ5FQoOHZcOzyZ6zPoHGRDEpSO0vLFDSzn44S
	TkAU5y57anTzpsxkwvsz/zLt0T/TsqhPX0pNjwfPb
X-Gm-Gg: AYBFou0Mpjyz2y+f/X3Nr5vIUp+YrKorKp/wUT/EPGHveh/qlfxyRBA17ZYHOTKZOKK
	ZL0ultV/F0uTzsacSUja/fiE5UOaULshL6I/+z5cTbdo6Km6VPKXMYFiOlTg2wSou5or8SgJf6h
	qO/myn8XgBTeTsu+KKOsR1wNLB0mz7j8Ff8nFlJcVI583FIcU+bX0WB1LsSuJn0jiW9Ts/s9OAV
	gl9U/jDvNChe+dEXl1l9SMebI9/iEYlc9FKKGEjOG/evkxZZrortQDkrv6rkQnTH9f6o2sbduix
	61V0K6xjJoRIcGRxLp0EPyKH1uOYq2J6HsPSzBp/6AFuV5tysdJD7FUqyOlHtUhF2OPcSmffMa7
	+2H8yy+M8Huv72FRVcEzU
X-Received: by 2002:a17:907:7282:b0:c25:977e:5377 with SMTP id
 a640c23a62f3a-c2e4ad7cbf6mr69097466b.10.1790889791661; Thu, 01 Oct 2026
 14:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001171349.81454-1-ebiggers@kernel.org>
In-Reply-To: <20261001171349.81454-1-ebiggers@kernel.org>
From: Sandeep Dhavale <dhavale@google.com>
Date: Thu, 1 Oct 2026 14:23:00 -0700
X-Gm-Features: AclHuK8XgZOhRUaL3sAt7Iljpz3t_TC6CLjoxsnzy8OUuuVA4aEvXm2un4VWkDk
Message-ID: <CAB=BE-TsYHMdwKbVPmEQZXENL1gVcwUa7Sde=e1wgGuVLKWnEA@mail.gmail.com>
Subject: Re: [PATCH] fsverity: RCU-delay the freeing of struct fsverity_info
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:13=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> __fsverity_get_info() calls rhashtable_lookup_fast(), which just uses
> rcu_read_lock() and doesn't directly synchronize with
> fsverity_remove_info().
>
> For the same inode this isn't a problem: its fsverity_info is removed
> only at inode eviction time or upon failure to enable verity, when the
> inode no longer needs its fsverity_info and it will no longer be
> accessed via that inode.
>
> However, this is broken and can cause a use-after-free for concurrent
> __fsverity_get_info() for *different* inodes.  Those rely on following
> fsverity_info::rhash_head in the rhashtable under rcu_read_lock() only.
> They also use fsverity_info::inode to do the key comparison.
>
> Fix this by RCU-delaying the freeing of 'struct fsverity_info' after
> it's been removed from the rhashtable.
>
> Fixes: f77f281b6118 ("fsverity: use a hashtable to find the fsverity_info=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/verity/fsverity_private.h | 15 ++++++++++++++-
>  fs/verity/open.c             | 13 ++++++++++++-
>  2 files changed, 26 insertions(+), 2 deletions(-)

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

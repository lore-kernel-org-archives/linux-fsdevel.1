Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578912;
	b=hRTekallU9ArhTf7tqh8WOIRGKi8gPnirv3cXN1HMnSMBsSUYT5L0yETFpbMMPtx1na5
	 SHaYwvarCs5JzRiPmwMD+OhGsnsFlpeg+y74rtQr8siJz6xNBKQsDVRwiFzCxuEHF2z3o
	 gWjgzzz4p+WayRzg9jkAzCg9TuV9hmplvF0ZsZYj40L4JTH34JV6jvbsHFrnScreO29Q/
	 I8ieLbu7LGf2brsWolqAjolhFgiZzcPJe/SItzQ0fC3tvHNeFjMbu4PqtugJ9yYxcoq9e
	 ZTsmrvSI/d7QiGn9CpQy8Sbiy6LYevUWr36BE7OgHaUWqTI7xmp6oxN5XzMyMBQLQWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578912;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0xc8hhnGzqwQVL3eY7Q33EOzRhUWz24n/pDkXb+Wj6M=;
	b=csrDhGK1CDbA7JCqWqnDGVxe7948hqPbgy6l+ijIpn41mRt5C0fY56/ycXaiu56Kok8s
	 8u6AMoBJMDRus+sIxFO4wJXnRQG9P1M55kXf3mWXLV5s994laj8TnzmhbmeNWkluAT8Xh
	 GlCcQ1/aOwXkwszPqSYwnUC5/l8KLYS9BHTmGBBjJql0MggwpGba+mdUkw5U3sZ3vtLQL
	 mpIVCXmZCqfjcaPbMebOM7Mcqwuxj/5T02neNjadE174lrXV3rOxQR009hXvzrrzrrWP3
	 RgZLK6nxfMyXFfEt3wtVEx2w21y6uW8likewNBMKmAxtI9fA9cxQharXlfEjCw5FWvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5h0OS+W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2D606A321;
	Wed, 21 Oct 2026 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5h0OS+W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9AF1F000C9;
	Wed, 21 Oct 2026 10:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792578911;
	bh=0xc8hhnGzqwQVL3eY7Q33EOzRhUWz24n/pDkXb+Wj6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=K5h0OS+WkLCh4NmG/0DlwQWoFFV3pGBgLWd/oXGkUtSB7FfPX+Wx7beBCxdCTg9wG
	 gN5g4KTY8qz7+QblXbHpvbBJllymWSPwnVnIZHcaqcWgBYNYjtqm0J2vLpVf6O0Hua
	 7YaJAuOhg/A0k5FPuvmiHF2NJojIvKU6nhAokf6AFrxzg1PVcc5c4OAGHy5P6QPEx5
	 l0XxYPnFkIrtQLjleIlo4QtwUMkonFc0qzcxo1U00hW7H81UeKwILgdduWQBLYR6b4
	 lmle0d87q/9lj/t0tcQPqKtgGBWDGpy4lIE+IF8bdSMHYSmj59p6p0hxgMwq7lMBoq
	 ORkK2HMJV4GQA==
From: Christian Brauner <brauner@kernel.org>
To: Sanan Hasanov <sanan.hasanou@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sanan Hasanov <sanan.hasanov@ucf.edu>, 
 syzbot+e353ad4408c4f9fac965@syzkaller.appspotmail.com
In-Reply-To: <20261019013645.40834-1-sanan.hasanou@gmail.com>
References: <20261019013645.40834-1-sanan.hasanou@gmail.com>
Subject: Re: [PATCH] minix: restore uptodate on bitmap buffers before
 redirtying them
Message-Id: <20261021-erdumlaufbahn-innehalten-monster-10d7ac78a7c6@brauner>
Date: Wed, 21 Oct 2026 12:35:06 +0200
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aaizelgfnvGTDDjJyyiFuec8MyPX1FhmmK/FQv/A3NI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdmBptU2zZxfHv78t9//7uaF2cuC7u4feVGQWMh7UM+
 Sunnos62lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRKFVGhssqJnf+7C226Jnc
 uX3Pp8mvVUrLfty8llDNfshshsuWdCFGhiMLWYJeed9f/bhkVU+H+h7/hTpLjU+J33otKvqQpan
 +Bg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sun, 18 Oct 2026 21:36:45 -0400, Sanan Hasanov wrote:
> minix: restore uptodate on bitmap buffers before redirtying them

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] minix: restore uptodate on bitmap buffers before redirtying them
      https://git.kernel.org/vfs/vfs/c/71e7bca183fb


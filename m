Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373190;
	b=E3/BUCztSr0nmugOYjI+KRqbtcEv79QvC2KO/3BAE/wd9+A71c1TrG88pDAIB+bpzK59
	 Ge/OIowJZ69q+UPElD+C9m1os5IjMq42UyeIeI2QNUzhnqAC6GCFTV0IB3S8/6s8MEEbN
	 7zH9cYogCgRJ4H1dQKCffaXI1i8yo6gb4CbxBvM/FPsWQvPUL6acRO5b6FfgBCvJF7qUg
	 mK0zalHuAmzpSXGZer2yyybBD7yLpC6fR2ll6fNi1amyJIMFglUqOx3/v2FnvsHh5uxW8
	 PZJLS94CFxaDM4WLChQ48lqEJiVOdbA/0nJDtDB0aagR00hfAkr1aZQ/xLQRN//s5MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373190;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=CM90dHwkMMK+3yO6My/rIX93xYpgwHbmTRgLKDv2bGw=;
	b=29r/T3I/DjOl7qCTWhmKdDky5n6m8mv5thhh20Bx+67QcMygLZUFqkOl24C0VUjfwRLK
	 6HN6QQg+ua/430a7Gc44YJovgtJNWEtLX+CFfAJaxn9Ly5q8KoC+O7Nmlf44NWN6VQXyt
	 owzrycshg9BNeYR3H6sESd2y2gcm8j/C8f8ovVrV+cjonrB4nplDZQEem7fhfSJgPq833
	 qGUVUrc9VXjltPZC8JGZ250yabf5pofaX25J6d8+QajQ0dDyfDFMBPTD3HZ8ovajyjw8d
	 inHKTC7+PuGNjkdavHbeceaJ8hChqXNueq828KeFeAbCV8QOI0FkSItpyTMw1ZoQyzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+CvVI53;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4930606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+CvVI53
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F24B1F000C1;
	Fri, 30 Oct 2026 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373189;
	bh=CM90dHwkMMK+3yO6My/rIX93xYpgwHbmTRgLKDv2bGw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=c+CvVI537xkqLUZl2teTjXWL8sTFUb1T4cKmyXPq+nXBrsMeFRBDb6Qm/xwv/ysc4
	 QWYnqmdRjGoVB8/lzCUMVVWmKcjIAYfB5IdfmZCWVYJYicUuXIpD3R+eNUyirLgFcw
	 rDrSXxAQSjV/GfSiJOsnqPWMTcSRXmIPKHIgFxEO1DVuQ9H7ZhKFq0oYE9/xyTBanw
	 fUuF6tBhs7UOs8DQkoSd20PIIbZRAq6jKKl0OX4D2Rm2Js1+7FjVbG4s7BZOeMfLrP
	 cCFVeF38PdLZL0CYjXAUzad259h9qS13lslNS7Nm//8UXc+y21csIhUiUFTbp5HnZ9
	 XerFzN1wBtlFQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, 
 Cheng Yongkang <teel4res@gmail.com>
In-Reply-To: <20261022112534.3513745-2-jack@suse.cz>
References: <20261022112534.3513745-2-jack@suse.cz>
Subject: Re: [PATCH] aio: avoid request count overflow in ioctx_alloc()
Message-Id: <20261030-zuhauf-anmut-halme-8b5e37b28c93@brauner>
Date: Fri, 30 Oct 2026 16:13:06 +0100
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
X-Mailer: b4 0.17-dev-ce4c1

On Thu, 22 Oct 2026 13:25:35 +0200, Jan Kara wrote:
> ioctx_alloc() saves the 32-bit nr_events in max_reqs, then doubles
> nr_events before checking the ring-size bound.  For
> nr_events=0x80000001, the doubled value wraps to 2, so the ring check
> passes and aio_setup_ring() builds a one-page/127-slot ring.  The
> original 0x80000001 is still stored in ctx->max_reqs and charged to the
> global aio_nr quota.
> 
> [...]

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

[1/1] aio: avoid request count overflow in ioctx_alloc()
      https://git.kernel.org/vfs/vfs/c/b44341e39d85


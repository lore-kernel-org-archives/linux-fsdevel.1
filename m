Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A243265CA2
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292896; cv=pass; b=Qv7BNe9aTo93zrR/N+SnPw0BeUOjWfob8rLc1twFm3q7CgbzdUda1geATMZGR+uGDX/j00KAUJZ+IE/MPPfaBT8CnmfOcXPHirYZ3tU9fT7gDffE4J/cshv+vrS9PXfKQWIE7GefxysZVg4ziaPRIZb+Sh6XMxpXwHqQsW22tQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292896; c=relaxed/simple;
	bh=j/dPFsL20cNBcqiBzP//mIFaPumAciU8Vw5CSWOBshQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvxFUQQXli9CWJJfKrevziHYy/TQv2rHnVI/8JpalLvswds0u/gxv3tcqsA5B+QtvNOyeu2NksHDWvjU2iRPaJWDkBn7EINxAP6CSlUXiPSSwjkbMtMaaU+KBAC0I+6Z27Jj1cqKgXZRAFRxOV7d5UstucokM6pbJ3rkZ5m8k14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=U8xQUu8A; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="U8xQUu8A"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0006ea8eso56127651cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 05:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784292894; cv=none;
        d=google.com; s=arc-20260327;
        b=Fn0VZC0k96c7U1CLUjAy3xI0YZQtCHeCj2MHrKFLWfVc94VdHQr+E+pfhuQNh2hxNN
         TBoW3tys1absdWz5ndlFtPfdeLf8BC+lnt8fK18Cp8lVfztJnrOoU1Y61GS2UpWAh2lG
         9XU/TPBhC0+SpFxk0PPv8uLVbhjIfXCC0vM3ZhQczJmY2XTxHV2dyrzRsqwaEwK5YxV6
         RCHAkcQVH9Lz7PiLUk/fss9NQL5uZJP2mt6C7T478n5+9ttWfBQse3xGmjwIeJHWUDf7
         EB5dze2pqEYkLJJtK7EPhkv5bO6luFOHWAxb2gjq1NKxsEZreWRPjHoVcmYZDkJzoMQJ
         559Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RkEn/U4bSQDGfp+R/hFke2W+WB1mabwpE00gBZz/WTw=;
        fh=j2ba9qCtVeVyj9/Ee/JC0WeHO8qlC6v860X1KjrtVaI=;
        b=r7ed4nwKEH3VvuaIK7tQnEKbFEKFBsuUmA61iPLI8kXYS7Yknx5hJJvgJJhHEepVtM
         CWo8DSiqSSYcZ/A9HoFF40hpgugfC/XXl88ZSi4SL1VAicgKSs7fniztP+OYT4m4dE1x
         KXb818FIM1NiT/UTeB4FW/ov1UcN0Nbj6EMj7hN4Qgy7r82Urqf1Sx3ksGSc1TD0GFmT
         mdYFypTlHjPFNk/v78rbOAOqVyPT4kXwDuaTGOMDF0aEv+nJdNEaYF02TqCAIRT/59Z7
         s46G5bYN9UzsRYY2/B1vTJe2s7Kg+A1/oQgWJpOiS6vWESksTwQP8sONh9y6ZKKnRwDr
         WgiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784292894; x=1784897694; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RkEn/U4bSQDGfp+R/hFke2W+WB1mabwpE00gBZz/WTw=;
        b=U8xQUu8Ag0SRsekW+V5gRKXv80g1m0z3zfA29FVnP7wQOBOX1Dd3FotW4GrHJQSk8/
         akoCS6/i+6i4/kgk8DV2/Vds2bnFrQdO68BGV9ivk2G9xRoAKN/9+KiOHcq6m8+iBs6y
         Z2yO55kaXenZyJw6Udk0cf71QE5K9WjO4/Mic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784292894; x=1784897694;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RkEn/U4bSQDGfp+R/hFke2W+WB1mabwpE00gBZz/WTw=;
        b=SupjbJ2/tiqzl5wIR8CHq4WbJWFd4r4LOPNnjuIxKBA1EqeqCdAPC/lhZLvb3KXtCP
         Pr6N4DgMVqtP8umrT6PQWSI2UkEwHcSSTciXdjQPKubvpp0af6b4fvVKtkanbLfLisf/
         iDRGyemdtVxTYRf0zCy1HJaSd2J+JAoJL8WgEq7XX/kNMc93TJFJwFzYV2qAshqPbs1Z
         w7lDIi3uaJK5eMMN7P8dyoxAkegczyQaahhvkmhoakZdhuNlGT8LjgbuyUnKyRgrWMdk
         Ie38gRboJIpl7gBH+2XClCSTz4Mu/vBG1NNd5v8gGrUHQVlzYTqfZOWoWJKw4wzv7xzS
         N0Uw==
X-Gm-Message-State: AOJu0Ywd40D6eqTVErcCzS6bp1U2LVsw4XEHPEC2HydXSGcAlLRyqK16
	nrvWGPqQdOWXXU4z/Rn5F5jplEnxiAKPoKfe8m1AnvDzgWS0RK5lmqKnly5kU2LNn0O8PN8QzEq
	ejGPpc3w8UmJSr6JdlPPgxKRn+RAEOokePRNqaCAONw==
X-Gm-Gg: AfdE7clY72J7VlUmA/3hGWWh1fc/wGvHhVP+jlICgKhASOCw34AJFK7w8fUo6n2v66r
	HeBBgkNyMXyXfzRjgExNqbuZFatXAIDMyoeCEB5cqC1cKdT/XO68MzzrKTBg7MvzvIveOUSblvo
	z9wuh/xCzqRmf0TH46+fx+jTYCa4P5J1oegXHUrXGRDqu8Z7mDVD7aEboCNZqPon1N4r3Owqv9A
	BWvvImtw5b4b9583uk/CEuDdRJ3uhdFgAKU/QqIeoY228e28mTzCZda5BDns9DvL+MCc0MBQP3f
	xrIWl87brFmjCZV+46lgMu+u8w==
X-Received: by 2002:ac8:5854:0:b0:517:87df:d8ec with SMTP id
 d75a77b69052e-5213a385983mr22000141cf.9.1784292894270; Fri, 17 Jul 2026
 05:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623004227.77628-1-jim.harris@nvidia.com>
In-Reply-To: <20260623004227.77628-1-jim.harris@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 17 Jul 2026 14:54:43 +0200
X-Gm-Features: AUfX_mwpY12WuPN9JW_YjJy1uKhyn54yddm1u7-rTCQkoISfPR7tH3futXxsKhw
Message-ID: <CAJfpeguz9BuDtTo7_0SE_iW6w_tLtDqc5cW8bcE+EUKQnDCU9g@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: allow larger read requests by setting bdi->io_pages
To: Jim Harris <jim.harris@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, Konrad Sztyber <ksztyber@nvidia.com>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jun 2026 at 02:42, Jim Harris <jim.harris@nvidia.com> wrote:
>
> A FUSE server that advertises a large max_pages and max_write (e.g.
> max_pages=256, max_write=1MB) cannot currently obtain matching
> FUSE_READ request sizes from the kernel.  Buffered sequential writes
> arrive at the server at the negotiated max_write size, but a large
> buffered read() is split into several smaller FUSE_READ requests.
>
> For a buffered read, filemap_get_pages() -> page_cache_sync_ra() sizes
> the read against ractl_max_pages():
>
>         max_pages = ractl->ra->ra_pages;
>         if (req_size > max_pages && bdi->io_pages > max_pages)
>                 max_pages = min(req_size, bdi->io_pages);
>
> fuse leaves bdi->io_pages at the default VM_READAHEAD_PAGES (128KB), so
> a 1MB read() (req_size = 256 pages) is clamped to the readahead window
> (128KB, or 256KB for POSIX_FADV_SEQUENTIAL), producing four 256KB
> FUSE_READ round-trips instead of one.
>
> Set bdi->io_pages to fc->max_pages after feature negotiation.  As the
> code above shows, io_pages only raises the limit when the request size
> already exceeds the readahead window, so it enlarges explicitly
> requested reads without enlarging the speculative readahead window.
> This avoids increasing speculative page-cache readahead on behalf of
> an unprivileged server.  NFS does the same, setting io_pages from
> rpages while leaving ra_pages at the default.
>
> fc->max_pages is already bounded by fc->max_pages_limit (and, for
> virtio-fs, by the virtqueue descriptor count), so io_pages inherits
> the same bound.
>
> Suggested-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Jim Harris <jim.harris@nvidia.com>
> Assisted-by: Cursor:claude-opus-4.8

Applied, thanks.

Miklos

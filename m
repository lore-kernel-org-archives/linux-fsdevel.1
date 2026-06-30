Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E107131E834;
	Tue, 30 Jun 2026 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862264; cv=none; b=Nkd55Im/lrCEAW3uQOK1dNU0V12VBxOHzrHZ8JuanhdP1yM5N//S4YcKQli7a0SypuebviXPlrUFt72q0Sx2/8btV7C7aT+bEcUgIrPuFILnuMSkrqpW27khxPeIZWG62CltqrusRfvGSNcxogfc48ZOSKSFuk7ZyP4HfnrAruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862264; c=relaxed/simple;
	bh=nmum7b6E4ThNuBAAdyTQN0WMwuwlJI0AauIO5UVtdIU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=W5yTCaM98qRJn1wWw590kfgsQsTeDPxTbpkwW4eKiq2cIcoMsEPWOFUAYXqsxPKESCWGhV8We3PcUduEmLiC/0cW4IhEMLp4LBvmOE7JqioCb+wKM9pvf5l+qfOJuzgoi4b3iDvPEnThxqJK4LCpCN/r1QDyxOJGJe5tuhpW9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=f/SOD/M3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RGki0XLy; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="f/SOD/M3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RGki0XLy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 343EB1D00100;
	Tue, 30 Jun 2026 19:31:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 19:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782862262; x=1782948662; bh=HC3rX9aewZEqOlQDOIhJ49d2y+me05A1l3L
	MXf3ayxU=; b=f/SOD/M3AWchs5RHZQRloOwx4RPHyI8CPEZU7eYZm+QmIlTIvRr
	D6uCo2OcNbjbaPDiKoNAZmjgUQ0aRM6rlMeYQ5H7MRMXt6hofmWFY9lW7x3wmpnW
	smU6dAJo6oB7Vt29rKaistws5ngCbj7Hq/GE8FdgQk4inclqx2PRnI6z4EwfYamu
	nW2fGB5h5hwvTzcEIKcCAK90nC+pded/vgcKWtIgtRkuMbrZ6MF13IeDJ+KhXGNE
	I8ALSYBZ5jjSIuRv1gd8gdtt3MwPPuQWEsTvDWB76k22MP0Mu80R/RT7VludM/cX
	jETnkvE8xVPvdRhoBpXl6q6BqoVlQ1ohU9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782862262; x=
	1782948662; bh=HC3rX9aewZEqOlQDOIhJ49d2y+me05A1l3LMXf3ayxU=; b=R
	Gki0XLyJFcdaxGQErHAdlMBJvq77ky2TbBe6RT7mJynXNQyZn4QaSAowD0uGMLbi
	Twmg7gdeLvb46KUvKtLFvxFkLyYhOYcwg9ROBxgwZ5qQzV5WxXhpNRdqOK2rLCIB
	EnZoF8ZWnfrEpm8OEvTwGKon0dT6F+ZIvzxSS1CvEulMmixI98sB6pRzRsJ0psGl
	GKSVLUTvFDpzJVgOBuDyry+7vUoooBq9pWH7EUE1RuLDmyBU+jyXjnbg0justEwx
	4HyzDscPgkVG1fKig1E9Fmh2Gf4aiy1nK3x1yxLuQpdfbwRBQGxRuJL6EKUXIaXc
	Nz4VIiJMhTzm9tIp3ARmQ==
X-ME-Sender: <xms:tVFEagueoKrrWe4SlOsxUq8pyjlKK9yc1b_oWILLi7yee58qlb3cyw>
    <xme:tVFEamaGgTR5YXzTucoxD5YUhAiQD6eIjDM0sanYHPF97juTzLIhCu96lJte99KDu
    Uib2S-gHgCJCjEn_d-84eTc8FbpLKO-eIkdU6yy_jgzqfvAKA>
X-ME-Received: <xmr:tVFEanUlJ2r5pJF7vSD596Koo0YBoSTHldvEAPyw9x9gU_4e2mKXh3_mVX76F70FHz49pN7igDJhApbRw9GeCvgAD0T93_8>
X-ME-Proxy-Cause: dmFkZTFd7dJuxJk5EJFZXd4B37RWxuI3t196xFcOklBw5G9dOdPyD8bg9jUn1ZyZ9nCVBJ
    Ec9ReMjCZWgey70bA673/xDU0x4XRXlpZY9D7cqXRIpyYhP0O39vBsJXFS4LcQQZn2zAbO
    P7a8tTWMVLvGDXa91UU8cXVDmevT1ZyHa458O/l8vN4YVMbTA1EnvFT8/QHLWvEncJ5j9N
    oO5R3qzSxnm0X3vFYmyjXVsmJupMhNrQF7mtkYn7lUWT7HqnHHWXHiZnE0NTCAOtWGf1NH
    eL13vi4ymALcmorQgGJErnTWq2NczzSaBsOC7ZRNA+0beoGH1n3L0EvNyTuAkkEr8BS5g4
    brL5BL8T16/xy8haJp7loi+8XdnNhq4N9Dg9OaITGTuUIjBJf0kobPVXeeYIh/xGwRqLLU
    y98Llco1WsiZxJkNLLmhsz3Dw2hw/5SM2bV75dBj+RPVZqrFvH7bYxsjCVngSIAT0af0j3
    GjimMHOjcPRhfqr1Q6IncRkGPAk9IVSliy71Nmexn/dhokZdxRbOkbeZxRxneqd5I/u8Ue
    QmkiO7MOd5Ci1Xt46cH1l/lzZhaDTbR1+SwfJGRSoqaCzg13BGw5/E+t7jau9Q1mZuNhUv
    0W3GKiy6dYrhPGAJHxToAII+xWSYwkDPEVl/sSvwUyMbj4J6FtaeVv18UF2g
X-ME-Proxy: <xmx:tVFEajRSn1PlnkqA1vIBD756iLuh9XVmFpPHDWafaqRaUZ0p435fNg>
    <xmx:tVFEatMSZOdftkBt8yWC-EpE_L1tIRKyL1hKqgBz3mMYqt86KMfwpQ>
    <xmx:tVFEapQF96azsKLawLxTAwWoEinixA0-qMcRyr0o73V5jcY_cJQ8iQ>
    <xmx:tVFEajgnFulqeLOY-7pbVYnYA71nsnYIB0Y9BHv_enGGY3uP93ljVg>
    <xmx:tlFEarBQ4zM78LtgpgOwvvP730YrbDg4hsb886wJ5VG2xoM-PSZUThCF>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 19:30:59 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Cc: =?utf-8?b?0JDRgNGC0LXQvCDQm9Cw0LHQsNC30L7Qsg==?= <123321artyom@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: PROBLEM: FUSE_NOTIFY_INVAL_ENTRY leaves stale negative dentry
 after c9ba789dad15
In-reply-to:
 <CAJfpeguDUS_3X-AFZD6XCJB1SjVkFGu2aJ+p1BK574Scu-ASdA@mail.gmail.com>
References:
 <CAFbF8N7++zopZuEcsKRxBV_sgOGCbzCY0hOyMw1SiGAtuzGhyQ@mail.gmail.com>
  <CAJfpegsCJnMfn_BzzTK7m9ndCGVsnPit8ZsT0fzAhYoY+yOsKQ@mail.gmail.com>
  <178035740095.2923901.5908691318688917347@noble.neil.brown.name>
  <CAJfpegswAZv8OmDAcK-5u8kssAF1vZKe4gdDB2XPErAnoGFSYg@mail.gmail.com>
  <178056619459.3392745.3091041855723132411@noble.neil.brown.name>
  <CAJfpeguDUS_3X-AFZD6XCJB1SjVkFGu2aJ+p1BK574Scu-ASdA@mail.gmail.com>
Date: Wed, 01 Jul 2026 09:30:55 +1000
Message-id: <178286225519.27465.210364797855970767@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 04 Jun 2026, Miklos Szeredi wrote:
> On Thu, 4 Jun 2026 at 11:43, NeilBrown <neilb@ownmail.net> wrote:
> 
> > My guess is you refer to the need for retry-on-error.
> > I need that design so that locking can be pushed closer to the
> > filesystem and ultimately, in some cases, removed.
> 
> Aha, but this is filesystem code, we don't need or want to move it
> closer to the filesystem, it's already there.
> 
> > It is a lot like the reason that we often use cmp-xchg loops instead of
> > holding a spinlock while performing a simple operation.  The code is
> > more complex but it scales better.
> 
> Okay, so this is about making VFS more scalable?  Can't we just leave
> filesystem code alone in that case?

yes and no...

Some things in filesystems do need to change - particularly some uses of
d_drop() and all of d_rehash(), though they don't apply here.
And as I am changing what inode_lock() protects for directories I
needed to review all uses.  As I was providing new interfaces I wanted
to be sure those interfaces were capable of handling all use-cases, so
my goal was to convert all uses of inode_lock() on directories.

However I did take that too far here.  As you helpfully point out, I
don't need to change this code at all.  It only involves fuse code
taking locks on a fuse filesystem, and this usage isn't problematic for
the new scheme (as it would be if, for example, d_alloc_parallel() was
called while the directory was locked).

So I now see that I don't need to make any changes here - thanks for
helping me see that.

Thanks for fixing the mess I made.

NeilBrown
(with apologies for the long delay in replying).


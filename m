Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892492;
	b=Id3/+SXPPC5eku/0D0WhjQ64fU6Tunzxk4hJoE5iu/umJalNTLxsauT8OIp4P/aY4G9y
	 rmUBwEdpHzUbzcvFMKC2ISDmYPWHN8Ww4FSLuS9YYg1iCWXVsgeIJVehZZ0CnpSkD0ww0
	 OvSFoh0L2MaFufPVb/4MSnWjlwo1lStXYM/xihZLitGvTyuZeSLJLIm7UvYRn27iyMoM7
	 bH+JdPvFrqcRe+N7Ftui7p9S+yGROt0JpK3weRA7WV0+PJ9k9sN+Fo9K5eVWt2VLR6xwn
	 eVOo9a3zNxpPktE/qmtrdKu7Py78exKyvTQWot4PWHMu9WpVukMKcQcM+dKcZB0FtGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892492;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=xdwtOpkQzwoHFeFMltxpA/VozAeSoa5DuyFL+4EYsGw=;
	b=43T5zukVRStGSoV06Ip0Y3OLefOpNmelQdd/BQ6ptGL83UNsR8MboJXU2h84ppglROp3
	 Zsc4EMhhGrmwKOGxaEXW2MZCnkyozVgKhIbwLJB7r7L3lGjCFTe+7VxtOK78lAtUCZuF2
	 4BrdSUfJ/8rrk35UnlaZJRRM4AMj2RxvY95GdJRmuFc783BnG8XfC3QkAMofAruSCGtqC
	 UZIgqxB16HOnd+hbccBpzfFw1ZWqdZbR6Rk3QpFc95RxpyVqvxbYNSfk7fCIqLRSOCIg0
	 qLE8vHgufa1kTN3qVvrLvE6pP1uVOyM0pAr2lemcErKHKW0qBq75Ma23lA1XGoPYExQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=IP9HkLBv;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A1606A328;
	Thu,  5 Nov 2026 15:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 056A1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=IP9HkLBv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xdwtOpkQzwoHFeFMltxpA/VozAeSoa5DuyFL+4EYsGw=; b=IP9HkLBvbk1lubBdAmiZbHpFA9
	pmSKXuo+F7hLxOjB8jN0rpCSPuAxdKbM5DekhKD4C8urwosbxfBF1Ls+frt9W/lW+G4nQWdIaIFn1
	wrOWq862neCkfs2PDdh+EvKaJcSjr2EkCxh4dvS/BHYG/evoQTvH41Ta7VxvESnjhhHShpgoueDid
	1zrma+AkOet2EIPQfEo8RpxzbS03YT6B263KZPvAXGlFFOPfErGqLE2UR3Io7T63rfcEh/0KTKVDM
	WjTMchqToIqhWOWVaUv18N7E0A5KQXaXjCijku1X5D7wdZl8lPECXLHUXb/tYb2v2J6RPVcT/dJ4v
	aRiLBlkQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOzNl-008atX-14;
	Thu, 05 Nov 2026 15:28:05 +0000
Date: Thu, 5 Nov 2026 07:28:00 -0800
From: Breno Leitao <leitao@debian.org>
To: Christian Brauner <brauner@kernel.org>
Cc: kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [fs/pipe]  f7f4665dc5:
 lmbench3.PIPE.bandwidth.MB/sec 18.5% regression
Message-ID: <auygOHcuBba_o132@gmail.com>
References: <202611041404.befe64cd-lkp@intel.com>
 <20261105-trommeln-einspannen-radius-ccb4e174e407@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-trommeln-einspannen-radius-ccb4e174e407@brauner>
X-Debian-User: leitao

On Thu, Nov 05, 2026 at 04:04:58PM +0100, Christian Brauner wrote:
> On Thu, Nov 05, 2026 at 08:38:45AM +0800, kernel test robot wrote:
> > kernel test robot noticed a 18.5% regression of lmbench3.PIPE.bandwidth.MB/sec on:
> > 
> > commit: f7f4665dc520fd8bbc1db20e59945773e03744a0 ("fs/pipe: unify the page pools into a single per-pipe pool") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


> @Breno can you reproduce this?
> It's something we should at least investigate.

Ack, I will check it , but not today unfortunately.

I will come back to it tomorrow, and until end of week I will report my
findings.

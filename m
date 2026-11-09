Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233960;
	b=FeCCxbXeSB6AF4klO7T/rHqrDCIYa3BBaiS9Fo2Xidc7GhNq3ppoImcyP8oLjYs7ANT+
	 JoPwT5QFTBspjIhCXtDIHeUl8hXv2ZllhLauTtyIUUMb68tvNzisCh6a34s9SoHePRgX6
	 fnKG62aC9gfDmwOm8IKu0RHFtl9XEugnfitBYohLZntctqDdVbUPBfHNbYC9VW9mptE8k
	 syvauc0a+7clf/moQl2DBCFBLwLMFEQvVobiQfQWYSXNJ5eI1LrexXTNRdnfDvWXZPvRr
	 DWoaDYOQAJHhQqoK6qFhW5Ki/x7C94nVfG0q+nbBLynXDNjv75n8Y4Drm7Xch8ZaLhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233960;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=NIB1/ZT+g5Dd7DPogVGzdEFGpyRe6qe9PFDmiF7RsFU=;
	b=SdzLZuyqE1e2OVDRt6q6wShcd+2KHmO5QfVad8M2rh2903tTFS1wkH0qXnbUGvbD305d
	 8y27W3wig+mYewb3w1VjfMkF3bEleluGSI+ww/8u0Ao/T3bBKSc9eIMsK3KxeY4K1fl0r
	 ClRXjWwRyCpBOLpGoXNwCYvCUf7rig04New4X6ZVuhu7Qt5OdXqe54GXWHwiqemT6EgAh
	 /AroPxccwDKKJWgA29nwk/eEvsKJkUG/B+2D9U7c8w3r89MW0BHZRhj65kGKXQZBhITQm
	 3NGTUEJ4DT3SYOCgGCGPrHOH4IJrzhYsSFnTZig0SO3ByXiQz/Ktv7Q+k2Jk2IeHyCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=W+dNP01j;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39138606A331;
	Mon,  9 Nov 2026 14:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39138606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=W+dNP01j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NIB1/ZT+g5Dd7DPogVGzdEFGpyRe6qe9PFDmiF7RsFU=; b=W+dNP01j0H5iEkS83+zs/HtExP
	DyfsCIw624cxQe7iidx/x8uPeI3hsyqsCvMzhW6Q8Vt3t6HpUtbOvHPSbMyRYiVR8Q83AYJk6mirX
	Xd3jUW76GA+fd/5n1K0tpERYcT+GUSIO/rej8HMansToOP032BXy9uEhG2nr64q2wFgkrbzU0fBmB
	cPHRILUZLut8ZrssUV3qN4244N5Z+4CIJSbLmho8aJG200cyITNlxy/5xafp+E3woVJL7gc7Q2oQ2
	MyczW1vc3zcHWDiTxGZ3eiyLgcxYJnl0tfIFcKbmfs/f1BPHkflEoyp82RzY942+XF6pjQvpuMXCw
	YsvC5awA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQQDG-00BgNX-15;
	Mon, 09 Nov 2026 14:19:10 +0000
Date: Mon, 9 Nov 2026 06:19:05 -0800
From: Breno Leitao <leitao@debian.org>
To: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com, Ran Hongyun <ranhongyun1@huawei.com>
Subject: Re: [PATCH v3] configfs: fix slab-UAF Write in config_item_put
Message-ID: <avHWS7-3mMEsgMpd@gmail.com>
References: <20261105165055.362-1-drifabdelmalekmohamedsaid@gmail.com>
 <au4DDpKhquR7oXwZ@gmail.com>
 <CA+xk8n8apsFgcWfzLtWrtL2wU2R0Rn31hU68oQ_PRJK+=dBc9w@mail.gmail.com>
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
In-Reply-To: <CA+xk8n8apsFgcWfzLtWrtL2wU2R0Rn31hU68oQ_PRJK+=dBc9w@mail.gmail.com>
X-Debian-User: leitao

On Fri, Nov 06, 2026 at 06:30:52PM +0100, DRIF ABDELMALEK MOHAMED SAID wrote:
> Should i send v4 or you can apply this directly (if good enough)

no worries, I can handle it here.

Thanks for your fix,
--breno

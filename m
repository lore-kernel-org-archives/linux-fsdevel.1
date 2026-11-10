Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348560;
	b=YGqCPDMSRRtr02XPU/SCLYIoYBxRi6FFVJligIhAQZCbkFZoIZykDCGtN4ILOpLSFZh5
	 L1rschjFxUSinB6IqYdP10S6NxU225PACQnS4p23Nk8AqyAILVhrs9T2REEtcozs/IJSe
	 Sy/Wwd325VGTYaEcmDgTDYmqLpfrd89Wlfnf6ZO83wOhwzc1qg8uwua+/3BtVfmEdFXkI
	 4Byoh7kHkRFHA0kTejoxO6vPSuhaKfn2iirb941ozcMGgy9pHZeUDHV8l4JtqtsRF/YzE
	 y74vtULnmI/W9Rh+WXPrYJ/STgo3fx63GqCbRhD6nFm0FL+9OJjgIKc2/1BrEpISMKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348560;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yCNYyB1e6mPY3KPv5YE8b5u6D+UcPYwLF6+CATlptOI=;
	b=GpZQRH2WrsBOemWfxwv/F4hkOQCrWLZhzsKKiksiR+hXZJEzCEUhp/oYea+NYE9rfePs
	 dzvn8lPW/sjlENVCpCiIqpopBNi5WbBRX8MJbHBUanRrQ6Nky/tS2rjYThqNc0rq8PFS4
	 e/xeyprodvzhDl9uAqypPxQ7UAN+rbg6qDDXaJ1KQDG4cmqddCFM8KtCTeg2IEJcZa1F9
	 yZkVXGeEQM6pZ5c/qD9GOJAwHg+vKY4VeerxHRaOafxeKXIInkuZYQnpIUTChZ7AxLrVB
	 UDcjnb2k6rYnwdLwEfUFdrDdy5z+9bYT8XvNEnMwPMjAL46ZMISaiFDBt3nwwr1WILQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LntIx4kd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C164606FFC2;
	Tue, 10 Nov 2026 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LntIx4kd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C95A1F008A5;
	Tue, 10 Nov 2026 22:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348559;
	bh=yCNYyB1e6mPY3KPv5YE8b5u6D+UcPYwLF6+CATlptOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LntIx4kdGcmJSWf5RBTTiBeJKxc1bNdZxIie5RsSU1+PBGV9iOcAOaTJiL+kjm/n6
	 FWPasirHjGM32twIctZQbHTdsMIIhgERzNj3eiQkuL5bKF8WKhx5psXRPWH0cAXgwF
	 xBxCaA25f2S/y3iv2V+B0w9NfjioCdNmBIzOkAM6y1QJffRS+OdAqeRoOzBsZopHOL
	 v6mcRRoidX3XDuxACq/P9q69ob21R3wXslR4jjOa6/ANOIS/v/OlLovN6+shc5pQYM
	 J6kwi0g4nKJInt3fM6QjWyPdWZstTrri3XsnZekbjcA7bqvMfXQRQCDWraVhP/BTf+
	 rX0+PtWHoFZKw==
Date: Tue, 10 Nov 2026 23:09:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
	Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
Message-ID: <20261110-schornstein-rustikal-obigen-6f6c4a495c0e@brauner>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
 <20261104-allein-bepacken-hitzig-5e517d3c129f@brauner>
 <20261105-genehm-dachrinnen-infusion-9cdf4868d32e@brauner>
 <CAHk-=wgLpWDjmcNWphCMkKXKwuZsa8KWRPvJ4j=C_ktCL4gBzg@mail.gmail.com>
 <CAHk-=wi-B--TBQuYjz6J6vKtEMpNSm4_wVRzTP_vE=uTLb7P5g@mail.gmail.com>
 <20261109-hackfleisch-lohnt-konkret-02b5f3dde4f6@brauner>
 <20261110-goldkette-zugzwang-woher-1d6f21b4ddca@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261110-goldkette-zugzwang-woher-1d6f21b4ddca@brauner>

On Tue, Nov 10, 2026 at 11:07:05PM +0100, Christian Brauner wrote:
> On Mon, Nov 09, 2026 at 12:26:23PM +0100, Christian Brauner wrote:
> > On Fri, Nov 06, 2026 at 12:19:45PM -0800, Linus Torvalds wrote:
> > > Ahh, this all goes away in "scsi: core: let procfs copy in writes", so
> > > never mind.
> 
> I updated the tree incorporating all the review items I acked on-list:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.procfs.cleanup
> 
> The overview is in the umbrella:
> 
>     https://patch.msgid.link/20261104-work-procfs-v2-0-b45cd5789ac5@brauner

Oh, I think it'd be good if I get this into -next soon so it has long
exposure there.

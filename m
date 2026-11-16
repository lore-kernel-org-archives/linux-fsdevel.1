Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825191;
	b=EnJc7A6uh76b+RGOYrIBZqj7dIBqgMXI1MbtxDaQINmZWAM4T7Nz9hhbMlM8WYXRgrJS
	 7eAOuKJbqaJk4lH1oWS04cz4os93NzsbuZRp04PYHHNHiSpj9NckiUngCHLH6GTpZ8vZ4
	 pSNquAVrx0slnjrh1fHrQG61/3stYIXByApfc2qKghOe47hm56Omt3GDbgLmrUtGUT859
	 rcu6UFZlwbIB4+1BrY5WyWr3ag23nGWogBfvyxIFagg1Xx/svnFg3qt7fHD4Cq5byQATQ
	 4ao0DO5nTYTVdtqosHVc5AUfiXRln1sI/ODTDVBxou4vm0I3TjRVUN2RCfw2uvyP7BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825191;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xxxchh3oo8QactJDFBFNQRwSEBe+f9CSw296vsCa4Jw=;
	b=a9eeTq9aUvQnye94r4ah2D00V5mIdR76ax8EHFLN0oCqO6LZ/W0XMT7OE+Izx5W4Uz84
	 GJQ041coyWAwbVxMQo+Vb93aJI7emqqXFRetFrbxhW/j8pNAe8gsSOjVr+8TriSMrp1ZJ
	 WyQZh6hpLv0MjktKqZktAC9uzu7pbePLxm98e7/mxmTJVsz9A0TjKY/a0aFDHH0mL4w4k
	 Sqd9QIdeAbIzmuArba8ve+LN1F4xP85EOaZGSJSHB0YdKLUK7wRzPdeqVEOPRoV4JVYef
	 T202JkW5gHb5WwMAeKQyKjbUs/FeNGl+eG+kkag/bFeZMLDcGwi9hsjmgz2qzz1xfLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gX2DGCG7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8398F606A323;
	Mon, 16 Nov 2026 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gX2DGCG7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60AA1F000C6;
	Mon, 16 Nov 2026 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794825191;
	bh=xxxchh3oo8QactJDFBFNQRwSEBe+f9CSw296vsCa4Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gX2DGCG7qGkvTjXcrfHLrGM5iTfJPnOI5tIBB71nW55SnyESrdrusW4Z/uJeL5b0V
	 /HLYkmbMOONpQ1iPFWpIz9On2BqjuczZdvItlyKclOGg5zKgP7pYzqWEfQlUO0siRz
	 8fPtn3hZxsyeexPNBdRDEm726q4b5GNVhPFqQJlY6D2Q/+gQ4vy6DVcg/PWRTQmWn7
	 bgMFroj7iIKZajBVWuIrD7V2RWoVbnxgNd4UBMMt24HagePco7fl+keG8KVEqY6xX2
	 wPNY8BRLt2uuWdFLyGtpEtP//LaDYS7xRp8+BiBiVap3V7WgJ9QhgeGgIC6X0dx6CC
	 4q8v9JY2NfFOg==
Date: Mon, 16 Nov 2026 11:33:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
	Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
Message-ID: <20261116-kaiserlos-tauben-leitsatz-e761080c70f1@brauner>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
 <20261104-allein-bepacken-hitzig-5e517d3c129f@brauner>
 <20261105-genehm-dachrinnen-infusion-9cdf4868d32e@brauner>
 <CAHk-=wgLpWDjmcNWphCMkKXKwuZsa8KWRPvJ4j=C_ktCL4gBzg@mail.gmail.com>
 <CAHk-=wi-B--TBQuYjz6J6vKtEMpNSm4_wVRzTP_vE=uTLb7P5g@mail.gmail.com>
 <20261109-hackfleisch-lohnt-konkret-02b5f3dde4f6@brauner>
 <20261110-goldkette-zugzwang-woher-1d6f21b4ddca@brauner>
 <20261110-schornstein-rustikal-obigen-6f6c4a495c0e@brauner>
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
In-Reply-To: <20261110-schornstein-rustikal-obigen-6f6c4a495c0e@brauner>

On Tue, Nov 10, 2026 at 11:09:15PM +0100, Christian Brauner wrote:
> On Tue, Nov 10, 2026 at 11:07:05PM +0100, Christian Brauner wrote:
> > On Mon, Nov 09, 2026 at 12:26:23PM +0100, Christian Brauner wrote:
> > > On Fri, Nov 06, 2026 at 12:19:45PM -0800, Linus Torvalds wrote:
> > > > Ahh, this all goes away in "scsi: core: let procfs copy in writes", so
> > > > never mind.
> > 
> > I updated the tree incorporating all the review items I acked on-list:
> > 
> >     https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.procfs.cleanup
> > 
> > The overview is in the umbrella:
> > 
> >     https://patch.msgid.link/20261104-work-procfs-v2-0-b45cd5789ac5@brauner
> 
> Oh, I think it'd be good if I get this into -next soon so it has long
> exposure there.

The bugfixes now sit in vfs.fixes and I plan to send them to you, @Linus
before -rc4.

All of the semantic and tree-wide rework is in vfs-7.5.procfs and should
show up in -next tomorrow.

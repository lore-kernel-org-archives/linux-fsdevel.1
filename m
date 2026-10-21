Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578818;
	b=1dijGPHNhrSkx3d5plfOil15cgqunFDGaEoGYovfPj9JB/SZwfe4s1hzkCnRvvAfzEV8
	 QCry9QtXh1BqAU5Wowq53lTGxHWhSVTQclnuZDMFvBjEZpqqEOWTlEOTDdwNDj38ntsd0
	 IlDVcEpe7F3EQ+5Hcx+kRw8wlvh9nJ2XjKLtGdwAKeLLjC/BDqSO4c1sY6tzw7En5UTFl
	 u9tAlL7pVyl7jtHydv/fsacOFeK/bwv6QIHX5Hra8n6S//3HpOoZgzQDQZrPBz4jqbtSm
	 LFkOs1cYx9Fv/sMr4k9TDEOQIsZrGlM9TuBOc5XAxdk8vz4wklQXrVG3Sx//8LkQeWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578818;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6J7jTB8ZusMmWeQuWCfjeyOnHD6ObRnFwkW0J1SCAi8=;
	b=yIzhJv0gqS6p0H/qRAhga8UFOf9O9gWKT9msXUysTeNHuKEvzouKrOysabdJdXdwFWtX
	 slIxdBy4OZaGZfJigyZQLGQgB39gPKowekm03xsJ7BBvoab1JOYRBThWbxH4M2NXByPT8
	 8xPiCOZHeCvVpfk1e+XuHg0abHLshbkgq2JoyDyI4FYikmbC8HqHxGu0ujKBzj277uWIW
	 LQwueJhNgMFSqBToyb3YaSF9sCEb+Eu9Jwh2Oa/BvBXGVZvDqfGDj8NLv381kjqdq8lLR
	 lJWjPkwvJNdUMIFbowpshWRKMNYqImDEK8bIC4AjQHfm31eTOI85MwtwuzGPkLJBbgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ciPejxsz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000E606A31B;
	Wed, 21 Oct 2026 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ciPejxsz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD611F000C9;
	Wed, 21 Oct 2026 10:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792578818;
	bh=6J7jTB8ZusMmWeQuWCfjeyOnHD6ObRnFwkW0J1SCAi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ciPejxsz5EF4s9y23vjZkA6rVkDLCMERhRw51oVcBwlr2hmCfzZo3IMddNvg4XbdG
	 Rm+w+mXBO5NItrFpB8urrXckFJn0NDlfAmF8axoGJYpLSSKg18Rf0FImoJ6ZVaB27T
	 9KpjOwopKUINxwmT/fcgXBfqQ5cnF6/6X7KxoMlHzpFiE6JDQejRsTXfTcqL1mbqm+
	 Dch8gXlbCmeUv9BEiylbyMh8aBIbcbFwUK0aLJxIR+ROzKUb1yA0wlrsueUq4gwFsI
	 DxfNH3IklYQgpKBESglxjJJpRb3kGM5qFT5uKrlkZwItdXheJS0Nn+n4o3q6X7MO6N
	 XzuiCWMHSuCyA==
Date: Wed, 21 Oct 2026 12:33:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached
 connector
Message-ID: <20261021-kammer-leselust-leitgedanke-b4fd57f7d30a@brauner>
References: <67hq7zqnvp6onwwjp24axucgxbzsko2dphielupdfzmfyk6x57@bdeef7fjkqfa>
 <CAOQ4uxiQF4M_YSBMW3h8VCKR15GV6g_K5nf=2odtYetEwKHm9A@mail.gmail.com>
 <6n6r5zvcu5ojihyb52rhejlky7xrn2a2p4l2cgfut5lsscunek@bcnpy7bifjrs>
 <CAOQ4uxjbEY12XMmfCXTPTpASmECCXcGBQR+bS93k=4vgqzFDZA@mail.gmail.com>
 <20260902070359.4163607-1-4ncienth@gmail.com>
 <CAOQ4uxjwGdKhX423KoFxW+T5hc9uzCWSsGwn0-QX=CJipPSaYQ@mail.gmail.com>
 <20260902215046.1149198-1-4ncienth@gmail.com>
 <CAOQ4uxhuOSyMHnj9JZk6LU9=wpE=BRFXJ3fSEOGGV+6tC_5hfg@mail.gmail.com>
 <CAOQ4uxgiub97wtDpWx6n+p4EBuusSp4xKm+b1Xa_GBAHH8=i=g@mail.gmail.com>
 <CAOQ4uxg7Qt436SiKhKEJKOjtCjeB_XyTjazYF7HMyQAGGcgx2A@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg7Qt436SiKhKEJKOjtCjeB_XyTjazYF7HMyQAGGcgx2A@mail.gmail.com>

On Mon, Oct 12, 2026 at 03:26:59PM +0200, Amir Goldstein wrote:
> On Mon, Oct 12, 2026 at 1:48 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Sep 3, 2026 at 3:07 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Wed, Sep 2, 2026 at 11:51 PM Daehyeon Ko <4ncienth@gmail.com> wrote:
> > > >
> > > > Hi Amir,
> > > >
> > > > I was able to make the handle-reopen sequence reliable on ext4 and drafted
> > > > an LTP test for it.
> > > >
> > > > The test keeps 120 auxiliary inode marks on the victim to widen the interval
> > > > after the first FAN_DELETE_SELF, pins the unlink and handle-reopen workers to
> > > > different CPUs, and has the reopen worker read the event queue nonblocking
> > > > before calling open_by_handle_at().
> > > >
> > > > I ran the exact final test for 100 iterations in each of two fresh 2-vCPU
> > > > KASAN boots per kernel:
> > > >
> > > >   - unmodified v7.2: 200/200 iterations reopened the unlinked inode, and
> > > >     closing the reopened fd generated a second FAN_DELETE_SELF;
> > > >   - v7.2 with your patch: 200/200 iterations returned ESTALE from
> > > >     open_by_handle_at(), with no duplicate FAN_DELETE_SELF.
> > > >
> > > > The test is based on LTP master commit
> > > > 12724413534a6d4160ff9694ba6f09daa4ccb6bd. The attached patch adds
> > > > fanotify26 and the corresponding build and runtest entries.
> > >
> > > Very nice!
> > >
> > > I think we should wait for Christian to pick up the fix or suggest an
> > > alternative, but after that please post this test to LTP.
> > >
> > > Thanks for following up on this!
> >
> > Christian,
> >
> > Please apply this attached patch in-place of 669bb5af15d41 ("fs: make
> > sure to call fsnotify_inoderemove() only once when inode is dead") on
> > your vfs-7.4.misc branch.
> >
> > The difference from v1 [1] is removal of the obtain_alias parts, which are
> > wrong for network filesystems.
> >
> > The LTP test provided by Daehyeon now fails because it uses open_by_handle_at()
> > for the reproducer, but a similar race could be created with hardlinks
> > release/unlink race and this case should be fixed by this v2, meaning that
> > FS_DELETE_SELF is reported when all hardlinks are unlinked and all
> > open files to all hardlinks are closed.
> 
> Sorry I forgot to update the comment.
> Attached v3 with the comment change.

Done and in vfs.fixes.
Thanks!
Christian

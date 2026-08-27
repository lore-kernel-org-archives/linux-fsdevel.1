Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB23B4E9A;
	Thu, 27 Aug 2026 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817813; cv=none; b=Qdan/4m63nmZPOZ0pN+6KTzmRmToStef78kh7+UKQA2OtnY8/Bv3bEiT92hkyzCHIirIoMttjzEk6bM6nnW84d2tYcCCcPycUCzm3qZIAh36vi8iPR/mAdBjor75NS5knhuUzI1iqbOFsMTgiAAkwDwdB2vCP/oNDxb71eA48CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817813; c=relaxed/simple;
	bh=D0y1p8jHsbJIFJJmNWL1F7UmcdesScg6DH59aTlcXwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJcCB2EOrtEgEllQsZJydfvx2X29pu11mab/JmyDquu9VcTNa3hXQX4nUDN2nYACvTKSD4Be2mk1KS5v6Xg9xLWclw60HxS1GQxpUz/OkDSCtAdnSbq01z5C3ioA49I5H5+RDU6O2keN9B/kV2ajSjR6avQv9kLLJ0lT1/YU9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y59X1WvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y59X1WvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E00A1F000E9;
	Thu, 27 Aug 2026 08:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787817809;
	bh=qXL2oS6rqznvftTLrf8LZgLPX4TTr2sqHZu9rHP27d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y59X1WvDiWVncqZBMXRihTdnQutjHIyDcTlQlCc4zknTmgdM6vTOl25vP36YLvKL6
	 YUBjX5anvmKQ7eJpIDQ14FxKSytIFMGy2w9mhR8fTUlkS+FtY0m7xKMA8HZW3CnJpV
	 hoOHxOBxY2OBO5H1q7Ze17kvx7eHIwORLcqvkrQ6X3YBStdrAKOKK+1yDiD2O3DdsR
	 S+f1RwI85rYYh7iyIerlzLMIn5UlEHAkHsCplAdn5GPKT1TndiL+0UMB2sw9Odk1xh
	 08/tBci7eh73lRSVGlra5NkC8LbfBjzShg9qo+DNPBuQN2aTKbwNgnHt/MMSUZqWrF
	 XDGwJ0FqV7FFQ==
Date: Thu, 27 Aug 2026 10:03:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Christophe Leroy <chleroy@kernel.org>, Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 0/2] powerpc: remove spufs coredump support
Message-ID: <20260827-teilen-flaggen-extensiv-61ce38f22855@brauner>
References: <20260826-work-spufs-coredump-v1-0-579e72a7ab66@kernel.org>
 <8ddf7d95-05b1-4758-9b5b-9360db77f904@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ddf7d95-05b1-4758-9b5b-9360db77f904@app.fastmail.com>

On Wed, Aug 26, 2026 at 08:47:42PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 26, 2026, at 18:06, Christian Brauner wrote:
> > Note that the IBM Cell blades that shipped the Cell processor were
> > removed in commit 05bf59fbeef3 ("powerpc/cell: Remove support for IBM
> > Cell Blades"). The PlayStation 3 is the only platform left and nothing
> > there produces or reads these notes.
> 
> I don't see how you concluded the PS3 does not produce these
> notes: as far as I can tell, spufs on PS3 should still be able to do
> this if a process using an SPU crashes, and old gdb binaries should
> still be able to read them.
> 
> Whether anyone is still developing SPU programs on new kernels and
> would benefit from the information in the dump I don't know.

Sure, _old_ debuggers can do that. But new debuggers can't and have
dropped any support for this 6 years as I pointed out in the cut off
part. Similarly, gcc killed the SPU target 6 years ago in 10.1. So no
modern toolchain can build this. And the last supported kernel I found
is v6.12.

I deliberately left spufs itself in but I would really like to get rid
of the coredump special-sauce we need to have for this.

> > So remove it.
> >
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> 
> With clarifications in the changelog:

Ok, I'll point out that old tools can still do this.

> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

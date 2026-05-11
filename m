Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43B3A4508;
	Mon, 11 May 2026 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507475; cv=none; b=OTx2SBNCRO0G8xYJZZaAAV4gNc4xA84CvTc4jWM1kNbFOd8V5ZYmgzxzk8aohMGx6AlVeRpecimUbgOoOyBk/8Hh8eGWWSl4M4gf6pB38UvLljbW6y8FbXOkwsOcUyWt+at/OYJljPrNfvNHbB/SjH/O9xWqOSq+G830Afp4H0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507475; c=relaxed/simple;
	bh=oQvTmeGEc99r8erfM15bC0WUhgOmacUXjVtiE3IA898=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0b/3AIMsJC6GdhJ6Uv493EyeQVagXW3XiZQRJQo6M8jyDEXFu5iriCxoesbutkBv3XEO5fGV9eqiHptTXhcOG8wkoy7iA107CvQp0zEW+PV23csHl+S55sn6WBw5iyWCu9nayr39LMG/JOE87EAtNAjEvImP1afXHmO7CtjHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9IkDCot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9IkDCot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45902C2BCB0;
	Mon, 11 May 2026 13:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507474;
	bh=oQvTmeGEc99r8erfM15bC0WUhgOmacUXjVtiE3IA898=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9IkDCotg6WWhykj7LZiwk6kawsNmowRdw8GQsSasp9kxb6mE29gfCIOpj13P4psp
	 AXKsxJ8oPv917nMkmHvI1jSpeROEBWJUVk3ZzvVp0gINqx86NbVyMlQQtdCeUQGPn6
	 29HMz/DKbOfD4F1f7CPP9RUfA9Afm/KGSJOeYshNR7aYHn2EK3WLFcGsDd00AwAIqK
	 qwPUDOXXJsw6P/clU8G3N3zknUoe2lT+hoSLagHDySfIww88HdNb6DN0u8pcGE7vJU
	 /pf2M8wzmVCuiqbLPIe7kd9mSqDc38xi/hBos/LiW+JtYSk3bPp67HCU4fUQU/1ivY
	 WtkcS/ukw2kog==
Date: Mon, 11 May 2026 15:51:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-erofs@lists.ozlabs.org, 
	Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	oliver.yang@linux.alibaba.com, Carlos Llamas <cmllamas@google.com>, 
	Sandeep Dhavale <dhavale@google.com>, linux-fsdevel@vger.kernel.org, 
	Tatsuyuki Ishi <ishitatsuyuki@google.com>
Subject: Re: [PATCH] erofs: use the opener's credential when verifing
 metadata accesses
Message-ID: <20260511-ozonbelastung-verzweifeln-a03cd0309ad9@brauner>
References: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com>
 <af2c4X1YCB7NEb8p@infradead.org>
 <CABqzrSOaCMPD_QrSq_y_6bXLC3ecm3FZsE_ACrdNbTHG8baMCw@mail.gmail.com>
 <188c33e2-331f-4362-8475-b8cea7a8fe7d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <188c33e2-331f-4362-8475-b8cea7a8fe7d@linux.alibaba.com>

On Fri, May 08, 2026 at 04:39:15PM +0800, Gao Xiang wrote:
> Hi Christiph,
> 
> On 2026/5/8 16:24, Tatsuyuki Ishi wrote:
> > On Fri, May 8, 2026 at 5:20 PM Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > On Tue, May 05, 2026 at 11:56:15PM +0800, Gao Xiang wrote:
> > > > Similar to commit 905eeb2b7c33 ("erofs: impersonate the opener's
> > > > credentials when accessing backing file"), rw_verify_area() needs
> > > > the same too.
> > > 
> > > Two things here:
> 
> Let me use Tatsuyuki's reply to address your two comments.
> 
> > > 
> > >   - rw_verify_area is a helper for use inside the VFS and file system
> > >     read/write method implementation.  Erofs as a user of the VFS should
> > >     not use it at all.
> 
> Currently EROFS file-backed mount metadata is directly using underlay
> fs page cache, which is mainly used for composefs, etc. to avoid
> different EROFS instances have their own EROFS page cache for the
> same underlay backing file and avoid unnecessary copies into them.
> --- That is also what composefs once did in their codebase.
> 
> Since EROFS just read the underlayfs page cache and does _not_
> touch anything inside the underlay page cache itself, so I guess
> it's fine?
> 
> On the other hand, we talked a bit commit f2fed441c69b ("loop:
> stop using vfs_iter_{read,write} for buffered I/O") in another
> private thread related to fanotify, which lacks proper
> rw_verify_area() as well, since it called into raw read/write
> iter methods instead of using the previous vfs_iter_{read,write}.
> 
> > >   - using the opener credentials when accessing the backing file seems
> > >     wrong.  The entity accessing it is the file system, so it should
> > >     have system or mounter credentials, not that of someone causing
> > >     metadata / fs data access.  And this applies to all access by
> > >     a file system backed by a backing file.
> > > 
> > 
> > I think there's probably some confusion of terminology here. buf->file is
> > opened with the mounter's credentials, so we are impersonating the mounter
> > here. Perhaps the commit message could describe that more clearly. Same for
> > the previous patches mentioned.
> 
> Here "opener" means the mounter as Tatsuyuki mentioned, I just
> follows Tatsuyuki's term, but it just means mounter credentials
> indeed.

We're slowly reinventing overlayfs I see. ;) I think it's probably fine
but it's also rather sketchy to mess around with permissions like that.
Mainly because I don't think we have any actual page cache permission
model. It's inherently shared beetween everyone and this kinda tries to
bolt permissions on top to not make it so. Probably fine here but also a
bit wonky.

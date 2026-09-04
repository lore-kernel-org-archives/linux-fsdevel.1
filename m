Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F03B2D1D
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510165; cv=none; b=P1GGeXVrakQsHM0RZxaOj941u3oO4/OlMaTCr0x80DQ6kTLkj4d14f7zy8VBMruztGTbgV1s6Mex5HeYg39vLMfE1EYsdbrhyg8jq33tU9BZHe6N4wmJc2ApnF900cNH5vrabrsbKujDAxFEystNr6ZqpvJibwbS9qxU69hZ3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510165; c=relaxed/simple;
	bh=eyoqfcZNOrhfsTAiad491Er8/wtQztPNNmAMKY7yJs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b681EtO//5+kisq2S8/83dSbs+H9QhTMKCw5gl8yVNSEzB5NoBRYcj1p+V2QzrZLddbdt6BauPN+dvKPck45VjMiz40vLzNpAaeYywZLoOuRCPOgXt+rYygGyU6S2/Glrd87wsrQ8CjGomEWgJz8ffLzgaN8wznvXsFgB3sJJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmcNO+DP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmcNO+DP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D083F1F00A3D;
	Fri,  4 Sep 2026 08:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788510164;
	bh=cU0tXjNCAqFuJYdHOWWa37/FkZoOfXmqoSZFmoZBpEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FmcNO+DPDmmy8fIb1irTfYsT4QXVp8fHHBtqJlwcGjYscH2f/iZqR+NZUnUEGInVl
	 /BHMPDlkGQzgy8pbQEWuhldjK2ANyn6CrSze70tJoeKR9MzShFoiw87D8O/e2Z5fet
	 pLvyXqkeJq8JNWqVKeUZKGyMZ2e4ofZYeXGR6dI99ZgIuyA5playPHKV6yX5MWghIj
	 RAm0iBfq0DITSHrP/gPIVOz9crAn68oFRFoIF7udu5/MBBD/0Lz3I6ECAJOXQMP+cj
	 P2jiZITTBsJ/pxgwHa+sBZnmKSYP7ZrspXxLV2vRG4N6earNZNt5CQLV4yLLmSCHbZ
	 blVE27H22kDQw==
Date: Fri, 4 Sep 2026 10:22:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC v2 02/16] fs: add fput_close_list() and fput_list()
Message-ID: <20260904-nimmt-sparflamme-westwind-3c4c8232eddc@brauner>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
 <20260902-work-coredump-unlock-self-v2-2-1bece368cbb1@kernel.org>
 <CAGudoHGQ=eTQjzY1cV6ZUa+CmTrTF0=au6r+_98CqEGnY+ZfxA@mail.gmail.com>
 <CAGudoHFEjeLK_neejhQTKTS=YxN8ew5p=8jWW-WYK8XC5tw_ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFEjeLK_neejhQTKTS=YxN8ew5p=8jWW-WYK8XC5tw_ZQ@mail.gmail.com>

On Wed, Sep 02, 2026 at 07:58:46PM +0200, Mateusz Guzik wrote:
> On Wed, Sep 2, 2026 at 7:41 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Wed, Sep 2, 2026 at 5:58 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > Add helpers for paths that close many files in one go. They collect the
> > > last references during the walk and drain them right after
> > >
> > > fput_list() runs the final __fput() for everything on the list.
> > > delayed_fput() shares that loop.
> >
> > nit: I think fput_list is a highly misleading name here, suggesting it
> > grabs a list of files to unref.
> >
> > I don't have a proposal for a name I'm happy with and I'm not going to
> > argue about this, but to throw some ideas: filp_close_list,
> > fput_finish_list or similar
> 
> The more I'm looking at this, the more I'm convinced I'm whatever name
> it should follow the convention of ending with _sync.

Ok, might change.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6022FF144;
	Wed, 22 Jul 2026 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723889; cv=none; b=uIghThWicYEmRsIawA9RmaFmV7tGb8jpb52HnIsOIYmnXwF2w0oXlBtLosHwLFCknVk+X7n/wAlze5kOL+qNX/jZlYRCykQdJWI61h4uGhl8Zvf5/JEv7mJ+XIANylvpBqS+a4mMlD+7XCx5m4Inw39bQe67WWeLX9sl7c4cOLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723889; c=relaxed/simple;
	bh=ZvLlYsoMdMFZaqIS1I423rwWee8uS4YkCkdFSnj5whk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLdfkv4Di09pFe6QbPvYayLiwjFJR6veipXLtCddLVOyC4wiMJzj+nWeZvWhuDhD2Mkjs6mGQDYRSxGjByTdx0SIu5kL1HAfDa4W1tnXwCLRan9+Wog/7HMJ8tuIAeY0Y8YeIeJ28rinqtiA3WZ/TyHiR7SZeDVrxc0xiqh6lUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zmy6ZDQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zmy6ZDQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478CA1F000E9;
	Wed, 22 Jul 2026 12:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784723886;
	bh=iBj9zW2gPJekmQDZp/gsMdlmXiGZjbKWwdD8GbmT/jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zmy6ZDQaUNljEgDrw7+tFeP8sTCaoA88FR41Ijgn+DGEZyRVzmIHS4CHhPUFIx7ey
	 mJKjtO29dBI5J9qxHHS6ZDBdMqaUGX+6F/cleSlys7NYIarVtDumAdge1Sh2vj5s5l
	 KKv8B/SGPzIXSCSehfZRGHPNPqZKUN8VHt4FrYrpuc7+XR6Mwcw0Vk0014ihJH845D
	 7rcKyh9WCJWYyBFv+imDw8gjAr84BECV3JH9Fhkvo9r0uBP5f8m4EhN8TkGE1NuNvS
	 olTK0ckJxs2aOtHHA0CeBScHUMaB6OTpOotuigkUSKFFUanXID2RDl8QaIxLj4RHsa
	 YpIcherlIjzCw==
Date: Wed, 22 Jul 2026 13:37:47 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Boris Burkov <boris@bur.io>, Jeff Layton <jlayton@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Justin Stitt <justinstitt@google.com>, Carlos Maiolino <cem@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Brian Foster <bfoster@redhat.com>, 
	Christoph Hellwig <hch@infradead.org>, David Disseldorp <ddiss@suse.de>, 
	Mark Brown <broonie@kernel.org>, Jani Nikula <jani.nikula@intel.com>, 
	Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <amC5iJPzGAUXKc3D@lucifer>
References: <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>
 <akzETpsps4TMfqpC@lucifer>
 <0ba6bf66-e48f-40df-a953-503d317b3dbe@kernel.org>
 <20260707124031.GC211515@killaraus.ideasonboard.com>
 <ebc1f034-7297-459e-975d-5c143567392f@kernel.org>
 <20260707141803.GA254690@killaraus.ideasonboard.com>
 <20260707-siebzehn-geleast-gastmahl-4889a8f6b474@brauner>
 <20260707-impfschutz-lerngruppen-klubhaus-7aabcc82f3b4@brauner>
 <878q7mr59k.fsf@trenco.lwn.net>
 <20260722-haarausfall-giftschlange-klotz-820f0391533e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-haarausfall-giftschlange-klotz-820f0391533e@brauner>

On Wed, Jul 22, 2026 at 02:08:51PM +0200, Christian Brauner wrote:
> On 2026-07-07 13:03 -0600, Jonathan Corbet wrote:
> > Christian Brauner <brauner@kernel.org> writes:
> >
> > >> Then someone can basically just merge the original patch I sent since
> > >> everyone seems to agree on that front. And then the extension to include
> > >> how the LLM was used can be discussed in a separate patch.
> > >
> > > https://patch.msgid.link/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org
> >
> > I still have it around :)  I can apply it if that's truly the
> > consensus... I'll confess to having not entirely kept up with the
> > conversation over the holiday weekend, though, and needing to review
> > things.
>
> I read the article. :) Feel free to massage the commit message to
> whatever seems right and resubmit.
>

It probably got lost at this point so also please add my R-b to it:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Cheers, Lorenzo

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F716381EA5;
	Thu,  2 Jul 2026 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006646; cv=none; b=c+bymVbsgCVQ3M1UK/ggIH1Pnyl3pB2Let/YYhiNwS4RQtdSFxu7cVYj/do8YxL8j8RfOHaohtM2ncIRZ6K5MFOO/8f/CsC9SN6o3KyDDUrN7f4LoF0tPbBeVDwiTTqgqmzYSJd2ytzo7bOE62Iawup9SsW0yiqn3MVchsx+AMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006646; c=relaxed/simple;
	bh=9K1i9dno+GYJB7OyjhS3iFmXTM82jlqJMgvQUM+PuWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdYlLcxzMKebIYFX+AABV60T865vPARE7iFjw4YCcLnj4Lv+Xpnh4x5vNxNMv8puYO+zhkbmA1Sjuaq6iydCMx5onJEytz8rK2RIaKikVxXfKujVSGJT7hHzSK2UStZy+Mb2CKyOJka+vGwqlUXlX11ij7CaVjh899XKsKTWcTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opt5lc0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opt5lc0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AA41F000E9;
	Thu,  2 Jul 2026 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006644;
	bh=+1gyA9vJtCAGBZ56ASIsSzijOAkPi2SePmW0+74/d98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=opt5lc0aAOrKZhxee6MwzqQ4+qAjaZSz4dpsGzKxDCsNrF7tGyombx2XgMgrlyYzO
	 hbg664Fya/Q2QSmmDWqz+QlU9Fn+ICkW6AekrwqWnY4E7sdo7Jk88hSs3UpAdPmhHc
	 FVRvEK8tFAJM/woUChbNcZPqI0nayXoudG7CnDHk/Hm2wtIlV/Rshqy3V4CneyIjhk
	 S1GLU/odOEfhFoiqaPSSFwZHUa4KwwNmYX0xcBMOMV/ftqyZtgZ49P0tZ4o8Wb3R7z
	 ouv9yLtfV+9sBrGfMg4SeOY3ucACe1zD+VTq3hkew4I4PuapNSBPpxw5hdPm8LqAR3
	 a2ARvmevBHuTg==
Date: Thu, 2 Jul 2026 16:37:13 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Brian Foster <bfoster@redhat.com>, 
	Christoph Hellwig <hch@infradead.org>, David Disseldorp <ddiss@suse.de>, 
	Mark Brown <broonie@kernel.org>, Jani Nikula <jani.nikula@intel.com>, 
	Jens Axboe <axboe@kernel.dk>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <akaFlAPtMumfPv3G@lucifer>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
 <128935557.3798727.1783006392991@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <128935557.3798727.1783006392991@kpc.webmail.kpnmail.nl>

On Thu, Jul 02, 2026 at 05:33:12PM +0200, Jori Koolstra wrote:
>
> > Op 02-07-2026 17:07 CEST schreef Greg KH <gregkh@linuxfoundation.org>:
> >
> >
> > On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > > We've had this requirement in place in the Documentation for several
> > > months, but it's becoming clear that the signal to noise ratio from this
> > > is quite low.
> > >
> > > 1/ It's not universally followed. While many people do try to attribute
> > > the LLMs in good faith, not everyone does for various reasons.
> >
> > Then let's move to get people to follow it.
> >
> > > 2/ It basically serves as free advertising for proprietary LLM companies.
> >
> > Who cares, make up a name, all I want is the "signal" that someone is
> > using a LLM so that I can review it as-such.  And if I think someone is
> > not reporting that, I can ask for them to properly attribute it and if
> > they lie, well, that's on them.
> >
> > > 3/ It's not clear why we want to collect this info in the first place.
> >
> > We want to know if a LLM is being used.
> >
> > > Given that the data this provides is flawed at best and is being
> > > collected for a purpose that isn't clear, let's just kill the
> > > requirement for these tags from the kernel at large.
> >
> > No, please do not do this.  It's useful already for many patches in my
> > subsystems, and is only going to be used more in the future.
> >
> > thanks,
> >
> > greg k-h
>
> Why not:
>
> Keep the tag like David suggested as:
>
> Assisted-by: LLM # automated removal of useless blabla
>
> I am indifferent to whether this should be a tag or just below the --- .
>
> And add something like the systemd guidelines that Christian linked to to the
> AI Coding Assistants doc page. This provides much more useful guidelines than
> what is currently there. I triggered this whole discussion by reading the page
> and adding the model to some clean-up commits, so some people do read it...

Yup am fine with all that!

>
> Best,
> Jori.

Thanks, Lorenzo

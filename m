Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD4303CB0;
	Thu,  2 Jul 2026 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004814; cv=none; b=TSY+/hqSdqcfHNuOuGdhu2AVbsfss+8pb5vdj9V4fzCqQAkNnN+DyYlF9pyQWIxRTVEpSxobGdJnJnfzG13yVRnI6uzpNvcLGqjp1EsawPKA5Z5CDW+yNGCeg2QQjFcdoOszt0bXJhuAVeiS7iFX/Phbs7p76clyWx0I9JjfaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004814; c=relaxed/simple;
	bh=tlFaz4fot5vD/BI2+jmaNOOxliFNMQZ2DTZWs/Y6LPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFsTdMCXVTa8+RECYtMK1Mi5SOXSXSI658uK1dbKcOZujY+jMzkvCBgwZU9gcXY0oRr//vESz6GLHbJareThZK5Rp8UhniH6bxt6pZuFrC+5Dyfn+HOofc286gtTmywC0TTArRVI53nRcx/zomeNBX7WVxiIn/zMrZj1PfCyLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2mHB+r0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2mHB+r0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398241F000E9;
	Thu,  2 Jul 2026 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783004812;
	bh=+jtRyIDu4u5+oITJVqGs0wT5i8yN1eLaTcHSu79Rl9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D2mHB+r0dxK/mbLTyo/yHTy2pPs4AhDlkQ/ArUgXRIMtbzPp5qatagWkN4sxSX2hK
	 6UdosYyXp318TlIMFepkN01s1dnGuy/0irVXlWcAVhD9ag5I5/RHlhlct5FZ2u9Z+9
	 UQJububszEtEYQp8gUdCRX3/iiBlG9g8RU9OcN48=
Date: Thu, 2 Jul 2026 17:07:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <2026070224-unholy-commode-cf45@gregkh>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-aidoc-v1-1-735572dfb995@kernel.org>

On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> We've had this requirement in place in the Documentation for several
> months, but it's becoming clear that the signal to noise ratio from this
> is quite low.
> 
> 1/ It's not universally followed. While many people do try to attribute
> the LLMs in good faith, not everyone does for various reasons.

Then let's move to get people to follow it.

> 2/ It basically serves as free advertising for proprietary LLM companies.

Who cares, make up a name, all I want is the "signal" that someone is
using a LLM so that I can review it as-such.  And if I think someone is
not reporting that, I can ask for them to properly attribute it and if
they lie, well, that's on them.

> 3/ It's not clear why we want to collect this info in the first place.

We want to know if a LLM is being used.

> Given that the data this provides is flawed at best and is being
> collected for a purpose that isn't clear, let's just kill the
> requirement for these tags from the kernel at large.

No, please do not do this.  It's useful already for many patches in my
subsystems, and is only going to be used more in the future.

thanks,

greg k-h

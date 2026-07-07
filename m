Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945223ABD8F;
	Tue,  7 Jul 2026 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436403; cv=none; b=fhiVWCSXI64TY7CxTlLk/rZc3yHdIoySt0ZAEZIs+OA2ae++1Fbs+jylafm1uG9EItZjaXC+o0ynhZUObd8UT0IM2FX32VYeXaWJvvPu1mmJzTJPyqdCYzyuGN5KtswG87aOOO6+KE4l0Llh6FGYN+fdufNmxTWA6ijXslSYF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436403; c=relaxed/simple;
	bh=QixuW2nfNUHDy9ywdn8QnL2EzwTHHI285KbirfePa8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mp4B/b8R11+7sqR6Ln/3iNtMeU65SMw3emR2BSGFx5BookFCFrNpnynGwjTt/bWfmd1J33F44g+XdDah24almB+ub/q94sN06wi+ynnzW6N+fLTFlUHzwllc56JK7FnIP8MxRhi4XUdHX8d8iOZnd/UY2xv0jl4g28WWrNq3MT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRuDiBWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRuDiBWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6803D1F000E9;
	Tue,  7 Jul 2026 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783436402;
	bh=QixuW2nfNUHDy9ywdn8QnL2EzwTHHI285KbirfePa8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NRuDiBWk68jnc2Ndp5YVN95UacVO0u+evFftQyW5reBRxwqJzGJtT7A3FQAqKajdo
	 x6LHMfQ+alexmlNIKWi53LVLyXY5q9OEmB31UsXvQUvtr7/bOpX3wcNC68cu6dVQz1
	 rS5xBXMPRsMqCRQstxf1lTnBIRnhC91o3rHunA8pjj+P84NTFRBVsWUT9FQPxEr+WF
	 YaEQK29aKDnNI46BsaRN1RgVHbcRU9aKiSmM374p6MOB+5e4ziM8BLG83olPlW2FOq
	 kxayyV6NXim0eJOkEryYvnGuhtqAgmW0LYJM2Jj84I4sMjUZYbxELBidDhaLbHTKGM
	 Oqi6RhxjM+QPg==
Date: Tue, 7 Jul 2026 15:59:48 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Boris Burkov <boris@bur.io>, Jeff Layton <jlayton@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, 
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Vlastimil Babka <vbabka@kernel.org>, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <ak0UK51HkMKHyte2@lucifer>
References: <20260702211740.GA639365@zen.localdomain>
 <3f447113-4407-471f-878f-e6d6edafee71@kernel.org>
 <akez23ZhLRSGMFQ1@lucifer>
 <20260703163251.GB3734786@killaraus.ideasonboard.com>
 <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>
 <akzETpsps4TMfqpC@lucifer>
 <0ba6bf66-e48f-40df-a953-503d317b3dbe@kernel.org>
 <20260707124031.GC211515@killaraus.ideasonboard.com>
 <ebc1f034-7297-459e-975d-5c143567392f@kernel.org>
 <20260707141803.GA254690@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707141803.GA254690@killaraus.ideasonboard.com>

On Tue, Jul 07, 2026 at 05:18:03PM +0300, Laurent Pinchart wrote:
> I haven't heard anyone involved in this mail thread objecting to the
> concepts you translated into sentences below, so I think it's worth a
> try. Of course there may be objections from people who are not aware of
> this very conversation.

To risk repeating myself - why does it all have to be in one?

Send the non-controversial bit, get that merged so it's there, then follow it up
with this. Simple no? :)

Sending this, getting it rejected, then having people's backs up because they'll
tie the two things together seems the less politically astute move.

Thanks, Lorenzo

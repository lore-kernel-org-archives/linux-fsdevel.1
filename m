Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AADD3451B0;
	Fri,  3 Jul 2026 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058742; cv=none; b=MDuAc59/L20SwmdEVCT9NskKYCoPe7Nnaary/pu+TuC0eUT+KgScQab5NYAnNtbfn6U8v+yQvx4cR2N3zwNiuRUGi7SSHBM3yStjgvKBkfhRNVBb6OaNP/a/P+DXt56sArJh9Xmw4vMVT3TF0lf2eVLJeK5mq/Uu5BMRh2R1T4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058742; c=relaxed/simple;
	bh=EUQA4Fz3a4i+pOb23MbOZ9f7vV1yvw5548DaVDRgyEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPuEgGXsFVxZZ0XOaq95AqUriFGDJ0dzZSstJoljJzryxvMmHBEpthG0p3uOQKFqEsH4oDV54iIt1/+4eUXuoyKOURCyVJhL1MFqTS5EI0fBuy7XD8HppPnpKOCbZ17rGOQH0INm7pjb7qiK6Bo/q8/neKMDxXwUk9dMPdRhA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E8D1F000E9;
	Fri,  3 Jul 2026 06:05:40 +0000 (UTC)
Date: Fri, 3 Jul 2026 08:05:51 +0200
From: Greg KH <greg@kroah.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Justin Stitt <justinstitt@google.com>,
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
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] docs: link AI coding assistants and tool-generated
 content pages
Message-ID: <2026070343-heat-cleft-0abf@gregkh>
References: <20260702164901.121128-1-ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702164901.121128-1-ljs@kernel.org>

On Thu, Jul 02, 2026 at 05:49:01PM +0100, Lorenzo Stoakes wrote:
> Both of these guidelines are complimentary to one another - one specifying
> guidelines on AI coding assistants, and the other specifying those for
> tool-generated content.
> 
> Since they are complimentary to one another, provide a link to each in the
> other.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
>  Documentation/process/coding-assistants.rst | 4 ++++
>  Documentation/process/generated-content.rst | 7 +++++++
>  2 files changed, 11 insertions(+)
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

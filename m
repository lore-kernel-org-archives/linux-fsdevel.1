Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEE63783C7;
	Tue,  7 Jul 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437021; cv=none; b=XoMA9xmhBi9t+DnTLPi/xKSJbsKJ6Ze8gVMl2Y14+NF0PurK8YG2QqqE2yVHVat7BzucVR/f2me4vF0aj6GZ4bAVBp7J4tVwo5HBSrTxzqo4nXfufalJThUFf8SFdj5ulocr6cEceQCz/oPHHJVO2wHY9L6toKhwLKjFdgNA4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437021; c=relaxed/simple;
	bh=a5T9qpkUzRc3UNfYbx2QShdibt3Pd9YHNy+BR99Um4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1TgsF3CZ5OxXGEoVSguPE+DzpF/318X7oEsu7cgfEfiZeQtWjWKMu5d01Q9HFitkos2lDb7GRgQtvE+8JR313kN72gawqhO0oygYMikv4qYY4hg6ym4ToEJnPVBHUx5p4J5AKjLLEtTZHEUXarI6JCe4fGE3krL4LUKhNF3IGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTlaB7un; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTlaB7un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29281F000E9;
	Tue,  7 Jul 2026 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783437020;
	bh=a5T9qpkUzRc3UNfYbx2QShdibt3Pd9YHNy+BR99Um4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RTlaB7unlIc7lCSZGDt/1AsbEvD4EMJGllcAmt1hsAHcByPdEJUFwz1EelX9gbVWt
	 V+MvvoXRucD6hs0djixaMg0ankEl9rmn/7vPADTchv2IClhXnwiQWZqqAyEsNQCBwt
	 z2m5Q91gKFHInzD01KyUIeYtqh+osNQOH21HC+XA97h3i3whr/D+NYHOhmuRj31Ka1
	 QA2u5a0+aH1HgpXy6ua4e5ACtJevYNyXccJeCwU+hIhbvNRUnVw/S/Nk7+bA4Ggza3
	 8w/DZ5ow+Es8+W7RYghNJm82T+1u1nYRDhg9JaH0Q/LtC4ZJp/cQjVDBzV1HG/ghCs
	 QTV0K+oBMg1KA==
Date: Tue, 7 Jul 2026 16:10:07 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
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
Message-ID: <ak0UjMSqm_6vCDIu@lucifer>
References: <akaWnQ5Pkg_676B-@lucifer>
 <20260702211740.GA639365@zen.localdomain>
 <3f447113-4407-471f-878f-e6d6edafee71@kernel.org>
 <akez23ZhLRSGMFQ1@lucifer>
 <20260703163251.GB3734786@killaraus.ideasonboard.com>
 <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>
 <akzETpsps4TMfqpC@lucifer>
 <0ba6bf66-e48f-40df-a953-503d317b3dbe@kernel.org>
 <akzMh-ySQ2fN0d8R@lucifer>
 <5ccbb28a-171e-40c1-9a6b-9ac7b6b7777d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ccbb28a-171e-40c1-9a6b-9ac7b6b7777d@kernel.org>

On Tue, Jul 07, 2026 at 03:29:44PM +0200, David Hildenbrand (Arm) wrote:
> On 7/7/26 11:55, Lorenzo Stoakes wrote:
> > LGTM! Do you want to send that then? People can comment on the actual path then
> > (probably worth cc'ing everybody here on that also).
>
> Let's first gather some more thoughts on the rough direction before spinning of
> yet another discussion. :)

I'm suggesting sending a simple, uncontroversial, change to get movement rather
than continue this never-ending talking shop :)

Anyway I'll leave it up to you!

Thanks, Lorenzo

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC5737EFF3;
	Wed, 22 Jul 2026 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722143; cv=none; b=trmPsPMFQ3ZwUjvwL69wlA8uTGj1Nd785eRmHqKrjpWAfyD0lblQpiCZ2svDtmz/LJK1tXclqp02OSfYfrnClqJEwzifaee37MFy/2OvItgQaEStX/NUzFHh4+Yj3NvJ8iDBlzPWxFhP8fkAScg6wE6M1kyt5KuVqmB3FhM+9K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722143; c=relaxed/simple;
	bh=ItwoYYVU/UGT4GyesbFZUS8RFEtT3CxoUXI5G1iezgQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=u4m2vBUE5/gLLfq+gi/MHttooQPl6BS4IJhyFQx0ucLMzyw2osAGg7OLRKJu/D80Naq5HszdEf5WQ9pv9cNZXU93rkRXiTCulxQvT10GFHH4BwMTjuhAcwO1slzpoFq0AXYYXqlRICIqi7NFUxwaQqpxNj4MYdiQCqrFsTKw2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQXsRH66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQXsRH66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83261F000E9;
	Wed, 22 Jul 2026 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784722139;
	bh=iOuVeIpKdAgtfM+FVY3Pn1qMntI6WAAEuCUsLohS4UI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=eQXsRH66cnYAAazQVv1G2MYH6uXLYwVAZF03VfWt9z5zHJ842fcFLkQCTWPX+SA3J
	 wlJEhKbrnrTEXeyK4U9VHrX9vvSICVopOk2AQJ2mOXNZdgr5tn0WzA0ICuPaR4Jjpn
	 bKs/a+aLOcq2j/xM162wWTsdTwwvooByfiHKAxneJ1ujMF54CA9FdxTa8ovqsp+v6u
	 M/+zpDFRAwV4DvN/umqz6sOWswbUUUKIrl+zEt9Dg8eC/2ILFfVXW6hrB2NB8owUIm
	 ojPTitRN0reowOcR0yeF4EggjvN5Md+nj1Tvg5nC7+D4nbue1+uJybslaoTox+yYtH
	 MP9uRPooPQeYw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Documentation: remove the requirement for LLM
 attribution
From: Christian Brauner <brauner@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Christian Brauner <brauner@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Boris Burkov <boris@bur.io>, 
 Jeff Layton <jlayton@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Justin Stitt <justinstitt@google.com>, Carlos Maiolino <cem@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Brian Foster <bfoster@redhat.com>, 
 Christoph Hellwig <hch@infradead.org>, David Disseldorp <ddiss@suse.de>, 
 Mark Brown <broonie@kernel.org>, Jani Nikula <jani.nikula@intel.com>, 
 Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@kernel.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <878q7mr59k.fsf@trenco.lwn.net>
References: <akaWnQ5Pkg_676B-@lucifer>
 <20260702211740.GA639365@zen.localdomain>
 <3f447113-4407-471f-878f-e6d6edafee71@kernel.org>
 <akez23ZhLRSGMFQ1@lucifer>
 <20260703163251.GB3734786@killaraus.ideasonboard.com>
 <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>
 <akzETpsps4TMfqpC@lucifer>
 <0ba6bf66-e48f-40df-a953-503d317b3dbe@kernel.org>
 <20260707124031.GC211515@killaraus.ideasonboard.com>
 <ebc1f034-7297-459e-975d-5c143567392f@kernel.org>
 <20260707141803.GA254690@killaraus.ideasonboard.com>
 <20260707-siebzehn-geleast-gastmahl-4889a8f6b474@brauner>
 <20260707-impfschutz-lerngruppen-klubhaus-7aabcc82f3b4@brauner>
 <878q7mr59k.fsf@trenco.lwn.net>
Date: Wed, 22 Jul 2026 14:08:51 +0200
Message-Id: <20260722-haarausfall-giftschlange-klotz-820f0391533e@brauner>
X-Mailer: b4 0.16-dev-9dec3
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ItwoYYVU/UGT4GyesbFZUS8RFEtT3CxoUXI5G1iezgQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlbLp6aEu4t+HCurOzDef4KToYd21ldFYLMFFrKWuTi
 9sesfNARykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET2NjAyLHjG0WbUs5+3ZnNa
 F3vU81fC7cIvPr1zv3RLoHb7UnH2OIZ/6rOS99Q8fJlX7vtmi+fFtMvThHoXM7K/e+p1v3mr9Ip
 bbAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-07 13:03 -0600, Jonathan Corbet wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> >> Then someone can basically just merge the original patch I sent since
> >> everyone seems to agree on that front. And then the extension to include
> >> how the LLM was used can be discussed in a separate patch.
> >
> > https://patch.msgid.link/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org
> 
> I still have it around :)  I can apply it if that's truly the
> consensus... I'll confess to having not entirely kept up with the
> conversation over the holiday weekend, though, and needing to review
> things.

I read the article. :) Feel free to massage the commit message to
whatever seems right and resubmit.


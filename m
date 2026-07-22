Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA905464D
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724982; cv=none; b=lCD2YIze0e/hwaW/8rmxTK7FGcf0sBJBuTcVfZqMStcVCLoxXJC4x1ZpxdkTMD/egJcD72WdhgOeUjEifpZnfQXNR374Jk8v2Riz5z5zWIRS1SDvqCZYIpwxK/cfJHd7oX6Qo9W9x/6S+RdCHYW+oM/wIrZSPBFWn9NTSsSJ9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724982; c=relaxed/simple;
	bh=uTCEgjS8fbhwdzZaXQoIGtuiEXimJmcH8jEmmCuCEYg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=N4SQtgosqRKI4HgN6B96QEHOoDVrwDvl/r9bj7e+BOCst6MYBEVupIyUPJy8ufpLTuSj+89K9Qapzp6H1hKoKmoNtwpd/7u7ybD5DFkkgeKx8UfPz7Wvn9Ad0Zb4KMITvsU/PfLJ9vrGM//UnGkENU83EFKO/im1vcN9bkxm2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Koq3uHpw; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Koq3uHpw"
X-KPN-MessageId: b5c7f1ff-85cc-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b5c7f1ff-85cc-11f1-9e8e-005056999439;
	Wed, 22 Jul 2026 14:56:09 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id b5c79391-85cc-11f1-b312-0050569977a2;
	Wed, 22 Jul 2026 14:56:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=//3NCZ/De7H7S5CgRXWxFdth/1TDK4QRJdBGqoWmpek=;
	b=Koq3uHpwUrso615qPHNJDSwdQximiU8mcPt9LxqbMW4tqRgO0ZfWMU9BjBju8eW/cv+gaQqzVtZWS
	 vEPftO1BfXftI0xG6pLeWx4S53D0wJNB+C9b6Hj+Qag3nyO/v570UCiiefjgeKdZSOdmma0GoAqh4k
	 oJ8zPM4jsu2154RXx4VFxmXKXax51S/aCYegaVTMXo4bYrnn5BqJ74HVG+Vjf4IfBRrKgawPluLETM
	 q8yagDjIDB6jjCG/muBkXHRFZjXma2zChejYcKZvtcrxOPEpfFN+7XiQ/MzEEmPZxLOILc412etXW0
	 bdghsdqG/Ou7jRS9lbrNlQusii/BbEA==
X-KPN-MID: 33|TfHYfRDMERQmjU1pJj7/DyOb6FiHhdLv+Uof2zI2IZ2QiYj/Wxlpf+aF+8MGKsh
 /ne5ucWtYCyBj8i45xTI+lceFAH7eAt79dKSeUprW2po=
X-CMASSUN: 33|M5S3SLQWn79u0v8TdPHqrn5h/EUm3705GFnoQKG5sBGhhGijNDPxJAsX7LRcHFF
 6iI70oLz5zDCaG2rWDIJl0A==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id b5b3af26-85cc-11f1-916a-005056995d6c;
	Wed, 22 Jul 2026 14:56:09 +0200 (CEST)
Date: Wed, 22 Jul 2026 14:56:09 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Boris Burkov <boris@bur.io>, Jeff Layton <jlayton@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Justin Stitt <justinstitt@google.com>,
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Message-ID: <992794329.165694.1784724969343@kpc.webmail.kpnmail.nl>
In-Reply-To: <amC5iJPzGAUXKc3D@lucifer>
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
 <amC5iJPzGAUXKc3D@lucifer>
Subject: Re: [PATCH] Documentation: remove the requirement for LLM
 attribution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 22-07-2026 14:37 CEST schreef Lorenzo Stoakes (ARM) <ljs@kernel.org>:
> 
>  
> On Wed, Jul 22, 2026 at 02:08:51PM +0200, Christian Brauner wrote:
> > On 2026-07-07 13:03 -0600, Jonathan Corbet wrote:
> > > Christian Brauner <brauner@kernel.org> writes:
> > >
> > > >> Then someone can basically just merge the original patch I sent since
> > > >> everyone seems to agree on that front. And then the extension to include
> > > >> how the LLM was used can be discussed in a separate patch.
> > > >
> > > > https://patch.msgid.link/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org
> > >
> > > I still have it around :)  I can apply it if that's truly the
> > > consensus... I'll confess to having not entirely kept up with the
> > > conversation over the holiday weekend, though, and needing to review
> > > things.
> >
> > I read the article. :) Feel free to massage the commit message to
> > whatever seems right and resubmit.
> >
> 
> It probably got lost at this point so also please add my R-b to it:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> Cheers, Lorenzo

I think there is broad support for this, but might it be better to await a
more comprehensive change after the maintainer summit?

Anyhow,

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

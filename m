Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31C343216
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241715; cv=none; b=eKWVdDIUZsxPYyXUJCZ+foSAsBHtO53dYW3CFPc/L+JocU3s4dds2IjwKNSOFoiiRhThQod6Iybt9aa/6ZvRxOf6pelYVwwvDpQbI/ttLnTSBYSWE0v+89yiw+VQS0RCKjHvtNX0BRFpxERPY9oKwtBbLW0RBZUoWqadkTqANA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241715; c=relaxed/simple;
	bh=cFJDvhg+CqIpOrzN83+Mx11W2Ltk+rpt0VQ1++Sropo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjRvjf+Tk/+6gt8z5svaF1a/JFCG7aKECKOLodeEMM39UvYSBuu/DHU4gxHol8/Zr2w3Fzd5NAHP/w4xqdc+rxvKkQbNlWZUJjwZqHruZOM0eyHapM8NDfvgbZMLUXY81ZnFutzsoTc4nYRTqNuY1FAQ/Sm5jJNaXmPbMopku3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (204-141-067-156.ip-addr.inexio.net [156.67.141.204])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 060C6E02CF;
	Fri,  8 May 2026 13:54:40 +0200 (CEST)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 8 May 2026 13:54:39 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: Re: Re: [PATCH] fuse: disable default bdi strictlimiting
Message-ID: <af3NyD5QDK6pmbR_@fedora.fritz.box>
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
 <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
 <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>

On Fri, May 08, 2026 at 11:42:10AM +0200, Miklos Szeredi wrote:
> On Mon, 27 Oct 2025 at 23:39, Joanne Koong <joannelkoong@gmail.com> wrote:
> > Miklos, could you share your thoughts on this? Are you in favor of
> > disabling default strictlimiting? Or do you prefer to have it kept
> > enabled by default, with some mount option or sysctl added for
> > privileged servers to be able to disable strictlimiting + enable large
> > folios if they use the writeback cache?
> 
> So what I think we should do is implement some sort of slow writer
> test, and see what happens with and without strictlimit.
> 
> Tried to ask claude to do this for me, but not getting very far.
> 
> So if I take this maintainership role seriously and not let myself
> drown in the details, then the logical thing to do is to delegate ;)
> Which is hard (for me at least) but I'll give it a try...
> 
> Could you please check how things change if there's limited writeback
> rate and we disable strictlimit?  And what happens if there are
> several such instances running in parallel?

We have run all kinds of workloads and tests (xfstest, too) with 
writeback enabled and strictlimiting off.

I have not noticed any problems, but we have not done any systematic
tests regarding this. We were always testing something else.
(usually performance impacts)

Thanks,
Horst

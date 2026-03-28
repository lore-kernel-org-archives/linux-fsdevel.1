Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9AC18787A
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774735919; cv=none; b=qrfVmus8Q5LerD/PrMWgpu707uiUccGgyuAFLw6awZfTDKOH1Mdds+BhWFSKL35v8kCKaERc3qZlznaqz5kozLR34atWD+E/FhbwyJkR4kTuKHsAUG7UgNPku9DV6VMWcrTb2k8A76nXnoX0oZuGS/OIcpKECQZz2Md7roEjwh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774735919; c=relaxed/simple;
	bh=0MdlG2mz45bRM9Xj6kyx8qg0fPfcxBFvB/6XjAE1ggg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0nl2yYdDSaectt5Iz9fflV7yTBTYOu5LSyQwmoIU81OG8LrQxjCV/gE9rDqED2smY+8oK4IQK/M0FUj2YR944y4VpW15MTmBWPYlX3BB8d/qcaC7spEtCD/WIQotvH5da6bHuPXy/7RVO46xidOi4dGnuw9RDuwQNbiRKIRawI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=Koxr6Zfg; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="Koxr6Zfg"
Date: Sat, 28 Mar 2026 22:11:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1774735914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0MdlG2mz45bRM9Xj6kyx8qg0fPfcxBFvB/6XjAE1ggg=;
	b=Koxr6Zfg/l1KoNsJLmKKSwJYIj/WFY7TyyVgjynSwZ7gS+oEdDNkpHGaw5iRUiRU/2QGlq
	MGl56UbNkAy4VV4OihiZBGEgXYzel7iy2u0Ob302EfM2at1nX1UmenK+wzWfPRiTE5L+z/
	QBS2uUG7xnpjt1HLU8YQVuMk1/qMNcnIdPks9m1IWfjMbnbrhm+bqsTo7qV4wYs2zs7sd6
	uzgDwg5UoUXypEHeJ0kGpuYnc/7ey2A4zsWKeAtPazqv0r968pP55KX3iSaUmcIk2lXOId
	tJmiCODg45iaegE7fwUzwAX+e+aoVSgixb+YhoVJTC8g7e/M+ptOSiRCZuWaEA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Kara <jack@suse.cz>, Leo Stone <leocstone@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] hfs: update sanity check of the root record
Message-ID: <achSKrW0yLAKsAD5@Bertha>
References: <21e7ebfd-d35d-4682-b553-6996cc8c3a8e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e7ebfd-d35d-4682-b553-6996cc8c3a8e@I-love.SAKURA.ne.jp>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 28, 2026 at 04:12:07PM +0900, Tetsuo Handa wrote:
> George Anthony Vernon is trying to fix this bug without my patch
> ( https://lkml.kernel.org/r/20260311211309.27856-1-contact@gvernon.com ).
> But it was proven that George's patch cannot fix this bug. Therefore,
> I believe that we came to a conclusion that applying my patch is
> the way to go. We can apply George's patch as a further improvement.
> But unfortunately Viacheslav Dubeyko (the maintainer of HFS) is not
> responding. Therefore, I'm sending this patch to more developers who
> might accept this patch, instead of waiting for Viacheslav.
Thanks for the CC. Slava (Viacheslav) got in contact with me directly on
Tuesday 24th to say he missed some emails and acknowledged not being
completely correct about the thread record logic which we were talking
about. He indicated he would take a look at the next patch version when
he received it.

I will follow this thread with interest. In the meantime I will follow
up my patch with a new version, thanks for your review of it.

Your patch validates the superblock lookup, however my patch which you
linked validates reserved CNIDs retrieved from a bad cat record on disk,
which is also a reachable logical path which hits the BUG() on
writeback. I can consistently reproduce that BUG() with your patch
applied.

Both patches are therefore necessary.

Hope this helps,

George

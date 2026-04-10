Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26293389E05;
	Fri, 10 Apr 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823867; cv=none; b=MnarLLaZjHXSKXGw83+DbWLYzZztGQ+cq5axnscVuwOdIuWTYaBbS6MfSbAJn8/lOqWhepMpLQq1ZDf+iLMR0PYZxFBHI5jDIhbxvsLaSlDOCYJYBO3/jFxdgX75h8/d5vRHkxSqeTjPuoH875EvFUmvq2uWiZa3A1SNNJCtG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823867; c=relaxed/simple;
	bh=u3shdn/VhTUrysknc+IWeX13Mypw2Gqe8IMtP46BvmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny8iJfAT51rPi3O9vaxiINMIHaz5B0C+MyIA0m09Ne/shddMvvY4LUgrOxFvjcQl/InaowTursDho4d2gF8XAGeCZKQMctmva+QWEHx4L4bOvBejGnTGL+C7Ck8j4Osg3r8bR6EGgGgvTLdapiO2ynVoNTdUF7L6f42l/natEkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKHcdKXE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKHcdKXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2810BC19421;
	Fri, 10 Apr 2026 12:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823866;
	bh=u3shdn/VhTUrysknc+IWeX13Mypw2Gqe8IMtP46BvmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKHcdKXE2kz4m0NEBd5EKtByrIIew2xRPM9M6TUF00occZ4EyMKOt2YUdYVsHnCo0
	 fNSRX0fb0Hbd2twIm/dyttA2LN+TqLTdZ909pvkhZS8h7pGn7Yhva68ZtJqsZLZ/If
	 tdguzE3v/3GvKP5hHIRnkjjVac850Gdb2uNM2zbSio5tgjmijdEdz+01rtEvdJNKjY
	 QY9VKGe7uu/nk/E51BxqhEmmdYN1W/PvkHS3utdN+SbGU+hY3BJSyQa4VKOyVStKX+
	 7rhSZO2S67XO/uptDkC1XS9crG8eNVR7QT+21pAsNytGil3CdbYboU0ETriEW7gqau
	 PEplVxGXwpW0Q==
Date: Fri, 10 Apr 2026 13:24:16 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc, jack@suse.cz, 
	ajd@linux.ibm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com, dev.jain@arm.com, 
	kees@kernel.org, kevin.brodsky@arm.com, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mhocko@suse.com, npache@redhat.com, 
	pasha.tatashin@soleen.com, rmclure@linux.ibm.com, rppt@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Al Viro <viro@zeniv.linux.org.uk>, ziy@nvidia.com, 
	hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev, leitao@debian.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/4] mm: improve large folio readahead and alignment
 for exec memory
Message-ID: <adjrKwgiZwXR9epk@lucifer>
References: <20260402181326.3107102-1-usama.arif@linux.dev>
 <803a0c15-0a6a-4c00-b6b3-eaae56d5fc15@linux.dev>
 <adjkCOiLgZ_-zovg@lucifer>
 <adjllNan2vgBNBHJ@lucifer>
 <5f99b289-629c-47c4-bef0-966d6678a2a8@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f99b289-629c-47c4-bef0-966d6678a2a8@linux.dev>

On Fri, Apr 10, 2026 at 01:19:08PM +0100, Usama Arif wrote:
>
>
> On 10/04/2026 12:57, Lorenzo Stoakes wrote:
> > On Fri, Apr 10, 2026 at 12:55:42PM +0100, Lorenzo Stoakes wrote:
> >> On Fri, Apr 10, 2026 at 12:03:03PM +0100, Usama Arif wrote:
> >>>
> >>>
> >>> On 02/04/2026 19:08, Usama Arif wrote:
> >>>> v2 -> v3: https://lore.kernel.org/all/20260320140315.979307-1-usama.arif@linux.dev/
> >>>> - Take into account READ_ONLY_THP_FOR_FS for elf alignment by aligning
> >>>>   to HPAGE_PMD_SIZE limited to 2M (Rui)
> >>>> - Reviewed-by tags for patch 1 from Kiryl and Jan
> >>>> - Remove preferred_exec_order() (Jan)
> >>>> - Change ra->order to HPAGE_PMD_ORDER if vma_pages(vma) >= HPAGE_PMD_NR
> >>>>   otherwise use exec_folio_order() with gfp &= ~__GFP_RECLAIM for
> >>>>   do_sync_mmap_readahead().
> >>>> - Change exec_folio_order() to return 2M (cont-pte size) for 64K base
> >>>>   page size for arm64.
> >>>> - remove bprm->file NULL check (Matthew)
> >>>> - Change filp to file (Matthew)
> >>>> - Improve checking of p_vaddr and p_vaddr (Rui and Matthew)
> >>>>
> >>>
> >>> Hello!
> >>>
> >>> Just wanted to check if there was any feedback/review on the latest
> >>> revision?
> >>
> >> It's -rc7, this is definitely something for next cycle :)
> >>
> >> On my part, my upstream bandwidth has drastically reduced, and review is
> >> probably going to have to be a hobbyist thing at least for now.
> >>
> >> Also, not to be mean but:
> >>
> >> $ git log -E -i --grep "(Reviewed|Acked)-by: Usama Arif" --oneline | wc -l
> >> 21
> >>
> >> So... :)
> >>
> >> Review in mm is very lop-sided, let's try to balance it out a bit!
> >>
> >>>
> >>> Thanks!
> >>>
> >>
> >> Thanks, Lorenzo
> >
> > (Note that we're in a 'quiet period' from here until -rc1 of next cycle and
> > won't be taking anything new until then. We plan to do this from around rc5 or
> > rc6 of each cycle in future).
>
> Thanks! Just wanted to check, as I am always confused about this. Is it ok
> to send patches for review for next release at this time? So that they
> are in a good state when rc1 comes. I wanted to send PMD swap entries
> for review after I am finished testing, but I want them for review for
> next release.

I think different people have different views on that :)

I mean it's debateable whether having a glut of new material on day one of -rc1
is preferable to having a bunch come in that might or might not get lost along
the way :)

I personally feel it'd be better to send during the cycle window rather than
before but I suspect others disagree with that!

So from your point of view, feel free to do what you like, but maybe David +
others would want to chime in with their opinions?

Thanks, Lorenzo

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D43A7189;
	Thu, 16 Jul 2026 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214803; cv=none; b=KTFGL+/aFRw0FYwzK07HrbKGjop/8hWpaJmXfGTKs/v55Qp7KyAJfisY7DK1sU+kkS9uhfhAuS5C5v62gah7vaV3b62Y08/SqDYzIX9rZb7vt8EGYRsuQ8xLwI1jjZbkkpNnNKzb6ZGHB/4sFygtv14hM0IRL22YPtI1WaXOY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214803; c=relaxed/simple;
	bh=mZcIKy0sKnwiVTiIn1xnQqul/iC9zSIy0vEYFOh5eLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsvYItVyl/Vm6rSUYV2kVq0NNIx7VCdOnRrPnOc4aBEDzhBo2wNc/2ZOUqS2g4qLFS89xA9ptrbOnMw16MLYl0gQciaDbNzTshZWBView8qeCLcLtJinK3ZsJWeseALpo3RxvR/x2uCk5zIslTP/b0III+qqfabG9MpZfL8sJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsI1yLU7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsI1yLU7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082A81F000E9;
	Thu, 16 Jul 2026 15:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784214799;
	bh=mZcIKy0sKnwiVTiIn1xnQqul/iC9zSIy0vEYFOh5eLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KsI1yLU77HcEbaUDL1hSrDTf3zwMw/qpIqrIgSG/O9oRVSo8fW4BNS4MCTWT7fXas
	 J8kZj/b638mvvaWJyB/d7e5QR071mfNahmSxOgjSpAr5/BzAnSvHZxczE++LMgDY74
	 TBGjqLDh6CK2v0FTHngXee55oEV7bNAL/xar5n5aoRdqnl7OIvaOYbz5BZGocLcpXP
	 zkoDEmRL5ACkAj9tkUS4AhG/dP1DZlr5RtrDtf3WP/ko3hh1wWugvKyoCHv94sDrNr
	 bRbAOWkOsnKjR2VDpBWelHdNVxsv6Kw1gzLzkE6grf3+lUq9dAjIUSoxyb/ngAGHpm
	 bf91edPL2OBkQ==
Date: Thu, 16 Jul 2026 16:13:05 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/mseal: remove further superfluous comments,
 do_mseal()
Message-ID: <alj02XcxXC6kQGnK@lucifer>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
 <20260716-mseal-fixups-v1-3-3a9609bf041b@kernel.org>
 <aljzdCwWzyvTDgmv@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aljzdCwWzyvTDgmv@pedro-suse.lan>

On Thu, Jul 16, 2026 at 04:09:14PM +0100, Pedro Falcato wrote:
> On Thu, Jul 16, 2026 at 02:43:11PM +0100, Lorenzo Stoakes (ARM) wrote:
> > There's no need to abstract do_mseal() any longer so put the system call
> > implementation in the system call declaration.
>
> This looks great!
>
> >
> > The comment around do_mseal() is strangely formatted, overly long and adds
> > a lot of superfluous information that the code already provides, so boil it
> > down to the essentials.
>
> But I would much rather we delete the whole comment (like Leon's patch did,
> per my request). Do you disagree?

I would like us to retain the information I added yes. Removing that is not
really helpful I don't think.

>
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Anyway,
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks!

>
> --
> Pedro

Cheers, Lorenzo

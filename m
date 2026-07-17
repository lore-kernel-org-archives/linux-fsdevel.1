Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A394346E44;
	Fri, 17 Jul 2026 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285482; cv=none; b=txfIDN54pqv3Vw2nSSpMG5OUiXkgX3euhf7GELqj4pnRL3nhueaBPaRm+aP40gtuZQyE+i54QllO6557j2RbTj06WrxefgA7aR8jeE4X4ifuc1zR3VZTKdy+P8EEqFrVuKO7mA710kuRorbtxRpvv7YUlSC8ScSXHmq7lR+O+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285482; c=relaxed/simple;
	bh=58YYxJ1AsKeT1NMwQx91wX4hfn62nLgtCKNlVjHfm94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3jpfFYLnJfevZakMWzOZLBEQLUjlnwG3OadUBq0Bk0EE04iaf6Sm+TLPwHwEZ8WIXAKDqgiwBZYbkK5oysVyZjKml+QRLnL/VqEwLDJmn+OzMkbSC25grbXRVFDc+AZfBPDJrSQedBGtkDy+PLucoc+X4RrIbVgL5uTxJxRmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOqbGHrg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOqbGHrg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26761F000E9;
	Fri, 17 Jul 2026 10:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784285481;
	bh=71Rz2odtnovtyZHYOoOEtfRFkaOu7S/0JgGyHI8HJw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VOqbGHrguzzlQCgD6qcxghkRrh5RspPw/Uf4fqCdXiSL45WmVvQnJ+k1dw9BErRD0
	 t1Vb0vr56W8uAdmXQHoBs/KqSie8Zr7NYoqMPTGoh5i1u+SwkTMzcL+h4dfD2kh5aq
	 ugHGlks74+E9cMG1AqybpSP1JAlbU3A5EQ1lV+d8D9KxWsXszCTlJVTmf/gl9F0Jfu
	 rJVsUM5zs+5DpbHOlMYX5EdoZV+9aj4g3t2zrF4DLHKLzk4nWlRZVbekJmIQEJ9cNl
	 v+fUdsfGTscsJcNCW+uWk6zzKi43Vw3XVIvZ7PP3AZ3CZ3wURd5yanvEskdfqdZ0X9
	 PO0GIc9ATmFCw==
Date: Fri, 17 Jul 2026 11:51:05 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/mseal: limit scope of mseal address zero to
 address zero
Message-ID: <aloHtq1Q580vU467@lucifer>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
 <20260716-mseal-fixups-v1-2-3a9609bf041b@kernel.org>
 <aljyYdgzRZW1kIhs@pedro-suse.lan>
 <alj1Cyt4JvbVM7tB@lucifer>
 <58bca89b-e3a8-4207-8ee7-63ab04916443@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58bca89b-e3a8-4207-8ee7-63ab04916443@kernel.org>

On Fri, Jul 17, 2026 at 11:41:11AM +0100, David Hildenbrand (Arm) wrote:
> >>
> >>>  {
> >>>  	struct vm_area_struct *vma, *prev;
> >>>  	VMA_ITERATOR(vmi, current->mm, start);
> >>> @@ -66,6 +66,38 @@ static int mseal_apply(unsigned long start, unsigned long end)
> >>>  	return 0;
> >>>  }
> >>>
> >>> +static int mseal(unsigned long start, unsigned long end)
> >>
> >> I don't like that you go start - end on a function called "mseal". The actual
> >> system call goes start - len. It just looks confusing :) So either rename it
> >> to mseal_range(), or make it take a start, length pair.
> >
> > I'm not sure I really understand the confusion (I suppose you're equally
> > confused by the lack of flags parameter?),
> >
> > I find it silly that we avoid function names because a system call of the same
> > name exists.
> >
> > But I guess I can rename it to mseal_range() since I don't want the series
> > blocked on silly naming issues.
>
> I think we typically have a XXX call do_XXX, like with mprotect(). But not sure
> if there is a real rule to that, I'm sure there are exceptions. At least it's
> only an internal helper.

Yeah I think that's more the pattern.

>
> Just like with the "__*" functions, sometimes it indeed helps to just have a
> better description that shows the difference. But sometimes it's just really
> hard to name or restructure stuff.

Yup :)

>
> I think the page fault logic is especially hard to follow with things like
> do_fault() and __do_fault(), whereby we have another layer of do_read_fault()
> etc in-between :)

Yeah we are consistently inconsistent also on top of that :)

In general on reflection I realise I was being a bit stubborn here and Pedro is
right - mseal_range() is much better, reflects the [start, end) vs. [start,
start + len) thing better.

Will respin with that changed.

>
> --
> Cheers,
>
> David

Thanks, Lorenzo

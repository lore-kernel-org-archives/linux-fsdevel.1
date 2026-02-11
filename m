Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE91632;
	Wed, 11 Feb 2026 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770776009; cv=none; b=Z8JGNE1ZYhEyD4A0T0gv1YxOAKC7TQot1Hmxw5wDuhbnZEbhthWrX/lUk3ipkE3s7ZW244bYklADi+zXMBSe+zcUnCqTESl4IODozqqOjDPJM0ODU+2uJ0/2E1oDXgyB/0mEkYBy+vkwEWzVXywXtlU0fkWSy+6dofPMRROF+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770776009; c=relaxed/simple;
	bh=yXx4VCbLiHuPaGrCEAU8CteczPm6mdcA1lCmrgLNfPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEvtXqTXmAmINxjsMNtiC1pofxsp2lliW6TS3eZz3TADh8aOvgUSt8xQSZepL6hkEoNeIxRmGRGQJwLzcaMVuRReWIXoAbxOxfU7eZ7o/LttTx0mWSc5n+a5FyLHpWNIB09OouOO2huF89FK0ETO2kavR5nRaRV1cYcPZ2zHmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kM0AoIh3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kM0AoIh3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BCI/XuxdC+8VK/bC2TL5MDk4fq6gWrkySuFHqo8v/kI=; b=kM0AoIh3/MJfTCJ00RGYvMf618
	wpTh+kRGhs7uUENK8fpJClag/GSqq0SYcVXXUF4dT8+Hh8j8C2mppeEGoGPpaFA7YzGNdjr32Ncz1
	PkYQ4hvRVXUZ2Rlt1LgG5Q1Lr9Pkj9jQdr/FCNoL7mip3SKvGuFrvzaxkvGbE6vCaxnpi7RExwMi/
	OTEBw7yJ42mutpdxFxps8anMRwiqzS4dNkPDsILeBgBp8n9J3Cqv0NZsjCupoPqcDvmHRnvxb4IRE
	28B6fA8X9KTfFWIq/hhi8SuQyuXUlcAhrT05EZlfULOI8Zwlx+1GHSf50np2KPg7FuIrwmu0GYqh4
	LR5J+8LQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vpzlT-0000000HI4t-2U8k;
	Wed, 11 Feb 2026 02:15:39 +0000
Date: Wed, 11 Feb 2026 02:15:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kees Cook <kees@kernel.org>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: Keep long filenames in isolated slab buckets
Message-ID: <20260211021539.GK3183987@ZenIV>
References: <20260211004811.work.981-kees@kernel.org>
 <CAG48ez1GYR+6kZHDmy4CTZvEfdyUySCxhZaXRo1S=YyN=Fsp8Q@mail.gmail.com>
 <202602101736.80F1783@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202602101736.80F1783@keescook>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Feb 10, 2026 at 05:41:43PM -0800, Kees Cook wrote:

> > I think this path, where we always do maximally-sized allocations, is
> > the normal case where we're handling paths coming from userspace...
> 
> Actually, is there any reason we can't use strnlen_user() in
> do_getname(), and then just use strndup_user() in the long case?

Yes.  Not having to deal with the "oh, lookie - it became empty this
time around" case.


> > >         if (len <= EMBEDDED_NAME_MAX) {
> > >                 p = (char *)result->iname;
> > > -               memcpy(p, filename, len);
> > >         } else {
> > > -               p = kmemdup(filename, len, GFP_KERNEL);
> > > +               p = kmem_buckets_alloc(names_buckets, len, GFP_KERNEL);
> > 
> > ... while this is kind of the exceptional case, where paths are coming
> > from kernelspace.

mount -t ext2 fucking_long_pathname_resolving_to_dev_sda1 /mnt

Watch the show.  "Fucking long" here being "longer than 150 bytes or so".

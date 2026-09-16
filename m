Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DF43F08F;
	Wed, 16 Sep 2026 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561286; cv=none; b=pS/82EUkQolnr8PFvNs8j0qpGIz5G/f67i5nQjfffJNrzixFLqFG+xI0EGO7z+pLGeDwbaIUNKCFWpxDiAxyNpl/NNli4XKv+vf4CZ1VkAgIZQfK1i7cKfqOkDyRAWy9kq/Pe5D7UDeUwxIJAPOVjZBWWWP+f+ZR1LGqMbF49AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561286; c=relaxed/simple;
	bh=/jteFgX1YOvdk5JZCTp3G+lpKYjefdP8eKq1t2FGD2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD5bAwCLWehQF4rMRpi7sqtbRQiAOCARqfOS+wMrYzAyRqoAhfwXsdhnV7EJdgTEDU7K/oy3SSLKJc/lUf2M6LG7VsZJ8GJBNr6gdjhwSSJKWb5H0eAo8LlIm5R3GxCbt9TD9em71wsHc+QGeu1FOrZQK6Ai3j7zkeWEdpEiFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=h7Ic2OjV; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="h7Ic2OjV"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 12F3D14C2D6;
	Wed, 16 Sep 2026 14:21:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789561274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JhiKPY/PLmj1TpqDhYwo2ZZ9AYyR+pNOB9rK/mSR2gQ=;
	b=h7Ic2OjVFqZdGJEJbvmEtdElc9wmAGGPLXgiOi65D7NDBSOs8CHJNsvjmlzuXbChQ64MB1
	pfPCqvxqs7HgIxlfYu5UVGaP7IeytbpelvWvu+6t3Z+oCH7uTZ4/QxtvT04TjVrFAf3KJv
	Y3IUAw0hjaurGok9xDFbS+d32Two4cg3Z7erBQjgYh1nz3wBJzhFjA+JcfcU+maaAEwidW
	YVgM989GbVdCKaomXLW7NffrxPic0ae7H/9+l0JyuveV0sSvEQd4MWMr2uA6u6BGGgzc9B
	BasT87KFjvXtvbeq2TR8km1JI5j7Bg8CDPSaJexgXdiKOjDxNgcY7y7Zsi6UMg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f032830c;
	Wed, 16 Sep 2026 12:21:07 +0000 (UTC)
Date: Wed, 16 Sep 2026 21:20:52 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: hoobnn <853555@gmail.com>
Cc: ericvh@kernel.org, Jan Kara <jack@suse.cz>, lucho@ionkov.net,
	v9fs@lists.linux.dev, linux_oss@crudebyte.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, sripathik@in.ibm.com,
	aneesh.kumar@linux.vnet.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] 9p: dynamically allocate directory entry names
Message-ID: <aqqJpAh4E59nwe3k@codewreck.org>
References: <20260826064819.52523-1-853555@gmail.com>
 <aqa9WXmrgd_P7yxw@codewreck.org>
 <vz5bum547fqyxf5z4m3x7tuqkuq52jlopm65t7hvynqeulh7i3@2t4wnhfxs7qv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vz5bum547fqyxf5z4m3x7tuqkuq52jlopm65t7hvynqeulh7i3@2t4wnhfxs7qv>

Jan Kara wrote on Wed, Sep 16, 2026 at 11:47:00AM +0200:
> On Mon 14-09-26 00:12:25, Dominique Martinet wrote:
> > +fsdevel@ & vfs maintainers to Cc TL;DR:
> > Should the 9p .iterate_shared() dir_emit files with path
> > components > NAME_LEN, as allowed in fs/readdir.c verify_dirent_name()
> > only enforcing length < PATH_MAX, or should we skip any such entry given
> > nothing can interact with them later anyway?
> 
> So my take on this is that I'd refuse any entries larger than NAME_MAX
> (255). As you say it is very likely something in userspace or other parts
> of the kernel (fs drivers, ...) will break with such names so I don't think
> there's a good reason to provoke these bugs. For example POSIX states
> readdir(2) should be returning component of at most NAME_MAX length and
> although we don't take POSIX very seriously in the kernel in this case I
> don't think there's a good enough reason to deviate from it.

Thanks for taking the time to confirm this! Let's go with that direction
then.


@hoobnn: as said in my previous mail I can't take your patch unless you
give me a name, but the idea behind the patch is trivial so if I don't
hear back from you in say ~2 weeks I'll send a patch under my name that
reimplements what you did, plus check the strlen() result that's already
done in v9fs_dir_readdir_dotl() so entries > NAME_MAX are skipped over.

If you reply then there's no hurry on my end and you can take your time,
please send a v2 of this as two patches, one skipping the extra copy
into p9_dirent as done here and one for the limit

-- 
Dominique

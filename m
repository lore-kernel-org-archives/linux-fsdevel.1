Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD48634C;
	Mon,  6 Apr 2026 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509990; cv=none; b=lmwv9cjoV4Phs0b/84aPVIXhwrMuwZA6HuCQi2G4gGYDvN1dxiFBRhsa6kwJ3xPFQz6Vb5SNzdi8tyR/5qFO8nL6iCY3kyetgyH8WnwPtiaq/2892XvkjX7nCDfGB2K8yFnDarlSvluSXOKnE+J/mAerYky3ebf/Jxfcxb/5cb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509990; c=relaxed/simple;
	bh=X1FO5pOpgnUoemx6cv3wZvfqgFvusodm3KolcqI+58Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZ4Be9bGmb7oO/luPNSxeBUpDmM3t8pHvdNd4E4Oy25jMVW7NVepp3ghs5poX64+mmeNCyl0fQ/Ktt8kiDaPlB2TvHhQo7XfeGooWvHMa/BRLlSY/j+AER8xRgO7wxRgz+AQlL4/RqJiv2unLF6Elt1Rl5e3Zd10ylskyT62Nn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Jg2IKZ8e; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Jg2IKZ8e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X1FO5pOpgnUoemx6cv3wZvfqgFvusodm3KolcqI+58Q=; b=Jg2IKZ8eb9F5wsP9Bwt1CPKwD8
	GIDDsXgDYvps/VAq08TGSD0cT6OguX4lltzINjj3b3rbJ3zCpsZ2jDuf0QajILb07p0kjTzM4EDn7
	dZhQxEUA2qCZ3CXVIv6OVqbHci2I+fsQUsgnzkq5iJFqcbgqS3gV/ZbZr/nFhx77OgZ1gafktY5Xp
	RzJ/d+8zPyxZTSRwVRhOpAZxO9xw/Zv8eiVLaIUkDvJ6D5OyLI+WgmLQP5hqSRIO8u0zeEb9tTQpM
	/VbvWU2ZRvTNXy6Pt1KEv4Pxqq3+JzCxPCwn7vM0OzknrVqVmOv+ubi4s2R37frwzTu/gk1c95CAs
	NTwRHRzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9rJS-0000000EzEw-335G;
	Mon, 06 Apr 2026 21:16:50 +0000
Date: Mon, 6 Apr 2026 22:16:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: hide file and bfile caches behind runtime const
 machinery
Message-ID: <20260406211650.GD3836593@ZenIV>
References: <20260328173728.3388070-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328173728.3388070-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Mar 28, 2026 at 06:37:28PM +0100, Mateusz Guzik wrote:

> -static struct kmem_cache *filp_cachep __ro_after_init;
> -static struct kmem_cache *bfilp_cachep __ro_after_init;
> +static struct kmem_cache *__filp_cache __ro_after_init;
> +#define filp_cache runtime_const_ptr(__filp_cache)
> +static struct kmem_cache *__bfilp_cache __ro_after_init;
> +#define bfilp_cache runtime_const_ptr(__bfilp_cache)

IMO the entire runtime_const_ptr thing for caches is wrong;
statically allocated kmem_cache series got stalled, but I'm
bringing it back next cycle and this stuff is going to get
reverted as part of that.

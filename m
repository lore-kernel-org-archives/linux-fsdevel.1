Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878340DFA7
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777815218; cv=none; b=fER5nlre/0K+fjfwDMG2nSe3qYkiKxM2PNDqBit3rVIi/iu12bzQMBta3edJxwfOpb0o8XmoHYlEvRpcWLtHfLl44RYeMd37FrJVHe2QdoWVKAw+YxdlxtHoM0W2PtIWjxhKIdc5U5KYIleoCo653nIGTsAkE19AFWYg+zuaitY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777815218; c=relaxed/simple;
	bh=TxhLtcXKW7oWBM5FehAMJa5fsXmWedZp+wLE2/6AMb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeyB5ZJFNgJeEVN/GWF/rn1UqjGxuPvN0GPo30yTEcLjIkgb72YjYVBXMCCPiRvwuyN/3qpUG8s/Zk2/ArHdnNx6XVlFB3jJ/8+/PamvhUWAwe8WYEtglBVp4aMHFsZaoWQVug2cgVweq0D0wZ07iNhFibXHPI8UqH6h6ub0JwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R05L0RSb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R05L0RSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CF8C2BCFC
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777815218;
	bh=TxhLtcXKW7oWBM5FehAMJa5fsXmWedZp+wLE2/6AMb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R05L0RSb4QTxp1YUn8/sseBvMagwbHZEhfd3W9gzz5HIPX2eD+pkwaSKPutoYEThH
	 cO418jJ3BllKGT1rv7Q247KB1TL30lCgv3haXXHUnM49jL1I+PAHI+gAVIq338r3Sd
	 k4WhxSGQYNI/KDvlJdf68PE7F1d7XUBtxJ+TUHiIC/j85kdRyY5F328BsnzQheNlef
	 /JlRMHsMeeY5r6pyDbJUVA4kpAwVvzDNQlxFpvrffjSt/sxmttYPq33U8oki/cNf5V
	 LKfGo9lbt2WkgXgZwXsE95q6teqbOrIEelMCxmcRXZiOcbvbt5Iw6FZaKrqd1emrIg
	 IyYZxa8mU6Gaw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67c566cb519so807707a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 06:33:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8La5sGrAuMiSbC2srANeT7aXhIKu+uL6+L1dkWyIR3h0CwpAHksqAr9cKwwcVn4iNi+u9u7D5Rc3UdJ5It@vger.kernel.org
X-Gm-Message-State: AOJu0YyE5m3DMUImh/tIeagmgmf99wIuHDsgpajRggiU+jVDEDM6eJbY
	OtEgdS2zAftdxiw68VLX0HXGwBSgFKZSAwruzHnA64TpdluOmO6X+KtbjpydSZEe7UD09wc+PkW
	fj0ziEFs1ARpZvpBOExmnDQMM1Z7C1kY=
X-Received: by 2002:a05:6402:a0c6:b0:67c:1fd5:32c8 with SMTP id
 4fb4d7f45d1cf-67c1fd535c6mr1656452a12.19.1777815216788; Sun, 03 May 2026
 06:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213081804.13351-1-linkinjeon@kernel.org> <20260213081804.13351-11-linkinjeon@kernel.org>
 <afdESUirlu57HBOT@casper.infradead.org>
In-Reply-To: <afdESUirlu57HBOT@casper.infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 3 May 2026 22:33:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Gw8ph6PHEiGYfAAK3MPKKTwgO5VE-c1N6EyKWcx8iiQ@mail.gmail.com>
X-Gm-Features: AVHnY4I38IXT5fNQd2gfAi4mygzaTYwq_C_ym0OrcPvxHRBBvHcBtyAqkL7KujA
Message-ID: <CAKYAXd8Gw8ph6PHEiGYfAAK3MPKKTwgO5VE-c1N6EyKWcx8iiQ@mail.gmail.com>
Subject: Re: [PATCH v9 10/17] ntfs: update attrib operations
To: Matthew Wilcox <willy@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu, 
	jack@suse.cz, djwong@kernel.org, dsterba@suse.com, pali@kernel.org, 
	amir73il@gmail.com, xiang@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 9:49=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Fri, Feb 13, 2026 at 05:17:57PM +0900, Namjae Jeon wrote:
> > @@ -215,7 +232,7 @@ static int ntfs_decompress(struct page *dest_pages[=
], int completed_pages[],
> >                               handle_bounds_compressed_page(dp, i_size,
> >                                               initialized_size);
> >                               flush_dcache_page(dp);
> > -                             kunmap(dp);
> > +                             kunmap_local(page_address(dp));
>
> This doesn't work.  kmap() makes page_address() work, but kmap_local()
> doesn't.  kmap_local() returns a local mapping of the page, and you have
> to kunmap_local() _that_ address.  page_address() will continue to
> return NULL for highmem pages.
>
> I'll send a patch soon for ntfs_decompress(), but thought I'd flag this
> in case there are other places that need to be audited.
Okay, I'll wait for your patch and audit the rest of the code to
ensure there are no similar patterns.
Thanks!

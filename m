Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381DB3E6DE3;
	Tue,  2 Jun 2026 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407716; cv=none; b=gEZzYshWBLVDOFGVTq2k6MqBtNXS8cPATJ5vQUSMDChWUBhtA14YXSHFARd21N+DCfMoLFyrMHqf9oLvcc/uJPc7S5bpqH7NdehR8evke+2XhpsMDuI6IoG8OZc+IwGwKzrQvNHidyBsWkgQlAQ2HW4uIplkaaZha/RfM3ka2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407716; c=relaxed/simple;
	bh=z+ssSedXNDqwpoCd66mmuzgBkfuSj2vlr56Ju3Xl9g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rsp+Nxr02+FjPhTaZ5zijjU6AYRpguS4J0kGLvYLMGcSyLKDR4ex/IvK7+BslmEXp9UTxYmNmHGmFdSVvvGob/CsdWjQ6RP81IPFd9ZUdaxolERQDyj3nVSXqRPsdPvaJCBDgGToV53KEilujieDyT8cEysxXBJQLlbe6q8mHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMN6NOUo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMN6NOUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6FC1F00893;
	Tue,  2 Jun 2026 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780407713;
	bh=DaCSsnBQcLMloicGEjTBB3YgF6H5vHu541BNKfnyXkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eMN6NOUoJxtSw/QwiRbuS5Js/IF2QMz8AScAhujqMvMkoNZJtmOxu+wsUbKxHqvDQ
	 xPY/uKsS8ayRIDNao/Fk84YwEgGnUByAuKNADpLutSIOMrvfAnCleVKcvvMkacQFiM
	 3qwYNpz0W3jgSonb575hBIIAxGol15YGqmuUM0v1gEvvydVYMumvdKposTma0tehT+
	 WYADy6loWvVBRVBoPsYmf/E5BsI329ui/mR6q/qZMhW2IgVceSXatP6bixntVdrTxy
	 Atwlu+lR0iPdEJBQhOVynPT9gKx/0FejQfokPOXaQrYKL5egM5du/b/owx5NQZLEZv
	 nvhiO7wM9dHTQ==
Date: Tue, 2 Jun 2026 15:41:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Al Viro <viro@zeniv.linux.org.uk>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Charles Mirabile <cmirabil@redhat.com>
Subject: Re: [RFC PATCH v6 4/9] vfs: lookup_open(): move setting
 FMODE_CREATED up when calling create()
Message-ID: <20260602-aufdrehen-umorganisieren-formlos-4f0e12bbcbda@brauner>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
 <20260531182045.171711-5-jkoolstra@xs4all.nl>
 <178028128000.2923901.7917758563328454041@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178028128000.2923901.7917758563328454041@noble.neil.brown.name>

On Mon, Jun 01, 2026 at 12:34:40PM +1000, NeilBrown wrote:
> On Mon, 01 Jun 2026, Jori Koolstra wrote:
> > In preparation for using vfs_create_no_perm() in lookup_open() we need
> > to move setting FMODE_CREATED on the file mode to either before or after
> > that call, as currently it is in the middle. If try_break_deleg() fails
> > it is currently not set, but vfs_create_no_perm() includes a
> > try_break_deleg().
> > 
> > Going up the call chain of lookup_open() we see that it is only used in
> > open_last_lookups() if no error is returned from lookup_open(), so we
> > can safely move it to after the filesystem create() call. This also
> > makes more sense when reading the code as you don't have to wonder what
> > the implications are of setting FMODE_CREATED before the create() call.
> 
> It seemed a bit odd to me that we set FMODE_CREATED before actually
> creating.

Plus, we kinda-sorta-maybe do expose that as uapi - even though it's
broken on networking filesystems... which I didn't know in that detail
back then. So be prepared to whack me over the head with:

820a185896b77814557302b981b092a9e7b36814


> It doesn't matter as FMODE_CREATED is only meaningful if no error has
> been reported, and if create doesn't end up happening, then there must
> be an error.
> 
> So I like this improvement.

Agreed.

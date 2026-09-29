Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B70547057;
	Tue, 29 Sep 2026 04:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790657349; cv=none; b=UnoPbrBaFvg5KjsW3vruQ7HvIdR8tZEulTsSsebCJ+zgQkzJlsbD8Wmx4tEq71bzpVA42ltGH1TjMkCL/FJ+MdBP2iiSV48eoD2dIuLyO9f4PDnort+csao3ekJy0klvc722JXNa0392ZdSf3TAIQtHkKPERTtuURbhe2lIrccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790657349; c=relaxed/simple;
	bh=J/UQimpf06iy9VfDQfTVGxVDQ06pWaArxYp+7nYCcB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca+a+9p8g7tv3PyZFNAurFaCXrw9nf35/ji3P0S1E/MMp8Iep4KG1GziAS80Umxd8pAUNVh6IpANN0bfxmnSU74LlNcWYOWXCTTIyvew4U7c99QiucnKAc4uhwgWMEWFlO834AcFzkkyxk76cbc/0RmCSeWzSac/h4OGmoXoKyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WtJwl6ix; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WtJwl6ix"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NvA93RvJPlxSg6PcQeB+KluU3vvMLvZ/EyUbU6cqdOM=; b=WtJwl6ixHHzAWiNl6Qn/o37fpr
	Mm/GYj4PSecTcge6nlf9eGM/R1pa9XfDCdH0lSVz9ZBVyjadqeH8kSnjznELlIiCd8QRUEltTW8Tz
	84wSzMjBu89+qkgZcGKl4tFagmWwEuQECm7aO3h/kh0FabWtCl+RWvLcSV33qEqsVPwIOpJGw+Rbp
	BOVOo3i6TZUt0evAH6K03LLzfTb9E5fU82INhMfO2m86NZPEKTwvd7mQ6xr1l9rO+CgeeAYPW0e3U
	EvfZxOc8rbpLBoPE08+m+D1PbgPacVA9UFNjVRVpy7pvPjJHyFwCopvoPHsIFMLsd1MuU5Yr1sMj/
	Hqf/O3TQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xBPlj-00000002Ph7-3aXN;
	Tue, 29 Sep 2026 04:48:43 +0000
Date: Tue, 29 Sep 2026 05:48:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Georgios Androutsopoulos <georgeandrout13@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
Message-ID: <20260929044843.GA3909609@ZenIV>
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com>
 <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 25, 2026 at 06:00:42PM +0200, Christian Brauner wrote:
> On Thu, Sep 24, 2026 at 08:39:37AM +0000, Alice Ryhl wrote:

> > This looks like it should ideally be on the C side instead.
> 
> Where is this godforsaken broken code, that tries to fd_install() after
> exit_files(). It is _a bug in the program_ that is not something the
> apis need to work around.

	More to the point, papering over that at runtime is wrong, and not
just for modifying descriptor tables - fdget() is just as wrong in anything
that can be called from tail of do_exit().

	It's exactly the same as with "what if it gets called from an
rcu callback?" - it's a bug, that's what.  Don't use these primitives
in such context.

	In particular, ->release() mentioned upthread should not be allowed
to access _anything_ hanging off current, not just descriptor table.  Note
that the last reference to an opened file might be sitting in an SCM_RIGHTS
datagram pruned by AF_UNIX garbage collector; as far as the method is concerned,
it might be called from random thread.

	If it tries to access (let alone modify) the current descriptor table,
you have no memory safety whatsoever and checking if current->files happens
to be NULL is nowhere near enough to resolve that.

	I don't know how to express that gracefully in terms of typechecking -
sure, we could pass an empty token to each syscall, have fdget() et.al.
require that as an argument and propagate the damn thing to all such callsites,
but that would cause an insane amount of churn - if nothing else, ->ioctl()
signature would have to be changed and there's a _lot_ of instances out there.
And then there's the joy of dealing with ->sendmsg() and ->recvmsg(),
thanks to SCM_RIGHTS datagrams, again (reading descriptor table on sendmsg()
side, inserting into it on recvmsg()), especially when you consider the
fact that ->sendmsg() and ->recvmsg() *are* callable from contexts where
one shouldn't be allowed to access descriptor tables.  None of such
call chains is going to trigger descriptor table access (e.g. knbd is
not going to try and send SCM_RIGHTS datagrams, etc.), so it should be
safe, but having compiler prove that without inflicting overhead on
the code paths where it really wouldn't be welcome is not going to be trivial.


Al, finally back to the state when reading from screen is tolerable for
reasonably long time - dry eyes were _really_ not fun to deal with...

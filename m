Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEEC47A893;
	Fri, 25 Sep 2026 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349330; cv=none; b=g7WqULQC/3Ijaki4cfwKr5mcUp7PppLknsRfKG1lbnx9so/2HFiLUqixDwVS/6RYBhlzKNsNac+041Uzjfuzkg5DSBRs8zGGsbjnU0UdqriAQZDtQ78Yrd6dzATKUN9oUznxJJbxABeUH0TOkpVYDzNIflq1JYvh6lIsRq7rihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349330; c=relaxed/simple;
	bh=URfWye7+NFaWDbfpX83zfp7f4bdfIWaGwcFiVRan8Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhk2O2ZxZ9kDNc6N4u61ja/e0+A+D0dEPblwSDo4Ms0WtdYyN7zo2/0E0YAMUOs1BHy4iP71RDqjh0m3NIq9SLPPBCa31EpeOJbruWqAgP5LwrbKK5sh8Pxy1OCTVbFQIghZbgJKaigEpoyltOWyHuQX1OuUMcFCDPaR83OPAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoAo8Bot; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoAo8Bot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8BA1F000FF;
	Fri, 25 Sep 2026 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349317;
	bh=lvYc6pPZnAveBfWQ63y5Dc25KA1+8Uxmt/f8nYWHKUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EoAo8BotsFDuAmCujPR1qVsTjJoTnTNbSBBFlsXJIbB7bpnPUysAkmYf2Y1DZZul5
	 YAwytsETpbWhW2LAkiOhTKKaIAU+c/jcHL5XUHwaRnIAmydKqq/54KW9du99H0fMV5
	 nKmjfKv6n9wTIn7N3KnSQEbA51T/Ug5T84+Dugvbjah5/XKcuO9FJ5av2Z7wIeY0T8
	 u4FEB6wUjKTfx86JeeMcnqAMky/fzYduva7Ij+C18bnpkf0L1DgLQAjlOaEl99T7iE
	 kRdvfghUoKir7FD5pPtAmShKLbXMRD0uRWXdNzrKhkL4Ijl2Lq4ZSjihNKkXg6QHFR
	 7Gi8GfDEEi8vg==
Date: Fri, 25 Sep 2026 17:15:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Georgios Androutsopoulos <georgeandrout13@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miguel Ojeda <ojeda@kernel.org>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun@kernel.org>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: file: handle fd table teardown in file descriptor
 APIs
Message-ID: <20260925-entfernen-kocht-anbot-a03d3ea7e01a@brauner>
References: <20260920200154.1194983-1-georgeandrout13@gmail.com>
 <DLKFTVSN56P2.2NHCFW6NIUOAH@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DLKFTVSN56P2.2NHCFW6NIUOAH@garyguo.net>

On Sun, Sep 20, 2026 at 09:48:54PM +0100, Gary Guo wrote:
> On Sun Sep 20, 2026 at 9:01 PM BST, Georgios Androutsopoulos wrote:
> > Several Rust file descriptor APIs rely on `current->files` being
> > available. However, `exit_files()` clears it while execution may still
> > continue on the same task.
> >
> > This affects `LocalFile::fget()` and the
> > `FileDescriptorReservation` operations that call
> > `get_unused_fd_flags()`, `fd_install()`, and `put_unused_fd()`.
> > `FileDescriptorReservation` cannot cross task boundaries, but remaining
> > on the same task does not guarantee that `current->files` is still
> > available when these operations are performed.
> >
> > Guard the affected operations against a missing `current->files`.
> > `LocalFile::fget()` returns `EBADF` and
> > `FileDescriptorReservation::get_unused_fd_flags()` returns `EMFILE`.
> > For the infallible `fd_install()` and drop paths, warn once and avoid
> > calling the corresponding C helper when the fd table is already gone.
> >
> > This prevents NULL dereferences through these safe Rust APIs after
> > `exit_files()`.
> 
> I suppose we could add these checks to C side instead, although perhaps one may
> say "its bad caller code and not worth checking"?

It is a bug to call fd_install() or anything like that post
exit_files(). Whatever code is doing that needs to get fixed.

Similarly it is a bug to call fd_install() on kernel thread which do not
have files at all. So whoever you're doing this for is breaching core
api assumptions big time and I would like a detailed explanation
otherwise I see no reason to merge this. 

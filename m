Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B62346771;
	Tue, 29 Sep 2026 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688537; cv=none; b=F6eiqzgPedtsknwuuNcoyzwc02vp+lQRckTKcwEgvIuApLZqPd1ljG17KFIeobj8oBJwwO6NwUsz2jAtTp4746o7z0zc5EgN2dYiLSYmaRRprrPTlkMFpKhEfS+EqRWYi1Q4+awr9kNZTBsXcGTJAF77UEuPzZUx4drqypc3WXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688537; c=relaxed/simple;
	bh=Q6I7gu/AJYVtMGvHRAkWSS1JvEZWBGbBeUPBS52sG7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVyda9Zld0Rdjz9mp1xssjIhZGwZtIN/ooPBhINWso9dNSXeKzT+1F26tu+jBMfDlEY957naVieTCIABN5ncK7dcDkfNfZEJV2PFMEZI2ltuWUin5v+VEmLPvISbrgTERjy95+eR+B1K969DUw4IWxkXG9ipPfzXGqG+fgy/Dv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DsZvHfN+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DsZvHfN+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3+B5gTPq64xpJqdo/qwWrQuCpe/ndMdyOtlqxcyH5Y8=; b=DsZvHfN+rsjhBsxOl3JqdnWPg5
	SndOkgWSJb432XlG43Pc2tTQf4e53zuD2GovBRMvfpMqHPdTf35PtZcDFPaUTdVzGH52WtfIskVqy
	CmFsO9zOTkuLPNJlFJLCMQQQwWDvKubXHDsTVQ6N0D0Mua8SpGgEU929pfkZYi+vXkzt5yv63MwI1
	OjbwN5JCIZYFb+4ZUfTn67T/LpBuXyyTrLIcQucY1PL5cRKWXQHzuPx5DvFDkc23Iw9rsgUHlZxa8
	G0IKQunIhWDZ0VD6ZF+y+m6SlGsQrqmZyN4j21DXDiuz0j4mvvfENJ//WaMcAKQOiEgKIKi5NEf46
	7T2qxagA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xBXst-0000000Bh2q-1gTy;
	Tue, 29 Sep 2026 13:28:40 +0000
Date: Tue, 29 Sep 2026 14:28:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
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
Message-ID: <20260929132839.GA989762@ZenIV>
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com>
 <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
 <20260929044843.GA3909609@ZenIV>
 <art7swUNAa3AyUrL@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <art7swUNAa3AyUrL@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 29, 2026 at 08:49:55AM +0000, Alice Ryhl wrote:

> So, I previously wrote some code that could invoke filp_close() to close
> a given fd ... from a workqueue. This was in the scenario where the
> process dies and the usual cleanup function gets called deferred from a
> workqueue instead of from the ioctl like usual.

Huh?

1) filp_close(file, NULL) doesn't do _anything_ to any descriptor tables;
the only requirements are that it should happen in _some_ thread context
(workqueue is fine) and that caller should not be holding any locks that
might be taken by ->flush() of the file in question (for a workqueue
callback it's fine as long as the callback itself is not holding any
of those).

2) any caller of filp_close(file, files_struct) must obviously guarantee
that files_struct won't be freed under it; passing current->files from
workqueue is safe in that respect, but obviously bogus.  Note that
descriptor table in question will *still* not be accessed; it serves
only as an opaque tag that identifies POSIX locks (and dnotify_struct
instances) related to the descriptor table in question.  IF you have
just manually removed the file in question from descriptor table
(file_close_fd()), you must call filp_close() passing it the same
descriptor table while that descriptor table is still guaranteed to
be alive.

Rationale is memory safety, actually - for POSIX locks descriptor table
serves as lock owner; the reference is opaque, but we don't want to have
it outlive freeing and reuse of the object it's pointing to.  So anything
that removes some file reference from a descriptor table is responsible
for corresponding filp_close() call done *before* the descriptor table
is gone.

Note that we only need to take care of the reference we remove from
descriptor table; files_struct destructor will call filp_close() for
anything still referenced from it.

Places where file reference is removed from the table:
	* do_close_on_exec(); filp_close() called in the same loop as
clearing the descriptor table slot.
	* do_dup2() in case the new slot had already been in use;
filp_close() called just before return.
	* file_close_fd_locked() callers. Three of those call filp_close()
as soon as they drop ->files_lock (close_fd(), __range_close() and
io_uring io_close()).  Remaining caller (close_fd_locked()) leaves that to
_its_ callers (binder_deferred_fd_close() and its equivalent Rust-side).

Again, normally both removal from descriptor table and filp_close() are
done by the same primitive...

> In this case the correct behavior was just to do nothing.

... leaking an opened file?  IDGI...

> It was a very easy mistake to make, and if such mistakes lead to null
> ptr derefs or worse, then I think it's worth doing something to reduce
> the bad consequences from this kind of mistake.

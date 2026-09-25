Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0084C4F79;
	Fri, 25 Sep 2026 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352051; cv=none; b=Q08IwruDGOCO7XDyv5FcDBbC2fEo0M24yDTyQXzsb8KqJyGNTEgPl8hK1JR1UNwnnJ4jxYnQLtE50MfK6LEnTPcWSEctlLzZkvc/ydW+bxooQrFI7sANeyENFfPsp98ua+fBAjnZqJtqvwvvuPV9/CTClArzt9IvZClfWtG84Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352051; c=relaxed/simple;
	bh=XPk2iVEi1ZZ+DK84171FOJEbD54WgjtBA5JCaekTJKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5Ves1+/GJCaM//zY31zGYIBg6CcSHPnBD79wlqOIJK24Np9ULgNunh3jPiVFYl6hXdQr0t4mGKhnh8N2efTE3f8gN3dVOSXSkASdSRci1hJI0wOifwufOw0bc6pOQ3uVLo0MIhc7UZnVJ3lognHmMge2hFMmC67Hb1YgAK79qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrKX8OQ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrKX8OQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BBE1F000FF;
	Fri, 25 Sep 2026 16:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790352050;
	bh=rEVP8+QFyN1/i+S2OOZXHJB8hSPsPgMgJbSumvajv+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UrKX8OQ13toMLb4824ibANKh2WamtYlsMo0uYd47N/7/tdb7mr10rVYD8DV+Wcob1
	 H5rJPWjYq7WEpxHLlpb36LtYUApqp0Fb/SS7RBO6XgRpZU0fJZthtQ5r0Bgr4N+aqJ
	 ul2BM7XXg6lZDlfoo4dIqtebsJuLJY78KLusUGszh+CuzwQIkEweZVGo6MBzCDdtFo
	 cVVx6PrxT4NKLKfZCEyzPMX9OKvsaSWGgosnZqMCBvm6iFKJAG8IIGoPNM3YxgBANg
	 sDi8JuNFMaBng0kd+eHNTrEa1r5uWz1VlGTZh/fXoyLeQjW7vOEtG1mPh+RK9rINhD
	 sNtPXcIgwURRw==
Date: Fri, 25 Sep 2026 18:00:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Georgios Androutsopoulos <georgeandrout13@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miguel Ojeda <ojeda@kernel.org>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
Message-ID: <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arThye_219ruNbM2@google.com>

On Thu, Sep 24, 2026 at 08:39:37AM +0000, Alice Ryhl wrote:
> On Tue, Sep 22, 2026 at 10:23:39PM -0400, Georgios Androutsopoulos wrote:
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
> > For `fd_install()`, warn and abandon the reservation when the fd table
> > is already gone. In the drop path, skip `put_unused_fd()` after the fd
> > table has been torn down.
> > 
> > This prevents NULL dereferences through these safe Rust APIs after
> > `exit_files()`.
> > 
> > Fixes: 851849824bb5 ("rust: file: add Rust abstraction for `struct file`")
> > Fixes: 5da9857b127e ("rust: file: add `FileDescriptorReservation`")
> > Closes: https://github.com/Rust-for-Linux/linux/issues/1256
> > Signed-off-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
> 
> This looks like it should ideally be on the C side instead.

Where is this godforsaken broken code, that tries to fd_install() after
exit_files(). It is _a bug in the program_ that is not something the
apis need to work around.

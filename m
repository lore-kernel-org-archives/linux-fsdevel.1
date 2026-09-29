Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F32F36B907;
	Tue, 29 Sep 2026 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711263; cv=none; b=FbvL4oiZNQKpSc4jfLuMrybTxOMCRDV+o/FfKh0RnPo5FD7bAv7AvgiJB/HVfR0Hd+1gn0c6VMXC3g183C/OZuYb06Qi1jgv7hcTx3MuJGZqVDxeS9uL5xWzZfxC2W/Ya5+pFwuS0Ue9b6lVsTyfdtaijS3pdgONiNsszRcvhcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711263; c=relaxed/simple;
	bh=sI325cC8UG3uv9TDadWiuNQxt8yHhmXIrUg0Vwq8FWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnZJ8QKCtDVgqCQ+mPmJjwh0ISZF80Yqr+rfvX5oHt6ZCnGKjt4pPRWAA3MEfIy3cOQXX2I9/7dTS+1AAGNGly1hprJngujUOOj1aukzwBhcH9/TsKFD+v0mcpCmV6ySqj9Y8lfS1J2kpINeMDTDsIl/z4CPrZZO0dSQTaA5xzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NcL747iB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NcL747iB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NfOZsYWn5pZsGH9m0zoezdWqXY6d5EjWzhvFuRoX8rM=; b=NcL747iB7aF5ENFubPTI/02ASE
	Q1EEVP33N0rMp9PynUFwbzqJslqYLdf6b3Yrz4kI8qJoXYga2UfCs9n5iRXQ3dJW6mib+o750rXZe
	AXDhI3ThwrNJRowhvLAQCF7fHxM7M98103bgmM6mERt+yJADSDt1oPo/bJ6GBDnaKBVfCd/Vu0yQH
	rr+ZtDL5e6I1uPJ96dhWiZxefXeYKuiHgH/WPJaVlHTmxNod4puN2igA1jPllTC3B3Oogy5BtK1DA
	W2Jwj56ZWvvnUVE1hQouTfvDgPUqE20HAyNJ6QAwtZ0sfRjxDjaGT6TK+i/8HP1mtQWUT4F8vuaEU
	bs19di2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xBdnS-00000000ICf-3d6Q;
	Tue, 29 Sep 2026 19:47:26 +0000
Date: Tue, 29 Sep 2026 20:47:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gary Guo <gary@garyguo.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Georgios Androutsopoulos <georgeandrout13@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun@kernel.org>,
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
	linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
Message-ID: <20260929194726.GE989762@ZenIV>
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com>
 <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
 <20260929044843.GA3909609@ZenIV>
 <DLRSQRUVOGT2.10ZY01VEJVHCE@garyguo.net>
 <20260929135154.GB989762@ZenIV>
 <DLRXHGLDR2QQ.WZVRWGY995BT@garyguo.net>
 <20260929170218.GD989762@ZenIV>
 <DLS0CO1HEGJN.2XX8QX8LW8XJM@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLS0CO1HEGJN.2XX8QX8LW8XJM@garyguo.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 29, 2026 at 07:22:28PM +0100, Gary Guo wrote:
> On Tue Sep 29, 2026 at 6:02 PM BST, Al Viro wrote:
> > On Tue, Sep 29, 2026 at 05:07:40PM +0100, Gary Guo wrote:
> >
> >> The reproducer that Georgios posted on GitHub is some cleanup job being added to
> >> task_work, which drops FileDescriptorReservation. And since exit_task_work()
> >> happens after exit_files(), put_unused_fd in that cleanup observe that
> >> current->files is NULL.
> >>
> >> So it's not from random thread, it's from the current task. And I find that
> >> particular case of doing per-task cleanup not unrealistic.
> >
> > FWIW, descriptor reservation ought to be tied to specific files_struct
> > instance; note that dup_fd() can be called when there are outstanding
> > reservations and the copy does *NOT* have those reserved.
> >
> > What rules would you suggest for such delayed put_unused_fd() wrt e.g.
> > files_struct unsharing?
> 
> Ah, is this about `unshare(CLONE_FILES)`? For that case indeed our existing
> abstraction break down.

FWIW, the current rules are "you must not have any outstanding reservations when
you unshare descriptor table in any manner".  You are adding "... including the
ones that would be discarded by an already-scheduled task_work callback".

It's not just unshare(2) - there are more interesting callchains. For example,
unshare_files() from do_coredump(); this one should be fine in face of
put_unused_fd() in task_work, due to the task_work_run() in get_signal()
being upstream of vfs_coredump() call, but it needs to be considered.
Or begin_new_exec() - that has a lot more callchains leading to it.
It should be safe at the moment, but that needs to be demonstrated, etc.

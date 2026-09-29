Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6AF4E66AD;
	Tue, 29 Sep 2026 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689928; cv=none; b=BiPynhneRdHkRjLEJvRr0c4q6fChzX2SFHlroEq0ZDEBV6tfv7+MVxeneWa5G7qALpwl9tgiWX842INpUyDuNy6DHovjbh/oPKPG86AkXE9ubQbxth0qU+8yVNqisG6HMcHbwYK6OV3Bs6ypObeeK/DxzFlaG7fDDkQ4sZ1aQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689928; c=relaxed/simple;
	bh=nL5MClaRIwDVCv/QE0DFc1I9Xmfxdgj0PKlSIzVR9Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR3wI4z+ntpLXnknXsy6V/xbrPqlWQYrXiD02/7SnzBk503snCRlSxG17UmKloWOCPGl9GEPcauBhDuM+DWl6B5aEKE4VZBoIqvP7uqSwu+zSTZOfGUIVR6Hv+JeCU0aEeQn7YYafR88VDVuOSugY+wAT7LFJDEWfjzTKvvld4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Qi6PIQNu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Qi6PIQNu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=icW9vH+8BAeUrIYQizVMOie8ohpk97Gpl7u0ZmW23GI=; b=Qi6PIQNuPLEgJgehOf0EWDkzPn
	Mnq+uYq0N4MG9SThLtF4LDbtW7fOwr3d0mjr67kHBHuhoU4SJf1aBQAOxynufxleH8Zvg6ujxT2R5
	taEHsTEHtJrynDNel4k3Szcn2dLHGNMnl9K8IM5bGTBQQsHDeIloWQPRrZqbKcG2FpCN4e42nlW9e
	/BlI0LVLs7vMKqGzy0g/ILnq0yqOEXoZDOSNVCURikXlzwQ3XRja0wcGj0MeiuiVR3bCt2vhe9M33
	bIkAalOGSp1CK21W0Y2B4EcfOWfubGkcKkGqlZJaUKAIqC3f4pFDcSixCfJ8G/KHQbFKx0y8IMysC
	2177flHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xBYFO-0000000C57q-2Pqj;
	Tue, 29 Sep 2026 13:51:54 +0000
Date: Tue, 29 Sep 2026 14:51:54 +0100
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
Message-ID: <20260929135154.GB989762@ZenIV>
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com>
 <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
 <20260929044843.GA3909609@ZenIV>
 <DLRSQRUVOGT2.10ZY01VEJVHCE@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLRSQRUVOGT2.10ZY01VEJVHCE@garyguo.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 29, 2026 at 01:24:45PM +0100, Gary Guo wrote:

> > 	In particular, ->release() mentioned upthread should not be allowed
> > to access _anything_ hanging off current, not just descriptor table.  Note
> > that the last reference to an opened file might be sitting in an SCM_RIGHTS
> > datagram pruned by AF_UNIX garbage collector; as far as the method is concerned,
> > it might be called from random thread.
> 
> This part is protected -- we mark FileDescriptionReservation as `!Send` which
> prevents it being moved to another task. We also take care to make sure that
> the task returned `current!()` is not allowed to be used outside the current
> task.

Not the point - ->release() can't make any assumptions regarding which thread
it will be run in.  current won't change under it, but there's nothing
useful you could want with it.  If it has non-NULL ->files (or ->mm, or...),
that reference will also remain stable, but any attempt to do anything with
it would be a bug.

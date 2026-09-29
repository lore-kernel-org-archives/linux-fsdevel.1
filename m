Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E2A530E04;
	Tue, 29 Sep 2026 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701359; cv=none; b=Hp9GllxDsYK9TXnQWs+SoL+eRJBGI2qd6o4TqXoZC0Ej9/OcUHgpDGQ+m702h6+RT7cqnwYa9RzSSjxUWr++dr7sJFWa/BhUMUaunEUbG+M9m9ZXFIgmuLAxFwt+yaM2kDscVAu3UTIAPoSMt0lLvMbznuScj1B4dJ96SR69aNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701359; c=relaxed/simple;
	bh=sztxa51NDpnXgGK1FzhpqrWF9TVbYB1X0GV7fb1ZENU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOeiWWsueHvgd07lKo/TQquc7u0/XKlQ3c9gqkJ6Efmko8KUecallxaYB+mOpV+Idq4eywvff6hvrHfamp1g64ah7J2IROpWAZwGL333HUxnt0Ojh+OHd++llJHlgX9TKexYVKJeBftxEGoC65gN2yaBaz+ssrKzNHbWKRzEpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VqnY939g; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VqnY939g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sztxa51NDpnXgGK1FzhpqrWF9TVbYB1X0GV7fb1ZENU=; b=VqnY939gtSRzhLUZI4XEXXKxCB
	1fmHMvR5qwP47km1BXCICgcZEgKYcm5EItdNqjBR1dVDg+K0RRd1lPiBHGTfiuqOtRLREoLM4HN8Z
	6cSghE00wSNuOfm9SI6Io5Mxn2U4jh+twZY/ho77nuAx0zLAkVbWK3f0/1aYcroayESnizNPHZPxJ
	+T6rkD5OkWUCAbLvP5DrE+aHHGzTKCfRzCsjny1Ko0xzZ9Mdvk9eqPlAL3ZRP3Kbqdv2WxkE9rtfO
	zNVhy1FRMBLz9I8Q9/Ele9dK5ree8WigAhLzWvWjYbL6RcrDCyM9cr9sucFPvBlZ0ToNR6bDD/qCe
	TVMXd0Dg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xBbDe-0000000El5m-34dN;
	Tue, 29 Sep 2026 17:02:19 +0000
Date: Tue, 29 Sep 2026 18:02:18 +0100
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
Message-ID: <20260929170218.GD989762@ZenIV>
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com>
 <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
 <20260929044843.GA3909609@ZenIV>
 <DLRSQRUVOGT2.10ZY01VEJVHCE@garyguo.net>
 <20260929135154.GB989762@ZenIV>
 <DLRXHGLDR2QQ.WZVRWGY995BT@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLRXHGLDR2QQ.WZVRWGY995BT@garyguo.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 29, 2026 at 05:07:40PM +0100, Gary Guo wrote:

> The reproducer that Georgios posted on GitHub is some cleanup job being added to
> task_work, which drops FileDescriptorReservation. And since exit_task_work()
> happens after exit_files(), put_unused_fd in that cleanup observe that
> current->files is NULL.
>
> So it's not from random thread, it's from the current task. And I find that
> particular case of doing per-task cleanup not unrealistic.

FWIW, descriptor reservation ought to be tied to specific files_struct
instance; note that dup_fd() can be called when there are outstanding
reservations and the copy does *NOT* have those reserved.

What rules would you suggest for such delayed put_unused_fd() wrt e.g.
files_struct unsharing?

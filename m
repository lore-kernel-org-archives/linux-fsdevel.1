Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAC44D6A1;
	Tue, 19 May 2026 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184190; cv=none; b=SAGABCGJLWWSNxAvnJnj+Sxf2c7kMxrcHElsi/q/22yVE3RBuOylQRUHnflk2ERZ5gfDTqtuEDCC2UKW+LryDU2q89RUPcodbdL6Qc9qigz17EEg715gKwohERWHSkLhNvwVv1GxMv9m02slmvJ0hnajaPxGT7FQH4Z1juC/mpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184190; c=relaxed/simple;
	bh=rX/Q8oXbMSySRNyC7+NzxKvhA/QggJj+c2IzhXKHseM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fMUo7k9EblStcIrXkjfNehRq3YPhJqzJReoG+g1NffGu9Slss8vH7WoVnyldfRf4u8nza8dvPo0jVXKCmKQNb5FkGZ2sHK7XClfEZsF7qyww3jLUfLKZIvi83weofOqVU+CfmYTHK1byyXb2C0taDNthWELUMMzqyL5rLdPKGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpkY4roh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpkY4roh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE68C2BCB3;
	Tue, 19 May 2026 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779184189;
	bh=rX/Q8oXbMSySRNyC7+NzxKvhA/QggJj+c2IzhXKHseM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=fpkY4roh9gwMJQ/jVJi3hDMML+a3cbnvpqLaF97cSBRKOgbbXy+Y8WSlXZti3vTUB
	 Fn9CeEIFXwKnFGMEvBdNovTOsBxF7w8nHl5hrqkWxB9yWO3MJevoYnXFESyz1vQfUl
	 e/w3dIRwjxgFaaHxv7qVv72pXJO1k1rsXKYg2WsN4jh4lRjnjQMT5dLd7FThrViFLJ
	 b1M+b6UZh439sr1qotZte4TNpe10x6Vb5EsonDNamCXXoTNHqqaTCp0G3ctHQb3+4U
	 YcGcpn4r/3t1CUNcYq9kUP9R2cQHL1jhRAE66WWaNuHR8qoy3KBkXDj54mpgLkELUe
	 2pS6uOtblXl8A==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Pedro Falcato <pfalcato@suse.de>, Jens Axboe <axboe@kernel.dk>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
 Kees Cook <kees@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
In-Reply-To: <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
References: <20260516182126.530498-1-pfalcato@suse.de>
 <20260518-starten-messdaten-3b8aa670ec85@brauner>
 <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
Date: Tue, 19 May 2026 11:49:44 +0200
Message-Id: <177918418452.771415.4371785688744608623.b4-reply@b4>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2611; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rX/Q8oXbMSySRNyC7+NzxKvhA/QggJj+c2IzhXKHseM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTxGFklVjj2q5u83cGqNCFNpGeZ+tsoozPNx7sMnYJOu
 TxQN0/uKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmAhvMCPDe7bXOz9ZvjF1ln8x
 o0FmwZbznJwWxiHl4qlCdTsPG5gaMzL8Pa58f5fkUXHb39d+yP34Ov11fFyW+OTZO8zU7+6VmfO
 CAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-05-18 20:59 +0200, Jann Horn wrote:
> On Mon, May 18, 2026 at 2:30 PM Christian Brauner <brauner@kernel.org> wrote:
> > On Sat, May 16, 2026 at 07:21:26PM +0100, Pedro Falcato wrote:
> > > Since the advent of vulns like Dirty Pipe, Dirty Frag, Copy Fail
> > > and Fragnasia, splicing a read-only file is fundamentally unsafe.
> > >
> > > As such, as a mitigation, add a way for users to block splice() for
> > > files they cannot write to. This eliminates this whole class of exploits
> > > that use splice()+confusion in pipe/net/etc code to gain write-access to
> > > files they can only read.
> > >
> > > Users can simply toggle fs.splice_needs_write=1 and suddenly splice() will
> > > refuse perfectly legal splices() from files it can only read, but not write.
> [...]
> > At that point you can also just ENOSYS splice() and vmsplice() via
> > seccomp and force a fallback on non-splice codepaths that userspace has
> > to have anyway as splice() isn't supported unconditionally.
> >
> > It feels like a knee-jerk reaction to an exploit class originating in
> > buggy modules that we have little control over and we would extend an
> > API to users that is really difficult to use.
> >
> > What might make more sense is to add a splice specific security_*() hook
> > into the code so that an LSM can deny usage of splice in whatever way it
> > wants to - bpf lsm or in-tree lsm.
> 
> I feel like a sysctl for "disable all the splice-like interfaces and
> zerocopy TX" would be reasonable to have? Either by blocking such
> operations, or better, silently downgrading all such operations to
> normal copies.

I think blocking isn't going to be useful as it will make it harder for
distros to turn this on. So we should degrade.

> FWIW, vmsplice() and splice() are also weird in how much memory they
> can implicitly pin - if you call vmsplice() on a single byte in a 2M
> THP page, I believe you'll implicitly pin 2M of memory...

You don't have to convince me that it's a problematic api.

Let's discuss the other aggressive alternative: Can we try and
unconditionally degrade to copy. This would affect sendfile(), splice(),
and vmsplice(). Worst-case we would have to introduce the sysctl
retroactively.

Thoughts?

> By the way, another bug a few years ago of a similar shape was this
> one - also a bug in networking code that can lead to accidental writes
> into spliced pages:
> https://project-zero.issues.chromium.org/issues/42451650 ("ktls writes
> into spliced readonly pages")
> with fix: https://git.kernel.org/linus/c5a595000e26



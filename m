Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A51423EB9;
	Tue, 11 Aug 2026 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438896; cv=none; b=femGs7n9816FaEuvBew6BMoHMdUY2aRzOudA+/0hn6RqaMAJ4esnRaTFeCumi0nYNQaQTL8JZLzulqQvNY/Zl2a32o3qLCveT05Yu0E2sPJml+nHgi4jIeezG3z2dK4Lz/N7RnymID0oR/vxO5kLq7bv7sw1qIh5pvuGRBM2f90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438896; c=relaxed/simple;
	bh=qwLIB2bBQXLL+bOlIVBK8cQuDQ5EvetyzrffCoPIo8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiquWzAl8U/p2qz+Jg9/khsEcakcmi4d5Nmn8il7ZVloeu3J4RW+lTJ8DSXW91Okpj1Z8p7LBW2OR2dAIqICIBuF7Te4EZC9QjiMzReiu6LCA5KyAOPH7/M+MH/kYR4J6d+ixELnETGzD0L8QbwPVaTZPtfITeidgD1RExzTeH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4mtIsOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4mtIsOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B471F000E9;
	Tue, 11 Aug 2026 09:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786438894;
	bh=ch1vwr1oMX7MtzHpeMm9rmqf5EDiWvebNhUXHEeGyWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d4mtIsOLuGnRJZtkYw+O7i+mHTHs+/HqRNCiHDct3GNdZybEQf1vbUq3ba1bt05ZC
	 QDuFDti6REB0w/Q7WBSyqSCcp5C3AtIDWe8Fkh9iAYrXUJjUua03qadFS5csC6YJGV
	 EczceT0jisxa2KhNBGE6aNEcrPEgENEAlzZW4aZfS5eCTTeWPb0W7LJSy2fhWOqQhy
	 p+5jO1DqzEh51TZr1CX3C+ht8q9zOlzbN5vWcTY5tsfcY2nWoiJ2ExUXf6jL4k2pYd
	 0mAonpH11HvCuZXky87DA/8ZKqDf78WGKGocoEtk0daEnXd7ZKWzmTsqzRD4V+sijj
	 t0OOc5lObx7wg==
Date: Tue, 11 Aug 2026 11:01:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: document semantics of kstat::{uid,gid} fields
Message-ID: <20260811-grafik-feinschliff-kochrezepte-53c6b27b31b3@brauner>
References: <20260803-vfs-comment-stat-uid-v1-1-162d062b737c@google.com>
 <jdgkb7u77fc56g7nm3k4ict4hk73ypu7whjriqocsjbawudm24@we72tpaxods6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jdgkb7u77fc56g7nm3k4ict4hk73ypu7whjriqocsjbawudm24@we72tpaxods6>

On Wed, Aug 05, 2026 at 11:39:32AM +0200, Jan Kara wrote:
> On Mon 03-08-26 21:46:19, Jann Horn wrote:
> > The uid stored in struct kstat is logically a vfsuid; file systems
> > initialize it by converting a kuid (filesystem perspective) to a vfsuid
> > (mount perspective), then use vfsuid_into_kuid(), which essentially just
> > typecasts from vfsuid to kuid.
> > 
> > For now, just add a comment to note this mismatch between C type and
> > semantic type.
> > 
> > Below are some notes for anyone who wants to refactor this in the future.
> > 
> > There are probably two options to refactor this away:
> > 
> > 1. Change the type of kstat::uid to vfsuid_t, and perform the conversion
> >    from vfsuid to userspace-uid in the VFS layer. This wouldn't change
> >    machine code, just be more semantically correct.
> > 2. Change the semantics of kstat::uid to really be a kuid_t, and let the
> >    VFS layer take care of doing the translation from kuid to vfsuid that is
> >    currently done in filesystem code (or in generic_fillattr, on behalf of
> >    the filesystem code).
> > 
> > Option 2 is probably neater since it moves more logic into the generic VFS
> > layer, and this is something that is expected to work the same way in all
> > file systems?
> > 
> > The following coccinelle script:
> > ```
> > virtual context
> > 
> > @@
> > struct kstat *stat;
> > @@
> > * stat->uid
> > 
> > @@
> > struct kstat *stat;
> > @@
> > * stat->gid
> > 
> > @@
> > struct kstat stat;
> > @@
> > * stat.uid
> > 
> > @@
> > struct kstat stat;
> > @@
> > * stat.gid
> > ```
> > detects 43 field accesses to these uid/gid fields.
> > 
> > Signed-off-by: Jann Horn <jannh@google.com>
> 
> I don't remember the reason why things are like this - Christian will have
> to return from vacation for that :). But I agree with your analysis so feel
> free to add:

I already mentioned that to Jann somewhere else. The TL;DR is that the
correct way would be to add vfs{g,u}id_t everywhere so that translation
into vfs ownership happens at the disk <-> kernel and kernel <->
userspace boundaries only. But that's a massive patchset that I decided
against because the real win wasn't all that clear to me. I'm not saying
we shouldn't do it. Especially now with LLM help it is way less tedious
work but it'll be a big patch. :)

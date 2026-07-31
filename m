Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9435695
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504740; cv=none; b=CTQIcCIyPF5+JIBRIunSO3wXT9xAZcMp6alQ+ImkKqoMzW9qUGJ05+jjat8IOrMRyZ2EsTreZC9x0QG+7xySq3fyg+iC53Ai2ThqDJQU/ebZygKmuxSxZOF4nj3+YooEdQpeZb1RfIDUqQF0LvfuiLhLvias/OthRmBalkqs1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504740; c=relaxed/simple;
	bh=rZY276R1dF7CQ1YEccl0wOaW4qrQZnffxN9OrAT/gFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2czDnZlCWv7nSI+VK3jAJGVF9WEx5ndUw0fNtnJ/GeYjsp5gYyHcQVEVH0dUepPgFQv9sCP527ztMZl7EwGE2foJZYBL9Ls0+64WseB+w3HjFtEAiGGN/dGf+Xsc/I411SDWd/xpL3x6CbElF5V8K+s2lXP+hCR8aHxRXYThqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cghnf9Y7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cghnf9Y7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0281F000E9;
	Fri, 31 Jul 2026 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504739;
	bh=q5ZBFRjSaRWG49SYZwkFXwAI+svIJcrU39TitSzCLBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cghnf9Y7m8MyEdcVdGGtuv0KC9YXXAr1PAJJwjsKSvF36iYMcLbKLJFyiqGYY44TX
	 0Ji9gvJVwsEwrxwTJ/UIOndwlJbbMwf0EsokkC2iRbBddxaTFoM4jmmHc4TllPO1jo
	 EDG4nbpuwJDImziUksRNRSDxW0+hHYWqXI4PVNpdlQJDBNqdiBKv6LLz4k5EXHCe3G
	 PN3cQzIXUxmmKIisdwKmHNpaRfC8cDYq8Z5nDc2BGetjkQZ+BmVNB9NIWse8YD1cOh
	 MZEFkKGADviTAoD2GWXRmE7uPFrYK0UEBKyRCydoL+QHnso3vVVVgXf+e2ZU7kmhW/
	 Pc/207QXqETow==
Date: Fri, 31 Jul 2026 15:32:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Pedro Falcato <pfalcato@suse.de>, linux-erofs@lists.ozlabs.org, 
	xiang@kernel.org, linux-fsdevel@vger.kernel.org, amir73il@gmail.com
Subject: Re: [PATCH] erofs: reuse superblock for file-backed mounts
Message-ID: <20260731-geheilt-launenhaft-lehrjahr-7cc61610ee1c@brauner>
References: <20260730124120.1501126-1-gscrivan@redhat.com>
 <amtJX8aTZT5d_sP3@pedro-suse.lan>
 <8733x0k2p1.fsf@redhat.com>
 <87fr10h2wh.fsf@redhat.com>
 <20260731-geeilt-hasen-demografie-83c895f789ea@brauner>
 <8733wz1ekh.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8733wz1ekh.fsf@redhat.com>

On Fri, Jul 31, 2026 at 03:19:58PM +0200, Giuseppe Scrivano wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> >> >>> The time difference shows that sharing the superblock also benefits
> >> >>> the page cache and inode cache, as subsequent mounts of the same image
> >> >>> avoid re-reading the backing file.  This is particularly useful for
> >> >>> container hosts running multiple containers from the same base image.
> >> >>
> >> >> Doesn't this approach break-down as soon as you get to change SB flags (through
> >> >> e.g mount -o remount)? It will change superblock flags for all of them, right?
> >> >>
> >> >> (I don't think you can switch off the superblock transparently on a
> >> >> reconfigure?)
> >> >
> >> > This is the same preexisting behavior for block device mounts.  That
> >
> > Yeah, and it sucks ass. :)
> > Only an incompatible vfs-level RO/RW property causes a silent reuse to
> > fail. Otherwise it not possible to detect that a superblock has been
> > created and requested mount options silently ignore.
> >
> > In other words, doing this unconditionally is incompatible with current
> > userspace.
> >
> > Btw, I added FSCONFIG_CMD_CREATE_EXCL for this reason which refuses to
> > reuse an existing superblock for filesystems that would otherwise end up
> > sharing a superblock. This way userspace is guaranteed to not silently
> > get filesystem options ignored.
> >
> >> > said, I realize this can feel confusing since EROFS is not a block
> >> > device and allowed this so far.
> >> >
> >> > One way to solve this could be an explicit mount option "share_sb" that
> >> > is opt-in and, once set, blocks any remount operations.  Would that
> >> > work?
> >> 
> >> Would something like the following fixup on top of the previous patch be
> >> acceptable (suggestions for better names are welcome)?
> >
> > The patch as written still means that a task A creates a new erofs mount
> > with for file F and marks it as shared. Another task B creates new erofs
> > mount expecting to get a new superblock and will end up sharing it with
> > task A instead.
> >
> > That is still quite the behavior change and could be used to subvert
> > workloads expectations and be used in (odd) attacks.
> 
> no, my suggestion is that task B gets the same superblock created by A
> only if it also specifies share_sb.

Yeah, that works.

> If the option is not specified, as is the case for existing workloads,
> then it gets a new superblock even if A is already mounted with
> share_sb.

Sounds good! Ship it.

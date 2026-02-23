Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7AE378D9B;
	Mon, 23 Feb 2026 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882767; cv=none; b=uo+v486dwy0DUCyURcehdHvOEnItwVnI2j081MejhnOWBqv7k5nKlHmeHkMPJx5YuZ6gKM142JO8rzVllUmXxnke6go+Upr+fGgp85hyu59UiQoWDM2QRBbWV/xu9Qrk1Xzx7Iv4kEH/CcCO803iR6s880jtjYe6m10ZIUi7D7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882767; c=relaxed/simple;
	bh=7IYocus/c97LefvuOSkz3YYbOBRXPqXCIPlewr/+U7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifjLRXa8lRcg0NQ5YHS9rbe3LvWrcjRbtFsJJW4opoHBEQcfW6vhvCvcyArJGZ2x8wDaYmmW81SmkIiogaOZQPL8LuX/aF+s66dtHXxNFSlir3V81rU5RNYAmMDTrlPhAS4ZoGoQpaJJXwE2Ttbjq0RaRBaD31bpp5slAmYxXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEenlYOE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEenlYOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F240FC116C6;
	Mon, 23 Feb 2026 21:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771882766;
	bh=7IYocus/c97LefvuOSkz3YYbOBRXPqXCIPlewr/+U7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JEenlYOEUOjxItVtETyj1PwFIJHWWtVhZsnE/gu/5UOQa9X1VD/UJNhpf7tAIEb9c
	 Z7GY7IMSh8vym+DsnzrIVlFVbNyQUShWVJLtzPtrfFJLwZahZugKamUWSsMEAtGMcE
	 3zEmMfi4uKE9HnmlAMA8x1TU84cIwRw/0BCzcTMgPmOKc/v1Q7UP2g64D1SypqO5LP
	 BSZZ0wTfaf7wqeATlBMwVnPbomhaER53FXjSazzBWIDv10rs4EmjYheRrmBGGOxrg9
	 iGzxGtS2icxMknRSWr5Th23qKHLHG+A6D3ZZnCdCr/1KsbjzaUc6oClisuHGVs0Z8o
	 VA7FVwo11ZA8w==
Date: Mon, 23 Feb 2026 22:39:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: pidfd && O_RDWR
Message-ID: <20260223-ziemlich-gemalt-0900475140e5@brauner>
References: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
 <20260223-work-pidfs-autoreap-v4-2-e393c08c09d1@kernel.org>
 <aZx2dlV9tJaL5gDG@redhat.com>
 <aZx3ctUf-ZyF-Krc@redhat.com>
 <aZyI6Aht747CTLiC@redhat.com>
 <aZyonv349Qy92yNA@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZyonv349Qy92yNA@redhat.com>

On Mon, Feb 23, 2026 at 08:21:02PM +0100, Oleg Nesterov wrote:
> On 02/23, Oleg Nesterov wrote:
> >
> > pidfd_prepare() does pidfs_alloc_file(pid, flags | O_RDWR) and "| O_RDWR"
> > makes no sense because pidfs_alloc_file() itself does
> >
> > 	flags |= O_RDWR;
> >
> > I was going to send the trivial cleanup, but why a pidfs file needs
> > O_RDWR/FMODE_WRITE ?
> >
> > Actually the same question about some anon_inode_getfile_fmode(O_RDWR)
> > users, for example signalfd.c.
> 
> perhaps an accidental legacy from 628ff7c1d8d8 ("anonfd: Allow making anon
> files read-only") ?

It was always a possibility that we would support some form of
write-like operation eventually. And we have support for setting trusted
extended attributes on pidfds for some time now (trusted xattrs require
global cap_sys_admin).

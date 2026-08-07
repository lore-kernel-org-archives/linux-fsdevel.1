Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477B36F42A;
	Fri,  7 Aug 2026 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786129130; cv=none; b=XdpACaM/O2NS+flU3TJ/wREega8nrEXDBXsY6V12rMhoJNeVoQgSQK/n1OpYnuEYIBLBvZPfDgBk/zIqkhslvwAHTW2IlfFivaJKdWnrMQ6EJ3QR0MZQYQe/jUT5XdcVpuVkza7IXaFyxj8Bt4zwnJcH5n7JzefbW6Os6IXTEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786129130; c=relaxed/simple;
	bh=J0VlaskT4f+thJwfz+0/ru9LIfPbFktf1wleXK5w8gE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=t8YMB8ONQOlWIJzq9fF7554bIsEwcAsslB0mh28uvfOQlM3dwwFo1gBajviEnoTtc6UyB5wGIIjfY2dWLEkAWW+1xBNdCH3ZntXqvJ+pPwJvYatZcCpDcqn3qxiM2HyQM7zxE1sthOM7Oox9Rl/0wFJvd4lBAji9hlkU4OkCYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IV7ht/sQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IV7ht/sQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9A11F000E9;
	Fri,  7 Aug 2026 18:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786129125;
	bh=kUZlAh1tahWgcsjAc1/PIdZwdjnBfH0gZbPhpZppK0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IV7ht/sQxvuKv5ol/sYPMbMcd/1nc3D0tfYHpCHCWuovsBi5Kr8gqyEejnLlqcgit
	 wujt5kEUHyHSZuWlopt1Hmqs98U4mZ59a/ZHEVZrh3gO5jbFS4Ev2Z5xZsjLh8ZZcC
	 tYNkGcl67eABp6JMcc9PPTdkGMknBHmfSgZaMiag=
Date: Fri, 7 Aug 2026 11:58:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, brauner@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, jlayton@kernel.org, boris@bur.io, riel@surriel.com,
 kernel-team@meta.com
Subject: Re: [PATCH] squashfs: avoid thundering-herd cache wakeups
Message-Id: <20260807115844.d4eca51ea2b6ddfdcd7dc25c@linux-foundation.org>
In-Reply-To: <7d92d30a-c92e-451b-907e-74c91562d4ae@squashfs.org.uk>
References: <20260724190556.1950693-1-usama.arif@linux.dev>
	<7d92d30a-c92e-451b-907e-74c91562d4ae@squashfs.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 17:01:30 +0100 Phillip Lougher <phillip@squashfs.org.uk> wrote:

> 
> 
> Hi Usama,
> 
> Sashiko (the new patch reviewing AI) failed to apply and review your patch.
> 
> See https://sashiko.dev/#/patchset/20260724190556.1950693-1-usama.arif%40linux.dev
> 
> I have been dealing with this issue all week because Sashiko also rejected my
> patch sent this week.
> 
> https://sashiko.dev/#/patchset/20260805175900.600140-1-phillip%40squashfs.org.uk
> 
> After quite a bit of investigation, it appears the problem is Sashiko is applying
> the patches against the squashfs-next-git URL listed in the MAINTAINERS file.
> 
> Unfortunately that squashfs-next.git tree is unused and twelve years out of date
> (last updated 2014).
> 
> See
> 
> https://lore.kernel.org/all/267938f6-8212-4ddc-9055-452f9d166010@squashfs.org.uk/
> 
> and
> 
> https://lore.kernel.org/all/anUi3bkwfM8teo_R@debarbos-thinkpadt14gen5.rmtusma.csb/
> 
> 
> But as it stands your patch and mine are going nowhere because Andrew won't
> pull any patch that has not passed Sashiko.
> 
> See
> 
> https://lwn.net/Articles/1064830/

Geeze, that's very overstated.

If Sashiko can't review a thing then that's annoying because sometimes
it finds bugs.  If it does review a thing and claims to find
significant issues then I want to see the developer or maintainer
explain why things are OK.

If you the maintainer want the patchset merged in this situation then I
have no problem with that.

> 
> I'm going to resend my patch with a base-commit: tag to see if it makes
> a difference to Sashiko.

That would be interesting.

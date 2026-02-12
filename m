Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CCC27FD56
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924176; cv=none; b=Fg7L2Wg9tL3ag2uavsSkncwlvF1EYuvgQ9YqPtV1Zy/FVh6L7pDUouciLqHQl/oyNRAdt/cJ3PnHY5FIaY9xtkUt1mnKX62+GNsjbeVxTKiWWRuShVS4vxYgnfsdLQczKvtd8PYfJAN6CVwM7OXV7yHZXHh6dm0h2xxjTgHAZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924176; c=relaxed/simple;
	bh=/C71skHDmJFn28pRqzn2A6eLiRSQ7aYAuezeLEtkcSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgV2ichHGRdFWznFjBQLJ1LOdrjaYq+lA1SJo1YFLfcl7chYHx7brc4Aya3R+l7VSAtg8LdDMi00LNMOY3snqWCilIm7VyeF8/UCnNrOJ7nM8u77Qeym3o4wdvSsIzEh/gCAYVMFo0P2nLhxz7CphvAkDK7Lvct4FcAZI4DPW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dgyg+pO9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dgyg+pO9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MyMBEjN9uvLNzW7L5IL3dE8UthJvMUe23rnnjjvfbSg=; b=dgyg+pO9PVj7j5O2dnt2arHrFv
	LVV4sH/w0V1Tp/aPwq9A8NxNa7EVIB4FetzulFKcdnbfai4CYBXj++XktdlQhuGwQ8BtbuHPiYhWZ
	ThcwYUSC7bwt1zTN7YjJQeVkbbrDoPyyW5FZhLLvNtg8JWrLYOhHJEy36yr7VWt1fAwGSShEwP77Z
	RBZrWyYA7fvO6x0OocbxomBKPfOYojzC39ttTHnOqCLGbkjvAUFKhvmAzDGZnuX/DpvNTKDxWZPgx
	bBzC1O+zajpZfohS4cNxTuGgNq5O+hFQ4Q9i44gkvUZZ34Ky5hZvv7N/Mvg6ZrVvnyptzQwSW21vL
	kcFXVWGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vqcJI-00000005qC2-27Jm;
	Thu, 12 Feb 2026 19:25:08 +0000
Date: Thu, 12 Feb 2026 19:25:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Askar Safin <safinaskar@gmail.com>
Cc: christian@brauner.io, hpa@zytor.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260212192508.GP3183987@ZenIV>
References: <20260209003437.GF3183987@ZenIV>
 <20260212132345.2571124-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212132345.2571124-1-safinaskar@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 12, 2026 at 04:23:45PM +0300, Askar Safin wrote:
> Al Viro <viro@zeniv.linux.org.uk>:
> > The interesting part is whether
> > we want to deal with the possibility of errors at that point...
> 
> You mean that finding topmost overmount of root of namespace may fail?
> 
> Current code in mntns_install indeed can fail, at least theoretically:
> 
> https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/namespace.c#L6243
> 
> But I argue that this line is unnessesary and should be simply replaced
> with call to topmost_overmount (which, as well as I understand, cannot
> fail).

The pathological case to consider would be something like e.g. NFS root with
referral right at the place we are mounting...

Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517391DE8AD
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780865851; cv=none; b=B5nEFnuKUD44Zmeb69sHzEFQysGGgAAZ0YvxVyIsO6J5KiuNlO6hwRngwB3/5KvzprZy1X8X9Q7nMdXC9H1F3oIZ1jXDwdRD+Bhhb3DpYbKYdRwwPsU0wZQaFvdaUP47Ypb/gF2c/9rJ/2upaXErSk44cfjNpr9Sd7MPapu+KvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780865851; c=relaxed/simple;
	bh=B/sZVvAFXdE6Bx1i/RUTN4ZrzNDzrsaCqVA7xoOqA0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs/ElkEps4IuFCE0Eih9L1TF/2PnQD43ugQviuHcvPGlOf1bIO2a/dk3PEaxlmTi+UocsP3/AOXv12N4lTUSXNLXZvqx2LfotuxBh/sEniarCs0vjMhB6g2s/CN9d+mQ9Amv2Svf86lg4ebwO15W7/uOC+oAPx31xXOS74DibiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=jUWyvFwx; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="jUWyvFwx"
X-KPN-MessageId: 788d0502-62b3-11f1-96a9-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 788d0502-62b3-11f1-96a9-005056abbe64;
	Sun, 07 Jun 2026 22:57:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=xlUmDG2nlDW4848cVrZwRBD696dw89A3xToKVOP2e/0=;
	b=jUWyvFwxFBLevPNuNhZzYMh1J/DMOjVyk21gdbxlU1u/6SUf7fs7f9b7tdKftbIGBUmNyy9hdjSu2
	 +DvUZRQr/yxupWxV9BUPfdc5wijxOrpqQ70qNhTH+0Bzt87mlKutEhitn71ltzqx56ARsBf3VgbIZB
	 QnMGfYER4T0dTAureOfFe3avHJRXRlBtGQzTqXXkThnKmRgccr3zYdNqXnsLWD1pbFLNtTDiN34QpL
	 6RHxNkFonziqSyet0URPPxujl98Au0gtuI9K+3q0TuOytd3/6+OsAH2XPW/CmAaHVWH9VgV6aa4nJq
	 GU9SmtVylvcR+xZz4Xuuh5Eb3f+gNGA==
X-KPN-MID: 33|I6LvFKtO1/NFu1Q8+EZrhwkCiekSZq3o/g4C1e2ZhAhJAr45OFqXWpFkttGcHcz
 11g2B9Ez4yzibwUoMnLxwT5WrmetNsqOCH9EBGZ17LpI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|oknSqWqjgHPSYNouYsAAFHMWTPeZDpPRo95rdBFgTcT6wU2i/vWc1ydw0YQ1JO/
 2xhx4egmAgz88NSAki0jVbw==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 78661918-62b3-11f1-a6ce-005056abf0db;
	Sun, 07 Jun 2026 22:57:18 +0200 (CEST)
Date: Sun, 7 Jun 2026 22:57:16 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] Maintainership of the EFS filesystem
Message-ID: <aiXXi3mqIcHSo7lS@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Maxwell Doose <m32285159@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>

On Fri, Jun 05, 2026 at 09:52:19PM -0500, Maxwell Doose wrote:
> Hi Christian, Al,
> 
> I recently sent a patch for the EFS filesystem [1]. While writing that
> patch, which fixed code that was now incompatible with the latest GCC
> (+ an undefined variable), I discovered that the EFS filesystem was
> orphaned and without a maintainer. I inquired with Andrew Morton, the
> person who merged my patch, about potentially taking over
> maintainership for EFS. He noted that he was fine with it [2], and he
> directed me to Christian regarding this possibility. As the subject
> suggests, I'd like to take over maintainership of EFS, if it's fine
> with you all.
> 

Hi!

Thanks for looking into EFS. I am not sure whether it makes sense to
have a maintainer for just EFS. The only reason this (and some other)
old filesystems are still in tree is because we don't really know much
about their users. Linux strongly emphasizes stability of user space, so
we don't just rip them out. Ideally, they should be replaced with a FUSE
driver and removed, but no one has stepped up to do this (for good
reasons).

What would perhaps make sense is to have someone maintain API
compatibility for all old filesystems, to unburden the vfs maintainers.
This maintainer would just be focused on ensuring that modern API is
ported, so that the old stuff can be removed. But that does require some
expertise while it might not add much.

Thanks,
Jori.
> -- 
> best regards.
> max
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/fs-efs-remove-unneeded-debug-prints.patch
> [2] https://lore.kernel.org/mm-commits/20260605193524.f277071da69189161e84e327@linux-foundation.org/

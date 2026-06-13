Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714E423C4E9;
	Sat, 13 Jun 2026 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381282; cv=none; b=GnEj59ydh/gTCnirqAmHoJFaranmvUjsKzu7FUigwsN6x0L1u8f+WmbllOtzsvuPGHu2fFo4BwEvYybCWeIhPC5ty4JftluMHoYGHyE0h/Jglgeoew6PFXqhVrvrqqdj0r1r0mvIZzACLaBPmcyswGNhTOQ36/8Vhv6YIyD1oD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381282; c=relaxed/simple;
	bh=aqWGCg6it9Yd7sq2hpspoN8vCgsRojtXqzQf2n4KEOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9t6ZuGO5pz+hak+0fWB4UlsQ3Yu26qC9PPv7Ie5aEInlErmY+uJrz1GSfuXBXqNurhoDR+HDU/HGQrBdsfhmGMKEqo0/kvIrH8p3qGMbkaCVd03l/yFDQ+elPhpVE+bDzC8R2PhV79KU/rJyJzVUrQc5FVe6UGTDQ7zyCEONFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLyPQbkm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLyPQbkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6421F000E9;
	Sat, 13 Jun 2026 20:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381280;
	bh=nsiL3MJM4m4xNhTHLRxjqyydr7sCcW3k5PyoiLnAqvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QLyPQbkmL1+F+IdnwqelDQn2+UaYDxeMMPkT8+SCWhHg6sPF2xI9IYFwF2svZDQSU
	 JYIJjVQTJik7dW1GC3JMjYe7bP2o2yoiczATWYT5yZsqIsS33VmMOu2o3Ql9W5McKX
	 UMyWqBrwplRX4QG94lPot0VPLyKuFrKiNJZ99TLSRvp11/VDYvwmHE0UMKi6Y6rY7C
	 qW5b7+h6TyISF3JzJqMiR9YkRhx4lO6yD0R+SQTqrqP5P3o+A2AOEVp1DMSp2qVhWL
	 KXB22btm4vXKPRWF0++Xad8NF884Ms1ZZgv5OHLpgpHa4otXdOovXaoIzZ9ml1XoJc
	 mY/IjvzrkCLLA==
Date: Sun, 14 Jun 2026 05:07:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Wei Yang <albinwyang@tencent.com>, 
	Zijie Wang <wangzijie1@honor.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: only bump parent nlink when registering directories
Message-ID: <20260613200637.GA3447336@rocinante>
References: <20260612153031.536525-1-kwilczynski@kernel.org>
 <ac6b0e86-468d-4806-a9e4-60df0efdfcef@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac6b0e86-468d-4806-a9e4-60df0efdfcef@p183>

Hello,

> > --- a/fs/proc/generic.c
> > +++ b/fs/proc/generic.c
> > @@ -404,7 +404,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
> >  		write_unlock(&proc_subdir_lock);
> >  		goto out_free_inum;
> >  	}
> > -	dir->nlink++;
> > +	if (S_ISDIR(dp->mode))
> > +		dir->nlink++;
> >  	write_unlock(&proc_subdir_lock);
> 
> nlink accounting should be folded into pde_subdir_insert/pde_erase
> probably but as minimal patch it's OK.

I will follow-up with a v2, then.  Thank you for the review!

All the best,

	Krzysztof

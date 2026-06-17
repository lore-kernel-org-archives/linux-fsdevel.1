Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D285373BF3;
	Wed, 17 Jun 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718011; cv=none; b=g5nCsP9CABWbmRBrG1KPfIGZhzGGdfN/Rkmaal3xi6DePvYdCCVFTTVdcnMtQeB0jvgDngQq0Bacl1xS+oXbbkgkDEKLAXaZvLBmxOmXZGmYOhgXOMM5+zgQkuKx15vhcOpcyLmHrwaFfNUyswdgJ4rw/ELDP6aOrphURr/yQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718011; c=relaxed/simple;
	bh=Q3EppVyIAzldDQeHiU3GGZ6sXK225mcvQcRPFOwTh4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK3VKIeWZuo0xlchCob1fRNVt1eYue0A7nJkfD+X0lhPKWKLRMfrsVRzoYzTYNPP01Ur/RwecGG8TuvU6dx4wDmd0xNThYtLqdc+Lu1bC5ivkDScjZlGiCVaAAjOtsMbcUWI1ctfN2+KHNR8McT2wNdU4/akr1g1HftQxjL9fJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nP/QGtCh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nP/QGtCh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PcW4yhsbJNIlOdOi8liKCG9YkTC2sUqTdvuc+EIeHNc=; b=nP/QGtChpgkRPa4/SQ1WwGzAC3
	92Tq4lsvWGLvQipc2LHXpzFKKDCVup7fngr5gP9iK5DEpXVcHOK75kx0ZFGs2i0oESJ9mk/AhMTU0
	avBN/ST7/fmpTnNUZy0ASqFhyi256Gt5Mik9OFXOKn+l9FqupYfVuyA0Er157yVUY6ErcGi+29LUu
	9teT0zOZUz3orDT1lvy/WRA8t9SEfbQbRR7l4FDOsQWlmsskSoxL8z+8Gl3AGxgabwTEM7uP2XfLh
	lF9HUVtbqZeC519k4dzQALFlQuEuWa3a69blcLT47+c7ZV/RjIxEx+y3JqAV8v/d2PtYd+haO+2l3
	m8+O9v9w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZuF1-00EmvQ-16;
	Wed, 17 Jun 2026 17:39:55 +0000
Date: Wed, 17 Jun 2026 10:39:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Josh Triplett <josh@joshtriplett.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk, 
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Message-ID: <ajLWi_3zqo9uqkWc@gmail.com>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost>
 <ajJgWBCFYwz9OIo3@redhat.com>
 <ajJ1Xi1p9UhQvILi@gmail.com>
 <rlios6fzl4xc2p57aurth2bpt2iflskf6crabqi4u45f6mejbm@ekxu5ua6wa5c>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rlios6fzl4xc2p57aurth2bpt2iflskf6crabqi4u45f6mejbm@ekxu5ua6wa5c>
X-Debian-User: leitao

On Wed, Jun 17, 2026 at 05:01:04PM +0200, Mateusz Guzik wrote:
> On Wed, Jun 17, 2026 at 03:23:54AM -0700, Breno Leitao wrote:
> > Measured it to _just be sure_, 1-byte ping-pong (perf bench sched pipe -s 1):
> > 
> >     baseline:  2.674 usecs/op
> >     patched:   2.710 usecs/op   (+1.3%, within run-to-run noise)
> > 
> 
> Can you try this:

I've tested this change, but the results show no real measurable
improvement beyond measurement noise.

	patched + your change: ~2.66 usecs/op   (-1.7%, within noise)

In my experience, branch hints haven't proven particularly effective, at
least that was the case when I worked on PowerPC some time ago.

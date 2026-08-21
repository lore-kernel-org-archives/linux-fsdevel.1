Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7C43B3F5;
	Fri, 21 Aug 2026 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325551; cv=none; b=OvYb/2UHQf2elYTvqUf6L/wVD6MAP/dZGoaCCqNLjyFz5XubJHTexCpgv7+6mE7SY/Lfwhhxc5GWPceunngzE47NP1MboGmZauBg+qKTL5n7p6E6E8khZn1A9nGYATU0YSmgKqa3pV0ebAINmYO6+jCVLJPNQnC5RZDf0fam0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325551; c=relaxed/simple;
	bh=DgvivRGfuO7pmPJ+C4WzaSQrVKUkmZqrVNcqR7Bx/t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG+C4G6bTOGLJ8lPbyvKlCJoJWYe8c9nUYL9Q0AwkTwofsoyWr4j/6liXK0HNaWx8u4UWVcyWmH5I4W1zbn6VvnW67uSAQLn3ArBRMWvGVvvbvS9UAEcIROGIRuEBOefVkcvSxrRMASrChSTpYfMp9faK2hfLI7ByJBr9WNhYV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qer0+X9/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qer0+X9/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Su9KgWL2onkGSwDtlDmPuaX1T/I/VKpTVIzc0TrDrBw=; b=qer0+X9/Z7BpQqiVV3fPeRwHoQ
	HD3GiQFVB9g37fijIo+LwAlvbQSJh+7Yo24Bvmn1T+sySxFAhJPw7ucRL72Y+Z/Nc2KQ+3hzk7JDl
	DpFEvJcNBtDVnmBsNxWC8EW1lOB9FhMqUWvGHKeYc/nROoRcYyB0gthUTuoCJVazc0mm5H/fkp0Ue
	tirT1bU+quNUVo2GoGNtNZpurTSk5iFG5glYR1T0ToXW0R8Vb4dNc+uft/9Plo03NnH7l+CqYzyNG
	LVPXVDkgGBklXHKq4hE6npoSdstZe6dVY6rAwwPC2d6IQpKrGQWOq0vL+gaHprOF4FrqZjcmJOmav
	0I2S+8sg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQgr-000000002G8-2ZWU;
	Fri, 21 Aug 2026 14:57:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B5F853006FA; Fri, 21 Aug 2026 16:57:52 +0200 (CEST)
Date: Fri, 21 Aug 2026 16:57:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
Message-ID: <20260821145752.GG687043@noisy.programming.kicks-ass.net>
References: <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
 <aobDGgivy43cz7xQ@google.com>
 <20260820091018.GA4120091@noisy.programming.kicks-ass.net>
 <aobGRjc7SE1rwIHu@google.com>
 <20260820093402.GB1837346@noisy.programming.kicks-ass.net>
 <aobKfyGHkdMcleoc@google.com>
 <20260820104111.GC1837346@noisy.programming.kicks-ass.net>
 <CAJfpegsSzOqs1zkhB9GZxsT5HT1zXDbHsZNEbA7P7mxe0w2dng@mail.gmail.com>
 <20260821083000.GF687043@noisy.programming.kicks-ass.net>
 <CAJfpegvRw0Emd=2hsEeg3AvYaLgRBUbMdo-=eUMa3FRFfnetgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvRw0Emd=2hsEeg3AvYaLgRBUbMdo-=eUMa3FRFfnetgA@mail.gmail.com>

On Fri, Aug 21, 2026 at 04:33:57PM +0200, Miklos Szeredi wrote:
> On Fri, 21 Aug 2026 at 10:30, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > That would be adding conditionals to the mutex, something we all pay
> > for, always.
> 
> It's just one bit (could be stashed  into LSB of ->first_waiter),
> Condition is checked before going to sleep, i.e. adds one branch in
> the slow path.  Don't think this could be measurable.

I suppose I'm not at all sure how it would differ from having
mutex_lock_freezable(), or how it would help in this situation.

> > One way would be for each file op to be wrapped like 'link-$op-unlink'
> > such that the client (the task doing the file op) gets linked to the
> > server (the task responsible for satisfying the request) before it can
> > block, and unlinked once its done.
> 
> Okay, how do you know which task or tasks are responsible for
> satisfying the request?  That's not a generally calculable
> information.
> 
> sshfs is a simple example: the transport layer process is ssh, but it
> is in no way involved in fuse transactions, there's just a pipe
> between the two.   How would the kernel know it has to link the ssh
> process when the pipe is written to?
> 
> There are probably many such examples where this fails.

Well, it was 'your' (as in not me) suggestion to have a freeze priority,
which sorta implied you knew what tasks to apply it to :/

Anyway, I suppose that in this case the fuse server is responsible to
communicate this dependency to the kernel -- or the sshfs fuse server
should use libssh and embed the ssh client inside itself, instead of
using pipes, dunno.



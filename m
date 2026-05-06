Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EF4014BA;
	Wed,  6 May 2026 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075749; cv=none; b=dWEKTviDtcDHzJYY7lZ/m76oUF/UspgZXzzQgOxKcvFw6IyHMkF71y25gqKvQP+LPiIjiWaL37HNG4b6gI2awtI/3Cn2MSVsjcp6jpNHnx/Akjg21nGdf9Bo466z0OfvwA6Q1F4VpqzPKGZpo66WWn4aOdEKFQQfUuQedIBoYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075749; c=relaxed/simple;
	bh=+BGH21eRCiqslskfiMQtWdoKqriFkp7jcSChuoDS8Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgiPpJz2vC6YvG7u6OuaSFO/9Ny5UWHHqXQ/bdBo0H3g+i6wMTyNZKIdmCgdXT3n8K6dRf1Ljz+s3IJVs23oDdv8/PQ5q3uz/MTRvBpqKxEHNdN5bgflQzAO+DT5mqbxV6GYbPR0149xayTbSacV3CVaCzgkLDL2l1gXaYa/ANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=s9RKGg2G; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="s9RKGg2G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Av5M/B5ze2twIEZd2rJl43+3GaOAGwGe2WHT+o2E1k=; b=s9RKGg2GEepirdTFoL0yGucqFK
	k0sZspUzQuF32zybq+o0PoUT7b3Dlkg43hGDhfd/ltJX2YGyGi6jDl9EUop3z/VWOYjYvPqYxhJP8
	LOSEXTLg4JmCxsKAYOJS4vDVUBQ/epBRgczwY/+YkI8z4Ny5kl7EqSiCJ9WAQ/U0WC39TD2xE/fVS
	FygnBo3R36X197Dbpzq1ROF2A6sDNVbwS+TfgtqfN/GxiwWX9M9kzCjfaPgsRpl+FALVDIQBBPrjL
	CSbTUeMYSbloIFjAPgWobPEkpPKPkCuelDu2OPfW5LtbZF2H36BlB0PBPSC/atXvElJ9deCY5WJaM
	sZmN0CGw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKcin-003dYA-39;
	Wed, 06 May 2026 13:55:30 +0000
Date: Wed, 6 May 2026 06:55:25 -0700
From: Breno Leitao <leitao@debian.org>
To: brauner@kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, clm@meta.com, kernel-team@meta.com, 
	jack@suse.cz
Subject: Re: [PATCH] fs/select: reject negative timeval components in
 kern_select()
Message-ID: <aftIFyQuXcR2Vop4@gmail.com>
References: <20260429-timeval-v1-1-4448e2588bbf@debian.org>
 <gyswxhot4ze7u47kxhljzcwd4bjvutq5yrwlir5x37ulry2grc@52i7icjp6rki>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gyswxhot4ze7u47kxhljzcwd4bjvutq5yrwlir5x37ulry2grc@52i7icjp6rki>
X-Debian-User: leitao

On Thu, Apr 30, 2026 at 09:33:01AM +0200, Jan Kara wrote:
> On Wed 29-04-26 06:09:37, Breno Leitao wrote:
> > kern_select() normalises the user-supplied struct __kernel_old_timeval
> > with
> > 
> > 	tv.tv_sec + (tv.tv_usec / USEC_PER_SEC)
> > 	(tv.tv_usec % USEC_PER_SEC) * NSEC_PER_USEC
> > 
> > before calling poll_select_set_timeout() -> timespec64_valid().  Both
> > operands of the seconds sum are unbounded user-controlled signed long.
> > A crafted pair where tv_usec is a negative multiple of USEC_PER_SEC
> > drives the sum across the wrap boundary - e.g.
> > 
> > 	{ .tv_sec = LONG_MIN, .tv_usec = -1000000 }
> > 
> > yields sec = LONG_MAX, nsec = 0, which passes timespec64_valid() and
> > then flows through timespec64_add_safe(), which saturates the absolute
> > deadline to TIME64_MAX (clamped further to KTIME_MAX downstream).
> > select(2) therefore blocks effectively forever instead of returning
> > -EINVAL as POSIX requires for a negative timeout.
> > 
> > Only the legacy __NR_select syscall takes this path.  pselect6, ppoll,
> > poll and epoll_pwait2 all hand the user's two fields directly to
> > poll_select_set_timeout(), which validates *before* doing any
> > arithmetic:
> > 
> > 	/* fs/select.c:271 -- the validator */
> > 	int poll_select_set_timeout(struct timespec64 *to, time64_t sec, long nsec)
> > 	{
> > 		struct timespec64 ts = {.tv_sec = sec, .tv_nsec = nsec};
> > 		if (!timespec64_valid(&ts))
> > 			return -EINVAL;
> > 		...
> > 	}
> > 
> > 	/* include/linux/time64.h:97 -- timespec64_valid */
> > 	if (ts->tv_sec < 0)                              return false;
> > 	if ((unsigned long)ts->tv_nsec >= NSEC_PER_SEC)  return false;
> > 
> > 	/* fs/select.c:744  do_pselect() (pselect6, pselect6_time32) */
> > 	if (get_timespec64(&ts, tsp)) return -EFAULT;
> > 	if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec)) return -EINVAL;
> > 
> > 	/* fs/select.c:1097 ppoll */
> > 	if (get_timespec64(&ts, tsp)) return -EFAULT;
> > 	if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec)) return -EINVAL;
> > 
> > 	/* fs/select.c:1065 poll -- timeout_msecs is int; >= 0 gates the math */
> > 	if (timeout_msecs >= 0)
> > 		poll_select_set_timeout(to, timeout_msecs / MSEC_PER_SEC,
> > 		                        NSEC_PER_MSEC * (timeout_msecs % MSEC_PER_SEC));
> > 
> > 	/* fs/eventpoll.c:2512 epoll_pwait2 */
> > 	if (get_timespec64(&ts, timeout)) return -EFAULT;
> > 	if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec)) return -EINVAL;
> > 
> > In every one of these the wrap-prone arithmetic from kern_select()
> > simply does not exist; the user fields reach timespec64_valid()
> > unmodified.  glibc routes the C-library select() through pselect6,
> > so the bug is reachable only via a direct syscall(__NR_select, ...).
> > 
> > The pre-validation negative check that used to live here was lost
> > when the syscall was switched to the poll_select_set_timeout() helper.
> > Restore it: reject tv_sec < 0 || tv_usec < 0 up front, mirroring what
> > glibc does in userspace.  do_compat_select() has the same arithmetic
> > pattern but is only reachable on 32-bit compat and from a different
> > syscall entry; left for a follow-up so this change stays minimal.
> > 
> > Reproducer (returns -1/EINVAL on a fixed kernel; blocks indefinitely
> > on an unfixed one):
> > 
> > 	struct timeval tv = { .tv_sec = LONG_MIN, .tv_usec = -1000000 };
> > 	fd_set r;
> > 	int pfd[2];
> > 	pipe(pfd);
> > 	FD_ZERO(&r);
> > 	FD_SET(pfd[0], &r);
> > 	syscall(__NR_select, pfd[0] + 1, &r, NULL, NULL, &tv);
> > 
> > Fixes: 4d36a9e65d49 ("select: deal with math overflow from borderline valid userland data")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Looks good. I just wonder whether we shouldn't also check that tv.tv_usec <
> USEC_PER_SEC. But in any case feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
 
Christian, do you have any concern about this patch?

Thanks
--breno

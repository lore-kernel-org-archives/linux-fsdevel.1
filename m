Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07903EC6B2;
	Thu,  8 Oct 2026 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452537; cv=none; b=Nyb7YeAl9EGarOTuh+NdgC6TJr5RO2h4BaR0gCe4YM2UBKDPn3KUIT5kWjZru7SOzSnBbciWcMn2NpBYQ2KAoxr0LqTV6MHOYalY4iHfHn9H6N0PGpFnJ8Y1pgA1UC3GxEnnJM2iAK80+UXRmvL8FhMpNRAdF52g9v8S9Ps1VIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452537; c=relaxed/simple;
	bh=FyTtv6VHLYudm9aZT17T8hYcWkfbRZYWOtDIqWaLhog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADqRkhvuTzQiep38DzA28sezWYKQFDGyuHqjMXdRbhYVDhc4Hq+4RfRKwmRR/r20uj5iAo6c22xg4faNxlSVhCpx+r7eKUQh1J7MGvDCBSTtiJzOowiKCH5NnGljZJXwrsdTr5q3MS2PQ62+VXynRMAMYPt2JuT3OIn1MlQscpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QRvrbIjB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zOY+D+bb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QRvrbIjB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zOY+D+bb"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F93821BEF;
	Thu,  8 Oct 2026 09:42:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791452526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G50XP/ynVQ52FiYWUnLkgX1p7U+DkDWuSaDmmCm1Xg4=;
	b=QRvrbIjBU4O62jpsYU1SL67q6xhUoG245eN1sAESs3+U/6oaeYt5E61SL3kGFbrz24dYxS
	nKIqi/qMPH2M/HIGa3T2Af0z9h1cZqJHURAE5YoU3sERBR5wavqYRsf+M9QAYM/w2DCCda
	BcIkWHOPDQK16vPDTJ5Luwe4oM1k62w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791452526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G50XP/ynVQ52FiYWUnLkgX1p7U+DkDWuSaDmmCm1Xg4=;
	b=zOY+D+bbTBMIt8QPBOLbUkaldv9SxUPYiX5roE8pp4BikzidwJFjD6Bdmvv7Lu1Ol4OBoZ
	GLA5FQmQ283jcXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 588CD13354;
	Thu,  8 Oct 2026 09:42:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ot8nC25lx2q2DwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Oct 2026 09:42:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D1451A13FC; Thu, 08 Oct 2026 11:42:05 +0200 (CEST)
Date: Thu, 8 Oct 2026 11:42:05 +0200
From: Jan Kara <jack@suse.cz>
To: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
Cc: jack@suse.cz, amir73il@gmail.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] fsnotify: Check parent watches without child dentry
 flags
Message-ID: <qlw6x3hyky5yoievlkd6ylz3ov432hdjlzkcyboswqktnk43il@fvccpqnil5sp>
References: <cover.1791373689.git.partha.satapathy@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791373689.git.partha.satapathy@oracle.com>
X-Spamd-Result: default: False [0.00 / 50.00]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 8F93821BEF
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: 0.00
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed 07-10-26 15:20:50, Partha Sarathi Satapathy wrote:
> This patch removes the cached-child dentry walk performed when a directory
> first starts watching child events. Instead, the event path takes a reference
> to the parent dentry and checks its child-watch mask. It also removes the
> DCACHE_FSNOTIFY_PARENT_WATCHED flag and its update sites.

If we can get rid of it, it would be a nice simplification but I have
doubts this is feasible.

> On the test host, 12 million files were populated and their positive dentries
> were warmed before each run. With eight concurrent unlink/recreate workers
> and 100 sole-watch add/close cycles, inotify_add_watch() measured:
> 
>                          Before                After
>   run 1 average           107.420 ms            0.004 ms
>   run 2 average           125.433 ms            0.004 ms
>   run 1 maximum           122.811 ms            0.113 ms
>   run 2 maximum           141.198 ms            0.095 ms
> 
> The displayed 0.004 ms averages are rounded to three decimal places.
> Maximum unlink/recreate latency was 777.852 and 770.569 ms before, versus
> 8.525 and 15.624 ms after. Those mutation maxima are supporting observations:
> workers ran only during the watch-add loops, so the pre-change and post-change
> mutation measurement windows had very different lengths.

This looks good and is kind of expected. We don't have to traverse the huge
children list.

> One 100,000-iteration, single-worker open/close event-path run per mode gave:
> 
>                          Before                After
>   none:   p50/p99 ns      9564 / 15703          9684 / 15023
>           throughput      102221 ops/s          101432 ops/s
>   other:  p50/p99 ns      9554 / 15573          9684 / 14962
>           throughput       99442 ops/s          101497 ops/s
>   parent: p50/p99 ns     12529 / 19179         12499 / 17716
>           throughput       78196 ops/s           78655 ops/s
> 
> The 'other' mode watches a different directory on the same filesystem, so it
> exercises the superblock watcher path without target-file event delivery.
> These are single runs; they do not establish a small event-path cost or its
> absence. No open/close regression is apparent at this measurement resolution.
> The test used worker CPU 2 and listener CPU 4 on kernels
> 6.19.0-rc8.V_fsn0.el9.omm0.x86_64 and 6.19.0-rc8.fsn3.el9.omm3.x86_64,
> respectively. The test host reported XFS for its working directory.
> 
> The inotify correctness test and broader fsnotify functional test passed on
> both kernels. The fanotify permission subtest skipped with EPERM in both runs,
> so FAN_OPEN_PERM remains unvalidated by these results.

This isn't a load for which the DCACHE_FSNOTIFY_PARENT_WATCHED optimization
is that interesting. Try the following:

Create a directory on tmpfs with say 1024 files, each 4k large.
Place IN_MODIFY inotify watch on the directory.
Start X clients (where X can be 1,2,4,8,...,1024 to see the scaling)
  The client will open the file based on its number (so different clients
  work on different file)
  Do 1000000 writes of 1 byte at offset 0 to the file => measure time for
    this
  Close the file

I would bet you would see the difference already at 1 client and as the
number of clients grows and the cacheline contention on the parent's
refcount increases, it will get progressively worse. In particular if you
try on a NUMA machine where the cacheline will ping-pong across NUMA nodes.

We've got performance regression reports for similar loads already when we
added one cacheline load to fsnotify_parent(). Doing the "grab parent
refcount" dance is much more expensive than that.

								Honza

> 
> Partha Sarathi Satapathy (1):
>   fsnotify: Check parent watches without child dentry flags
> 
>  fs/dcache.c                      |  4 --
>  fs/notify/fsnotify.c             | 99 ++++++++------------------------
>  fs/notify/fsnotify.h             |  6 --
>  fs/notify/mark.c                 | 35 -----------
>  include/linux/dcache.h           |  1 -
>  include/linux/fsnotify.h         |  7 +--
>  include/linux/fsnotify_backend.h | 29 ++--------
>  7 files changed, 29 insertions(+), 152 deletions(-)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F61DED42
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.141.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790485540; cv=none; b=Ywn/n82XQOWbhztJHhCQGUoB0dOlUZpBkbYy45tuOqsydBWmaEXALtdZjNi4WbQFzzr+X4K0vnNIE3oPbHoiYtH2Qql2uCRYgdfMcSqYgISsNfYybVqibyJcU+ZKlaA0XHRnTJqTfaSItVRcIUEgY35lUFxaUFP2zdF6CgvzA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790485540; c=relaxed/simple;
	bh=zn6BbkJEhFs23Eo8RTaeJTaWbmcol9R1A4YoAun3TPQ=;
	h=From:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 To:Cc:Content-Type; b=gkL8vAoIIDP/3gzJuuAGgvQhDrbzLRmhT9MwtRlTE6nvB0zuShWDjyy52KM+iZa0u/ygDKt8IwoxgFOIMruf1AQ/iYd0Pkh7eJLuC1d89o1Q2buYfLE/58pVEkuwhtcglV0JWduj8zQxPXnZVDGumMgvNvrp+1kC/tkkVFrQGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io; spf=pass smtp.mailfrom=em.honeycomb.io; dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b=Lj8ltAs+; arc=none smtp.client-ip=149.72.141.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b="Lj8ltAs+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:subject:date:in-reply-to:references:mime-version:to:cc:
	content-type:content-transfer-encoding:cc:content-type:date:from:subject:to;
	s=s1; t=1790485538;
	bh=dIu+uxKxmBTiRyBhXA1GHtsbpyALmF82c9dDMDeUaVQ=;
	b=Lj8ltAs+d5EL+778uG8F9Mx1M0sZ2Ak8Ji2qpHMKj7CMjfifTKYdmPt6L+LuvU8ZjHgq
	tPSbPX1nycDrJQCIkmkBGTpQwLN6JeSbhdWpLUZ+Gw5IT+1IfaNFPFdgxhG0gaLg0PhiYC
	leNkSNhy5qgTbyy5YwoMl6iUe/S16UZei/2huaXSsYfjRHKtWe3a5tEaCMqOVRiL5wXizg
	hbdSvamDV3H4VhnxUxJY/SfaSJrgKuPP4KVgMwzNywW6lI5qYw3xZiQ40ZpjlRQAJahDy4
	Ic5dHk3gJNDUnIlPqU5zZDHWIMoiK860jMzHU1AON6WK+Wg/ddJSot2wf4oBhPoA==
Received: by recvd-54ddf9bf54-45v4w with SMTP id recvd-54ddf9bf54-45v4w-1-6AB8A422-13
	2026-09-27 05:05:38.117618214 +0000 UTC m=+206484.562045752
Received: from daisy.dens.ffj.family (unknown)
	by geopod-ismtpd-11 (SG)
	with ESMTP
	id nWB_4sVCTZa2RdD_Lk-VsA
	Sun, 27 Sep 2026 05:05:38.057 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: Re: [PATCH v2] writeback: size foreign flushes by target wb dirty
 pages
Date: Sun, 27 Sep 2026 05:05:38 +0000 (UTC)
Message-ID: <20260927050537.1117140-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924065443.1650126-1-yinxin.x@bytedance.com>
References: <20260924065443.1650126-1-yinxin.x@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmeQ2gdCcmbq0l?=
 =?us-ascii?Q?lGZMO8UHa=2F9Ew5Yxmb+YDm=2FpHpETUS9Pt5VXOiF?=
 =?us-ascii?Q?sk2Sy4Vnub50aQIlZ2SvrmetiPadB77p=2FkUPPLG?=
 =?us-ascii?Q?I4M4aPNcAiRbW0IHSBpbUMb691qG37Flv=2FxCGNv?=
 =?us-ascii?Q?1FSeM16bUGYFjZQZNvloacNtOQWNOyFo0suGhP3?= =?us-ascii?Q?TyQC?=
To: Xin Yin <yinxin.x@bytedance.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ian@honeycomb.io
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, Sep 24, 2026 at 02:54:43PM +0800, Xin Yin wrote:
> Use the target wb's WB_RECLAIMABLE counter and keep the existing 25%
> headroom.

At Honeycomb, a container that reads from Kafka and writes columnar
files to a host volume stalls for 30-60s after each deploy replaces it
(v6.18). This is likely the cause: the stall looks the same as in our
reproducer (little CPU use, lag growing linearly and then recovering),
though we haven't traced it in production yet.

I tested with a reproducer where one cgroup appends to 1000 files at
250MiB/s and stops, then a sibling keeps appending to the same files
under a 4G parent limit. With the old cgroup kept alive, worst lag
behind schedule over 120s, three runs each, arm64 KVM guest:

  b53f422491af (parent)  9.4s  3.0s  10.7s
  168a8c13159c           1.0s  1.1s   1.1s

Tested-by: Liz Fong-Jones <lizf@honeycomb.io>

When the old cgroup is removed, which is what a restart does, this patch
alone doesn't help: wb_get_lookup() can't find the dying wb, so the
flush fails with -ENOENT before the sizing matters. My follow-up fixes
the lookup. Worst lag in each run, this patch alone and with the
follow-up on top:

                                       this patch         + follow-up
  old cgroup removed, 1000 files       85.3  46.9  52.1s  1.1  1.0  1.1s
  500k files, synced before removal   115.3 115.3s        1.5  1.0s
  500k files, pod cgroup removed too  115.9  47.5s        1.0  1.0s

  https://lore.kernel.org/all/20260926-wb-dying-cgwb-flush-v1-1-a8d898085a3a@honeycomb.io/

Christian, could this one get Cc: stable as well? Both bugs date back
to v5.4.

Debugged with Claude Opus 5.5, which ran the tests; I designed the
experiments and reviewed the results.

Thanks,
Liz

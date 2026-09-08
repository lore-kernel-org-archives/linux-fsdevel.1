Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66537CD33;
	Tue,  8 Sep 2026 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896826; cv=none; b=NUHSmgsZi1sPC3AdSNP8v7F0BlFp6eWLoDfWR1Lw1JggkcWFoQdBzN57j6bBBeYlU0RX8bYKudyZw6z5Z/EWSEgu+ek8kONbg2OsdpfXq27uUrkGllM0rfYyi99FABq8DvJ8wSdlnNXU3c61mIf8vFShJ9fdPodGvDIhacAzEWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896826; c=relaxed/simple;
	bh=eHbJzUdWGaIipiT2eC/cd6U5ccZOJj+N28qQiF/iYpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI5aU7lxX8MS5S1UdCOKRT/0y2a+s925faeoaTjGc90Cu7oEEAstd4ajjeVT3WVU9/okXKD8yfU1ND3YSkJmHvFgu3ZhqIhJ6flH5+NDTXZ0CiPn5i9N/SXh2XiG3q/HzB7kmX7zy/aGfvAuQ93AzQB+QbnZUR7pfWgfyh+9g2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEa78D9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEa78D9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354801F00A3A;
	Tue,  8 Sep 2026 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788896825;
	bh=061K/R5HBO81K899BAC31j4Jyrujc1gyu6lrfrqP5A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KEa78D9T8QGPZw82BZHC7bojesHNdZAHAsF2KEdXSwz0t5e7PgwbUEpx6E+yC2+LT
	 CSm1LnYB7z27di4D4/48OPqZw/6QUfruQfOeKQ6mBQmIr++1pNjW0VYbGGM+wN+iCG
	 2oCR28xQ+jejPb8tN83dr/l6YIYdkWE8pD7b9EanyT3HZgC/kJRPicyu5QzxFBgelu
	 LRTX/3InlH4h3thXnuKoAzaXP7eSrAgijAmKou/36ZHArRmDWjymorlOE8GeQCq3uK
	 8hsfzKdMPdHsufjtBOxWlpi3Sn2odWaLCES1p8SQUTLhYvcAVRsIVbf7pbAfghaHVi
	 5N4peiJv5O0mA==
Date: Tue, 8 Sep 2026 09:47:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Xin Yin <yinxin.x@bytedance.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] writeback: size foreign flushes by target wb
 dirty pages
Message-ID: <aqBmOIVjejaiUdW-@slm.duckdns.org>
References: <cover.1788836830.git.yinxin.x@bytedance.com>
 <a889bf70370d17fec0731b60cf393d8cc7cf145d.1788836830.git.yinxin.x@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a889bf70370d17fec0731b60cf393d8cc7cf145d.1788836830.git.yinxin.x@bytedance.com>

On Tue, Sep 08, 2026 at 11:23:51AM +0800, Xin Yin wrote:
> Foreign dirty tracking records the bdi and wb memcg IDs of recently
> dirtied foreign inodes. When the source memcg needs foreign writeback,
> mem_cgroup_flush_foreign() queues WB_REASON_FOREIGN_FLUSH to the
> recorded target bdi_writeback.
> 
> cgroup_writeback_by_id() currently sizes this best-effort work from the
> target memcg's NR_FILE_DIRTY counter. The work is scoped to one target
> wb, so a memcg-wide dirty count can over-size a single-bdi flush when
> the target memcg has dirty pages on other devices. It can also under-size
> the flush when the target wb has dirty pages charged to other memcgs.
> 
> Over-sizing keeps the target wb busy longer and can delay later
> writeback work. Under-sizing can finish before enough pages are written
> back for the source memcg.
> 
> Use the target wb's WB_RECLAIMABLE counter and keep the existing 25%
> headroom. This keeps the budget aligned with the writeback object being
> queued.
> 
> Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

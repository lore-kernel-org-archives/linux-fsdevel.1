Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAEE381B02;
	Thu, 21 May 2026 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383915; cv=none; b=GKAni2K180iXIPD7BTI3AScsbsEhjLB8S2BSqkwQLY1DfAWjBaEBq24cZNP1lRp13yZ/y5DcXbG3DtNmeDbDI7iVIwrMU77gX3anhEqdCb1L+i1YsG8zdINIz6t0bl9zxkM66sywNpX15u27Q1taaOzwqKhyCDp8v9sIfoix2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383915; c=relaxed/simple;
	bh=R92kWi2yFCLckQIu3dU4u9xw6ybgbdqcKO/vXSuMKB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLqro9TZOSkZMuCzvkTAfbmm49ciJRnPU+mo678a8hDwHyVPr6SplloYNpHk2Q9oOX8nlC0EpiOmL+Xm643NGzHnouFOtAmtVyvZunybGQIiyT9kjmmGvKtIFtC8FQbsABJ8peerg+m5uQl8J/le9eHMdChtcgsT7C+P+0zdE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJ6R66cT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJ6R66cT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252401F000E9;
	Thu, 21 May 2026 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779383914;
	bh=XVFbF6HYn2YQk7B8y49fDdDuULfdkYo7a26mwtdbjMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JJ6R66cTus8CjKsExdA12p2npq8HPKv8Yp3wC3KCB1G/q/UgVj4AhP1dXdF0uUgBW
	 LYSmnOeujkt7nOnbbxqOx8yy0zfRIIvr0O+Qv3KdDP6ImC9NLTmk10oFGzQq4XCRGd
	 s3Ih0NBHEXXav+9w3Kv1Uc44ZexZoC6yDnEOWy3pIJ4U8+eHz6xXv26a+ouEPCPYh7
	 8tVhsHd/JuYtwsgm/v+P6sZHQSC0ESPgUlYp80orwUv0hJWdTVTf0KBeHt+rCjU7Vx
	 cKq8d9+Tc7AntY5ZdaH7uZvDu/knlyiuWXcoskmgpAM90tyGldtO8Nnmlk+9hR3Doy
	 6GRGvyMlolO3Q==
Date: Thu, 21 May 2026 07:18:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] writeback: drop now-unnecessary rcu_barrier() in
 cgroup_writeback_umount()
Message-ID: <ag8-aX5Vrj6DqDHU@slm.duckdns.org>
References: <20260521095016.2791354-1-libaokun@linux.alibaba.com>
 <20260521095016.2791354-3-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521095016.2791354-3-libaokun@linux.alibaba.com>

On Thu, May 21, 2026 at 05:50:15PM +0800, Baokun Li wrote:
> Commit e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when
> switching inodes") replaced the queue_rcu_work() based scheduling of
> inode wb switches with a plain queue_work().  Since then no switcher
> goes through call_rcu(), so rcu_barrier() in cgroup_writeback_umount()
> has no callbacks of its own to wait for.  It still drains unrelated
> call_rcu() callbacks from other subsystems on busy systems, which
> incidentally slows umount down; drop it.
> 
> Fixes: e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when switching inodes")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

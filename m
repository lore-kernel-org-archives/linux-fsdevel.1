Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38514FC339;
	Mon, 21 Sep 2026 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015733; cv=none; b=VHW5T1TRZHcrMU4U5W41Fum0AiqN9LMWoQRXQbsbQdk1Dl58NHiubUJVNVbJYkaESilecIqm9R0rXdefXe1dAWmwXOdVeVSg3oWBIcGTxXayOuPrAPx6URlwI9cR0wibFzFVaNAieDpCdjvjEyvhJziwBDoqBfE/0CzvbOjwDMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015733; c=relaxed/simple;
	bh=NonVOeMbA7i+ejQzKtIRHkn/zVO4IHY29+ELjvgKPP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeCo9chDPSssGyYTFNEQFMI8yPuhXirLQA64j4CagnLRZBkGT0fMyTXKUPCnGwKc+/3QcPRPqRLGqFo8+DSPqbUMzYbaasL/GuNsHwSqDnaOna/HHSW9V+sgzEX/Uvc0rEAYJUC2ePuAm5nB16UOdaESocz/9Zk/aWP0x1zSA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAey2uFL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAey2uFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F7C1F000FF;
	Mon, 21 Sep 2026 18:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015732;
	bh=LTyZcsiimJjAAMX+NnsM0wdS2L3qrWnVmTd4p/57Z1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZAey2uFLM15lQj7smTebL2vOgPxUI7hq90k1M4EfVURztnOAgZlr3f5ysle8BxKrt
	 wG/RUmi41ZB5ZvlLnRlYt9NvgyuPkZEhijO4FZqgI0xMvee3F0PWev6p4NguwGTwO9
	 v6s3ecOnuhmLuJAw6JVDmw/QUUCmYoDWOHKf6rvLBgOum+hUNfh4CAoy8gUP7BKsLF
	 WC2BGk/S2ieUOkDfD3UUT9XSz6+FChP0l7BkZ294cH+QatBHZnAE25hcmokBPw+QJQ
	 2paMthC+hcvIyNedlJ9b75kDRBsb6vqiNgzMC9oPrioYpw6vqtkAhsuLIuBZIF+JcW
	 B5p3qJ/I715OQ==
Date: Mon, 21 Sep 2026 08:35:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <christian@brauner.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] kernfs: do less work under the kernfs_rwsem write
 lock
Message-ID: <arF483xnyqFO1U0C@slm.duckdns.org>
References: <20260913021453.21507-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913021453.21507-1-shakeel.butt@linux.dev>

Sorry about the delay.

On Sat, Sep 12, 2026 at 07:14:50PM -0700, Shakeel Butt wrote:
> kernfs_rwsem is per kernfs root, so sysfs and cgroupfs have one each for
> the whole machine, and every create, remove and rename takes it for
> writing.  Whatever a writer does while holding it, everyone else waits
> for.  These three patches take work out of that section.
> 
> Patch 1: kernfs_add_one() links the node in, drops the lock, then calls
> kernfs_activate(), which takes it again.  sysfs does not create nodes
> deactivated, so it pays two write locks for every file and directory.
> Activate before dropping the lock.  lock_stat says 1200 -> 830 write
> acquisitions for creating and destroying five dummy netdevs.
> 
> Patch 2: kernfs_rename_ns() calls kstrdup_const() under the lock.  It is
> the only GFP_KERNEL allocation under the write lock in kernfs, so a
> rename can enter reclaim with the lock held.  Allocate before the lock.
> 
> Patch 3: kernfs_rename_ns() also frees the old name under the lock with
> kfree_rcu_mightsleep().  When its batching allocation fails, which is
> what happens under memory pressure, it falls back to synchronize_rcu().
> A rename can then wait out a grace period with the lock held.  Free
> after the unlock.
> 
> Tested with the kernfs selftests under KASAN and lockdep.
> 
> Shakeel Butt (3):
>   kernfs: activate a new node without dropping kernfs_rwsem
>   kernfs: allocate the new name outside kernfs_rwsem
>   kernfs: free the old name outside kernfs_rwsem

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

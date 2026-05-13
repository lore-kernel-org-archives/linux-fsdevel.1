Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459FE3A7F4A;
	Wed, 13 May 2026 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704602; cv=none; b=AXTzgi/UCHXVCLqbr0GwPKUxGZnDVEAZtu7pXnJoIPR+JZ9STYuts8WdALINixZSEUh7LP3EeWpVFsvgXc4s/jk2cVpOgymk3zviFxTa5ty4D2fEy2z1y13aAYHMFtB+YcUxcIl1Q/wot6IBQkll0IzCCHvfOUBVHcuH59+yc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704602; c=relaxed/simple;
	bh=RUTh1a49Bo6VO+/3yVlEh5+E000TuujeE0bgsjVlJcM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SMQf8gk0mq8nllKRCiqqgMhc8Ko0lc84y/OcIdrXf/ouFfW6Tnit1y+2wP1lNmk6pihF2xkBkwzgJZyCCSwPYUEMjfLAIHx5G5dB/Jh17NTHrK88CBCLFqqWq03FfkydouOJRJ42VM3yfs0pwOQMcyUKQ2MQzynbyayqdte4Zw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTmOB+Zy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTmOB+Zy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41574C19425;
	Wed, 13 May 2026 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778704601;
	bh=RUTh1a49Bo6VO+/3yVlEh5+E000TuujeE0bgsjVlJcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oTmOB+ZyxDgr8/1gVFVWXFhZvuG2C72woY/JfnD+50KqeveHUm4cnVFM0J18hJ8qH
	 hzZfq8gmPpib3Agtgir+ewWZDp3FXmKMiYvcjGxqBd8vPvZ/QdEAR7F1JCczohVxcn
	 ZWVERPktGz1JP+tLQd7xv4M21LdBKXe1hUwN5mVEvMarHdfoZ4ayFNVEo83MdG3Ej/
	 mvi2JJwrbSjm5ztS3V5bsNoSk2rmuIjYjNM9s7DZoR+yRL/G2BCNZBijGle+nAmL9H
	 t+EG42Jk8bCOdhW+NHGGM3WwXDeAEth0pU4eR/1yBVrF/cvDklWjpTcduhuJwdadcz
	 i+/fXEMQwlANw==
Date: Wed, 13 May 2026 10:36:40 -1000
Message-ID: <22cda97d61cc9d540d4e7116d5f3f08a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: fix race between cgroup_writeback_umount()
 and inode_switch_wbs()
In-Reply-To: <20260513094829.867648-1-libaokun@linux.alibaba.com>
References: <20260513094829.867648-1-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Hello,

Resending - earlier send dropped the Cc list. Sorry for the noise.

How rcu_barrier() got out of sync, as best I can reconstruct:

- ec084de929e4 ("fs/writeback.c: use rcu_barrier() to wait for inflight
  wb switches going into workqueue when umount", 2019) put the inc
  after call_rcu(); rcu_barrier() worked from then.

- 8826ee4fe750 ("writeback, cgroup: increment isw_nr_in_flight before
  grabbing an inode", 2021) moved the inc back ahead to cover the prep
  window, apparently reopening this gap.

- e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when
  switching inodes", 2025) replaced call_rcu() with llist_add() +
  queue_work(); rcu_barrier() looks like a no-op for this path since.

Could SRCU work instead? srcu_read_lock around the publish (atomic_inc
through wb_queue_isw), with cgroup_writeback_umount() keeping the
counter gate but swapping rcu_barrier() for synchronize_srcu():

  if (atomic_read(&isw_nr_in_flight)) {
          synchronize_srcu(&isw_srcu);
          flush_workqueue(isw_wq);
  }

Thoughts?

Thanks.

--
tejun

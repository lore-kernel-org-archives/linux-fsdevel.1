Received: from mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D60A4399F4
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2026 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231640; cv=none; b=VViSfITvHiDCCpAsZc4TBJCfXnQsiXvNLWviy8XYOwUbrkjmyD3fUEaLXpVwHeN2pEL8X/0UXauQ+ubYxKvwIYkYs1s0uCmz0oBzdxeFSk/6KOLqOInXB/NLZ8GomWyJqEbli41c9HP8fODjM8snXpPwz+Jn4wgnwQZ4a9uimjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231640; c=relaxed/simple;
	bh=BA1fZXNdm9XbdzD3T6eEi7wnLpD4meMpKZQWYa6zg+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfyL1GhdYbG0/SEg7WCr8DVi8fOqhDTdHHkwBXSZLdwtiNtR3siQL0ngugxVYjjqUuWe+UFJfLN1ALru7fN4FQ7Wc9Cb4jxj42mxYTHrU/wlLdCi51TWU/SNKW+/KatOAw190JrAdnAs9n97GJPJTNIRp0CoV4M1sR5cKIAI87s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PZw8JTd8; arc=none smtp.client-ip=95.215.58.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PZw8JTd8"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BA1fZXNdm9XbdzD3T6eEi7wnLpD4meMpKZQWYa6zg+c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788231632; v=1; x=1788836432;
 b=PZw8JTd8jw+hXPFos4eRuFz2nLD7dKrnHv4AP1ZYofnYiHDdv8fz/vSjbTqe/1Hin9AbjykY
 CMdkWyqJHn62VKxdrsyaaw7rAVdVp2vekOU66mDEzhcA6LHViqTR3xmWn2aNhQZdUVMmkypuxLj
 Ukaya9b83aouGj8/9migBCUA=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 481fa12d78614b3a;
	Tue, 01 Sep 2026 03:00:32 +0000
X-Mizu-Trace-ID: 481fa12d78614b3a
X-Migadu-Flow: FLOW_OUT
Date: Tue, 1 Sep 2026 11:00:14 +0800
From: Chen Yu <chen.yu@linux.dev>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, "Chen, Yu C" <yu.c.chen@intel.com>,
	Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Qais Yousef <qyousef@layalina.io>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Vineeth Remanan Pillai <vineethr@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/cache: Fix use-after-free of the mm replaced by
 exec
Message-ID: <apY_vvPExYP6qMZS@three-body>
References: <apPb-Dr4nPYuHQOK@v4bel>
 <825d9dcc-b052-4367-a9c7-15efc4b354f8@intel.com>
 <apXV6t-7drLDf-lL@v4bel>
 <a1a0bc24108e68656041dc17824d6b88b4120058.camel@linux.intel.com>
 <apX1ufR1reYZ9LBc@v4bel>
 <db2436d91e2e04a8a1063553ce64acc74b533f5c.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db2436d91e2e04a8a1063553ce64acc74b533f5c.camel@linux.intel.com>

On Mon, Aug 31, 2026 at 03:10:40PM -0700, Tim Chen wrote:


[ ... ]

> > > We should probably prioritize to merge the first couple of patches from
> > > that series now in light of this issue.  It will make maintenance and future
> > > modification of the cache aware scheduling code easier.
> > 
> > That is a fairly large change. 
> 
> However adding rcu synchronization will slow down the launch of a new process
> too much.  The rq lock solution has less latency in my opinion.  But I
> think decoupling sc_stat is the best solution without adding latency in the
> exec path.
>

OK, I see. In decoupling patches 1 and 2, the lifetime of the sched_group is managed via
a reference count, and it is freed using the non-blocking call_rcu() instead of
synchronize_rcu().

thanks,
Chenyu

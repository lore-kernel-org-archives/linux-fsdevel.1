Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C93F074A;
	Tue, 22 Sep 2026 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061763; cv=none; b=PiAuIDZ3RHR7zdvnM4nSEXkrgtItCyhrCfAI43utiJxh3yI3VktfCCA6fxdF6N/uB52zOIpCfx4WcX+E3Ooscq4yCKWd5sjX0evR9tKVPTRyg7KuibZaHgrQAfeUvZw3Laz9I36aF6G2l+E8WfMZ2MMEbTWxmijRgFIjjbFjCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061763; c=relaxed/simple;
	bh=6Z5mjMb7fj0LDqz3YyhYeMciJB2/4Ex/59Q36Er91D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOwIJAech/R965sNkWBZx9BAiQZXKaiuZxvqi8W5xIIXI5ODvouEaiv8XN6mxIoN351KPs/E4WFUB6/vTPoyuT557gyNlDNmP9YNwb9BROpxXjIqaZ6sFkXPauV3VBcoSD3Yp4mNjZpL4yNpD6x/+N95prAjlkfrJJpgMoh8nCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DWGtr7PF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DWGtr7PF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D4O/+js0VFa0QVJKCFXfhOl2hsauxjVReI0OW+GgIjU=; b=DWGtr7PFOztE1CkDEDs7zTSwkq
	/Qwknsw2rToEPRw1LFp/aj6mTWalhDgWM8oqYu1+loY2jiJdxnzzZ2lHi9KTGLAI9QcgAVWIDCdKj
	YaNtkIKBiRHInmbuDTdSywj+ZpAg55uzCAz0F0wLqxowzAFm4e+UejlyvM4WqEFrMTXv+QBLXoR57
	NSsziakePeYg57e/LG+9JXAOO2A1Z9/ARr+0DRPM8i8sTHGfFRxq/Z+ZasE1712hFrgBE+NHcDsMI
	JGj6zLPa3lPeyh5fkaNTj07BuUdB2v1eL15lpxkNjUN8y/xzijku4RKY3QpoWNfumqOyx9NDBHd+R
	Fc+HBt/g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8upL-0000000DCmh-1yMj;
	Tue, 22 Sep 2026 07:22:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B074F300708; Tue, 22 Sep 2026 09:22:05 +0200 (CEST)
Date: Tue, 22 Sep 2026 09:22:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Qais Yousef <qyousef@layalina.io>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Vineeth Remanan Pillai <vineethr@linux.ibm.com>,
	Ricardo Neri-Calderon <ricardo.neri-calderon@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>, Lu Wang <wanglu.priv@gmail.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Yi Lai <yi1.lai@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Zenghui Yu <zenghui.yu@linux.dev>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	Kayra Cizmeci <kayracizmeci@gmail.com>, stable@kernel.org
Subject: Re: [PATCH v2 1/6] sched/cache: Keep nr_pref_llc_running in the
 runnable domain
Message-ID: <20260922072205.GV4121339@noisy.programming.kicks-ass.net>
References: <cover.1790035273.git.tim.c.chen@linux.intel.com>
 <06af61afedac32e6477f57feb4d658f6c411c3af.1790035273.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06af61afedac32e6477f57feb4d658f6c411c3af.1790035273.git.tim.c.chen@linux.intel.com>

On Mon, Sep 21, 2026 at 05:37:22PM -0700, Tim Chen wrote:
> @@ -6395,15 +6429,27 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>  
>  static void set_delayed(struct sched_entity *se)
>  {
> -	se->sched_delayed = 1;
> -
>  	/*
>  	 * Delayed se of cfs_rq have no tasks queued on them.
>  	 * Do not adjust h_nr_runnable since __dequeue_task()
>  	 * will account it for blocked tasks.
> +	 *
> +	 * This check can be removed because when flat pick
> +	 * patches get merged as only task can get delayed,
> +	 * same for clear_delayed().
>  	 */
> -	if (!entity_is_task(se))
> +	if (!entity_is_task(se)) {
> +		se->sched_delayed = 1;
>  		return;
> +	}

This is dead code. In Linus' tree, where this will be applied, this can
never happen. A possible backport of this fix however will need to take
care.

> +
> +	/*
> +	 * Drop a task leaving the runnable set.
> +	 * Needs to be called before sched_delayed is set.
> +	 * clear_delayed() mirrors this after clearing the flag.
> +	 */
> +	pref_llc_running_dec(rq_of(cfs_rq_of(se)), task_of(se));
> +	se->sched_delayed = 1;
>  
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *cfs_rq = cfs_rq_of(se);

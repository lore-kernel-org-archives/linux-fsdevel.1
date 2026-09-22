Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263141B8CD;
	Tue, 22 Sep 2026 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065722; cv=none; b=L1wMoVUwELl3lIi9oUNAB8RlJ+PLd97qqUPYSwElUcH/yCtOEoiHIGSzeenq5zwW6j9IK2iXANVH11FFHttTIHCuvbRhnFSMJ8XzrptDzq6oSNWSMnmrjG29kkFQ+WFe2AiHCBWU1fcBwUZTKTQjK845SrhbVT6DPpBYXo+/dhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065722; c=relaxed/simple;
	bh=fwhAdvPKZuy1xRlwtW09qNbSF4k3c3Djj/nU8NPuwHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAmA7uifQgeNaQuOW9Wmpr/7r8Xo5unRiUIL59WPugfn6gnmIglcNu7xEafRaGSFNQm2ojwcJ1h35tTOoADzEeAbaZ04PDEI45X1VCCEUZhYKYXrIVV7PYfwPwtnBnRzb641+wUd/tSzls74fTrJXAeYNVhPU4XkstnJNNTr5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fnkRMEyi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fnkRMEyi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PfubRjl4+hlUE9k++w7dZcQM36qRb14JHyPG4O/PKVA=; b=fnkRMEyiFZRlkoIXIkHmeIfAQF
	uH9xp+wfoaRJvqEirWJ3TsgoXJOI3rJglOKEVHmzBt61a5A5FoP43o7Gxxx85Bivx6xU4m1tHAvM8
	00/fJtdacRFl6NMBEaChV0eGI1T/TJXlQXP7NW1Nf+/wEO0WALYUOqoGUbHXU1QJXGljH/iLsqhJA
	OTqZYTIpJ/vGzhLofEV5kMQNCSuGT6QctBp+1Gig1qQTPYPEXyuAceMjaud5SunG+xdslWl4NvdAZ
	hEOR9m8IdmMIbu0YezlYbNHuDge13ClURRR9wehj+c+scya0jTU4tgdXJPBiN51z0Xm+hMfbnA0cK
	clu60l2w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8vrL-00000007k9n-2SPX;
	Tue, 22 Sep 2026 08:28:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 98F9F300754; Tue, 22 Sep 2026 10:28:14 +0200 (CEST)
Date: Tue, 22 Sep 2026 10:28:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
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
	Lu Wang <wanglu.priv@gmail.com>, Hyunwoo Kim <imv4bel@gmail.com>,
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
Message-ID: <20260922082814.GX4121339@noisy.programming.kicks-ass.net>
References: <cover.1790035273.git.tim.c.chen@linux.intel.com>
 <06af61afedac32e6477f57feb4d658f6c411c3af.1790035273.git.tim.c.chen@linux.intel.com>
 <20260922072205.GV4121339@noisy.programming.kicks-ass.net>
 <65ee9df8-2422-4d1a-80d6-41ac51979da1@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ee9df8-2422-4d1a-80d6-41ac51979da1@intel.com>

On Tue, Sep 22, 2026 at 04:25:14PM +0800, Chen, Yu C wrote:
> Hi Peter,
> 
> On 9/22/2026 3:22 PM, Peter Zijlstra wrote:
> > On Mon, Sep 21, 2026 at 05:37:22PM -0700, Tim Chen wrote:
> > > @@ -6395,15 +6429,27 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
> > >   static void set_delayed(struct sched_entity *se)
> > >   {
> > > -	se->sched_delayed = 1;
> > > -
> > >   	/*
> > >   	 * Delayed se of cfs_rq have no tasks queued on them.
> > >   	 * Do not adjust h_nr_runnable since __dequeue_task()
> > >   	 * will account it for blocked tasks.
> > > +	 *
> > > +	 * This check can be removed because when flat pick
> > > +	 * patches get merged as only task can get delayed,
> > > +	 * same for clear_delayed().
> > >   	 */
> > > -	if (!entity_is_task(se))
> > > +	if (!entity_is_task(se)) {
> > > +		se->sched_delayed = 1;
> > >   		return;
> > > +	}
> > 
> > This is dead code. In Linus' tree, where this will be applied, this can
> > never happen. A possible backport of this fix however will need to take
> > care.
> > 
> 
> Would you prefer that we create a separate patch to remove entity_is_task()
> for Linus's tree (so that the current patch can be backported, since
> cache-aware
> scheduling was merged before flat task-pickup)?

Nah, I munged it in with a few changes (I removed that cache-sched.c
file) and it seems to build. See queue.git/sched/urgent.

I'll queue up a patch for sched/core that removes some of that -- if I
don't forget and all that.


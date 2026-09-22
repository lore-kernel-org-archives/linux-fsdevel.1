Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928FE1DDC33;
	Tue, 22 Sep 2026 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061878; cv=none; b=pZX1QH1hHx8WPA05AamSQita/PQXr/ZaiTFyGiII5YLtFMu0762HJEWZJIJtw0VFk69FNNO3/b39rysghY3ug3EwH1PclRZg+t/J9yMIIO/ItTW4YX0PsGVwH1wdVoNL9b52RjmjthF1AXE+t0pu4nit+DDoTxeA5LjcN4KFnL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061878; c=relaxed/simple;
	bh=AphToBMiKdpkW4jJyGrkF0MLgHLvibg8+sFDnX92rXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkG6yrk36EbSmWkytkPawSVlD3QYqQvyLEyETErLQuz8MDaqWIWxbwssxKLWNetB3bhJC7PIck97IvMWsYH6HcbH3NwsCzQnFskZ1J5JKIqFc9B2ZnqCjqIlTqJwCkpjOxQcAMaFdnFSnAP7W/jv0IpCPat9aQhAtUa+pkuyBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZljLmvs9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZljLmvs9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OdJLflAlPG2srZDj55Kplumdt/HlutALrygg5uboHCg=; b=ZljLmvs9ZpjUSMwVeNapnu9yQW
	bR4eSE1Y7mhFS2+g1kSyyZU24sd90De3F+IE+8ZpWQVqbI4UWfI6MOO4EVCOAbHIUb8G7FTPXNZQ+
	zHhaaauBp6/etPY1cYGIeFssIs2ve4iIpnkAdMSCgCeePrOBqlC533SUpgdp0sGs+CAEgqcxpmRqv
	u4ZE9wd8xRrgZ4lMPZ6mTWTm9KKnv1dwpvdTxIK+BF0ikHIhWB+3qiN4AA2gjbKN0OaIkEOpj/tvr
	0I6kaNTzsihN5aPn/nWepBC4pMSUTPZn7Wp/hm297NaxViUbCXbGY1nvj/M57y6tysU2MxwEFz833
	sZlyoGcw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ur3-00000007UwY-1ISQ;
	Tue, 22 Sep 2026 07:23:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D97213008D6; Tue, 22 Sep 2026 09:23:52 +0200 (CEST)
Date: Tue, 22 Sep 2026 09:23:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Lu Wang <wanglu.priv@gmail.com>,
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
	Chen Yu <yu.c.chen@intel.com>, Hyunwoo Kim <imv4bel@gmail.com>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Yi Lai <yi1.lai@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Zenghui Yu <zenghui.yu@linux.dev>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH v2 2/6] sched/cache: Honor migrate_llc_task semantics in
 active load balance
Message-ID: <20260922072352.GW4121339@noisy.programming.kicks-ass.net>
References: <cover.1790035273.git.tim.c.chen@linux.intel.com>
 <cb39f64a17fc2b76097264aaec74a2d6dfff4315.1790035273.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb39f64a17fc2b76097264aaec74a2d6dfff4315.1790035273.git.tim.c.chen@linux.intel.com>

On Mon, Sep 21, 2026 at 05:37:23PM -0700, Tim Chen wrote:
> From: Lu Wang <wanglu.priv@gmail.com>
> 
> CAS introduced the migrate_llc_task migration type to direct tasks

FWIW, every time I read this I get confused, CAS maps to
Compare-And-Swap, aka cmpxchg on x86.

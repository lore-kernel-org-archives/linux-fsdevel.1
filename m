Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A139345D916
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992085; cv=none; b=neyMvGfhVko3IkAx3rqcCnoqLr/A2rr10FOEYg7sabY8GkyJDcdK0Wjegg8CDeCIhbjUso//amMJeL3s9gfUs4PKWhYHS9RB4Lik1NCbUg1DBepgGctOh3NV+iYp3jDSAshvpLUipzBUh3Qsys6vBNZGu/nWfOLOGtKuSGMSNR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992085; c=relaxed/simple;
	bh=aQvz0ZYLQXdqqzd85lD3v43R3LA7HgRcKMR5C2XkRss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1LT3Fhp3e2YNOTFb7TVoDz0YxlTvji50BblYBPkf3RMLFDuhpbhdtwTvutSGsZFCsz6NjXev6MXlOeSXLIWlzfgzqfDA0rccjYzm8uMGC5FPgYlR1fVNajTj2wAhoOXBX/TPdTtuPSmdodVtxbSKA+gt3jXsL8oobJJxY+pY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eXlo75Vd; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eXlo75Vd"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9105d241693so8016306d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788992082; x=1789596882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C5NkJw6oWjdsiphJVaybRhCdoPAeWbsi0cRS0OiEPYM=;
        b=eXlo75VdvxhLqwj91yG3NjOJ83pkcplJ03h9KFjYjxYVZ9SKsqJsUyJ+SWGaQP57fx
         UT6p9GjxxLMqUjNf+j/jAHmpTEd6XxOVjb5YjGrb23SFedJHXhNMcU6aA82d/Wg60fzJ
         BAUnJsyxdnWDg6tFOch+SZsuDWgc60UAdfHL9T9sxdLevjI6jrtOWeWx/RUhRzKQqfjZ
         8ngeQcNR5SOnwg+dkF/w4leePSXjvVlKIg/mOKRjfncF5cJyZMFsdD2OEkHCtwiE8/Ud
         QwEyNorfCJ13/qVRZnrlJatCRC0XdPt0Z3w95usktLPB3aKNgY0HpId6hdM4trmTSRa9
         Hudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992082; x=1789596882;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5NkJw6oWjdsiphJVaybRhCdoPAeWbsi0cRS0OiEPYM=;
        b=Bf3Vk3mAOvSCBNZQm4+W8tB8uuwfjgNfgTkqwlhNZEzABfguDJxqg0YyBjWsL7GZf6
         QKyPCeIqTYEM0o41QG0kGqbkxjGJg7hptJEtPr2TwqAAHF2ST6/sXAWTkWPDqejCvaKf
         u7M/8dFrm7MHde18mIceV5DOb8inoBR52yBf4UkNXYL/rMOIT9MKURxdJejNzffMGEf+
         YztsyTFFEkMG6w0XNPiIayJ7fy06g9sVrY4NlJ8VUe40ttGXMlSWLKjJQyCxlVa1PDcD
         oW3U/5XC+EktSoSwtu91dCZT73ou4c+1ruPmwHSZbcGBW/1sbLTO++XkYzMS+bwwh9rT
         lNSw==
X-Forwarded-Encrypted: i=1; AKwUvBwPOXvjLyghlLKpkRZlcjz8QR5BRvGDspISEKK5bWyu6ncmF2pvGVr9A4r+zPcpRBPRL83yPE7gOHE5ju8R@vger.kernel.org
X-Gm-Message-State: AFuF++nESKM6wtYSgLcK/LmznnAGvQx18SPsAozIOGgHrlZR9btbT2IF
	trxcq2MEawKYjlQiiJDCQtMaeRFCfvXD12N18teZ9h5VSoXeIBUg/mn3gQFe+kLaXac=
X-Gm-Gg: AYBFou1Nf5UelnzptHh7KppQni/Vzb9qtrKWkbXtz0M+FKf1supPtEPzD0w4kJ4XrPC
	BfHhQqIHgUfvG39kB5AZU7gZRa2gjVE5R2ZBjrLcaRQZkai6MveywKQTyQAwIbnF/T5xBHuNq79
	llJFgXRlrEdfHWUGzMYyjDR+3Q6FJmxmh/YXfBNOW5m+WkxiC7Cmkc789bWtsaLfVhIrJSnH2O+
	KaEW6AK3m6EdWL1pVn4OaAoQiYUOpP9gnMPlG+vUZeShWVMjO8xp4Usjys/f3u5Ibv20hPV/7YD
	C+Q6o2WwP9QB3StseFio1LB1Lh370+ajs7n3UWpM2+Yn9kHc6l4up+voF0b9Xl6SK70vviPwemN
	ph8CXKH8lR237rkpwvuYvDtTbaROPAkKZHUi2342raHR51Aa/32p0su9U8Q4nap7A+MQ4tKic0Q
	yeLBF0dhCSyzxbFFwuJiHAs7Ont8Vk6/7mCH6jiBlzKP1i1sC2tXX71+5P7oF5zvNRcbNuQQi1a
	86agSFcFOJiw0Lusekf5Bu6AaGNaGcxcbhu1CXST07KnIuueVlmSTw=
X-Received: by 2002:a05:6214:761:b0:8f2:fbb1:cec4 with SMTP id 6a1803df08f44-910d104c019mr49748076d6.19.1788992077664;
        Wed, 09 Sep 2026 15:14:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406475f5sm151951376d6.9.2026.09.09.15.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:14:36 -0700 (PDT)
Date: Wed, 9 Sep 2026 18:14:33 -0400
From: Gregory Price <gourry@gourry.net>
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ye Liu <ye.liu@linux.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	mic@digikod.net, david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, 
	gnoack3000@gmail.com, ljs@kernel.org, sj@kernel.org, rientjes@google.com, 
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, 
	tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, lance.yang@linux.dev, 
	pmladek@suse.com, longman@redhat.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, dietmar.eggemann@arm.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, mark.rutland@arm.com, 
	Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rcu@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <aqHZ7lZQnugGJ0ig@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
 <ap7dC-LWNaoPYJvv@gourry-fedora-PF4VCD3F>
 <ap76-0-hN6CAcYXX@redhat.com>
 <ap8mgnpE7D4TTrno@gourry-fedora-PF4VCD3F>
 <ap8yoW37GY17pHYS@redhat.com>
 <e618ace1-6a8b-42c5-8a97-44b39dd1a7c7@amd.com>
 <ap-spMNyMvYFga5k@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap-spMNyMvYFga5k@redhat.com>

On Tue, Sep 08, 2026 at 08:35:16AM +0200, Oleg Nesterov wrote:
> On 09/08, K Prateek Nayak wrote:
> >
> > On 9/8/2026 3:24 AM, Oleg Nesterov wrote:
> > >> This might be my - admittedly shallow - understanding of scoped_guard,
> > >> but does scoped guard handle goto correctly?
> > >
> > > Yes, it does,
> > >
> > >> and why it's generally discouraged to mix cleanup.h and goto.
> > >
> > > Hmm, why? I didn't know...
> >
> > Apparently older GCC would allow subtle bugs with cleanup + goto to slip
> > by but clang has always caught those bugs and refused to compile so as
> > long as clang builds are happy, things should be good.
> >
> > Here is an older explanation from Peter:
> > https://lore.kernel.org/lkml/20260327154136.GL3739106@noisy.programming.kicks-ass.net/
> 
> Ah, but in this case the code is buggy, "goto unregister" jumps
> into the scope of __free.
> 
> Anyway, I agree that mixing cleanup and goto can make the code
> confusing or buggy, but this particular case still looks fine
> to me...
> 

Seems jump-out is ok, thanks for the confirmation Peter.

I do agree the general improvement is nice, but maybe worth considering
taking cleanup.h all the way if we're going to use it - that's all.

The improvement is clearly welcome.

~Gregory

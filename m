Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A759521234
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065193; cv=none; b=AjVL05SfBBq/zXap0lMUPTLo6IyX7vPiaj+lsPb8Nepgd9RdDhKTmKp1ka3HDULjGAtpr5twPkdN2hcKaXLDlKybicJanavs7529RiliBMOSjxs2iA4N7m3mXaxycgkaZtD8G/Uxj9peovoiXoV5yBu4P283jpNOFnyZbW3iDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065193; c=relaxed/simple;
	bh=3nM/7LI7olnSJqPMrKJo8aFg4AW5OoqFi8DNd+317Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqufCsZwnNVs+LhSrABih3oRGQU67QKzrEfdD/l67uQzbuL3OExSJXLrxd/iIWyoIV5+DG67OH3QH5mrIdq2gnRrvU+5QVYA9tEh8aD1VsykE/sF0jB0BXJo1wFWAHMXlV2DPi0yYUOnt3T3imeUvQfcfODCET+2AZq4HRIjj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osh0MPFc; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osh0MPFc"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-499db1a5b5eso132685e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065186; x=1789669986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ost6d0L83lIoeZ+lEEXbmuX93WTw58C3/ZwNuzffpI=;
        b=osh0MPFc9cxgmfb1CnDiMrCdC9tWwLfLZn/pp8Qe4Oub/GMcasoh0AJBH7+udkdYEX
         WdJVGieVYt+g59EeyCkxHJdx07kT9QIplTFoH6850IZn5Ylzc/ni9woXLAGLYh2EmOvY
         O0wtZ4rlkEYv/OlZLmlc1GH4D+F5YwcJW8Pf4pmk5S8lCcqufLOWlumG1lcsEpwBD18T
         a2meG4EtCzgXsOaZq3ocFlZPq/Qq74vdt6835VtCbzY4dR+44sHElo4/nCSwOfQSMa6c
         GQgz07QyFhdR+GbecDMaRRmle2BuA1LdxhyLiLwLBWd6rTcqmkRFWcfjj8n3Cqw1Kai0
         u78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065186; x=1789669986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ost6d0L83lIoeZ+lEEXbmuX93WTw58C3/ZwNuzffpI=;
        b=lK/OIkgkN0d7uo8pmZQbNuviuTGVSrRZYq8jc1qoVs0kYHR7wA82JIH0Q+RGEJ4CVc
         0RDEHuTLuGlLHCGcTNjQiV02q5/Y+5GBseGsEU/djmtfYYZ9SVrB/LwwEmF/fbV+dUaL
         27meBe7hOTCXBaIfkS4OK+xzTeUv2Tjg7LyouQaV9kyZARWyHW8MlRIBEkzc9zvubhhI
         JHuZi0zbzl8vFfRDOpxUaezvVPtwBA95+DWZqs9PEaA8Jjsib5M7s/VB1qlMJrv9himN
         r+zvLXrruYTEmngYMLDQEAx8X2ktU0WzIVbNlRZJ+uO1OjqB5fZoZQ28TxlPuNOlkDc/
         OkLQ==
X-Forwarded-Encrypted: i=1; AKwUvBz65MNWZT0DdBY/Z9AGFKLJy7sGcufT42SoOaQ6ZuwZbCQf2GPEPL9R46Ofz+JS9E+zQX77nmCJf1EJf/ur@vger.kernel.org
X-Gm-Message-State: AFuF++la4/DNML2WE4ApFnAsQO5r6Mg0ZRLGRm9qZp4Nqo3FY8QpFGvm
	m/DlyKw/nFoDpngxmFZA8VzZiqUkRjwSnijN9e/yJfoqQgcRxyXok6jNlPrOn9H6OqA=
X-Gm-Gg: AYBFou3qG7WvHRnZ4DMqVNPsf5IO0faCLuOVkF79ea36aZbnI/FELJ4Cbeu3ZlkSqaQ
	Rpdi8FG5tezsrdK3LZV5DoGSf+uDTwYWTz8VpX++Xp47WOG+Y0oMXMLyiUFHm264b4cUZ4q3PjM
	5btwmhxmpjaH9Ljm+kl8sG639RZj6T781mkMfDXq+YE67/JKiwdX2eQUYqaAO3oaeMwz4reoPho
	fmp0Te6IHoJZYPV8iClSNAMTJDL3DsFjocnzUK0Ir07KlLvDC9LsPps93vOAEx5NE7cyljU3+TJ
	0xvTL/VKLGhofQ4yOcwQjdJ4r7W9luhML7X110XxtTrTJVSWB4Mb2xk0sqtf55MJTPNKhrme9fr
	0WtbNTiz8BeISLy4AOyy06hLVaLQ4TKKkdd9m8BR2BxSsQGGZP6GvbKbprncbrtxgaz/jxpFypD
	HVI3srFzrbfIhpI7jZ5fdFCwfCJOFgp1//IwF5SNvdI9LQNhnkpQp5iWKv0KiP3OI2NZQ+Zr+rr
	Q542QmPQj57kBtxNwIxuGs2upHE+Jkm
X-Received: by 2002:a05:600c:4688:b0:49c:cbf4:572b with SMTP id 5b1f17b1804b1-49e619ec129mr2824565e9.2.1789065185924;
        Thu, 10 Sep 2026 11:33:05 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5765152asm40701325e9.11.2026.09.10.11.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:33:05 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: tim.c.chen@linux.intel.com
Cc: brauner@kernel.org,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	imv4bel@gmail.com,
	jack@suse.cz,
	juri.lelli@redhat.com,
	kees@kernel.org,
	kprateek.nayak@amd.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	qyousef@layalina.io,
	ricardo.neri-calderon@linux.intel.com,
	rostedt@goodmis.org,
	srikar@linux.ibm.com,
	sshegde@linux.ibm.com,
	vincent.guittot@linaro.org,
	vineethr@linux.ibm.com,
	viro@zeniv.linux.org.uk,
	vschneid@redhat.com,
	wanglu.priv@gmail.com,
	yi1.lai@intel.com,
	yu.c.chen@intel.com,
	zhanxusheng1024@gmail.com,
	zhanxusheng@xiaomi.com,
	ziqianlu@bytedance.com
Subject: Re: [PATCH 1/4] sched/cache: Keep nr_pref_llc_running in the runnable domain
Date: Thu, 10 Sep 2026 21:33:01 +0300
Message-ID: <20260910183301.1208504-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <82736e1329bf8ed195bbbc4990486c87094e6789.1789061845.git.tim.c.chen@linux.intel.com>
References: <82736e1329bf8ed195bbbc4990486c87094e6789.1789061845.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello :>,

> alb_break_llc() decides whether to break LLC preference during active
> load balance. It does so by testing that every runnable fair task on the
> source rq prefers its LLC:
> 
> 	env->src_rq->nr_pref_llc_running == env->src_rq->cfs.h_nr_runnable
> 
> But the two counters cover different sets. nr_pref_llc_running is updated
> in account_llc_enqueue()/account_llc_dequeue(), next to cfs_rq->nr_queued,
> so it follows queued tasks. h_nr_runnable is updated in set_delayed()/
> clear_delayed() and drops delay-dequeued tasks.

> So under DELAY_DEQUEUE, a preferring task that goes to sleep stays counted
> in nr_pref_llc_running while h_nr_runnable falls. The equality then breaks,
> alb_break_llc() returns false, and active balance is free to pull a task
> off its preferred LLC. Active balance only moves runnable tasks, and this
> is the only LLC check it consults: once the stopper runs, LBF_ACTIVE_LB
> skips the per-task test in can_migrate_task(). The runnable set is the one
> we want.

> Fix it on the counter side. A task should be counted in
> nr_pref_llc_running exactly while it is both queued on its preferred LLC
> (pref_llc_queued) and runnable (!sched_delayed). Define that membership
> once in task_pref_llc_runnable(), and adjust the counter only through
> pref_llc_running_inc()/pref_llc_running_dec() from the four sites that
> change either input: account_llc_enqueue(), account_llc_dequeue(),
> set_delayed() and clear_delayed(). Gating every update on the same
> predicate keeps the delay, wake and dequeue paths from double-counting
> or underflowing; see the comments at those sites for the ordering.

> nr_llc_running and sd->llc_counts are not touched and stay on queued
> semantics.

I have one question tho, can't we combine the checks with h_nr_runnable? On the paper
if we are updating h_nr_runnable we could check if the nr_pref_llc_running can be 
updated and update it if the condition is right. Because, every nr_pref_llc_running enters
h_nr_runnable while not every h_nr_runnable enters nr_pref_llc_running. 

Why instead we just check the nr_pref_llc_running's conditions on task_pref_llc_runnable()
and call these dec and inc functions after the h_nr_runnable updates. Wouldn't it be clear that way?
If possible?

Thanks,
Kayra :_:


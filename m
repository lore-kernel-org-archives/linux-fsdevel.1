Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C373BB134
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077820; cv=none; b=Hcvu3lNWjzDuhH/mGv59JuhexSZP92cw/ozTfqB42KHiJY6j9Iipnh/o8SQG3qbaVTbHqEGXPgy1Ha6eG0v+2a9iafHOknTguxnIhfM25kvYAObyPQ0T1E1iSiRcENAZqiZqVMoBxkdp5Dsa1JgYIuac3+Wfeu37QG4OR6srRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077820; c=relaxed/simple;
	bh=R6zJwtMniZUXSTTD1kXs8OQe30mecg5L76/NRGLeEi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgXQ7d2beJTwAIPwV0iJjunWFhnbcNqHoomQvvLegGZ3H1II8IEppuQEA6V8rHQCqzS4SxNgUO9eFiUsC1pWKgszAIXe0k67j/vTUs/u3UCwAVZiip3TggvFRSPXO/bVJhVtePTkZvhy1XM9JJz/chDQYJz0j17ZqT6I6paUPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX8Bh8fO; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX8Bh8fO"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48436686a40so22773f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789077816; x=1789682616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y4VC0C0lSHCs8Fcark7cmj0Id1dSh7PB6GmHxMlnI8k=;
        b=VX8Bh8fO3DZcCKWqBvPN/TMBYfSP252HHdp+vqoiMIpWRDOu+9zcLcxJxJ/gaf1oLH
         wAUY8ozIOlIYrJ3YsssD26QMFrgCyjWSfDASLNE1h9N2qwcsIRPIUd5tyAm+3AkXQVou
         krWLB71MKrk5eAPctlu7HjD/zoygACK+rnV+rOElrvBZcJ6mb45IAyQ946/EwMYntueo
         z/dXFiKLG19CiTicJPieg0APq3oLwEh3sxCiJ44ugjiTedEvl/tkbxW68jEwpOD/lgSM
         tX4fmqKB651Jf9hyTZKWUGalLcRxYHptTdFxKSlg12b+nxO3FMeozDfKzwnqz75w0toa
         a0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789077816; x=1789682616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y4VC0C0lSHCs8Fcark7cmj0Id1dSh7PB6GmHxMlnI8k=;
        b=aSsxiS8jJNqq1ICehBWlDtTDk/hdlE9X9HAQxsXHv7rALhoJSrrcV7UsjCh0J6dq5Q
         c827yGIIBmIjNRL8EKgfEB7HfYmkDAw1liqzEX8oP8EUr/5CNr8DEKhoQAucu5993MEt
         7ET/PNGy0r6haLJJm9WOLvqJ9yRjgTmHQmreV2UPep7nWB4yorj76O/21WlZV7hORalw
         Vt6J/WjuQL3w96OuErlv79Ho5liFuC+zbJQLvAbzgSBSbSdEVBKnmEhmcONauY9rmJcR
         VaIJ2Cvia+YgxotU0t97yucrjfMnQ9fYBox5wWZalKsX9NNLUR36SEA1Ipcl8x/+JVlx
         GfcA==
X-Forwarded-Encrypted: i=1; AKwUvBwo+LXSJfGj4PDXXZgtJ7YBy/IDOwTSa3wp15Z6b3fnR8zunKiFWizUBe4VNiJW3BS83ubxfgrAOKoNlBim@vger.kernel.org
X-Gm-Message-State: AFuF++kGYOB9JOgCVFPjVwsregxHZFGHCgs1bVh37c/Bkf9sq287o+hi
	mGb4Xwygi3lnQ3HOqJtrVL8FMw/wHClvkMNi2BPPkOTNQfmKAwPCB9vI
X-Gm-Gg: AYBFou2IlB8QOZom2a9SV/rJi5cxJR6UyQFxFepfwMl4Dcfm6r5gnB71+o1BEdLSo33
	JmPo2R1YxwyOHiYy2HmtfpXbOQzfg33tf7eOQ2YF7U6v3TzNaRRAw9e7Kyifcqruo8Wr11k8PI+
	3cW9ZAFeO3ZT2dKaswl6iuwDC26JC8qdME+lHc9qB8i/ivdtL1iJdeJ/YwZ/91q5zOgs++ChzIH
	BbEflwxsVk/N97eI4l6otZYnxGq3/LW762GDVD0cLh9/99rWQnLmwdQH01YuKe19+sUaMDLbgn4
	ABDFj0N3eu1oN+L/P7u0rY52p+GPqCrJnuUEzBvl03DAmBM3rUz5BcNXbuEFY45cPLUpwxpdPp1
	LtdwnbWqM3oY7FZkzmZPkbZgaCHU5fc5oVkdhw/J0UD07fZGnU+0R5vsgiX1+daaQw4ULnwX3Rn
	/UcNmQmGOhTmP8796CVHxeVdCeIdLQGAKqytYQSmxt/43yxojis1QOR3+Ce7ZRSv/5sfDr9s/SK
	bsYWQiv1qDYD0sWOWT/uQ==
X-Received: by 2002:a05:600c:4712:b0:499:d95a:41f with SMTP id 5b1f17b1804b1-49e61643939mr10000435e9.0.1789077815736;
        Thu, 10 Sep 2026 15:03:35 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c300e2sm111238475e9.8.2026.09.10.15.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 15:03:35 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: tim.c.chen@linux.intel.com
Cc: brauner@kernel.org,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	imv4bel@gmail.com,
	jack@suse.cz,
	juri.lelli@redhat.com,
	kayracizmeci@gmail.com,
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
Date: Fri, 11 Sep 2026 01:03:30 +0300
Message-ID: <20260910220331.1209469-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f3b70dd40e29b309ff3449a95a4af4513ad0ef70.camel@linux.intel.com>
References: <f3b70dd40e29b309ff3449a95a4af4513ad0ef70.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Tim,

> So moving the accounting next to (or after) the h_nr_runnable update
> would make task_pref_llc_runnable() return false and skip the
> decrement, leaving nr_pref_llc_running too high.

What I really wanted wasn't getting the accounting next to or after the h_nr_runnable. 
If we are updating h_nr_runnable in some way that means we don't need
its check since it's already getting updated. And if it's getting updated
that means on that branch we know how our check should behave since we 
are a subset of it. We can skip the delayed check on that way since we are
trying to behave as h_nr_runnable's subset.

>        if (entity_is_task(se))
>                pref_llc_running_dec(...);      /* sched_delayed still 0 */
>        se->sched_delayed = 1;
>        ...
>        for_each_sched_entity(se)
>                cfs_rq->h_nr_runnable--;        /* sched_delayed already 1 */

For example:

In this code the h_nr_runnable is updated the same way regarding what is sched_delayed.
That means if we want to behave as a subset of it, we don't need the check delayed,
since we check the delayed to be a subset but if h_nr_runnable is decreasing/increasing
we should look into our checks.

My head hurts. Please notify if I'm wrong.

Thanks,
Kayra


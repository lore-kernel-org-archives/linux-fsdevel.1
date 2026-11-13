Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590606;
	b=Vr5Hc15ny1j1cOukBF6hpEUkLYylDbLei0lvxtpmYRpzaLhUIhbWfoCSyvf3w5qTyRsk
	 nAZGoxEbAKBmoAYq4YWTbjJYy7s6h3Oxin9QDm5tJRlAjqJE2BdLaFn173d0Lm1uxjhGr
	 1NAUX/uYdGxwaZ+NuoePSomZGGhDGS877OmhuCY6Ncl5EPy3x9TChlrkQOb8TQkH9pf6H
	 g+lnBjo1vpLdpknibbfk6hCaRwblJTTOcCM1l+SQMACwpWs6FRov3ysSDq4+pDJWSq9GJ
	 LcoutMSCuXDYmC81oEeJstGW4pWQVZtTMuaY9iUmEkrOd3rCgU+ZnMsi58Qzn1wpzbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=yu5QMzc3QXUklBl5GRmDPmTAJYce2ooMnlaR9b715Do=;
	b=J7H2Ik+6P8IODPb+PQF7Hmj5w7gow4baNL31Dk8+IN9Ee9yL2O0eeR1SI9wpD73+Hnt/
	 3T+l32kob3exKMHi5KTqpDsvV9ULmXxp/a4lkRvBfmou5K91Lrtsiv84t2C7WagXz7Hh2
	 63B29v+10LGamnQYQe4STEyOM1ioLXl7dWp3UUkh7v4sj7nDZdJV36oMX73nYlzd8i5a4
	 0GjWEa8lOp4NxQPNOVWx6ik4FTzl9AGHDgiGN6an/8+vZcxvTAfsA5j3Hr9NRgFu9biVL
	 iMBWwJYZ2ujCph5Ft84ggJnZhJHb3rwei1l2XMTasP3yjbGaBKzZhoR+uStiqQtzDWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="xkc+l/Ri";
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0926075E07
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 17:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD0926075E07
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=xkc+l/Ri
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ede7cb02daso16932335ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 09:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794590605; x=1795195405; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yu5QMzc3QXUklBl5GRmDPmTAJYce2ooMnlaR9b715Do=;
        b=xkc+l/Ric1gBL/XJaF/g07pdXD3EjnqX30zCqgLh5dnb/W3Y3Q9ZzcPLGVnPIEW8I5
         i6wkzU4MylRS147v7U//alMndB9TXpOJXn0KrJJ/w0VKZJ/QDLctzKQtDx2FUPMqQGe9
         f89nfb9NApy3X0lORFb/a89MIDaaSpv1Mp310=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590605; x=1795195405;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yu5QMzc3QXUklBl5GRmDPmTAJYce2ooMnlaR9b715Do=;
        b=ULUUJDVI/zs+vC1DUFc+AeQl39VpV/P5dPO6F6vACgiJzs/fx/5l7JeXDWUub2+uTv
         oYuX/3VPTzJz+JDglTgDPSk4pHN78MukBYtp1KuSFzREJLnmzI1nKrYUA4bLxK2FetCW
         jPbJGIBOvK7w4NE8g7nKmnvsTG3uM2GmJbiTMwvOMGGSaZuqnkDQkTRQMx3AJVV6+VJW
         2WNMfMTRTcNE0PL3eomeaJLpXGnUdI4ZLk704Oco9hr1K3DB8q31Bi9IGKI4UWTKsKAU
         VUjzjMvU2nN4feT9fQPVHiZVWobG19LBEatnNlGw+BHwkLvZojYxLJI96EynjK3WfD1W
         WxFw==
X-Forwarded-Encrypted: i=1; AL+hErGqSGWOpLFmlslQTmHJP3EB0SpJOOv4rQ5cWLDSNmjrs5AU2TzV/rCf5muYIjuC8pPuaRnSvvX11fDLCfO1@vger.kernel.org
X-Gm-Message-State: APuU4Z/GtRkFKb/yczyPwLu0filLsRpOmi9n0HLfEb4cyFbiWgg6gjyd
	FkzCl4bXTVhalNKIR8aSBhAQKpxYUjLFH9P64a+M8P+7BS8EATpv3KH1Ma+h9u2cywE=
X-Gm-Gg: AYBFou19YO8zfccmIp/7zxGBSdf5Go4N1etG6QVdtzTLCsZwvR+ZCsfJz3SN1n/c/LR
	4HoIoHgJ/IHwuN0DrK58ozunSfAAo0DWaHM+XcVTdbHPm1GWEmwkLqhEoOXZEOrPGDbJiNdbOBe
	oTkZMk0fZ4VyOBHS6EboVK33C6jej63HLI+K7r6aMMpEme69sjZn1gZlq9SihzYN2KXWVHKqAU5
	vWRVxhCAWb5CFA1xDolwKxNIgJbOV0aZm1iNCRpDLbbwdVNKUARedkTVxVgBK01vViQWpXieCag
	BOCPxSw359FJvnyNNQ601ICQvikvG134F6JGXCk60BNX49wT65BDpzr1llfvCFPgXDdqLYEwphF
	nYVTSzZi5FjPmP76IS+kC5SBkrpNvvstJ3GLUkR7Rc+brRGpIC1JxdZW6junQ9ghGsiuvobZ2qv
	FiRdSLfp21NomtM0ZyiTuh4LytvFQulSOijGMYJ+OvssUk8hCm3YGmHJ0Px8dEDOr+qC+yrW5Ln
	mw1h1cTl9PnRLw8vHS2Y0Yepb32GcUb8p2bOnQQaXFcBx3OOuDkf9XPNGIFjUss1lD7wnUCUkLI
	LQ0giF74GXuZLYf0fbUVM3kfzuKYgREIOW8JHcGmGvCi0XQ7J9Ilkc4wxGPw+vC81sNVTgwiWjf
	Wr7Mv9iuxfoAAs2hFX+KILPt3R9EKeUvzDsg3DE3ImabKTP8XgR0kBS3LJfx+v4VcrOrO0pDFRb
	N3UV+0qW5o3FMU1q952rQ1ePfdhrm+cmU5mED9H5iD3aWipHPGWAIEDJLLp6o=
X-Received: by 2002:a17:90a:c88b:b0:3ac:a6a5:5757 with SMTP id 98e67ed59e1d1-3b1b0b5beadmr2012590a91.11.1794590605026;
        Fri, 13 Nov 2026 09:23:25 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae98151dsm5319144a91.2.2026.11.13.09.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:23:24 -0800 (PST)
Date: Fri, 13 Nov 2026 09:23:19 -0800
From: Chris Down <chris@chrisdown.name>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Julian Sun <sunjunchao@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 4/4] writeback: report a slow writeback wait once per timeout
In-Reply-To: <20261110-writeback_stall_report-v2-4-9e0ed75074ca@debian.org>
References: <20261110-writeback_stall_report-v2-0-9e0ed75074ca@debian.org> <20261110-writeback_stall_report-v2-4-9e0ed75074ca@debian.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261113092319.f975912d92c98651@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Breno,

Breno Leitao writes:
>The flusher only checks for progress between inodes, so the wakeups now
>land on the first inode boundary past the timeout, a bit more than a
>timeout apart. The hung task detector scans once per timeout, so it can
>catch the waiter between two wakeups.

This does happen in practice. With your null_blk setup and the timeout at
5 seconds, the waiter gets woken every 5.0 to 6.1 seconds. khungtaskd
reported sync as "blocked for more than 5 seconds" in one of five 40
second syncs with the default check interval, and twice in a single sync
with hung_task_check_interval_secs=1. With hung_task_panic set, that
panics a machine whose writeback is making progress. Stopping these
warnings is what 1888635532fb ("writeback: Wake up waiting tasks when
finishing the writeback of a chunk.") was for, so as Jan said, the wakeups
have to stay below the timeout.

>-	done->progress_stamp = jiffies;
>-	if (left && timeout && (waited_secs > timeout))
>+	if (left && timeout &&
>+	    time_after(jiffies, done->progress_stamp + timeout * HZ))

But this check can't stay as it is once that's done. progress_stamp is
reset on every wakeup, so if the flusher wakes the waiter every half
timeout, this is only true when a single inode holds up the flusher for
more than the other half. With the threshold in writeback_sb_inodes() put
back to timeout / 2 and the rest of this patch kept, the same test prints
no "has been waiting" reports at all, only the "waited N seconds" line
from patch 3. Going by the code, three quarters of the timeout would
mostly have the same problem.

The report_stamp you had in v1 keeps the reports apart without touching
the wakeups, so maybe go back to that and leave writeback_sb_inodes()
alone? That also gets rid of the duplicate from wait_event() checking
twice. With v1's report_stamp on top of patches 1-3, I get one report per
timeout and no hung task warnings.

Thanks!

Chris

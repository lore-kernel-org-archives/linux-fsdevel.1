Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B1501F28
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795805; cv=none; b=IyvWuH0YKTq0DXjuyio3tlBbH03eTtKa98TJ049MFHQVG8TCrAGoCM99IQqSj2LNvRkO5mRO2jZgjveHLrl0A4EXKUiZSRdYRccs4UEP/RCImpPkLieHKFEmWb2lVabghAcVR1uEwKpI2PwW4rlHbIqhBZyRljIK+dF9VgJhuoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795805; c=relaxed/simple;
	bh=MICC69rDhpY77nwXlWteXYHHthmexIfa62lpP2Cj7Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZSDPUIl7NOJ7vaiEyiED8YBMYzLoszSeLuvjUkIV542ST4rK0TE1LT+V+3/ZfAcPMS/oCRglkh4k8hw6v4NEGXfUkADZty9x/vFhWsqvvxMuO6kkimPO/Klw9OLyJuG9enMjdR6QEEHsvpwyj3T5fwpxAMA39Vbt+f4DiQDXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Dcby7mMa; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Dcby7mMa"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9391252b5caso242887385a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788795802; x=1789400602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9N6f/b+RDjU+5LdwC1W3FgNOtZzFd5njRslDhw37g/s=;
        b=Dcby7mMa23igHcsyogt4hMcsQ+LF9/ES8wasSJN5liRTHzn6a+6B8eXPqKM0aOy1Uq
         x9PaKWDzBn1NBHviEWZtE9wBpsyTU44o/5IhM4HkZHowaBVBQ7TwQxBmmNUaTpq31Z1R
         3NHxEtcae0R7ht9bjMQLD5quH78Ei9I7pWfkkADIT42Fh3jUNU06bgnkfg3/E4MsGxdO
         LXi0zYbnzstFxw5QmexR0S35KLzBUoQ/5kuCbBwEnHSnlN4Y0CtzlckZOBIq8p12pC6R
         gvaFbq6dtBVtj4sZ/m8gBRTbhGEiaABmWOIhFYsKEQFGBbyytulKzhaZW5RJZqer41Am
         SezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795802; x=1789400602;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9N6f/b+RDjU+5LdwC1W3FgNOtZzFd5njRslDhw37g/s=;
        b=tWfxdNY8O33194yH7rG5XZWuPD63RKHOGtHWa9gdO4sZwFuMcqoogvGjHz4NWXrvm5
         Ybm5+nC/3c5wyq8nRf3v7Ljnj2ewv1nuV8xGDE9QgqjH92/xVuDA6XyJJQqNStKykqp6
         +3Pg5gu7MJsg0uCi4K66GduGLccEZyXAuC45raR+yAUvvE4Dtth61xlXEF6Cfgn3T7tR
         IO0jAMejY3iOSU2pAycteueXF0lKjOPQ85Gj7hWthM/gDCj2VWWx8J67/GITXQq5SaNv
         Zsa3/huRyepmgiRBZC2VMM4TPZuf4yuILip4lai+chqvPKw/1lHsfMGK7hoU4+UvyHSs
         1IpQ==
X-Forwarded-Encrypted: i=1; AKwUvByjxF114krjMAfzbDeyxcVtYDeGk5OaAQfI8q0Y/wiAEnKjf1vy2UeQQKgNEKORAQFFzHNUyPGwtH2x59p6@vger.kernel.org
X-Gm-Message-State: AFuF++lnP6SJ+qmxYeafmDYhYr0KuGZI+p7xZOcpIvo6Im1JO2mzTZvc
	/c+CZ2M2GNwUWenJSpmPACAW5b4mJ1UDRxZoONUkQZqNnEoikdrnQxYAPWMVQWmiFzU=
X-Gm-Gg: AYBFou1sc6tiion+L3qLK5oMQ14H/wTee8+gUsjc/WIxUPx0EYVzjDDysVMvdq4nVnI
	B6Iq7ImSiiaINcUfaw4FI2Yix79XJdwE6M9NXhwsHl3/UQxexgZasx5Tbu23bBZFlyRTqle3A+r
	OasU+YA4k3yJxOG/MP09tGN5BUvT3m4XUfSiaQbKgI/iuD1jkgUQNpFcWkycV76rzNZSnj7X0IR
	txk0SWycbm1FP2///P2EpaagSzDoIs66F7GArundGRPw1dCTAz9w/ytFjHTDOqus8BN7P7nUDMP
	44MWmIh4maWyWjTDRxO+PlMsOKBkgOBPShXqSfh88hfh3+YjpjTPeyo4qsydWQ+4rHdrLS6QWBE
	bjyNYYEhuFcSF7qYGoLSxYukg+4LjkUUb0sV/mq3mRUFwUmBArt4vpJQEbJZ0bSDTGaJf5n9ekC
	FxStxNRYTeOs8flZ/8De+ZaO4fp+dbPxWzaGczGN3cgYewEDFFAhp4mkxr67LsrdzQsDqh5z8vw
	X2zKAmAeKXwAUrRY1fwK/oYqphI4k6AMEa6xf3Oj5gL
X-Received: by 2002:a05:620a:1a10:b0:939:93f:3b41 with SMTP id af79cd13be357-93980341197mr2411106785a.16.1788795802336;
        Mon, 07 Sep 2026 08:43:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406bf8c3sm94620766d6.48.2026.09.07.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:43:21 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:43:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	SJ Park <sj@kernel.org>, peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, 
	rostedt@goodmis.org, jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, 
	tglx@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
	gnoack3000@gmail.com, ljs@kernel.org, rientjes@google.com, shakeel.butt@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/8] mm/ksm: convert process iterator to
 for_each_process_rculock
Message-ID: <ap7biSs63MDeB34i@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-4-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-4-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:29PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process() loop in mm/ksm.c with for_each_process_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: SJ Park <sj@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>


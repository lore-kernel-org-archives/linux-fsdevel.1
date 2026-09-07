Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F4B50C2A7
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795752; cv=none; b=ItjzCTH3SIemF8F/2ClD3gN0Up38VLEcKLm4qnAqNR7rR6WyIKaKhYgDUnfIegvgn8q3jEz+ZO1PwlyOlv2VtQUS1fo1axVfjXrjTHvLY2eKH1+kb4gleqxqfVlC40QSsw+2GRaBsTmX4NxXNQU9PIdqpGzQ2RcwHe1U0mEXVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795752; c=relaxed/simple;
	bh=+OOqmbaWCc+bj0drcgwfudfjBi7gFVexonNebA007r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSaYK4lFNsH6fD781Q+QGQ+jYNGBQMMBuQBRkFqrIbuF3TePWgDBVGg8wJXAq2cEFkVQjTj0qqbh1DJxN5IYLML2wE98EN/hYgtgFiN46eVv2NDqhbjrPEHHRqZ7CuGCOTD/6/QegJh+DAxVth9W+OJxS3sIU+DincF8FzwetUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FdRMqgpf; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FdRMqgpf"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9399a1c21c1so148758085a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788795746; x=1789400546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UsM2t2muwC2t6tub3Lkt0Nmc2lGDELjoRCFL/zUluw0=;
        b=FdRMqgpfx1J0zFlqgT+7WgNaj4cSat5/uXgUrOcggIxlg16d1IM6j5fzpoJdfxjB2P
         /9rUsuFGSVHMph0igjnLvLn8ySpk+gqUvrbN2vFaavz5LgUAygmQgsPjMBRC7VanS43W
         JATad4DlLfdmil2YdGkAk7tfgNrN3SfEqLlxTPx+BvyXWvyr/1Ny4qAc9W2iZ6xpxYhN
         3K0/WZ5iPJtbKqRjbXrV42h3dY+YXtAJuM2JWde/5KyxEbZBHxotsnD3mqBpV8K/mpt0
         eO0NVTl1ECtQ1D0rNaVQ1r0m1zbGZZIhGn0fLez/Vrp9QfQSJWdVs2a/JZrDUaX1hpvF
         3YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795746; x=1789400546;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UsM2t2muwC2t6tub3Lkt0Nmc2lGDELjoRCFL/zUluw0=;
        b=XWQlT6KtuI4L1ZRc4V5SK//us5BeAYZwOEQy34g0ZNMdK8y51fsckw4SL0CAjdqXL7
         RuAo2OzHd1fV+x+86J9Cw9WPOiTCq/sPiKQ6FC0hiszznajOgL5fY1ZNBbRKCSuVvp/M
         +y0noGX4iX9qrap/x0hbpdQhrOQC84eiizx7F836gshrAXKWKbHr+RVrGm4JtlIQUYab
         XPFUqIwuKo/Xo/gBRhFrUIkMEDM5LR3gU9s2xOWcPNo5lsvt0N9MLeUWHYiJ7+LjvB8r
         vuJE3u9PFbu40+DTFUgNKICCa4DSfQMhECMzok/tfvINmzvkKzXL46p3oqYEaXpCuhZb
         bkxA==
X-Forwarded-Encrypted: i=1; AKwUvBwRRI2OBel/0/Hvf6d4xkyemc0cZ5bgYqGIcEUfLY8AyuQSrhDrRpWP5GbrcckbqucHXQK2FPr0Hq/AchJ3@vger.kernel.org
X-Gm-Message-State: AFuF++l8fwsprt6onSTfH2vD7qNjMmsjh54t56dsgOsyeYHQ8FHAKA9/
	E4EeaNAkBfIDgvGsclOqSTh3nlogX62CfRjuQz16kbT6w9nqvq7J05d+OJI+l6ng+dM=
X-Gm-Gg: AYBFou1epkZwqs11u0GXeWfZhcmwvCWtrAUK+vohFC2UxPgdz9N3v7YctSNt8N9V/Op
	/Brv0vzS9zMOCXgQEVoC2y79huLCLEV+nrRBwE2NDfpRK3wKxrIbkMsKyhcIVWO/W0PxVUAf55X
	KXkhdb0b47vtw54oLZmg25ZHxNjlprWg0EQKK0/XFnmrM0p4kcoGh+qRU9nB6cJUsDpKP1WwtVr
	8adkBV86CcQ903GfSBh0eHLG5q52fxhpNED/pvSVYsR2LQk+uhte+tUyinLYbRDtTbIZ7LKwf7C
	yxmrE88KZjyExZtlniRsrVmuYZdljAPfvjEwr5IJTmZtnNxoTvjI6tkMPiiVEYZAZ0AaFycP9md
	JlDpjNsdjA0ZdlG2bF//GdWTKfYUV9yYBXilJHC2r3ZGV601RmuE9qKTxyOOyVDxl89+5INb3rl
	nzaDiKAj2r0aAETe9lpKPsvue1bbQhbU+JebQmyB9SOiYL0CXYuEQtywm2//bPHfKOGtCo3elZV
	/SuiqlmNfvGVdFI/1YKuj47EgcVIs5FlZII0lb/USRz
X-Received: by 2002:a05:620a:aa14:b0:939:6c2a:24fd with SMTP id af79cd13be357-9398031b73emr2041569285a.9.1788795745703;
        Mon, 07 Sep 2026 08:42:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040646d64sm95118286d6.14.2026.09.07.08.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:42:25 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:42:22 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Ye Liu <liuye@kylinos.cn>, 
	Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Yi Tao <escape@linux.alibaba.com>, 
	Michal Hocko <mhocko@suse.com>, paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org, 
	jpoimboe@kernel.org, mic@digikod.net, tglx@kernel.org, akpm@linux-foundation.org, 
	david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
	gnoack3000@gmail.com, ljs@kernel.org, sj@kernel.org, rientjes@google.com, 
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, 
	boqun@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/8] sched: introduce for_each_process_rculock and
 for_each_thread_rculock
Message-ID: <ap7bPSbO7UvFSwPf@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-2-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-2-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:27PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Introduce for_each_process_rculock(), for_each_thread_rculock() and
> for_each_process_thread_rculock() macros that acquire the RCU read
> lock before the iteration starts and release it when the loop is left,
> so that the RCU read-side critical section is scoped to the loop body
> instead of an externally managed rcu_read_lock()/rcu_read_unlock()
> pair.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Lorenzo already picked up the nits, this is really nice otherwise.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>


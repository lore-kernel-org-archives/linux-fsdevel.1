Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DAC50AC0C
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795780; cv=none; b=MgF7BONFhsIVr+CJZdNjJYGCg/A9E6Uvt20MF19cMylMItGfvxjTbkGJKXe2FiYqgdXa7iaeDBh+1w/e9UTCS9mERqt49ZhM/+S7I41J6kige+38E/ANzjfZKGrWj4wyIzfh/luzvt6ZT/yJDZ0BsU9a/CA3FODXn78QPjKtpBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795780; c=relaxed/simple;
	bh=QtFPJiEMPSV8S29PeKQ6fcZP42NUa5u8vRMrfd5W/ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Miv14DAQR7vc8AEEoyukOxIFq+MwetxOF/7m3f7EEKBDP7z1bZucVbePMBKLy80FrXmNDRO0HsuDF/XvbtH06Ss1B21Ldgwq04zGpQQ9WuUlFWFboYvrfb31m4zsZ35ZOZISSHPeeMJ0kh0C/npL5VBJuVGMGu/jVbjKz2J+YsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=u5XpV1py; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="u5XpV1py"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9104956083aso24897696d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788795776; x=1789400576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K2bTzYuWDSR0jh+E6xDNAXwrxj96pyu9ESjj25Dc22Y=;
        b=u5XpV1pyWPn+OPlByOIxZ/a2rHnc7iDCTmfm4h54GPexVCJAoRwfCrTxogIXRAhxXp
         DlJKycZAJs9eBZWBy88+QzTKRvdCGMqkzbDHGiHfCNYV6dR3dYQpAabebm4ARI5VzkrR
         U0guES+JYZiNFW+FdmiUFtCD5g5u2bXLYvjHWEKC8g0SXMiMbQvYaCh6HZHONw6OoRvj
         ZipjISx4LvG5IiBC7116GrH6WdN+SwNJHuAwljjkSGdtfdz/rcKhaW+7D8mOX3ZjQt5b
         BEILZVv91ew17kfj1nj8Xwtyto+EGPIav9Cs/Tq7csxl2I1pOLHOnuFtMDQ7AksHwEIo
         o/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795776; x=1789400576;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K2bTzYuWDSR0jh+E6xDNAXwrxj96pyu9ESjj25Dc22Y=;
        b=o8RVAFgX25J0y8tkberDO430CkLlLuBR625DjI3MxvqW0w5IjuHGOZBNs7zsmngYH0
         YXLmgq8wppHb7HOH/T85ivHvB1Mq5x/JOL6K9Vd0yKJCZA4E4eYKzm/DT6fSjpw1zCB0
         fR86W4E4jJbX8kcbGRbDwRet/kxlEj4+Rem5BqwXoJs1I/A/RekWHDYbOqiiYWT5U/vR
         /0wVdV7Hkt4yNmXidNqTP3S+vS8D9WR9Ft+al6G6zUsEyzshvaZNmTii1CWc7AAUFxDF
         jTf+dNoWAowOAOkX6uYLwQ7ZoG7/zHsPE4e9387MCbV7Ll03XcJtQZJxwOLSYFpwOcyY
         uQ6A==
X-Forwarded-Encrypted: i=1; AKwUvByM0SMs9r6lp11BBl2M83QoVy8xP4ZB2ybtokYDBTKmCiQL9Zpt61oJdtMvLGNI2R8PvRiO11fva3ve2XRv@vger.kernel.org
X-Gm-Message-State: AFuF++n5GB7K3Lrdx017rYtFOwP9wt7z9QcV/FwHfEObzjE92yGAVdH8
	UTFhvSQZ8mVle5SlCWpi0MYCZC8Rcc9kjpviVzHXaPcJaI4zW1mr5XQrgvF1Y7vfdFs=
X-Gm-Gg: AYBFou28KdPapsGT4XrRUIUgMfY9Ire5PDoPmpGqqWHNPKeA0/SyJj0/rgYdWBYIkEC
	v7qF2pfapMP7hZk+KrMf+7emt5KnEZh8jFKuMbIZOlGFkGtfeTC0Vm74cvOAamAkqkv0csjiDd+
	3sGHm7rjRAGxTi6tRSESzB3qUV07eM01giqLm+fYgwyYp3qmaSiFTb6Ce46wjH/qe7k9loIKUZB
	3a4VzclvjT51FcVjwm9Hq9zAo9znG8c0efSQE42exI6gKwKa06dB4fIV8jOCwuNHcjHjKCqVqKr
	tPgZVGiP7dZ2xwr3Pjc3F0ldGAMivjFl/suKOW+QLWLbnwK7YtQPhP10HJ/BURJ4EZX/UUhR9p1
	XyddBv0tMBVT4SeygEoQ3YaIWOoN/FH4QINX1mR35DhdyrxA+fvP1VKV2yFE6G8xDBTBaxJB2gS
	G4mgkWJy0bF0ou/hDYld8Gb/98G8420MnQufCF9mDMEU6UaFk/iEeioNuSBlSWuP4CkAIqNgyHZ
	rUBMv4xXDgHujfPQWqXUcEU1MLq/AY+HIwhhTgTj2vU
X-Received: by 2002:a05:6214:ca4:b0:910:5235:14f1 with SMTP id 6a1803df08f44-910523515c6mr109464606d6.22.1788795775829;
        Mon, 07 Sep 2026 08:42:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406625d9sm93010046d6.20.2026.09.07.08.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:42:55 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:42:53 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>, SJ Park <sj@kernel.org>, 
	peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org, 
	jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, tglx@kernel.org, 
	david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
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
Subject: Re: [PATCH v2 2/8] mm/oom_kill: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap7bdHdjGgmIzi_P@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-3-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-3-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:28PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs wrapping
> for_each_process()/for_each_thread() loops with for_each_process_rculock()
> and for_each_thread_rculock(), which scope the RCU read lock to the
> loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: SJ Park <sj@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

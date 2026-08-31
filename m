Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D393DAABD
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167385; cv=none; b=blMl7VyuNpB0BZv4xsLswwbG7XM6GDssM73NvUohBBcKm8Jt8NmTVD3W/EqiIqQ9+rmYyeuhjlgM/HXtB31vVsWIgV7cVKwkJiz+LAoa7IJdaTBDmji0s5Pr8qwhQXpF92cClDZJrK/gnVpeo4qlbfoPcMHSYO0Kbxaf6J1bFwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167385; c=relaxed/simple;
	bh=NQzxN3RdeSfNNKapYyGm/IPsR5F7fvtch0RxWaHdydM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlkwrzreXi/VmVjbSWgzsHQlj3l8JNhrXHfdF/gEgDv6poII9yiHNpvHdmvWAoE5H8cKghu6zCmqnhofjNJ/ilH/BvdEdUxRQyybV1u49S7XvWynCzT0svr5D2K/D8/H/yCuEhzHmywvZyyACSSWHp2KM6NWeSqRS5kZqJ+4VqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WmMpEtxz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WmMpEtxz"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482f9309813so2117846f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 02:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788167382; x=1788772182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aoEjE8TELGQjXx5xs4Igsq3G0G5VVqVmGoWAazModw8=;
        b=WmMpEtxzhZHxRnsH8+ngDbHTxGffgJFMISul3O+BJgXd+uORanf0Y2OuOYK1AYgMuR
         0HD5hiduf+8BPeh5Ley7RbcNMR52BrsMv4DcNXtDHoTtx9TQEJR7BdIjeTcC0pNtZ3Wp
         I+xaqjTIvWFCjTvjl6/FocrNcrmxzDu4PkV1e3jobP311xAW3NZxF9UOZrosJhw/inRV
         DsxB16WauJUD93wGsB6AUYmzivm0fgHg2Mv6MxLFmCJPcoMkXyRHTd5gC8xN6sNiKRu3
         gU8Ie3N/0EmZbOtODKDH8wVGRONSHF3EE8thFqkjXNcRqIfzEhi/4d6GTbwbCm2PW1qm
         gF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788167382; x=1788772182;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoEjE8TELGQjXx5xs4Igsq3G0G5VVqVmGoWAazModw8=;
        b=RggSwfnhbhbwQf384YnFsZg+cXuKipVaFLokqjMf8xlP9Jn4pqcgiEBYvABBgUStEm
         frJNtftC8lVZcYj+AI8U3KQEi5LK1Ljeop10iLEJwe7mC08oyRWF+Sn+ZZSXlvCRMmj9
         +nRwF3SnyQJ8FVc9mqdZ15h67JIavbAdSvph2LOQzlqHrh4B0rkjLxFyZWcuDUuT/I80
         9wTRx+vPnlJfW4WrPATIxd8hjsfmEjeeyc6k9mBp6T4G5sTULFQey2zrmMCm6Xl5FMFl
         S0UtGFOoBF7YuLLKkRn1IqSkO2b5qDPIfTxY9UcmEz8af4FS7da9fXKveSlGKzZVi7NH
         1BdQ==
X-Forwarded-Encrypted: i=1; AKwUvBynGY2M83/WpcHDXJ3YDWg8yMwQ6e3RjaSojb2My6eWUhh1352mrckN6EujdVj8JPWdYFWX9qCln5Ftzejs@vger.kernel.org
X-Gm-Message-State: AFuF++kfVDn5lsKBygkKg7fMqIBD+7xU61X1NSCADFgwHOHxh4tuE43A
	rjtpklty3fmXsOqpXxqKadsHY//TTvLX1MNE3FLHCPiRfFmeiX5ju2ypP23NDgICdnI=
X-Gm-Gg: AYBFou0PR4zUm6ikqstnj7FH91f+ar3+ZchwZm6fCpUiFHOs8tFhtdJ1wTMkrbUpGpN
	O5hzVE3WdPPTLOw3NNSuxtIS3ovNG2S2shziSG+zCqQY6SafNl3c4T5kVIiXife9MD2jUze5dWQ
	WUtrdbHtBlHP2Wb/IP3tHKXTt8Y7WJNMZGqL4Zi+ZpdS/PmQjYNQPo41eXj8GlGhhrMgmW2hk7L
	wIMCPvnDsgPzSz/sKYJRDVm1YYmUQE7vXy5v6vjwxBYqyz2Qim1t+5FlMpMcM8XN3QFPK3Jdeig
	9Yi54LQvlNUEt3B+cc8DbZsGWaSbIwKqTMkj2ks47WQiNigVgN/iavzzZkhOmIwW/V4VciU7XWK
	L4MO3WS/tT8tM98MgVr/exPUxAN/xURz5v5d0xyT/tXa4oqi83+QKLXan9dxObXsnmtpzHUSZo2
	0nLVFiodIMiFF15Yj2PiMtPquQB1m2nVyp1PJwgInc4dIoGVHJBtPN0T83zFqDVzO2puIQVGSQy
	T5r+5rFrlK+
X-Received: by 2002:a05:6000:288c:b0:484:3bb9:25ca with SMTP id ffacd0b85a97d-4843bb92758mr8741566f8f.12.1788167381881;
        Mon, 31 Aug 2026 02:09:41 -0700 (PDT)
Received: from localhost (109-81-17-247.rct.o2.cz. [109.81.17.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb28492sm20835619f8f.31.2026.08.31.02.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:09:41 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:09:40 +0200
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <ye.liu@linux.dev>, Ye Liu <liuye@kylinos.cn>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/oom_kill, proc: replace magic number 1000 with
 OOM_SCORE_ADJ_MAX
Message-ID: <apVE1A1pI4Ad6Ts5@tiehlicka>
References: <20260811033609.3992348-1-ye.liu@linux.dev>
 <20260829201310.648ed330984b91b1c135d8a3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829201310.648ed330984b91b1c135d8a3@linux-foundation.org>

On Sat 29-08-26 20:13:10, Andrew Morton wrote:
> On Tue, 11 Aug 2026 11:36:08 +0800 Ye Liu <ye.liu@linux.dev> wrote:
> 
> > From: Ye Liu <liuye@kylinos.cn>
> > 
> > In oom_badness() and proc_oom_score(), the oom_score_adj normalization
> > uses a hardcoded 1000, which is the value of OOM_SCORE_ADJ_MAX defined
> > in include/uapi/linux/oom.h.  Other code in the kernel (e.g.
> > fs/proc/base.c oom_adj handling) already uses OOM_SCORE_ADJ_MAX for
> > the same purpose.
> > 
> > Replace the magic number with the macro for consistency and
> > readability.  No functional change.
> > 
> > ...
> >
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -594,7 +594,8 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
> >  	 * exporting for a long time so userspace might depend on it.
> >  	 */
> >  	if (badness != LONG_MIN)
> > -		points = (1000 + badness * 1000 / (long)totalpages) * 2 / 3;
> > +		points = (OOM_SCORE_ADJ_MAX +
> > +			  badness * OOM_SCORE_ADJ_MAX / (long)totalpages) * 2 / 3;
> >  
> >  	seq_printf(m, "%lu\n", points);
> >  
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 5f372f6e26fa..08bff7a55db8 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -230,7 +230,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
> >  	task_unlock(p);
> >  
> >  	/* Normalize to oom_score_adj units */
> > -	adj *= totalpages / 1000;
> > +	adj *= totalpages / OOM_SCORE_ADJ_MAX;
> >  	points += adj;
> >  
> >  	return points;
> 
> AI review suggests that this is a misinterpretation of "1000"?
> 
> 	https://sashiko.dev/#/patchset/20260811033609.3992348-1-ye.liu@linux.dev

Sashiko is trying to be clever and it is simply wrong here. The scaling
fact is indeed the same as the OOM_SCORE_ADJ_MAX.

-- 
Michal Hocko
SUSE Labs

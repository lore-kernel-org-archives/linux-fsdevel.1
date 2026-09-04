Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E9449B29
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520020; cv=none; b=Lh1HGKFsub+LrpOEcx4Or72njXU6x3jko5blFoXGCr1RKJHmOGbRey6/YwwAR/XFbdHY2C/hx+gV9dXgNDHT316gMX6+59yxgU7pxqYYM2F1jF7vvrs8Rghhyio2J+3WacnmO00jDutgHveOhMWv+5P5JYkB4BVqp413fz63Vq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520020; c=relaxed/simple;
	bh=SF/YlEQK954Oqqw1MugM1o137YjqR+3X+umSu4LOZR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mARXFS+gQUI/6fYxa353OnupjJarXXPRpEFp76KxRoDQhXSu7fvhC+VgklrbckjmFhc7tf2ydpNI7xpZQLyaCBbLtgYsD/JikF/bKMLK7DhjrGcnx3o3xB/ou8O4WQSjXHLy0Wtk0Fh223ALOM0SbpmCRa/mhOFlboO9JzlTQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XuvgT+5m; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XuvgT+5m"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so8041755e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788520017; x=1789124817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LN+05tYUoW+ljcA4oJQdgwn36aZVMFD1VDoe2ImKRvY=;
        b=XuvgT+5mgB54GA2M4ENjcxfslNkgFqidKhdyQMw9gaK3DTLXVL/PJjxfba6GOX9xXo
         +JOLj9oep77ursC6wt7TI7YOCXZvazOGIUSo8sqCPbvbB4Yzep8REDt6dJmosWUvHw/B
         3r0LGtsrO5JkYaAhznCqf+/oNNhQcHUReZr4+2jCEBIS2ncBfnLUr82l+3GlsBmUw8E+
         gzDDCUMEEBDozBHspj0m9EHQ+vgxtg0B9kHk+Ux5Yyg3jiQKkq5H6qSglxQ+6e1lkj73
         jDIO4PUrbRReKrnaDKtPsaiBu0AqDQE7b50SBnnHdkvRH3qhMOPBUV332KHTEYpeHYm+
         Wp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520017; x=1789124817;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LN+05tYUoW+ljcA4oJQdgwn36aZVMFD1VDoe2ImKRvY=;
        b=VPVMEQbfhIXEeCg2QO2eVplE1XTCO6FDvCx0bY9HhLIvt4T1Vxl4o8lKHxGok53H4t
         dik8nm3xyuvDE3p304X6QP8w4pb7k8IHiq9tJza6ZjpWwDJqJgeKXGilryOFkQkcseKX
         aPYoIScKAvSuOX3+FH2S8g5JCZXPg/z9eMvuY7a1acS9QiAvWtQdTnzpoAzPzKA5s5vA
         1nO5SZyzN4uYR6W+246UWSDS9pkbXntDj2vs9oFaFEm/FQgDAUP4C1kFFOvQb0G/H/vF
         MiX93EIw5CWAsVeVwKef8EwWL50SxjpPYCQnC0G8QQShHmQqOn9yKh5VfCrPD2KYWT8y
         ni2w==
X-Forwarded-Encrypted: i=1; AKwUvBydIh7DVk+GhuT1Wi97+egPacR0FKsp8aBMNaKCq8fVA70Cec2Ig4Mjp87UWDXEIDlxO+WAl7EBwf9kIXS7@vger.kernel.org
X-Gm-Message-State: AFuF++mafhbDGkI5J/ldPZRFXcT2QbxUVzBWnwLK06JglVmWfI37KW5C
	2Lai5OJpGiOkwH6PceOSa9+FpRoiNIAOut1yitlP2HIiuGvRKAGzVOuTZoSi6Pu3KSQ=
X-Gm-Gg: AYBFou2niqXN7pzLP8hyFJAm1p+Wlq3+rVKKb1XWHxPFKJa3M6kWc/F1CyAdHGF2HLo
	Ui5sTvmcuPGtjOscxBYUniRLv8cekr33K7JH/mpHB1DVWmNdsK3bB/TgkUN5OwHh5F2oVlOlrhf
	0h1LX2L6/WMdP1aF8B4J57h26piWlTI2BWbcdfIh+BzKavrRDJqvi1X4uytLTvjJ6URmv3nTSG8
	pWJeWTakqIia0IGctafM3pbqd9Wsr+sijjOtF4v8AfI4Jp2zFXGiCRRgmf9M2lSiRULx+HjZJTd
	00clacgOKt/+LZBvoOhoLpZF1kePiSW6MRsurHHSr8KU493GBroBP+1vWTd5RsyuUeEX/cSz5P4
	Lzl+XniMf3bAghHkl/srcLVf2E4plx9JMIi+CeyBHcl7Buz7GenZQfPqZISpKRIeAQT86X18YRg
	OPF20hJdnSTzE/2J3TWtFw3elyQXjlKFE+Qvn2bB3A6htatwks3hh7KgVL9YY5lSbjPerOtEDPE
	QxGl5WSrNBbYcwCy349ZpVG
X-Received: by 2002:a05:600c:4709:b0:49c:fa21:e748 with SMTP id 5b1f17b1804b1-49cfa21e99bmr29698025e9.30.1788520016817;
        Fri, 04 Sep 2026 04:06:56 -0700 (PDT)
Received: from localhost (109-81-91-122.rct.o2.cz. [109.81.91.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm161987755e9.13.2026.09.04.04.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:06:56 -0700 (PDT)
Date: Fri, 4 Sep 2026 13:06:55 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	"David Hildenbrand (arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Ye Liu <liuye@kylinos.cn>, Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/8] fs: convert process/thread iterators to
 for_each_*_rcu
Message-ID: <apqmT2phgpwHD3v-@tiehlicka>
References: <20260904083001.553587-1-ye.liu@linux.dev>
 <20260904083001.553587-7-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904083001.553587-7-ye.liu@linux.dev>

On Fri 04-09-26 16:29:58, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
> with for_each_process() and for_each_process_thread() loops in fs/
> with the for_each_*_rcu() macros.
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/proc/base.c        | 4 +---
>  fs/resctrl/rdtgroup.c | 8 ++------
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 6a39de424f62..da36ba73dc17 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1160,8 +1160,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  	if (mm) {
>  		struct task_struct *p;
>  
> -		rcu_read_lock();
> -		for_each_process(p) {
> +		for_each_process_rcu(p) {
>  			if (same_thread_group(task, p))
>  				continue;
>  
> @@ -1177,7 +1176,6 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  			}
>  			task_unlock(p);
>  		}
> -		rcu_read_unlock();
>  		mmdrop(mm);
>  	}
>  err_unlock:
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 5dcbb0a964e8..3f96d21b84ab 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -709,14 +709,12 @@ int rdtgroup_tasks_assigned(struct rdtgroup *r)
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> -	rcu_read_lock();
> -	for_each_process_thread(p, t) {
> +	for_each_process_thread_rcu(p, t) {
>  		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
>  			ret = 1;
>  			break;
>  		}
>  	}
> -	rcu_read_unlock();
>  
>  	return ret;
>  }
> @@ -826,15 +824,13 @@ static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
>  	struct task_struct *p, *t;
>  	pid_t pid;
>  
> -	rcu_read_lock();
> -	for_each_process_thread(p, t) {
> +	for_each_process_thread_rcu(p, t) {
>  		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
>  			pid = task_pid_vnr(t);
>  			if (pid)
>  				seq_printf(s, "%d\n", pid);
>  		}
>  	}
> -	rcu_read_unlock();
>  }
>  
>  static int rdtgroup_tasks_show(struct kernfs_open_file *of,
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs

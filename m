Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BCB372EE9
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836274; cv=none; b=goP/vGRROFK6gb6OBJnhigcqZ6/LW2MaYnv+zKEG6FEn3CbZbpo2FJR+K7saVzjOzLQtiGeRpWOwWCTqL9pp5gdbMKa5GxnKtCF1zbR32Qd+yCcZGeHPYQP27k1mTW0u/Lt+K6K+A8b+REYFLYMIdpH8DKk6ltBQXXiRzXvuLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836274; c=relaxed/simple;
	bh=8OND1/0AYgNqnoCeYS/E6gAzXT/A0SvifNlta/YF/hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjYi3BBVMdHDY92GaR91MCqH2caW+cxRMkX4FXAu9OsfqiCDuzRnRWjbXiFucdfYe9NovjsXTyDYPiKSaiMLlZVugCrUX5Xr2OmlfQTYChKeRzcBEtLKlTA6q6ylN64pdG+sNZAKASAwmUjHnWRsS43ZsziKIoU5W7GaCFy+wqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYkjSBPe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYkjSBPe"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495590dde14so12094355e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836268; x=1785441068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EbNfG762V9iQLpaTOSvs3ajtk56VK9tQ40uqRHpU1sY=;
        b=GYkjSBPe/1WMVWbZkB5FI8sWCdMhf3eeYCIAECMDAuSMCsRKlv73X0xfcXJPRUrN82
         SWuYxcyQXTOxJCS81NPaGA3TRrwcWfC/2xwwGhDBYHptJcvaBbG8KSck2+2uthLSWxy7
         9ccSdtMngirt5Azc2L7P/HGSNI3989Ha9wsq8WsswG2/xvCZTSsO7PHuHzLTLD22b8O/
         XVULB2CWdsvPfM3dy/aOI/PtNw+R+PW4N5CrwvH6sQZ75F3Q5UOC/Kh7xtoSdhMVCa1E
         czeKBRf1qi8mkC4L0Tm11RkKlTRp4erTPhgyuY0lNz1jJ6Kgqyq9q0CmrI7QHxVazWCF
         lkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836268; x=1785441068;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EbNfG762V9iQLpaTOSvs3ajtk56VK9tQ40uqRHpU1sY=;
        b=IWavvq2HCnD+oJIi/qdREfFu+bLGk9MI97GsuSKrJgAr5aFHjt5z1EOqVWOGROfu4V
         yBKc9aQIgb5u3vFUs7tHWXosGdfVNhDijJmv87gHbH9jDQ/DcayuhfHm87padq4KTyLe
         XyoBxnZ02FUdce7oJOoarvNpmaBUlB5nWdlqPQLIw49B5QiBxPXsLqLEjJdWh+EVVMqQ
         /IOQEq40l7AVdxD7/oH8td9Dk/a6dwsFe4mG3Lc75ja47zoN6nBla6Kt8o5PuJMuq7xw
         ADd7aG4Orym2jE9xcnZmrwQTlKQansORsUvesE5tgbRDUYidJsWyyN+qWYV4ZAfRlYqA
         Gn0g==
X-Forwarded-Encrypted: i=1; AHgh+RptdXXyj4J9fCu34qm79eGsvyYlTc4wNejIZcdkeeZroe0j9YqPCQu5UmbfQ7Kmnt1pB00EOedhw6rsfoqJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyS03eFrSZ2n2pz7U1wmBuB7gumqzmKr5ieSrl/7BSSw74RKVaB
	D3DMd/LJGa3/CP1qEkRnmlEqcT0P+AdcCZhrQetrGfCezDsaGmKhFROJ
X-Gm-Gg: AR+sD11aWmxtvPW8fauJ81/gpjqvZf4klrnTTux7Xjws1cOpsD5kK3NRF0ysxizbGRl
	TIpbNlMF5w5n5Ce2o9bnOldQYoepR+SAONwo1RMpLCc8sLzeVB3J4iSyQNJrNNhr5eX/y0ETUAu
	WN87sDvTs0n0UNspRYC3bIhf7IDUsBgtGlVJRqlJpqDfvs+4RF/GqZMju6IGRcLWx/QifrqsQuk
	E/MZFCvvFQ/A0ndDGAOjeQAQ9koREwsrucsIvFU6LslCtoLoOYmcnXAs0wNVJTveAdj1PRD+6el
	E8UxX2+OzDttinORg4Vt4RkkoIuHz4QLsNyHGB2TusEPOHqYoPcfyRE84Qp7ZfebbknSl3sMqJM
	JWv2L52zFvbvaBHpaegG8bFXBOaW9EkipfEozHStILttb1DDfw0rwtPwLT+EXMrN0DkGi0kwmve
	dfeqTVcflbJhSJ0CenchY9t6uiA+euM4Y1UDscVJDvEGwqgZlb1g==
X-Received: by 2002:a05:600c:28d:b0:492:6efc:7c60 with SMTP id 5b1f17b1804b1-49573cff4ccmr39509505e9.28.1784836267559;
        Thu, 23 Jul 2026 12:51:07 -0700 (PDT)
Received: from f (cst-prg-85-255.cust.vodafone.cz. [46.135.85.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af78a02sm13212845e9.7.2026.07.23.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:51:06 -0700 (PDT)
Date: Thu, 23 Jul 2026 21:50:50 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Guidong Han <2045gemini@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Qi Tang <tpluszz77@gmail.com>, Junxi Qian <qjx1298677004@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventpoll: pin files while checking reverse paths
Message-ID: <aeufm5ugcaps3rlvbii5a3gbjo5dqosatv4tyqjuyekt2ibl5h@xkbmjuqfn53x>
References: <20260718104406.27897-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718104406.27897-1-2045gemini@gmail.com>

On Sat, Jul 18, 2026 at 06:44:06PM +0800, Guidong Han wrote:
> Commit 319c15174757 ("epoll: take epitem list out of struct file")
> intentionally removed temporary file references from the reverse path
> check list. At the time, both epitems and their files were freed after
> an RCU grace period, so unlist_file() could obtain file->f_lock through
> an epitem while clear_tfile_check_list() held rcu_read_lock().
> 
> Commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU") made
> struct file SLAB_TYPESAFE_BY_RCU and removed its RCU-delayed freeing.
> RCU still protects the epitem, but no longer keeps the referenced file
> from being freed and reused. A concurrent close can therefore make
> unlist_file() lock or unlock f_lock in a recycled file object.
> 
> This violates the documented SLAB_TYPESAFE_BY_RCU rule requiring a
> reference before acquiring an object's lock. The race was reproduced,
> causing a wild unlock of f_lock in a recycled file and breaking its
> mutual exclusion.
> 
> Add ->file to epitems_head to remember the pinned file independently of
> ->epitems. A concurrent EPOLL_CTL_DEL can empty ->epitems before the head
> is unlisted, leaving no epi->ffd.file from which to drop the reference.
> 
> In list_file(), acquire the reference before adding the head to the
> check list. The caller either owns a reference or holds the ep->mtx for
> the epitem leading to the file. In the latter case, file_ref_get() can
> fail after the last reference is dropped, but eventpoll_release_file()
> must acquire the same mutex before the file can be freed. The dying leaf
> can be skipped because removing links cannot increase the reverse path
> count.
> 
> In unlist_file(), epnested_mutex excludes another list_file() or
> unlist_file(), while head->next prevents a concurrent EPOLL_CTL_DEL from
> freeing the head. Save head->file locally, clear it with head->next
> under f_lock, and drop the reference after the RCU-protected operation.
> 
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Junxi Qian <qjx1298677004@gmail.com>
> Fixes: 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guidong Han <2045gemini@gmail.com>
> ---
> SLAB_TYPESAFE_BY_RCU allows a slab slot to be reused while an RCU reader
> still holds its old address. Once that address contains a new live
> struct file, KASAN sees valid, unpoisoned memory and cannot distinguish
> the stale object identity. CONFIG_DEBUG_SPINLOCK exposes the failure
> instead.
> 
> The failing interleaving is:
> 
> CPU0: nested EPOLL_CTL_ADD             CPU1: close/open churn
> ------------------------------------   ---------------------------------
> p = hlist_first_rcu(&head->epitems)
> epi = container_of(p, ...)
>                                        close(victim)
>                                          __fput()
>                                            eventpoll_release_file()
>                                            file_free(victim)
>                                        // the slot is free; f_lock remains
> spin_lock(&epi->ffd.file->f_lock)
>                                        open() reuses the slot as new_file
>                                          spin_lock_init(&new_file->f_lock)
> spin_unlock(&epi->ffd.file->f_lock)     // wild unlock of new_file's lock
> 
> CONFIG_DEBUG_SPINLOCK reports:
> 
> BUG: spinlock already unlocked on CPU#0, poc_unlist/150


Well I'm no expert on epoll, but on cursory reading I think this is
fixable in a simpler manner and without the extra overhead.

If you were to add a constructor to the files slab, you could move the
spinlock and mutex initialization into it. Then unlock can safely
proceed and maybe that's good enough (as in there are no other issues
stemming from the typesafe thing)?

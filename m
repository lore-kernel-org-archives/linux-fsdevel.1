Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D19340DB0
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127378; cv=none; b=cY6yYxDCkFyINmtoJ6rwDerPKnKioNpejvkRXyW2YbvBTFzPbc42Lwqz/YvnIh704T4+XmjyHKPKjIgk6ms4o/CzJT5GCIlVjyUojNw9aS5N4xxVk/K/fa1z6f4XTbtNiYoLEidku0i2FX/Zc7rei0UAYWI5/+hb+o4CJR1fUBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127378; c=relaxed/simple;
	bh=9DhD2pW+bSt/gPoW5xEYxxu7wL6Rdoekxf3LOg3ftT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLM6XS8b06155Kdbx3sF/wyQriUWRRQMzu3wnB1S2OSk30fYkPHHLhN2rP74lyfPh7Uv05U7o/IaPzIn3nGlKlfZnpioUsqurdrUwpSx0dfaioIOzkJFmNCGgbTJ3yDwpJU8PnhNPv21YwOv4nevLUO42mwuExJWAfPHtNoEFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hm96AmKZ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hm96AmKZ"
Date: Tue, 3 Feb 2026 15:02:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770127374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IKHZdSHkh6A9hkDw9y8PFuhbi5mMsWLx1zNxmNV6a2w=;
	b=Hm96AmKZiw4xkXrJMx5AwTOblcSEuowPkLatqgg7YWwrlAzVA25UyLcHEJ+rUgDIVytwV8
	BY0OuciAB7HSIA2yNZgqJeUgAakfqZLDIo3MX6LwW3I7XVgF91+nzG3lPY+b2CkVicp3DB
	QR7peA/SQ0hcjIhYsDFUSSvAcs3cyzg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Julian Sun <sunjunchao@bytedance.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] writeback: Fix wakeup and logging timeouts for
 !DETECT_HUNG_TASK
Message-ID: <btfdnzqktucegolmalsawd3oj4htzl4mafybgyx6zqqlwpe3q5@lu4ntvit6zhf>
References: <20260203094014.2273240-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203094014.2273240-1-chenhuacai@loongson.cn>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 03, 2026 at 05:40:14PM +0800, Huacai Chen wrote:
> Recent changes of fs-writeback cause such warnings if DETECT_HUNG_TASK
> is not enabled:
> 
> INFO: The task sync:1342 has been waiting for writeback completion for more than 1 seconds.
> 
> The reason is sysctl_hung_task_timeout_secs is 0 when DETECT_HUNG_TASK
> is not enabled, then it causes the warning message even if the writeback
> lasts for only one second.
> 
> Guard the wakeup and logging with "#ifdef CONFIG_DETECT_HUNG_TASK" can
> eliminate the warning messages. But on the other hand, it is possible
> that sysctl_hung_task_timeout_secs be also 0 when DETECT_HUNG_TASK is
> enabled. So let's just check the value of sysctl_hung_task_timeout_secs
> to decide whether do wakeup and logging.
> 
> Fixes: 1888635532fb ("writeback: Wake up waiting tasks when finishing the writeback of a chunk.")
> Fixes: d6e621590764 ("writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Disable wakeup and logging for !DETECT_HUNG_TASK.
> V3: Also handle the case for DETECT_HUNG_TASK if sysctl_hung_task_timeout_secs is 0.

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
-- 
Pankaj

Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34B41D216
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377300; cv=none; b=XewORoPOewFq5pFiToBtvYbW0ZFhURetOWsSi0BPbqcNss2fJIcSKe+qcv/SrWsYca9Gds8KsWgb0CeewbS353Zbr7n8yzBCXRieQsfxLKW9eJj+BvidgXSu2Jlli1YqOaoT38H7pbFQh8NUxelC/ypZRa94L8UG3oniaWLBMx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377300; c=relaxed/simple;
	bh=FP5oFiBYbVyY3JVsCwCjRRtGL56Xd97vsRfsO3nXhJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlKLmTXxm8Tx613BF6mUwyKFXMq9rZv38luZDhis+7MZgcYrwuonQ+OXxIMLff1GUVC1EfI2PkfwPCPjRCO8+bGiRgEzggYH+w4OV1g6NYQyb5zr54fMR5w7fUFqTXvIES9kWO3nYW4rlfW+BFkFEC9FqWVhnCU/LgSeFO7vrhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iW4S+Uhv; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iW4S+Uhv"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso12712345e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789377293; x=1789982093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eLs2DuVwwmthhfTQvpsHARZ1xrBdjckpgXaXtFhSszQ=;
        b=iW4S+UhvWmezfeAGKr0L+2xuiRjMbQd6M+PhopKnsZUC61vNP25L2lv4pJY+S9wGX5
         qwv4o46Ua9XNn4mJfsa8QQGLXJk+5dAYvHJnrd/qVMhyp0g85ZQBm6Ktc0NJ79OT0+Qp
         VkjUByq1mY+cBsq7QIb8Wdg+IrGnUbrJp9Z3byHwcBrrNxTuW58h7KauSmsLyjyW6Ff9
         f46Qffw97Zjf8AHQK+ZeDMXqkQuZeeWNO+NNfIF1pUl5YWrufFSarSRx3lauZSpE3aG7
         uGsEdNYWZrZyRfDUWj/qJmdxd5zBvADMPXX8RutGXVUycUio2jGzzAm0pSOhCErDRNkD
         dyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789377293; x=1789982093;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLs2DuVwwmthhfTQvpsHARZ1xrBdjckpgXaXtFhSszQ=;
        b=b3uZshGstl+B6u9/xKJaAUtCzoO1hbtxD7ZriBgZZWEBxgkieGpU2pbGCzxZ+kDXDn
         /BXtmGx8QVXSoim2rtjr9d9gQV5VjTRfpa3T3gyE/eGLU6QdVDMCjADhtFrYpUXrkwTP
         Y09cc5CtpQ5iMh5jBxktAAzHxVgEtLhHaBGiTi7eXRqqdXmatnXVtBH8EhKhDyWOsN05
         WtXJy4KHad7OojfPGKqPy2h31BeIJChdAwbjhSu7OYSHrMnsTXsNFJ+aKw6bMbe/f67g
         42GT5T1HD5fL5pVr+X2On1ZXg0UAZ72UHoaSZXWsIyJ6vZdzhRsrouASVpN/57di7QFk
         jj+A==
X-Forwarded-Encrypted: i=1; AKwUvBxfPeA42qMzoKxnfIopmIIz6G1wHAcIFfIf9M0mX14LYXfZTVcoUxkeGKzNRT7PDFzgK9sFBEeEif8vksFe@vger.kernel.org
X-Gm-Message-State: AFuF++lSeABu3hYsnnB8J/k6BZlzy5LqiaCoUYhLKXWBeqXWPebanCCz
	lLPwHn4WDOSWdC8ntw8LcUDe0D75+nJojjD/cCkU1Aw41vDc0ihb8t4=
X-Gm-Gg: AYBFou0xbm5IrNAwTQc7YfaJMOKqIBj15ess2yvk1Kx1FXN55kfecxUjLZYZqGCbvOM
	zKlDsLYBqWukQCZF1OpNwYBwyJRTWACb9/h5dX3u1ME+VgS61OSq/cxfu06QVWHUghE32q+zEkG
	befZLlagrsrFutMbxwMShz/VWLCmvV0Xk6x3YPbJSywFO2GZH4Sems+z7o+m3ZL7l4BOTG+1mDl
	uTwbnExTrNtgCbKuXE17qlvYF2/mpSNDvKXwiekVeXBj4xLhnQfm8DTayi7lE62a1yVZ+uEiUoE
	V1znmBkuYXbFGgnf8HJz4intSGchHRZZtLKsbz9cCUDzuWo0kHaf34qpk6lSUnO1oSloozRl8M9
	zsAOJng7NBlIRF5TJ3VlgqsJOw5qFp+upYfuXU+FBK2Ku8HexLLci92xhyotHqBanS0ya1qDNjV
	ZKisGNcGCn6gWpTZouMbDbUJJS9riTGH9wl7VEvnYJ660O7SrRhofonQU=
X-Received: by 2002:a05:600d:3:b0:49c:cee2:a508 with SMTP id 5b1f17b1804b1-49e7a66b64bmr16207805e9.16.1789377293358;
        Mon, 14 Sep 2026 02:14:53 -0700 (PDT)
Received: from p183 ([46.53.134.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6fc9c027sm197705935e9.1.2026.09.14.02.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:14:52 -0700 (PDT)
Date: Mon, 14 Sep 2026 12:19:03 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, zhongyuan@hygon.cn,
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, jack@suse.cz,
	dev.jain@arm.com, ljs@kernel.org, akpm@linux-foundation.org,
	hpa@zytor.com, ryan.roberts@arm.com, mjguzik@gmail.com,
	joel.granados@kernel.org, jannh@google.com, oleg@redhat.com,
	aleksa@amutable.com, legion@kernel.org, kees@kernel.org,
	joannelkoong@gmail.com, tj@kernel.org, libaokun@linux.alibaba.com,
	ebiggers@kernel.org, sandeen@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] fs/drop_caches: do not scan procfs in
 drop_pagecache_sb()
Message-ID: <c566b9eb-7cad-4a03-bf53-ae3b3e699559@p183>
References: <20260914061449.4024632-1-huangsj@hygon.cn>
 <20260914061449.4024632-2-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914061449.4024632-2-huangsj@hygon.cn>

On Mon, Sep 14, 2026 at 02:14:47PM +0800, Huang Shijie wrote:
> There is no page cache for the procfs, so do not scan the
> inodes in procfs.

> @@ -20,6 +21,9 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
>  {
>  	struct inode *inode, *toput_inode = NULL;
>  
> +	if (sb->s_magic == PROC_SUPER_MAGIC)
> +		return;

This should be some flag somewhere in superblock.
Other fake filesystems don't support pagecache too.

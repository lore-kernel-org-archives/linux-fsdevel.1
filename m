Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1069C13CA92
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 06:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790920895; cv=none; b=EJS9O8AMCsHgydRAVchkh6GWNFQHP2Fcn3jRyJN0DqV/zXV8hg6wmIugGG3Ar9pA8+UvnmBVOzgfHiaAqEx8FNjdPwke+9+Hspz9fp+bDfEm66JJVCAUAo3mT0ec21KwkWf6x14rKqMvssks3oxjBJbGs7L+wchMORjpZYGv4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790920895; c=relaxed/simple;
	bh=Zzl8GQMYT4ovWCoYqlximp5PJDij3vOuu7nwytPtyeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHcCamHt3dToEVVG7XMWMEA+7PwRVvJ68VBO/BE10Y0/iCx7XiYtsiB7fOudue2eGsnawargMMT7enTuzBzad+AT3vXOT1LQDGz7hvhaJeBfTqLyxK0G5jhb6LUJbNukwuXdr0MARvS01SMvsc9sHops01dEiyFOnBQPVtaLebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0gEpkWA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0gEpkWA"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2db710396ffso4959475ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 23:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790920893; x=1791525693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bvzqwuTjdPy91zWm37KIYjrvoEq9pY5JTP911vnp5Bg=;
        b=m0gEpkWAEcEMiKCKafImmMAllmDHp7tF1YDuCG9bClKS817yH6g98rM+ifBUMFhco9
         XU+LXB4EZxHBk/OxGklmcd/mPfq8lqNu43EHcKShAPE+YQ5wLAMAMfCzU6HCaBMNy5C1
         hK8QUh3KmcUNgqOdjJDmllVDIhv8XnBxx0lf1oNSE2xPvjowHGs3CCctLMfRIe31sy7X
         TnY7mU91UYauds2srysRM8X8F/UMCYhKVafRSDxTVDksMdo1YCu+nrcMDh4sVuPvBfjC
         +Z03FQeEgmIyuonYAAueWYBUhHmnwO5+Z2U2QB/SvVTK6V0iaKUguHGe01zFHxllooyT
         ks/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790920893; x=1791525693;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvzqwuTjdPy91zWm37KIYjrvoEq9pY5JTP911vnp5Bg=;
        b=HyxIUIW+nG2qFZ0zKb+pMMU7JNUiETKx0/cf4eD/AJ5G/MeJb4zwdGfLgJqW37R4bH
         x9ScZmvhjjoyn+p3biyMxNFRcJShavpm1Wh3uA1Buoywv3Uk0Lf5yM5e81hKX0/+SI83
         EnMrXIf0X9Q6THvusLQY96AzWIpF5Hhrgtv3sNGiMSeZ0qmBf68werrJ4EF6Bue9xN/u
         C3THGw0rD4FkVJdFcb4kgqQkNFdfUD/uMdXo4V6zZYTTcvr8rAvK0Sq44qHipjArDvea
         KSv2kqY+JWL9INPJG/u1/EVpiSUcboUZDLCpiuk8MZhGcuzUGMi2YtbuTpsYVoVtKTlU
         Xuxg==
X-Forwarded-Encrypted: i=1; AKwUvBzbdZ+vuBexN7WoR0hVkiDWO4I303ONKBB9U4i9yzgoz1278/ugxC94X/cfkw/5iag+85FMd8aSFLAMstD8@vger.kernel.org
X-Gm-Message-State: AFq9FYKwUvBkCC3nE9zib0XkUw4uTz5BtcDMe5/QMWRvLyOi5j+zJiT2
	cMhDm1w/y38F/hzNt0oaEdLskFGd+164EFrea2Ju70Yx/TQzxYpsUn8c
X-Gm-Gg: AYBFou1rDKJXOIwEPwWS7h9zFwOzqON2ICTwMkMWBE7ykg+DKzhT06KYn0y4rq7dY7l
	paH2oeMSkiNihT2xgXvl4cQVQHL0XtKpRklYWuolMZ4eC6Q8K1hzhP8tUKmN982uyiZiKmS+hxQ
	uzpzUlNJC8Qluc//gRL3ndFITE3RgmessZlNXrVt7TIJlcRpm1puzYpug5f6cV1GJ0hbUszF8T3
	8v2NcwJKCLO32AL7cqtqioRb6pZ9N4/FZmULS9QZgTX84Y+m2JT0bAjLbwzeTkY+dfoS1VQCOxo
	DjeWCMoyagRv10qqjDBiBkuhqIp1u/+ZTC0H6p9FexcAoqCArucjuTauvUVcALvUB0Bt7jsVdNr
	8A8Own1/vdVg0eIxi7q7ng/hHQR3Xy9jx4FOOsrjYDH3rn0SvOx7XEIuganj87IwZAZ/DVBHPER
	RXeRTbzJ6w2pnuDbABacEYoVbs33V56egdy+X6iSvbH9Nty6oqp391bIaSVTEt
X-Received: by 2002:a17:90b:2644:b0:3a0:f2e1:8af9 with SMTP id 98e67ed59e1d1-3a4f3d124f2mr3588321a91.52.1790920893294;
        Thu, 01 Oct 2026 23:01:33 -0700 (PDT)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f721a6afsm519169a12.0.2026.10.01.23.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 23:01:32 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:01:30 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-um@lists.infradead.org, codalist@coda.cs.cmu.edu,
	coda@cs.cmu.edu, linux-mm@kvack.org, ntfs@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/7] VFS/xfs/ntfs: drop parent lock across
 d_alloc_parallel() in d_add_ci()
Message-ID: <ar9IuknaJqrGoF-j@hyunchul-PC02>
References: <20260929034158.1455429-1-neilb@ownmail.net>
 <20260929034158.1455429-2-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929034158.1455429-2-neilb@ownmail.net>

On Tue, Sep 29, 2026 at 01:36:01PM +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> A proposed change will invert the lock ordering between
> d_alloc_parallel() and inode_lock() on the parent.
> When that happens it will not be safe to call d_alloc_parallel() while
> holding the parent lock - even shared.
> 
> We don't need to keep the parent lock held when d_add_ci() is run - the
> VFS doesn't need it as dentry is exclusively held due to
> DCACHE_PAR_LOOKUP and the filesystem has finished its work.
> 
> So drop and reclaim the lock (shared or exclusive as determined by
> LOOKUP_SHARED) to avoid future deadlock.
> 
> Signed-off-by: NeilBrown <neil@brown.name>

For the NTFS part,

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

-- 
Thanks,
Hyunchul

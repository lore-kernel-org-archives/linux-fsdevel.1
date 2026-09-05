Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13682360EFF
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Sep 2026 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788589898; cv=none; b=M/JmNwBjHutWOadFFvZ9I88lnh2whnDErubvlxZWgKKb9HoacAuURaAt0oIoFn4frobk1nwI3bg2BGbVZObP1efBCVcLMj1pQnXrzYFzK8sHRj6ErP+RGV1IrTGmBifMpdzZ3QOeMXsl4pR1ua/+AxuHC9dJ8pjO4jJ840CKV9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788589898; c=relaxed/simple;
	bh=CSdPRELROkYKXy+2tVtR16UKWCgrtQnEIaCw5HxeGSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhX35DqH+q2wZvAsxfgMapCCRscxEZBk3YTqx7zD29UxUCuu1bGCXq80puH5DEMzAiodjQnsNr//gje+ZQ61hbFVtWFcWkhEs1aNPNDkm14R6lwb92VyX5FEYESo7WMQNxKeNnZYyFFpy4RPWz1KeekHh0XYlB1RN9np4GX3Z9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFFi5FYk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFFi5FYk"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso19935755e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788589894; x=1789194694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E0jfYxlquFYCTLGleo8vFGywQI0ODEMKtD2q20GPHRE=;
        b=hFFi5FYkEeheJKxTd6NpdlYlW6XEAX2xWBQdisIdVI+P58B0fJZPDFEYTTNjs1xHsd
         Fj869yNm/ZJQ1sDscqTmgdyrWCk9keGzKb7tDFnUlN5aytzo8FnRrc6vAib+ds0CXTUo
         znk380OhJKNGdrorzvXkCnKk708LmG3mmsIJmlUl8s7lYCMSW3ugiUrJ20+lOmfBco0J
         V5WX9Pv/jLFvowgYmxu/gj5NCKdiGSSJpZaOQu0dS7+f3pT3CXNwOU30PnLSNZil1wFk
         y/35Q1THjmaxiTqtCEqzbIcSKNbWWmirQeGiKngG/lYyZrRxwsOFU4Hu0azfnt18u2HT
         4CLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788589894; x=1789194694;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E0jfYxlquFYCTLGleo8vFGywQI0ODEMKtD2q20GPHRE=;
        b=f/GjB2a5UkDslBRYbGYZIghKd1OC4oWoF4S44OEsJMcuMOZWDzDr6bhmbhKmhXAIUA
         ttY9QzjYioxB8ZN3PjE/0zXR4xiQ6IQO3r6PcvKM5XlOSpqnfTybN7nwTXv6Uruh/Wea
         aFgL7cC1LfsZczTroFQgDjp+wI+2iQve8Y0Omlnf8dS3Q1vupfijDiKhg3COv3Z/ot7s
         Qh3197EyZs8mb+Zq74XEHgZyu7Wvzh9zktHHszwJqDpnHbHl0ffMog/+R9KnW2pr7hD0
         XhA3/QCp8hQQrpI0fKwvH7FClJ4CarJW4AGZJhOOnxwuZyJZV0LZleTqXtUlOh9Y2BvJ
         sggg==
X-Forwarded-Encrypted: i=1; AKwUvByERAG67MeZ//tXYh2DstPEv3K9Oda3pNYlneF2bPUgmMuTjCGjUHMVKfe7cd1JG1Zkm+5zzDZCjCmbjyaY@vger.kernel.org
X-Gm-Message-State: AFuF++kz4xFOH05YKjCG5q+5GI2mBQ9MFG82EvZzPpx7Ugwx+nKUMWja
	BjD3O6NXT+trOnYk7WEL7nTTq8WGQUnT94UUl9bHEwHLqXLUGhxoC1l7rAwpVjje
X-Gm-Gg: AYBFou2mOeFYNN7pfES4irnXUIphOBO9B4TsTd0sl96yJxn5JsqmUUT532XXtDTuOzU
	ovjoeiBuVLpPbc5H8fqJSlwkula90CeW5dXtAnI/l2xk3q5IE3fKlDzn2hEX5zrZ3ErYFjwVPyo
	fnEdC5prkpYjS4K+HvVnOxDZ5x78+sylcN3l0/P7yWJDYBp+/bVly1pLWUA4HUdG0sawOpLJ9jd
	acwHgyhJ0uZQtZZgAS3ODCcApOeWh/A/o6CDcy3aM7mijkoyinGNIbvkhrdkdQu7jWwUcShMoRx
	kW094y0Up+waCrqPAbymfcsAiJJxL/nQBgSrLCgjUHINz1ale4jmhhF4LkBU12EGXNqjOjCzDXJ
	JUo69BXJU3QNwxga234CDbaca2ZSiCQsboo8+GH94pUH30fYptt90xRuoVk6D5b8p3nKecJPwNk
	WsROlxALWtGhyyp+yxpvzpy0pu83eqF1lYysvHSnXqx35GkZg9fNKxU9HnUJhEWZNd16gxwhj9Q
	wrFwEK0E/fc3i++Aau5RHGO4UrggdXbCOQNuvFKMJ2pJrdWHPezilf7z3IKbBlkLidjsRrUgRXI
	HPUHkIJh1RbJYuy/Wmx19BLDV3qAKBMCbDHfk/gpzP8QEqolDHche9G5Lzy1csRB83Fynk7S85E
	=
X-Received: by 2002:a05:600c:3b02:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49cf8220edemr113027825e9.6.1788589893900;
        Fri, 04 Sep 2026 23:31:33 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7710aa5sm123259535e9.7.2026.09.04.23.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 23:31:33 -0700 (PDT)
Date: Sat, 5 Sep 2026 08:31:32 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paulo Alcantara <pc@manguebit.org>, linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] super: make iterate_supers_type() deletion-safe
Message-ID: <apu0mCbJ4S0TKIQM@gmail.com>
References: <20260903013336.92081-1-kmehltretter@gmail.com>
 <32afuwcqxfzvc2qwsvx6ecpyvbunr45wnvmezbbqzz25qtfn35@tvotjvtm3soe>
 <20260904-astronaut-anpfiff-unbebaut-743381f4995a@brauner>
 <20260904-rockkonzert-bergtour-dahin-23c9c5c87d0f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-rockkonzert-bergtour-dahin-23c9c5c87d0f@brauner>

On Fri, Sep 04, 2026 at 01:11:53PM +0100, Christian Brauner wrote:
> 
> Draft, feel free to grab, Jan or Karl.
> 
> ---
>  fs/kernfs/mount.c |  4 ++--
>  fs/super.c        | 39 +++++++++++++++++++--------------------
>  2 files changed, 21 insertions(+), 22 deletions(-)
> 

Thanks, I found no issues with your draft.
All the tests I ran on my patch also pass with your draft.

Below is my proposed changelog. If it looks good, I'll send v2 with you as
author. Could you provide your Signed-off-by?

super: make iterate_supers_type() deletion-safe

iterate_supers_type() drops sb_lock while invoking the callback and keeps
only a passive reference to the current superblock. That reference keeps
the object allocated, but does not keep its s_instances node linked.

After the iterator releases s_umount, final teardown can unlink the current
s_instances node. The iterator then advances through a reinitialized node.
With the current hlist it stops without visiting the remaining superblocks.
The unlink moved from generic_shutdown_super() to kill_super_notify(), but
the cursor lifetime has been unsafe since the helper was introduced.

The CIFS DFS lookup can consequently miss a matching superblock and return
-EINVAL.

Move removal from fs_supers to put_super(), alongside removal from
super_blocks, so a passive reference keeps both list nodes linked. Keep
the filesystem module reference until then, since unlinking s_instances
may touch type->fs_supers.

Make sget_fc() skip SB_DEAD superblocks before invoking test(), and set
SB_DEAD under sb_lock to serialize with those callbacks. This allows
kernfs to free its private information after kill_anon_super() returns.
Keep matching SB_DYING superblocks until SB_DEAD is set so concurrent
mounts still wait for teardown before retrying.

Fixes: 43e15cdbefea ("new helper: iterate_supers_type()")
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Suggested-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
<your Signed-off-by>
Tested-by: Karl Mehltretter <kmehltretter@gmail.com>
Assisted-by: LLM
<my Signed-off-by>

Thanks,
Karl

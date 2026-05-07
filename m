Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1583CF684;
	Thu,  7 May 2026 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153360; cv=none; b=W6JtAq/ncXcf3HlrZmIEVV6l/aQOgGKzIVqXdkHxBnNDUPrtEvnxXYfFTQ8tH7knlvZVvc+XGB7OLizAJkyDG019gUtsAqL/1VFBSKTwl8ijkgCjakbknwVwmhxjBLE339BFzEJ7v81ob6lhiIcXFgx90hxx8xPLtvOWMuuqpzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153360; c=relaxed/simple;
	bh=zTRqn9R18RyQ48vR4YvRDffnW34u2gQWzTtSualinEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FOuCBQBkL/4ctGQPt+QoHXqZ+wzm7ady8jGD1nNBKUpl9cwOMkk0e9oBvB141BU7pZ236dTy+VPoVEOZtwo8TkUQi9Ta2fjjrRqBiEfbvw4mE1VN6KGHu0l+xYbDKBuO8yPMh8Mzov3AzlY6md6Ev7/dF7tz0QEHdtJNRMisi/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wSIVSMDV; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wSIVSMDV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=z89M0XKJc2ZBtArXJQo2ZbAg+YV3BtExVkW8iyDFe3U=;
	b=wSIVSMDVfQT2BmMpeUl7bMPhqUUcwZbMsPHqAbzsi1hOEB8aayZhdbenOGfDljKUweh75U5sH
	ldaUchx4d++fvXAuuzPIlS5tWPEOBFNB27dXOqA5v7jGqtcE8h+vcozzk6FXstCf6UjM5c0O6po
	RYgYhCUy86UatwqecYJtOdA=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gB8wY5RbVzcZyt;
	Thu,  7 May 2026 19:22:05 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E3614048F;
	Thu,  7 May 2026 19:29:16 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 19:29:15 +0800
Message-ID: <dc3a864f-a325-49b2-9827-c957f48211f1@huawei.com>
Date: Thu, 7 May 2026 19:29:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nsfs: fix wrong error code returned for pidns ioctls
To: Zhihao Cheng <chengzhihao1@huawei.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jlayton@kernel.org>, <josef@toxicpanda.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <changdiankang@huawei.com>
References: <20260507112301.1042757-1-chengzhihao1@huawei.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20260507112301.1042757-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100006.china.huawei.com (7.202.181.220)

LGTM
Reviewed-by: Yang Erkun <yangerkun@huawei.com>

在 2026/5/7 19:23, Zhihao Cheng 写道:
> When executing NS_GET_PID_FROM_PIDNS (or similar pidns ioctls), if the
> target task cannot be found in the corresponding pid_ns, the error code
> should be ESRCH instead of ENOTTY.
> 
> This bug was introduced when the extensible ioctl handling was added.
> Without proper return, ret would be overwritten by the default case in
> the extensible ioctl switch statement.
> 
> Fixes: a1d220d9dafa8 ("nsfs: iterate through mount namespaces")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
> v1->v2: Delete unnecessary blank line.
>   fs/nsfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 51e8c9430477..160018c4fb36 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -266,7 +266,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>   		else
>   			tsk = find_task_by_pid_ns(arg, pid_ns);
>   		if (!tsk)
> -			break;
> +			return ret;
>   
>   		switch (ioctl) {
>   		case NS_GET_PID_FROM_PIDNS:


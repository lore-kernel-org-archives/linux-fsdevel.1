Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F61FECAB;
	Mon, 18 May 2026 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779076450; cv=none; b=GKvc4/h97nRtm/pcC+JZ8WvmbWvdIz5uT525A6xjLrB3RCcC1ZoTPK3Gv8iAmLNorBgQI31dIhgFhl4GrGbJ7GsteuCkBgxfxJtfL1oPM/guQOpQQunylM/agHxSLzrqS2NEIoTBbVee082eHEvd9sOZ6/amBhOq8SS8HxwOiCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779076450; c=relaxed/simple;
	bh=kSbZqALJqGQ1Tcn5/9PAqcWGN8NGzRhgYpC8zzFAlk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/4jtLnRasLW3MjKa5TBZAjTOBJq7pthYJC2dA79LFOgKzu1CpdD+kzFLgZjPmTgmEr3RbLepWV60bs36Auxsy3GQMA+pLL4gV6JbbwXcOaZ8w9Fzp47zh1PVDOxAHJrr8ViPC0WPaP3Rl8qGJTXeX6Mcjs1BpVOdIZHVSsSKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r6PMXp3v; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r6PMXp3v"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779076445; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AhzWgNsFCqkb6gA6X4u24Coz6XUqSynWVSY1ic8K1+I=;
	b=r6PMXp3vKTZ5DjC0/8ZkZiygmF49SllYxcKjFIoS7b/EpDA9dLAFZqGx82hp+yK2tRHh3FtpYsTcHXzuy6mbCkFKNG9j6qPOyrgy1j1l4K7MGG9lwlWkfxY9GCRsX9uifzrss8Bt4cNwkkwsHt7j2FLNg+zQ+L2h8OidZVFQSAI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X337ZhK_1779076443;
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X337ZhK_1779076443 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 11:54:04 +0800
Message-ID: <d5cd1ce3-db3a-4053-8556-a52982ff4a16@linux.alibaba.com>
Date: Mon, 18 May 2026 11:54:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] shmem: support xattr gnu.* namespace for the Hurd
To: Janneke Nieuwenhuizen <janneke@gnu.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Hugh Dickins <hughd@google.com>
Cc: =?UTF-8?Q?Ludovic_Court=C3=A8s?= <ludo@gnu.org>,
 Rutger van Beusekom <rutger@reasonable-sourcery.coop>,
 linux-fsdevel@vger.kernel.org
References: <87se7stpgy.fsf@gnu.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87se7stpgy.fsf@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

CC fs maillist

On 5/16/26 3:58 AM, Janneke Nieuwenhuizen wrote:
>  From d8291d06b67db045033664fb440f59001d7755a1 Mon Sep 17 00:00:00 2001
> From: Janneke Nieuwenhuizen <janneke@gnu.org>
> Date: Fri, 15 May 2026 10:12:30 +0200
> Subject: [PATCH] shmem: support xattr gnu.* namespace for the Hurd
> 
> The Hurd gained[0] support for moving the translator and author
> fields out of the inode and into the "gnu.*" xattr namespace.
> 
> In anticipation of that, an xattr INDEX was reserved[1].  The Hurd has
> now been brought into compliance[2] with that, and so has ext4[3].
> 
> This patch adds support for reading and writing such attributes from
> a Linux tmpfs; you can now do something like
> 
>      mkdir -p hurd-root
>      mount -t tmpfs -o size=2M tmpfs hurd-root
>      mkdir -p hurd-root/servers/socket
>      touch hurd-root/servers/socket/1
>      setfattr --name=gnu.translator --value='"/hurd/pflocal\0"' \
>          hurd-root/servers/socket/1
>      getfattr --name=gnu.translator hurd-root/servers/socket/1
>      # file: 1
>      gnu.translator="/hurd/pflocal"
> 
> to setup a pipe translator, which is being used to create an
> initial file-system image for the Hurd from GNU Guix[4].

Please add your Singed-off-by tag.

> [0] https://summerofcode.withgoogle.com/projects/#5869799859027968
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3980bd3b406addb327d858aebd19e229ea340b9a
> [2] https://git.savannah.gnu.org/cgit/hurd/hurd.git/commit/?id=a04c7bf83172faa7cb080fbe3b6c04a8415ca645
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=88ee9d571b6d8ed345f877e05f685814412e359b
> [4] https://codeberg.org/guix/guix/pulls/8632
> ---
>   mm/shmem.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 3b5dc21b323c..5d60aa4dba92 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -15,6 +15,7 @@
>    * Extended attribute support for tmpfs:
>    * Copyright (c) 2004, Luke Kenneth Casson Leighton <lkcl@lkcl.net>
>    * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
> + * Copyright (C) 2026 Janneke Nieuwenhuizen <janneke@gnu.org>
>    *
>    * tiny-shmem:
>    * Copyright (c) 2004, 2008 Matt Mackall <mpm@selenic.com>
> @@ -4371,10 +4372,17 @@ static const struct xattr_handler shmem_user_xattr_handler = {
>   	.set = shmem_xattr_handler_set,
>   };
>   
> +static const struct xattr_handler shmem_hurd_xattr_handler = {
> +	.prefix = XATTR_HURD_PREFIX,
> +	.get = shmem_xattr_handler_get,
> +	.set = shmem_xattr_handler_set,
> +};
> +
>   static const struct xattr_handler * const shmem_xattr_handlers[] = {
>   	&shmem_security_xattr_handler,
>   	&shmem_trusted_xattr_handler,
>   	&shmem_user_xattr_handler,
> +	&shmem_hurd_xattr_handler,
>   	NULL
>   };
>   


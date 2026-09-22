Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8C5372DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080803; cv=none; b=XnfHXVNOmFLnr8i3QTK9eohlmKfEVHnXBunpkks8KBR1JoT5hfxqyDEe1AIhVSXMLQ4JVD+GL/kl12VvKlvDe2De+9X06Mml/XAw72vWgSYeiW99rJfei1yxfpDjpJ1kDjsAaegjhOyUxTX5nEp6eFF8ZdXRqwozbqM6jEu9xHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080803; c=relaxed/simple;
	bh=wFmJBrwWil7bpAeYIpoN4GzUL1HvXOt5ldn6IIIiFHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uv+JsT0Yb8zIVSy5mU86bYClC1mSuIj1GrLxmQifRnGxXqKlQtxI0QgjSfDpL2RtdmbI8gWOvX3lZs/9SU1Iu6EFwOM1+tfsSw6Y6uRUdo5B+uCaqW/TxzNcajnKzDwHbGiPqQJW//OSIBT+CwJh8KGvjBB3Yrdb+6GobOUTH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=O2oXCldz; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="O2oXCldz"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e96a8ba8cso2705511241.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1790080799; x=1790685599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9blDfaIlaDE7zWOzf7sAkl81n8mIgiGQIMLz8R8dVg=;
        b=O2oXCldzJ3LpA4QHBbXInqG6gPFkiSS8IpezgH8R+ZrmCNrQGw2qZ3cz2HJXPR/LD3
         nDnwu+h/q1ydJlARyj62co9tTwdWIgt6A4ziEIgZPoWy6ktNQVyLZgBsOE9UYoUt4d3f
         ApfWcUtfyoMebnbxzEyQSfJL5IYMdQPZlYtb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080799; x=1790685599;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9blDfaIlaDE7zWOzf7sAkl81n8mIgiGQIMLz8R8dVg=;
        b=ItTo6GsbwOr1eWzvMUNMoxKBtHXGmLn/kySx3noZozn9oGJwTW2FnHpDC7ONbfoRAf
         WsgMiJPF0J0M0SBuTLM56Hjkq67jFGyv3MAYps5k7FWo0CD215qi7zVLy+4ZG/LNuTl4
         0aUPdhXDuFIwzyzS2paBi/tFOZYu/QSjUG/3qptz6YFaj0EMX7LVXJneT+Fo+SQwK1ZF
         VhihWA3jLiBSoZSw2XuIWZD6phYJxifJjTARz41ahh2kpGbKF4y+3NYUZR8rOhlUVfdn
         Zi8H9tfI98WTtfJBRBmxIB7d9h0CLYCDoysr5qEk7XEr/W61mlJVXi8V8mNI2u5FG0PN
         75zQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmS1EdoxRPxqvOOaLJtdF6TZZR/+JFo+1Z1EzutnPXhuUdthAPL/ye/NMnPMyhVxGI6jtkgrlSSmu2ynpo@vger.kernel.org
X-Gm-Message-State: AFuF++mwcKEPD3w0Zyi4F2hOTDDmS5AYODdqLPxr/f7CUCj//Kz2syI9
	0L3bnRj35+Ts451+PLMjiTw3oEE3eI96a1RKTY/cAMOcOSBp0R9rwRJ3uC5xUIyavA==
X-Gm-Gg: AYBFou0vqE2J8Z/5XbpZvt6cieD8RPDtMTV6q/n1/5Dhv3P28E6Acnv8KyXNSolVk8e
	G8bB+GnU4kJZB/o+wQfB5ue50YsTl2Xsvik32rTnWLB6jRWfB+2IH1/mNG0Um5EOjsEiwFig5KR
	f3+WTgdvYAb05C6kDRQb2KB5O1Nl5ozwoHY/O2+w+TeYl7EUh1cI8yH5fY8HfAiKo4tQAV9RQKB
	erS+fnTzpvzXkjaJl1PJfxnX/FribgIGvH4XJlOn8o54QYYt4sD03Nv+/SNF8Z2hCT7E419Zdj8
	UCPu7pLWBBAviRfuytmwnyzpDQps10673/Bt/pAveMqeoZnnbUdQ9/j5eC+s0LhMZLmRIHcVtOP
	BkRQ8QNNVEsW7QcA9M4eplp8CWgfYk/K+yo5Pkst/gsVomojEOHpwOC1ZZgDStalq71V3vZVRcb
	dP3Pln7VT6qL9UGUsG5LGolKpOoMFPfc0/Z/B/EOM+jhZy19YjnCqRxp2APvnzpeMudGp4ZArhD
	AG5
X-Received: by 2002:a05:6122:e22b:b0:5c9:a60c:2736 with SMTP id 71dfb90a1353d-5c9b598e442mr8405960e0c.14.1790080799199;
        Tue, 22 Sep 2026 05:39:59 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-91402535ce1sm14566906d6.48.2026.09.22.05.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 05:39:53 -0700 (PDT)
Message-ID: <d2052425-3fb4-4104-b1ed-f2d53e5a710d@ieee.org>
Date: Tue, 22 Sep 2026 07:39:47 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] umh, treewide: Explicitly include linux/umh.h
 where needed
To: Petr Pavlu <petr.pavlu@suse.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bridge@lists.linux.dev, netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
 <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 9:46 AM, Petr Pavlu wrote:
> The usermode helper declarations were previously provided by linux/kmod.h
> but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
> moved them to linux/umh.h in 2017.
> 
> Add explicit includes of linux/umh.h to files that use usermode helpers and
> remove linux/kmod.h where it is no longer needed.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>   arch/x86/kernel/cpu/mce/dev-mcelog.c | 2 +-
>   drivers/block/drbd/drbd_nl.c         | 1 +
>   drivers/greybus/svc_watchdog.c       | 1 +

For Greybus:

Acked-by: Alex Elder <elder@riscstar.com>

>   drivers/macintosh/windfarm_core.c    | 1 +
>   drivers/pnp/pnpbios/core.c           | 2 +-
>   drivers/video/fbdev/uvesafb.c        | 1 +
>   fs/coredump.c                        | 2 +-
>   fs/nfs/cache_lib.c                   | 2 +-
>   fs/nfsd/nfs4layouts.c                | 2 +-
>   fs/nfsd/nfs4recover.c                | 1 +
>   fs/ocfs2/stackglue.c                 | 1 +
>   kernel/cgroup/cgroup-v1.c            | 2 +-
>   kernel/module/kmod.c                 | 1 +
>   kernel/power/process.c               | 2 +-
>   kernel/reboot.c                      | 2 +-
>   kernel/umh.c                         | 2 +-
>   lib/kobject_uevent.c                 | 2 +-
>   net/bridge/br_stp_if.c               | 2 +-
>   security/keys/request_key.c          | 2 +-
>   security/tomoyo/common.h             | 2 +-
>   20 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> index 053555206d81..af4e76babe7a 100644
> --- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
> +++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> @@ -11,7 +11,7 @@
>   
>   #include <linux/miscdevice.h>
>   #include <linux/slab.h>
> -#include <linux/kmod.h>
> +#include <linux/umh.h>
>   #include <linux/poll.h>
>   
>   #include "internal.h"
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index b77f901fc3ef..6f5d059394b3 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -14,6 +14,7 @@
>   #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>   
>   #include <linux/module.h>
> +#include <linux/umh.h>
>   #include <linux/drbd.h>
>   #include <linux/in.h>
>   #include <linux/fs.h>
> diff --git a/drivers/greybus/svc_watchdog.c b/drivers/greybus/svc_watchdog.c
> index 16e6de5e9eff..b318eb34bcca 100644
> --- a/drivers/greybus/svc_watchdog.c
> +++ b/drivers/greybus/svc_watchdog.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/delay.h>
>   #include <linux/suspend.h>
> +#include <linux/umh.h>
>   #include <linux/workqueue.h>
>   #include <linux/greybus.h>
>   
. . .

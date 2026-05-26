Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F339732F;
	Tue, 26 May 2026 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793339; cv=none; b=i2pGvIjs4xKrzwK51isb6zcJoIx+82rDPG6/vzZLpcfInCn5kLmh+F1NVz0aZi8QyvipT1jiZvr/ZxOk7betCyqNzMu7h2Hj2fRHfvfcSMFXUdw3r7KhOxfbq/kciiQRF1vCNQAPslUsOSjAnGTTn0xsNik1leNzkfQ/EYp04XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793339; c=relaxed/simple;
	bh=X5PmJFYOnMoCHDWkg1xofv0SJcbSHYDhtU0aqiODcPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSjv2LvSh9LYgRc3XdN76KAr0NVpFTsAfNiV4xBQJVw30MXdBCp0C4WqZTd6R0NIC89j2zBc2Igxy2V9TNBQOciWTT7j901hufOIZpFznkyYfLBDIsJV6wUhLJdSDPMJM0CYcoRhhCmVYSLXmJnMJRbSDRAEQUu1AspIj9fJmmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=bNM3rJtN; arc=none smtp.client-ip=188.68.63.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="bNM3rJtN"
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4gPqZm4mrQz8gZm;
	Tue, 26 May 2026 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1779793328;
	bh=X5PmJFYOnMoCHDWkg1xofv0SJcbSHYDhtU0aqiODcPE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bNM3rJtNx/NvVUELxIAG2LtHQAmELBpJKTBS6Jk40WHOB/AOg+9szKTbfoNhOyCAt
	 GmqxyoxaKvpdKuDOY+8fSXhCTtNaCog8SNCBv4xsnNrjsQPv7zA8SVtl4TdAPf0148
	 ubmH0LmiRzXXTGspOUwXkEwwdkuPWR5LS3boBlwSQZ94bf2A2O8v9UawrsjkpjaX+5
	 e70EaFIZ0QBIGZVZ8EGIVx0KIpcBKxTjAVZKBzGfFnMGfMVsfSa8n+BRtbM5KF1zuk
	 y6ln4Uj6bNWya8r28IVYDEsHXI+4fyR0obMb9gusPZEYUEGhPU3m26gc2dD+6wOgh6
	 jFr8NlAQQ4kag==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4gPqZm42RYz8gWh;
	Tue, 26 May 2026 11:02:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gPqZk5GgLz8tcX;
	Tue, 26 May 2026 13:02:06 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 9AEBD61886;
	Tue, 26 May 2026 13:02:05 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <28aa7450-e4c1-43d8-acc8-16a95df1d1a1@leemhuis.info>
Date: Tue, 26 May 2026 13:02:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject:[REGRESSION] fs/qnx6: incorrect pointer arithmetic breaks
 dir scanning completely
To: Oleg Chaun <olegchaun@gmail.com>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, willy@infradead.org, brauner@kernel.org,
 Arpith Kalaginanavoor <arpithk@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <d02905f7-6ef8-4df0-bb55-dea44fda6ce2@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <d02905f7-6ef8-4df0-bb55-dea44fda6ce2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177979332608.596138.12636427513309806755@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 9AEBD61886
X-NC-CID: cPbqH/IzxRA6KHLDH+mnHajbvASCnvhBeSWrNM+7XMRObnKunM4=

On 5/26/26 12:40, Oleg Chaun wrote:
> 
> A change to fs/qnx6/dir.c:qnx6_readdir() introduced in commit b2aa615
> contains an incorrect pointer arithmetic (adding an offset expressed in
> QNX6_DIR_ENTRY_SIZE units to a plain char * pointer) which breaks QNX6
> directory reading completely: only few entries are visible, kernel log
> is spammed with "invalid direntry size" messages.

Thx for the report. From a quick look it seems Arpith Kalaginanavoor
(now CCed) reported this last month and provided a proper patch:
https://lore.kernel.org/all/20260310102233.391113-1-arpithk@nvidia.com/

Al (now CCed, too) suggested a slightly different fix, but it seems
since then nothing happened.

Ciao, Thorsten

> The following patch seems to fix the issue:
> 
> --- /tmp/temp/linux-6.17/fs/qnx6/dir.c    2025-09-28 23:39:22.000000000
> +0200
> +++ ./dir.c    2026-02-13 18:52:56.000000000 +0100
> @@ -138,8 +138,8 @@
>              ctx->pos = (n + 1) << PAGE_SHIFT;
>              return PTR_ERR(kaddr);
>          }
> -        de = (struct qnx6_dir_entry *)(kaddr + offset);
> -        limit = kaddr + last_entry(inode, n);
> +        de = ((struct qnx6_dir_entry *)kaddr) + offset;
> +        limit = kaddr + last_entry(inode, n) * QNX6_DIR_ENTRY_SIZE;
>          for (; (char *)de < limit; de++, ctx->pos +=
> QNX6_DIR_ENTRY_SIZE) {
>              int size = de->de_size;
>              u32 no_inode = fs32_to_cpu(sbi, de->de_inode);
> 
> I can test any further changes on real QNX6 fs images if necessary.

#regzbot introduced: b2aa61556fcfa8
#regzbot title: qnx6: dir scanning broken
#regzbot dup:
https://lore.kernel.org/all/20260310102233.391113-1-arpithk@nvidia.com/

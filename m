Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014F29B200;
	Mon,  1 Jun 2026 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329798; cv=none; b=aG9Q49e9l7GdStJRPMsSfgkNlaKMuBOuGl4U0yO9HRM8noIDfJY0jyGa0+dQGjx2aunVbXo2Dql9Nd2Y5I4c9XAjAfaDsL7jbLk7qv9Ml4q1VwgtKnQigIwDK0QpHLl0N/ANmYmpjVANfJX5nHsnSro8JTRDEWy3vRlvCHCk4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329798; c=relaxed/simple;
	bh=Ij/PIPeoe8eat5h9rRDoQ0+ASKdZMHhPft7GAFAJU0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmaezw7vpszJ/nB6nXX+2eBd1y7CwJbKgQi8ymZjEYXX8CjTtEHQCRK8FfNt7a9TbDHvAVL0abPQqeX09ojK8M0iDxTUYDXlBhY1nQdvW8BjHmI8PN7nF+mI7eq6v0bHRkhujxEkn8aagpz6agBNs9uLSsYj/frm+0leF2JOhZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=oDPG6Q3t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XMfZqDzA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="oDPG6Q3t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XMfZqDzA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D6AAEC0077;
	Mon,  1 Jun 2026 12:03:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 12:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780329796;
	 x=1780416196; bh=wA5E01d5LX7p68hsTd1fIlsAcpW0zylkjrgTQ7P7wsk=; b=
	oDPG6Q3t1X77dMXGx2onCVyoq4wnr7Mkx7+u2iTsNMj2CQhUgJ3bdI2dt1E3K7Rk
	eEOwmYyJhHt7nJo6QCgK+0GkCGbToMmwGf17h7ZhvdvMiUquY/YMmylUqBZk1U9a
	7/IxDzCKr+q1O4Z6FgRpTUdMs1jL3ZbMjDaNpG+oZNlOh7luMxQgrZLNp7W0v/gZ
	hg/Y22xQIXvTckGLOxz6s2RDhaiVaKQl8VG+xlmfnoOIScJ+sxkFHiOIGunC01Bg
	wDY3p7wBez0e0xj26DGNCdzEZhQIqNKVaXOdrFlTbkqOpcRZ50YohrlUmQNqa3iK
	2pt7/MdUmXGId04r4KfWpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780329796; x=
	1780416196; bh=wA5E01d5LX7p68hsTd1fIlsAcpW0zylkjrgTQ7P7wsk=; b=X
	MfZqDzAIUqwor6EzNfpf0Y+YTVCoV3Kb//Ukd3/DbVhFHdOMHpoHya1fB5n4dZhc
	ENg0rAiVbkbBzJlYEyHoe+3YYjvpN0JYC2Eu+REwusG+ntInFMvVHNQ6Q09LmEpU
	gHz5v8BmwrqIPIbBBPZcZDa1h882A5oloczVxP2FVa3BeSgKzlpgPW4dRYGKca6l
	jtZmZd3uOqZpEBcGbK+uY/mVTMpGOXfyMmu6QKL2sNhhfjgw289nL+VqoZx4T9EU
	9vZe8WspHF9pamLR+NJQU2LgwgKt4gjx02rncfE8z14FR08bt3QKVH88+bUXYtFH
	8g/Q3NSw+G6pPpNmMLyYw==
X-ME-Sender: <xms:Q60daiB5PaLw2R4FFtIMI6QQUurzlYN2V2T0_hMiX471mPcTJCtSkg>
    <xme:Q60dauB8ID5WwbYNdfvLMQbsGcBNqUjmSDNsBH2BWFjzQvJChPVRHoQLlCbpXLgwd
    Ewh7p0CaS0kUQdkxctrH_hXjr-VC5tZiqfOsve2YU4Wui_eRtM>
X-ME-Received: <xmr:Q60daloonDfiJepoCGz6Gz6yiP8a-t3VVUQzcKirk6Q8W-zOZeGMCYI9zlWgwyxzwY3BURItWzqGdBitfKkTem61FtCMwRdEek7hylEnUTpx4ejxJA>
X-ME-Proxy-Cause: dmFkZTFUmbEGFQN3Gts0uFyuMgV58NNOLbg/Uv/9exmDGsgwZZ1MgkL4mB40k7/bNDKAQW
    CVvmqu1XR1DrjE4RW3GmVOIoL58kNDaVuqIf3OlE4nVMLC7tllYZhoPysq+Et0nXjLPA/Q
    hFNG3yVE14AwVc7XqRdVhjGiW51a9bBNvJcYVYodoX39BxczsJP/a8Jy2Hf/wdY5ViQZhi
    NN3QjIeHhdZqnQJ86Y5fqL1N0pBB3PJgnGaENpgEwdnryRc1b+Y/Ui6u6pIyAaSxx6uNWb
    cxJF95Nj5sI5QSujns3H+/pE5zhr4z64erRFggeXxS2aRa5d6Knm90I8GfKhqETYK4DhrQ
    ba5/otAI18m4boo/adyEUMfvo9K1o9YKgLQV4eKz+vdndaBCRrC38/lfc8C7TnnfMgv3Lj
    ZrpdshyBs2OS0u/3FR0hZN7E2VvpchGAzfTuIPsMv9oo60ZBM0xMuj/0+bP/r0NmdOAdYu
    2Tj7Z0w6l+SLXqN+glZV4YQRLgWzbLPL3ci37bhHeg8kulvYQIIkhVtzMWv7M9J8OABwTv
    WrgAtPlqKK+6eV30UJHoMpjoX5CuDFZFzMiLcbP6dRvr85lm6ds/QnbKF3igUX8lqQq1Rn
    7y46a2ZB/Xcs8xwCNdo/4CETcODbHvwfwtRacxDt69URJiggRJ8X0KhOMs7g
X-ME-Proxy: <xmx:Q60daglksjwRP-mRlcoC7vPCRHAIKHRl_GftSE_rFkf640eXYb6Ggw>
    <xmx:Q60datz1WXrFdJG6l6i2LuEAywJX_XLyPzQKx-bx43bnkYvL2Q5EhQ>
    <xmx:Q60dag-YclHijO2oq8FG0MSTFQF4FMSSUDFpDYx-IhV6CnfiCez2Yg>
    <xmx:Q60dahKT_xro_XplnS-UiAFyQDTKAE1ABG3inWptmxDlLzlL3I6i5w>
    <xmx:RK0dapeTZqzKWNCivXpyGImLt-vCABpZuO5Sd4q6NhLNEtq7Ea3gQ6PG>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 12:03:14 -0400 (EDT)
Message-ID: <e456a62c-1b5f-4634-bbb4-cc3f02a04ea7@bsbernd.com>
Date: Mon, 1 Jun 2026 18:03:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] fuse: KASAN slab-use-after-free in
 fuse_uring_copy_to_ring()
To: =?UTF-8?B?6rmA66+87ISc?= <neck3922@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
References: <CAFmvuTW=gntFCBtuHGAu7caC9FM4Ovf_r1ng5gmy6djn9ziLqg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <CAFmvuTW=gntFCBtuHGAu7caC9FM4Ovf_r1ng5gmy6djn9ziLqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/1/26 10:28, 김민서 wrote:
> Hello,
> 
> I am reporting a FUSE-over-io_uring bug reproduced on upstream v7.1-rc6
> with KASAN enabled. The bug was found with a local syzkaller setup.
> 
> Target file: fs/fuse/dev_uring.c
> Subsystem: FUSE
> Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> Git head: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> Kernel release: v7.1-rc6
> 
> Observed crash:
> 
>   BUG: KASAN: slab-use-after-free in fuse_uring_copy_to_ring+0x20b/0x230
> 
> The same issue was also observed on v7.1-rc5:
> 
>   Git head: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> 
> Root cause analysis:
> 
> The crash appears to be caused by a lifetime/state mismatch between
> struct fuse_req and the FUSE io_uring ring entry state machine.
> 
> The KASAN report shows that the affected object is a struct fuse_req from
> the fuse_request cache. It is allocated in the FUSE open path via
> fuse_request_alloc() and freed later in the same open path via
> fuse_put_request(), but it is subsequently accessed from
> fuse_uring_copy_to_ring() while FUSE io_uring is sending a request to the
> userspace ring.
> 
> The preceding warning in fuse_ring_ent_set_commit() also shows an unexpected
> ring entry state:
> 
>   WARNING: fs/fuse/dev_uring.c:865
>   fuse: qid=0 commit_id 4 state 3
> 
> My current guess is that an error/teardown/commit-and-fetch sequence may
> leave a stale fuse_req reachable from the FUSE io_uring ring/request queues.
> 
> Reproducer:
> 
> C reproducer:
>   https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/main/fuse-uring-uaf-v7.1-rc6/repro_fuse_uring_uaf_userns.c
> 
> Full symbolized console log:
>   https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/main/fuse-uring-uaf-v7.1-rc6/clean_userns_report_rc6.txt
> 
> Kernel config:
>   https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/main/fuse-uring-uaf-v7.1-rc6/kernel-config-v7.1-rc6.config
> 
> Key config options:
> 
>   CONFIG_FUSE_FS=y
>   CONFIG_FUSE_IO_URING=y
>   CONFIG_FUSE_PASSTHROUGH=y
>   CONFIG_IO_URING=y
>   CONFIG_KASAN=y
>   CONFIG_KASAN_VMALLOC=y
>   CONFIG_KASAN_EXTRA_INFO=y
>   CONFIG_USER_NS=y
> 
> Runtime conditions:
> 
>   fuse.enable_uring=1
>   unprivileged user namespaces enabled
>   /dev/fuse accessible to the reproducer
> 
> I verified the C reproducer by running it as uid 1000; it then creates a
> user namespace. In my minimal QEMU rootfs, /dev/fuse was chmod 0666 before
> running the reproducer because the device node is root:root 0600 by default.
> 
> Without a user namespace, uid 1000 can open /dev/fuse in this setup but
> mount(fuse) fails with EPERM, so the provided reproducer uses CLONE_NEWUSER.
> 
> Brief KASAN excerpt:
> 
>   BUG: KASAN: slab-use-after-free in fuse_uring_copy_to_ring+0x20b/0x230
>   Read of size 8 at addr ffff888009ecc698 by task repro_minimal_u/153
> 
>   Allocated by task 153:
>     fuse_request_alloc
>     fuse_get_req
>     __fuse_simple_request
>     fuse_send_open
>     fuse_file_open
>     fuse_do_open
>     fuse_dir_open
>     do_dentry_open
>     vfs_open
>     path_openat
>     do_file_open
>     do_sys_openat2
>     __x64_sys_openat
> 
>   Freed by task 153:
>     fuse_put_request
>     __fuse_simple_request
>     fuse_send_open
>     fuse_file_open
>     fuse_do_open
>     fuse_dir_open
>     do_dentry_open
>     vfs_open
>     path_openat
>     do_file_open
>     do_sys_openat2
>     __x64_sys_openat
> 
> If you fix this issue, please add the following tag to the commit:
> 
>   Reported-by: Minseo Kim <neck3922@gmail.com>
> 
> If you need anything else, please let me know.
> 
> Best regards,
> Minseo Kim


There had been reported races already and I had sent out the fixes as
"[PATCH v2 0/4] fuse: Fix several io-uring race conditions" on
2026-05-19 to security@kernel.org. Given you posted a reproducer to a
public list, I can send out to the pulic list now.


Thanks,
Bernd
> 


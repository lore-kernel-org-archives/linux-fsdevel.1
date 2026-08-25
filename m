Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32477470117
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665475; cv=none; b=ljPE1p7k7I0M+DPtjUASKRkjy2V/Z9T1246M7BUo7CeRy/TT4+Njk+Zixezq30eE9uapHAnf+Ill12kND2TAx8uMM6X9kqEhndVbmK0hl2sTJXe+DNsbICpiaXzGsxbtEJHjfqSD+A2MS1JkPHAIU7zem0L+bnMH7hsIpzWNbAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665475; c=relaxed/simple;
	bh=5q1vX8CAVw1rFSd+O6ZB/UiBkD7aNeky43D+ZQqttCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p2eu2nw1I1ot0QuyH+kXVlbEvV+tOSzr5U3+RlctIIYQ5GTTOvscqujF76BKbe1wAQQ3lIxEQy7fBtA+gY4jzhQCzpOn9kPMpnOqzJ1eX/y6Uf1zIfOHuCqMWT/OTHpmmAM/7vnaEIlN2esXb4MtF0p4++V8AaMu/KyMFDheiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=febFWKWL; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="febFWKWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Gf
	LmC6rwYamprISfJQ7e28szJNM28h+jToqElmKdvik=; b=febFWKWLem+GYzAe0P
	HRn6Jtpd40250E2SkOIcJLErK50nlyAH1U5UiAGIb5jcNH8yA79xIH/mGErpFx0G
	njMh47q1TLIdyhtYla0+DxQbwmUN3o4o6NNuA2UtTq6nepILynaiTqzjL8udz1PB
	3s2NN/2AOqKfYCkZgrEGx+IDc=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3_2D8m41q_jSyDg--.31202S2;
	Tue, 25 Aug 2026 21:43:25 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: brauner@kernel.org
Cc: axboe@kernel.dk,
	jack@suse.cz,
	jackzxcui1989@163.com,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mjguzik@gmail.com,
	neil@brown.name,
	oleg@redhat.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 2/7] fs: make close_files() synchronous
Date: Tue, 25 Aug 2026 21:43:24 +0800
Message-Id: <20260825134324.974005-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824-work-coredump-unlock-self-v1-2-48fd1cca7eda@kernel.org>
References: <20260824-work-coredump-unlock-self-v1-2-48fd1cca7eda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_2D8m41q_jSyDg--.31202S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF45Gr1rGr4UXr45Gw4xtFb_yoWkJFc_Zr
	Wvvw1rur4jgr48tanFk3WS9rZ7tFs5JFyrX3WFqrWktrs8XrykK34vgr1fCr1rJr1xGF9x
	tr1kZF9rW347CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUqQ6PUUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC6B0kLmqNm-2x7AAA3j

On Mon, 24 Aug 2026 17:28:16 +0200 Christian Brauner <brauner@kernel.org> wrote:

> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -480,6 +480,11 @@ static struct fdtable *close_files(struct files_struct * files)
>  	 */
>  	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
>  	unsigned int i, j = 0;
> +	/*
> +	 * A kernel thread that might be needed to make progress on some
> +	 * umount must not run __fput() itself, see __fput_sync().
> +	 */
> +	bool sync = !(current->flags & PF_KTHREAD);
>  
>  	for (;;) {
>  		unsigned long set;
> @@ -491,7 +496,10 @@ static struct fdtable *close_files(struct files_struct * files)
>  			if (set & 1) {
>  				struct file *file = fdt->fd[i];
>  				if (file) {
> -					filp_close(file, files);
> +					if (sync)
> +						filp_close_sync(file, files);
> +					else
> +						filp_close(file, files);
>  					cond_resched();
>  				}
>  			}

This seems to be a significant change that affects the release timing during
every task exit. If this modification is indeed feasible, it is certainly
more straightforward than my previous approach of adding a PFUMPCORE flag
check NOT to use task_work to release files.

Thanks
Xin Zhao


Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC533F5BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708913; cv=none; b=fDxtWl4JFVX6aNUZlT7YweCJjHHyzAYa6nmflx1zxtmcE9H9q6UrfH796XCZz7+Lhe0BT/iWyFI4FvmhNKw1aGDYxkV7UdDiyZbdU5uCtdmgoaJ7v59/Y8YHgJL3fipyZ40B20TMkG8WPGjPw0/Ohd0IusdQzBG7wr1K2g2RhQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708913; c=relaxed/simple;
	bh=W0lWD9norO8ho877RT4s8d5/whlAlXiHVbgDmcsbUlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVnJ7zQ2NKYgCxQ62fY9VWHAP8JWsZjVtETD2q8EnQQ1SSs+dH0JX+ukJa8pIMEvd1WJFaW1w2Lmj5+nCOzvfnba/Ub/sq+u+RkIduHWaF9dB1qySXPcJDyoQxwxbPcEoGHh1cCVNZ/8S0v1XFaZc11/fve08db96UIrDne9R7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaSlOtfc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaSlOtfc"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso634083b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786708912; x=1787313712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o9s8AN57wB7Vi/36kIlm/41aiy/3Kyf8X3cTuSCNC9g=;
        b=KaSlOtfcJTORSjzWQnYFc3w2dVrVkQiguB4YeCRJLouWGE0KapMM+5wS+T6myekMnw
         R5Ezn3atktAk0NEUscMjQCSbatXctgPEI2NrLCEsHsC/kiI+89YvAuBaxfvY2JZlBQwz
         lAuqD4j/EV8rlnBwYlXFt4RdKh8JhHLrHJ7Uni/X7z2NC9/p9tdKV+Vk7CCLRbrgMV0a
         ILI41IQbOJKGMX9XMaT88kFte0Mab5Hy4yuI0dsXbxMQu/9eaGb+0R02CwWxN65KqwYL
         SWnv6hr9XWdzZzxciGMNhqk8DEHGAdhBAnx/om+3x009tWKeO4OytH/Ki7S2b8FpiHdP
         WSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786708912; x=1787313712;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9s8AN57wB7Vi/36kIlm/41aiy/3Kyf8X3cTuSCNC9g=;
        b=UuXFEqyRIhPIPHkmBiDg0Yo7V6oFU2GpwJBQwRVZfgDIOY4pD1CFl0D5TRmZFhCJGU
         0x8krh5FoeRE+xpvgBjuPfeXdPAjmoYwqT+iN4wVJ8Kyg34GWjNNrrOj/9ekgLsqatZd
         Ah9R17wVMfIlKLWhStegW0TocNnG77JUGRFhrkbNnyKNATjlQgIK/pJazlZIIXj+Vu3y
         NQFwLz6GyIyThPXrZmAvqjtJXCRMFM6NNCMDXa4c/KRezTfEI3itKTUhu+F2FJvod95V
         hC4Sc/k0pEhPJS6+UVNAAyo8vxMsjGltKa42uzsJw6bFd3WUsHJKc+0OY0Rll/bc2ayz
         nSFw==
X-Gm-Message-State: AOJu0YwzTY6DknTi7+E77Iw2VLvbKZTkt4IzGfwT2mHxknWrmAPuDbk/
	Y/FAJ2U8XTzXJ1q8YOsr6R+Jjp32ozas7EVOW7dclcE7p0Fry1dVTRRS
X-Gm-Gg: AR+sD11my11OkFgmNDgKFc9JfVx6QPFtBmAxJ23akDHvFUSNK/2MOZq85cTqABDBNa2
	xBJfaCscrWmn5PUxgPU1PqmxQ6duw9RFKHCLQggswna0aOzy8+Nw3uxScRUaP264tmb04aCyAXl
	GliAfDiI/Sw29DwhQ6Hxs54CFj8P1lCZHGEoMsaqRd8xl/AkDjAoMEeFYzmY/AIqk+l4vS0hxNG
	R1jwo6tet1EGw0nlZj5RwahlIOXEZ6/0XWV6Mq/ppxfwo9ndZlGXb5fH52Vh7sypiw/pb7sLGTK
	Vb44ZMyKsCaFuANWXjKJbbQBbUAxqINoIHdIFfEerLYpDID/+Qh6xHI7fpRSz4W/X27cDMvFrTH
	8H/SzCQunlm+UnXdOlPtDecKupDeMhTMFGY/URorZrp20rq+vTzqVi1TEdBemyd1RbA1sGU2+Pr
	gF4yoe46+yrmbZ52dK6Q85mZnzcf5lRtE2YmOi9t9UbO5PO5Dp0yThvTcymOcy6iicOWzfgCp60
	hoftiL6
X-Received: by 2002:a05:6a00:9a0:b0:84e:e741:174f with SMTP id d2e1a72fcca58-84fddf87594mr5396442b3a.7.1786708911472;
        Fri, 14 Aug 2026 05:01:51 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d01c2e7sm384922b3a.13.2026.08.14.05.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:01:50 -0700 (PDT)
Date: Fri, 14 Aug 2026 21:01:47 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, tglx@kernel.org,
	ebiederm@xmission.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] posix-cpu-timers: Dequeue per-thread timers before
 exchange_tids()
Message-ID: <an8Dq_XUMobC395V@v4bel>
References: <anfgrsPlUdwBhdrp@v4bel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anfgrsPlUdwBhdrp@v4bel>

On Sun, Aug 09, 2026 at 11:06:38AM +0900, Hyunwoo Kim wrote:
> A per-thread CPU timer holds a reference to the PID of the thread it is
> attached to and, while it is armed, its node is queued in that thread's
> posix_cputimers. The task is looked up by that PID.
> 
> When a non-leader thread exec()s, de_thread() changes which task owns
> that PID:
> 
>   de_thread(tsk)
>     exchange_tids(tsk, leader);		// tsk's PID now belongs to leader
>     ...
>     release_task(leader)
>       __exit_signal(leader)
>         posix_cpu_timers_exit(leader);	// cleans leader's queue, not tsk's
>         __unhash_process(leader)	// that PID has no task anymore
> 
> pid_task(timer->it.cpu.pid, PIDTYPE_PID) then returns NULL, but the node
> is still queued on tsk, which is alive. timer_lock_sighand() takes a
> failed lookup to mean that the node is already dequeued, so it has
> nothing to undo.
> 
> begin_new_exec() calls posix_cpu_timers_exit(me) right after
> exec_task_namespaces() and that removes the leftover node, so the state
> normally stays invisible. But bprm->point_of_no_return is set before
> de_thread(), so if unshare_files(), set_mm_exe_file(), exec_mmap() or
> exec_task_namespaces() fails, the task dies before it gets there.
> exit_itimers() then frees the k_itimer while its node is still queued,
> and reaping tsk later erases that freed node from the rbtree.
> 
> Dequeue the per-thread CPU timers of tsk before the PID changes hands, so
> that a failed lookup again implies a dequeued node. Process-wide timers
> are looked up with PIDTYPE_TGID and transfer_pid() moves that link to
> tsk, so they are left alone.
> 
> Fixes: 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  fs/exec.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index c7b8f2d6366c44..f80f70e1c26de4 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1000,6 +1000,18 @@ static int de_thread(struct task_struct *tsk)
>  		 * the former thread group leader:
>  		 */
>  
> +#ifdef CONFIG_POSIX_TIMERS
> +		/*
> +		 * exchange_tids() hands this thread's PID to the old leader,
> +		 * which is reaped right after. The PID lookup in
> +		 * timer_lock_sighand() then fails while the per thread CPU
> +		 * timers are still queued here, so dequeue them first.
> +		 */
> +		spin_lock(lock);
> +		posix_cpu_timers_exit(tsk);
> +		spin_unlock(lock);
> +#endif
> +
>  		/* Become a process group leader with the old leader's pid.
>  		 * The old leader becomes a thread of the this thread group.
>  		 */
> -- 
> 2.43.0
> 

Gentle ping. Any feedback on this patch would be appreciated.


Best regards,
Hyunwoo Kim

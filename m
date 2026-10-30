Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377562;
	b=Zg1uAK0pyUJMSj/p+WrbCS6/MRbxgG1Gefx8TKEyP0TEBSw5pxeRpcGgDSbeQ9iXgpb1
	 s0cXwMwY+Lqu/Qs8kI5Lf1U//4Xw6j6PrWbTyrQErGO4tVLQtelI+jMCAdf0acndV8NY4
	 vQ2+lu9tHZpOSQAhoWUmt2dbqy2OND5En4JpxFq5WZRVw0D0iSxS3MTHzr3U/NE9jAsP/
	 V8yY4f+XgzTUv9shzdtmoxkbZnm+aoXZGfYbB47lItcu8SSvatYeLF70o0jHDidoM3nwI
	 VXdEGi7VNyUqYjCkB5tY2jdcii+DgRy2cMR+OXqRUrfjz6rpnZcBMCKy6oz6vnn5rUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377562;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=68Hay92Y+nhwFfP0J5SBTw0RYHwdngtu3bjefOUy1a0=;
	b=dwbllyekDh7CeqmSMB4TB5Zkmk1hVuZvhvU4aBd29D3Y/sspSKjGiX2Bci19TWgbYrL8
	 prTBOdFgQsU4ins/W4H1mTUL7s0A9/qapunjRtDnSoQzMkU1eneRj0eYA4/Q0AgJfJxv0
	 2S73xPnVD/rncnKLzN61KiDZVPrwfvchLJjIR8BodUeDJUK0ZsCIRwujXbiwK5ACj+nmj
	 DklpK49KzEMbLvaE/f/KFPZvak6rrDW0ojdqxLaJRfFiq/rP0bFkvr1XU/+jE49hpXyWU
	 Bt9vUgjypGa0yf3X5ocdETXI4CHLYFVeZwJSDLNGScl1MiZF4SmBVKaueFn2if9HzVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4+jRZfg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5F606A31D;
	Fri, 30 Oct 2026 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4+jRZfg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B101F00A15;
	Fri, 30 Oct 2026 16:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793377561;
	bh=68Hay92Y+nhwFfP0J5SBTw0RYHwdngtu3bjefOUy1a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N4+jRZfgNoouIFfmgfrbd+AHHdlYfND2/42Ak70ZMKCuoA/vMUn1jhGbVTw6Z8XWI
	 c1P4HQh23J3q6NB3agS5pqPR5LxZoU1iW3/eVhOopfsRRhTJezksvd0TL+59kUxhv5
	 80Zy2BdlwLKO4YOwOUzm+LC6wWDF6Zip2pvsfu5MbiJbQPzpaFfY/w2W0TypbccnOD
	 NUo+UMuEeV/efjdSboXdgG4y4lyURjEYTwl6AyjPqtj52Jp/Qd22qCng63/td/tr4/
	 Wfmh4UBQJNxOfcbCc/arXqsJUIvHmuE/3frVObs9kHXyJhBGsxXd6VqVEckE7b/JRM
	 Zf2/XcNGz33VQ==
Date: Fri, 30 Oct 2026 17:25:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tycho Andersen <tycho@tycho.pizza>, Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	Andrei Vagin <avagin@gmail.com>, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 0/2] nsfs: gate pid-translation ioctls behind ptrace read
 access
Message-ID: <20261030-halbfest-dazugeben-einzahlen-b38d1ba2f119@brauner>
References: <20261030130422.738277-1-cui.tao@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030130422.738277-1-cui.tao@linux.dev>

On Fri, Oct 30, 2026 at 09:04:20PM +0800, Tao Cui wrote:
> The four NS_GET_{PID,TGID}_{FROM,IN}_PIDNS ioctls on nsfs descriptors
> only check that the fd refers to a PID namespace; they never check
> whether the caller may inspect the task being looked up.  An nsfs fd
> is freely transferable (SCM_RIGHTS), so an unprivileged process that
> receives one - the way container runtimes and LXCFS hand namespace
> fds to less privileged helpers - can use these ioctls as a task
> enumeration oracle across pid namespaces, bypassing the ptrace-gated
> /proc files.

No. These ioctls translate pid numbers between the caller's pid
namespace and the one the fd refers to. NS_GET_PID_FROM_PIDNS does
find_task_by_pid_ns() and then task_pid_vnr(), so a task the caller
can't see from its own pid namespace already comes back as -ESRCH.

And NS_GET_PID_IN_PIDNS starts from find_task_by_vpid(), i.e. from tasks
the caller can see anyway. IOW, they already follow the same rule that
PIDFD_GET_INFO enforces.

And pid numbers aren't hidden from unprivileged tasks to begin with.
pidfd_open() has no permission check, /proc/self/fdinfo/<pidfd> prints
NSpid for every level below the caller's pid namespace, PIDFD_GET_INFO
returns pid, tgid and ppid without a ptrace check and so does
/proc/<pid>/status with hidepid=0. hidepid hides /proc/<pid>, it never
hid pid existence or pid numbers.

> Two residual behaviours are worth stating explicitly: ESRCH is still
> returned before the permission check, so pid existence remains a
> 1-bit signal - the same residual pidfs and /proc carry today; and

That's not what the patch does. With an ancestor or sibling pid
namespace fd a task outside the caller's hierarchy now fails with
-EACCES while a missing pid fails with -ESRCH. That's a new existence
oracle. for example, for host pids from inside a container, that doesn't
exist today. And it breaks same-uid translation of non-dumpable tasks
and any LSM-confined holder that gets ptrace read denied, which includes
the LXCFS case you say is unaffected.

The selftest isn't correct either.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007481;
	b=wTt+nYeRKmNkfo14YIBa4wWQeDQ0r7hR9AIW9THFUG0UrZTlv9TlFr6OQw2Z3VhLU0T4
	 1p5IK4anVeqYui237nCHlGZLd40Sj0JUBWR2zuyfTfQnK4kFTcMZ7NDKG9oFyiv8JuZ2L
	 gPlPlO4Bnr48FWBy44n1MHssKAxtTyiLUnLfwHJ5OoLfNIcdomd+YVWMyL/GzeNeX5JX4
	 cNMu6n4kBplow6LgmPLjQVm6/Vcl/pZDFKuX9KkEJqaHzKA1K2b8JrKZSMrp9sB62eOJY
	 3ebYvv9s/OQO99jy7HJZgD056iurmqYMqlaicZVfHQcBuZaAlSx7qCJr0zEwAYuDiOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007481;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r+7quN+GXBrQXljQFdduQ9uCmIQYnXKvh0n7Ko5kSMI=;
	b=eW9ChXXUgp8AF6JiHLP+AhNYLHp2HNCY6JxptnwdlFBfQ77Rngv+0BzfddEBoWdxZtsj
	 liOh54GmFugSIhKlka7E08hPwosuzvavUwG2Bt1jT3YHUbtvpLSiwg3jeTyotKxWvquuN
	 7h3gE6SS3GJoDlpODbLrzlt/hM5d78ZDfz8+0bOuSsEbUXejdg5vAhfRz87z4kIHTl6bo
	 wBDYJvjaKsURt+aPzn+vgJRK91cMietOjFw9FzbXYWrbsSIaEMxyl7r3uEzZ5q6tnB4jP
	 DOb9ajacpvNwxCygC063r/pcHhKIt3rTYmMX4ZTAPQXXaNzegIFvBDjktXx1iGuvLCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEaCO8Ou;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3438606A31C;
	Wed, 18 Nov 2026 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEaCO8Ou
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B4F1F000C4;
	Wed, 18 Nov 2026 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795007481;
	bh=r+7quN+GXBrQXljQFdduQ9uCmIQYnXKvh0n7Ko5kSMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AEaCO8Ou258CYi6ozrLsOHwP/CgC7usWd3ZqOZf3yedz8J6gJFJEyyuP36bxVG6/Z
	 YP1v46USV9pgpN2JqXqOTvDUkZOcAJn38wQ3tY8hOUSONfTT9ZyV1dRa0U7O5azT7R
	 tsJijB62Syce1VryS6Ca7wMGdL1Vi0XMnP5Hh/qRaDmJn2ZMg5NYGcvPuVPobaRmjU
	 4t0jQQNOxynKkvxqRIY9NouaKbrn+tyFNz+039bKiLQcx97wg5MpHfvUrAkQxc4lBa
	 bJyxV0JrTTMpW02xxp3/dEptu4+lkQNbOf6AsJlCEEvFEy4rTZYYH2AD1QPDRFuHJg
	 ++D3Gu9z3XA3A==
Date: Wed, 18 Nov 2026 14:11:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Omar Sandoval <osandov@osandov.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] proc/kcore: allow disabling /proc/kcore at boot
Message-ID: <20261118-masken-disput-miesmacher-27d6baaae6a8@brauner>
References: <7c10f2e01b6f19229c83e81d887a87f5d1151841.1794904698.git.chris@chrisdown.name>
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
In-Reply-To: <7c10f2e01b6f19229c83e81d887a87f5d1151841.1794904698.git.chris@chrisdown.name>

On Tue, Nov 17, 2026 at 02:20:38AM -0800, Chris Down wrote:
> /proc/kcore lets any process with CAP_SYS_RAWIO read all of kernel
> memory. That's a pretty large read primitive for anyone who obtains
> CAP_SYS_RAWIO (and it also gives away the KASLR layout).
> 
> For this reason on some hosts we want to turn /proc/kcore off. In terms
> of what it can read, /proc/kcore isn't any more concerning than other
> ways to read kernel memory, like BPF with CAP_BPF and CAP_PERFMON. The
> distinction is that a process with CAP_SYS_RAWIO doesn't necessarily
> have CAP_BPF and CAP_PERFMON, because CAP_SYS_RAWIO may be needed for
> hardware access without necessarily wanting to grant general RAM access.
> CONFIG_STRICT_DEVMEM already makes that possible for /dev/mem, but
> /proc/kcore gives the same capability to do general purpose RAM reading
> anyway.
> 
> However, on a kernel built with CONFIG_PROC_KCORE=y the only ways to
> block it today are lockdown=confidentiality (which also disables many
> other things we perhaps don't want to disable, like kprobes and
> bpf_probe_read_kernel()), or an LSM. That's annoying, because on the
> majority of hosts we do want it on for things like drgn/crash, so today
> we build two separate kernels.
> 
> Let's add a "kcore=" boot parameter so that this can be disabled at
> boot, which lets us preserve those choices while using the same kernel
> image.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
> v2 at https://lore.kernel.org/r/a8474f0e2d0ef5ea9d53aa6649c7e9c9ea6f15c2.1794800574.git.chris@chrisdown.name
> 
> v3: Make kcore_enabled __ro_after_init (Kees)
> v2: Give more justification in changelog (Omar)
> 
>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>  fs/proc/kcore.c                                 | 12 ++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 176648941aec..205228294fc2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2902,6 +2902,12 @@ Kernel parameters
>  			parameter KASAN will print report only for the first
>  			invalid access.
>  
> +	kcore=		[KNL,EARLY]
> +			Enable or disable /proc/kcore on kernels built with
> +			CONFIG_PROC_KCORE=y.
> +			Format: <bool>
> +			Default: on

So I'm happy to take this on top of vfs-7.5.procfs but I'm really
unhappy about this proliferation of various hyper-specific opt-outs.

For example, we already have:

enum proc_mem_force {
        PROC_MEM_FORCE_ALWAYS,
        PROC_MEM_FORCE_PTRACE,
        PROC_MEM_FORCE_NEVER
};

static enum proc_mem_force proc_mem_force_override __ro_after_init =
        IS_ENABLED(CONFIG_PROC_MEM_NO_FORCE) ? PROC_MEM_FORCE_NEVER :
        IS_ENABLED(CONFIG_PROC_MEM_FORCE_PTRACE) ? PROC_MEM_FORCE_PTRACE :
        PROC_MEM_FORCE_ALWAYS;

to block FOLL_FORCE access on kernels which is another huge proc-based
attack surface. My thesis is that if one is worried about /proc/kcore
readout attacks they should be equally worried about these types of
attacks.

Iow, it would be nicer if someone took the time and came up with some
boot setting that is a list of memory protection settings instead of
spraying ever more kernel command line switches that nobody can
reasonably remember or use.

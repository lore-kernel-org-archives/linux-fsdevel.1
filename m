Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019425;
	b=QQ8BAnJ5wG+rqVRAWRzkKvdisszHauNkP6Fljr4cw4SG7Ol2Y8+N1wi7Qp2ZjI/h2Mv7
	 uyVzy4SM3IRBs3bGAeRT1ezxjZnO/R4m2agKswEisrGUPon7llFCkjtrjLU1sm78WgNx5
	 7bHsUGLVcwhELD7idZICRiCcfp6CEApeTtwUYyFFPW9hXFdW4EuOYVFhF+pcLdOOmp4y2
	 OadQnFpZk8OVX5KeNtlvYQJsSzcm4fJREBi8UqdClK2UfpTi9gpEu41HVte00wR2eo2kk
	 DsavCMpyLAlDu6ibNT4K7kFmjVfjJ8zRcl8K3iqWbRppXaee7YNtmprf4KYwB7pHCLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019425;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=L30cNThaCOfH1h/tg7mX5YLfxnIR3Ercf6Vj06Bp04E=;
	b=wOa3aNaGtqi9xD1uYfbJ2LMSWu9vzrE/bHvIBT4itmPw57wLlMBzv/SbtZz0rnR7C5qQ
	 L2+HBpR9j2HtQtaasLCkGV5nJUnMr0XFOVA4rUP8sGhhMTqtgBYKUoWeHsLjOUJdyC6oM
	 Dsh1FsFLVMbaaoq6LmRsPlfg6v3/RtBTWD4Sjoa5KfzZpk+f6QI2xLmBm4+bmKG2AB9ZW
	 A0N5hLoAEGHVKXUOqU9FDrvG5Db2QLR2JdL/mz/KmxOis3X5aq5Z6gCVt+UUINx9qF6La
	 MkoKYf29v/pAWgUy4WGqA7DsY1oQsqpRPwZvrMPgEzWIDrD8H5vxZVgB8A4Da0aEXwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtK7hvX6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027260A262F;
	Wed, 18 Nov 2026 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtK7hvX6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70251F01575;
	Wed, 18 Nov 2026 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019425;
	bh=L30cNThaCOfH1h/tg7mX5YLfxnIR3Ercf6Vj06Bp04E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EtK7hvX6Nq9ijdDvqy8+5uCAwPbPD8SHkgNx9MQnGIZL4At59ecHiqlBxunAq/wuj
	 QMThfzie8f4ekpL07Kiy50dg6QzPi5U993y4Ts9nGLwOoqyZSIZ2T3Alxs4MDk6iEg
	 WB9AGtcCr8+FfYAb/aKuXoYmOjYfNdXvPCDP+U+momDYJqy50R5rOyJN364Ujt95u3
	 7j29ndzZ7fuTS3WuH1ixuu88nXGuTTeiKga/zhzljz+vuThIvR9tj1IRqoqMUj8dA0
	 WoNoCeEMc4UbJLseHAhJYJ/MZWtT6tbBdyPXF3atbfdo3J18l7pbXOKvf0hZR3VQa2
	 Q4/sA/ZOzcHRQ==
Date: Wed, 18 Nov 2026 17:30:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, neil@brown.name, 
	cyphar@cyphar.com, jlayton@kernel.org, amir73il@gmail.com, shakeel.butt@linux.dev, 
	gregkh@linuxfoundation.org, tj@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <20261118-moment-gehhilfe-gefangen-ce4618af6b54@brauner>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
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
In-Reply-To: <20261024213539.1307600-1-jkoolstra@xs4all.nl>

On Sat, Oct 24, 2026 at 11:35:27PM +0200, Jori Koolstra wrote:
> This series implements new semantics for the O_CREAT|O_DIRECTORY flag
> combination for open*(2): perform a mkdir and open the resulting
> directory; return a pinning fd (which mkdir does not).

I've applied this to vfs-7.5.directory and folded a bunch of fixes into
it. Each fixup is attached as a git note to the commit I folded it into
so you can see what I massaged:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git \
    +vfs-7.5.directory:refs/remotes/vfs/vfs-7.5.directory \
    +refs/notes/vfs-7.5.directory:refs/notes/vfs-7.5.directory
git log --notes=vfs-7.5.directory v7.4-rc1..vfs/vfs-7.5.directory

The biggest change is kernfs. kernfs_iop_mkdir() now just looks up the
new node by name so the kernfs_syscall_ops change is gone and cgroup and
resctrl aren't touched at all anymore.

The kernfs patches are in vfs-7.5.kernfs as "kernfs: instantiate the
dentry in kernfs_iop_mkdir()". I'll sent that out soon.

I split out of 09/12, your kernfs_iattr_rwsem fix and the kernfs part of
11/12. vfs-7.5.directory is based on the first one.

I dropped "vfs: move ->create check in lookup_open() to before
try_break_deleg()". vfs_create_no_perm() does that check itself now.

Let me know if I messed something up.

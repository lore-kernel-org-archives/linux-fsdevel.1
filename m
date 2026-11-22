Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795382435;
	b=VG0+p+LyEJ+XyIPLFMvyElJAjEh/tRCE+Ne6D4tHx0SbvyYmfBY3rjkMfg6XU+l1XTK0
	 BbbydignarG1oM7OsfzzW2wCucGKrRWFtGXWwMm4D/ZqbtlYwARu+grn1nQJjl0yIWIQQ
	 YAK0MYIB1W+axxVpoYugtKzkSs9WrKuR1dKFUJ9/HSb8l43xA45Ybz3YNuMGm2AxWd8Fn
	 wKWMFgqzm0Jyz+wN0dHcJfe6Pa8lcuVZRpKwto8nG3WvGuk6DLF6MbyoSGA0cMuGF3NeK
	 XNyRLLTbp6yY/z3epsgcRGxfIf1JKTwZpzq81vl8PPtXjheYFtVhObVEShmwRp08aEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795382435;
	h=DMARC-Filter:X-KPN-MessageId:Received:Received:DKIM-Signature:
	 X-KPN-MID:X-CMASSUN:X-KPN-VerifiedSender:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Priority:Importance:X-Originating-IP;
	bh=SwQLJYeiZ7SR0jWPyxEYMPvW5myscvBbwRXUKhphf3k=;
	b=xJR5b3KCay6+WAS17XuilYmLjJgw4gQ8KP6m4wc69V1Hvgmr5W9Vd8TBd0cESypH4SBh
	 UNgElkbEhR7GDFSQlpNPMTWI2pig4ga4C5T4a+7lTUyxI1IO2gtFQctAJa+deaeTfRgSU
	 hyGeBt1UdL8NURJ7KiMBPqWFmm2CAVUVVxU9vyseNNeHhZZmtrRUeK0RXKYojbbio4/lt
	 EXxbqeBQ52w2R9Pvpn1dnE7mV18A1IL4qMVw0vS5H5hA4CpEJ3J97cMY08KqO7DCekpi3
	 iMXkoi3AeKX9Tfmw/uolGKdnThzB2B1CPGwa0DSP7KkQE/Y+DW4HvsvSTmT9cHkXvcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=lRBUWF29;
	arc=none smtp.remote-ip=195.121.94.185
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F10606A327
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 21:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12F10606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=lRBUWF29
X-KPN-MessageId: 8748e461-e6ba-11f1-964c-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8748e461-e6ba-11f1-964c-005056999439;
	Sun, 22 Nov 2026 22:20:23 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 8747bf08-e6ba-11f1-b88c-00505699891e;
	Sun, 22 Nov 2026 22:20:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=SwQLJYeiZ7SR0jWPyxEYMPvW5myscvBbwRXUKhphf3k=;
	b=lRBUWF29svTDCffap4ikI5QpkCGKFSrkDPeON0qdfjDabq+W9m7zfxV0dCUfXDzOngDil5a2sipDY
	 sI+/INW0XQTuIiph6dQn5h2NyL2mKhRwe/7J7ReB41tLSp3sZy8GrnfoVdicqIHHz4PaFu85NLDLwD
	 3Yfxk3oIrNibzmrWo0h7cFqZtnuKgdScDSe4AeLocyMbU53cqcvmxo0VoZ4tKusa0eDfFBh3uSCyLP
	 XjJcwmegpaVeQ2vhICWdjA5iJW0HXKtgPjLDEJuEUy7CM2VE26nBOBCnxm6CVsN1mAGCoplP4gjsXP
	 T/eqq22IzHRIO0XSgE43aXHhKJSiJwA==
X-KPN-MID: 33|Yh303iPwTCxJDbv+bWZQXK7DXknN+AYlqGs6xrKjPdXrgt1zyvgGXFI+0iyrH+J
 UJXF160+5hZryfVbZZ8fkIg==
X-CMASSUN: 33|RWNpzXoeI9x3UfQFsLzwHt/yGVJJKGRS5YyfKb4GKwpb7YK/itCDfAHao/a0s5Y
 olYqowhsh6zl6AJtsAb6r3w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 873c8071-e6ba-11f1-acfd-00505699eff2;
	Sun, 22 Nov 2026 22:20:23 +0100 (CET)
Date: Sun, 22 Nov 2026 22:20:23 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, neil@brown.name,
	cyphar@cyphar.com, jlayton@kernel.org, amir73il@gmail.com,
	shakeel.butt@linux.dev, gregkh@linuxfoundation.org, tj@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <637456056.2253868.1795382423235@kpc.webmail.kpnmail.nl>
In-Reply-To: <20261118-moment-gehhilfe-gefangen-ce4618af6b54@brauner>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
 <20261118-moment-gehhilfe-gefangen-ce4618af6b54@brauner>
Subject: Re: [PATCH v8 00/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

Hi Christian,

> Op 18-11-2026 11:30 EST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> On Sat, Oct 24, 2026 at 11:35:27PM +0200, Jori Koolstra wrote:
> > This series implements new semantics for the O_CREAT|O_DIRECTORY flag
> > combination for open*(2): perform a mkdir and open the resulting
> > directory; return a pinning fd (which mkdir does not).
> 
> I've applied this to vfs-7.5.directory and folded a bunch of fixes into
> it. Each fixup is attached as a git note to the commit I folded it into
> so you can see what I massaged:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git \
>     +vfs-7.5.directory:refs/remotes/vfs/vfs-7.5.directory \
>     +refs/notes/vfs-7.5.directory:refs/notes/vfs-7.5.directory
> git log --notes=vfs-7.5.directory v7.4-rc1..vfs/vfs-7.5.directory
> 
> The biggest change is kernfs. kernfs_iop_mkdir() now just looks up the
> new node by name so the kernfs_syscall_ops change is gone and cgroup and
> resctrl aren't touched at all anymore.
> 
> The kernfs patches are in vfs-7.5.kernfs as "kernfs: instantiate the
> dentry in kernfs_iop_mkdir()". I'll sent that out soon.
> 
> I split out of 09/12, your kernfs_iattr_rwsem fix and the kernfs part of
> 11/12. vfs-7.5.directory is based on the first one.
> 
> I dropped "vfs: move ->create check in lookup_open() to before
> try_break_deleg()". vfs_create_no_perm() does that check itself now.
> 
> Let me know if I messed something up.

Thanks for pushing this along and taking a look.

I am a bit confused with the order of some of the fixups, but it does
not really matter since at the end it works out. But e.g. you first remove
the dir->i_op->create check from vfs_create(), then add it again in another
fixup, and then change the error code.

Overall, I agree with the changes. It does make more sense to do the
SB_I_NO_ATOMIC_MKDIR check in open_last_lookups() and that simplifies the
logic. Also, I like how you've split "kernfs: instantiate the dentry in
kernfs_iop_mkdir()" out. That is much better and allows Shakeel to continue
his stuff easier. I should have done so and not be lazy.

However, I am not sure that relying on holding the parent's i_rwsem is
sufficient for the atomicity that we are trying to provide. Afaict nothing
in the kernfs layer prevents you from removing a grandparent and a recursive
kernfs_remove() of an ancestor never touches the immediate parent's i_rwsem.

Also, returning -ESTALE, if you set LOOKUP_REVAL, can make open(O_CREAT|O_DIRECTORY)
return -ENOENT. Not sure if that is what you want.

I also see that "kernfs: hold kernfs_iattr_rwsem when initializing a new inode"
went to the kernfs tree, so that is fine too.

Best,
Jori.

PS. See you at FOSDEM...?

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020174;
	b=NjXYzIgzMPdSc/jw6FFjYwBZ6nrIPnSRD90QfSjyJuCkx23nBIof2qoffHMXZ7ZX4UFq
	 9FG92RQoArcToQGONf56Xdo1JYdWh/tXZTzp0XQv/xsJwCM2RS6HbUSphf0DKkijxoE5b
	 jbliZFJwzq/LiTYGRO1T5e56l3DdYs8u+phrCaEWbNaJAEGMxF87vKH8rAhDHy07UQxJn
	 PM3de8gYuJW6dMXmEvxm4p7O4Qd+tvf4AjjxNXr3U2jDG8wPYksvFjs7RVBQwzYsncixc
	 gR50kvBMRnyqSQKSRJ3ddlNdSbTgbjOXJUzMKtP2aIgOGVG8gQecy6hFY2moAB7B5SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020174;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7E/QsT9QWiIWigkzY3GnhIN6sWFx6TjW+7rGa5ugqL8=;
	b=y0cXzQ4LLh+3dcAI0aA8wxoaLEVIi4Zi1y/qevFob7JAAVv9eteemjy8Wck7WJMsgtMX
	 ie2mseEAS4TT8qxY710HOf65Ow6S5MLNtJI9T5lM4I/vATUDPbu6gb9Mbytbw3hSTUXnQ
	 Vlw8q63Q+LqU1t+RKqX64PAHQtY68XSaB+4XHQ1LDEHdyDh6RGjLHq+BIbvWOimKyWyIP
	 rgXNMW+i5kwQ2b1O7mlo79CIx1lOgt9qPWQsB1sxv97JkKDcbVXygJqTB0aWEXyOMclZH
	 Z7gzFEbhQkoQ8n9w7E8N9plmYOhEd0x9TrBmp/3YD2UGR33+y1AiUTS/hiis1ZKbcxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="sA6AMe/s";
	arc=none smtp.remote-ip=95.215.58.149
Received: from mta1.migadu.com (out-149.mta1.migadu.com [95.215.58.149])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FC606A32C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC7FC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sA6AMe/s
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WhH+lGJmylbRzpwv6d+3XXqSEIVk+9KTPphJKUKXHw8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795020171; v=1; x=1795624971;
 b=sA6AMe/st26ecsfr1T8gTlltQIIsEmoEsrj9RDv2bzjBiAmmrn/cpFMHZBhtrU4tHAW5cFVu
 B1lP7AIQlVccf2P//cf2hA4iPcboIZ2eXjrcV6T+V/UK3WtcneF+uNg5u80/jaA6uqSutwKh3RS
 xXMkOAC4lJnydxeJvlkSzpYk=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 018c4da21ca3f567;
	Wed, 18 Nov 2026 16:42:50 +0000
X-Mizu-Trace-ID: 018c4da21ca3f567
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 08:42:47 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, neil@brown.name, cyphar@cyphar.com, jlayton@kernel.org, 
	amir73il@gmail.com, gregkh@linuxfoundation.org, tj@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <av3U2jLO8Q01swyg@linux.dev>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
 <20261118-moment-gehhilfe-gefangen-ce4618af6b54@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-moment-gehhilfe-gefangen-ce4618af6b54@brauner>

On Wed, Nov 18, 2026 at 05:30:20PM +0100, Christian Brauner wrote:
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

Just a heads up from my side. I will be sending couple of kernfs series over the
next couple of weeks. First one will be removing kernfs_iattr_rwsem from
mkdir/rmdir paths and later ones will be trying to make open, lookup, stat and
readdir operations lockless for kernfs.

The kernfs_iattr_rwsem one, I will send out later today.

thanks,
Shakeel

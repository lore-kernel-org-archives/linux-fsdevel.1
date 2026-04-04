Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15C261388
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775260708; cv=none; b=bkJPsxJj78OfxQY1v5m7sVQwOwLnXIbZkf01X+9/dlBAy3m1T1c7lWcnVBcN3KzJMD/RIIlYD3Dk5W+NxvZPYh1maU3L8He6aAuHlq8MX4/dWl1z6gV5km7zCfFfsNv2lVJadb2YK5bkGXSCLDbkGkXh2v02IU66vWHLeqDejuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775260708; c=relaxed/simple;
	bh=9wZbpzrk9hRpaJOd6WbeQSAkkJI1y2yU4ZKP1vV31gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeeytBg8a2NI2ivfkZPDEIo6qzT+JjhWALhDFvVLUFesryXD984zW5lrx+jPA+uE/fhCSdgdCOOW8OsgUqw0Uf8NI4rV6Xt/J7ldM0Sa4+M/6olX/SmcRwGmNN6fug240aBb/fxtTG2AvMpMseVJLaPUnuuH4xs5ELXyfIWM/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QQ93Puoi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QQ93Puoi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/Mz65QNV1lPgDDvgyQRQT4TRpbTlTLmldtn+wgh6Ee0=; b=QQ93PuoiTUq1sS7DIW7vkJ3t5s
	CHYauAUQOLSy0CPnwvlEYbb/1xGm6dbAwEBYpNuoBH64n+o02ikLiurazwAAFUL8U6WF7/m0MQQD9
	nzKCZIDbwMsxIz7eueHKHYwWwMYc1H7OP0Qko9lqV4qcd3ksriSy1JZGx/wAwtycqid/9ddOSDi6U
	VNxolkNXNWcH6HxejeFxhmhsI0YTU8Vf6KqwIDVFPKHATEU7x7fqPElRHhEi544F6jVtVzGvnBM/v
	+MQ7dSfu4yOU1nKDR7MOYQERWkpJsGx52hxXh8BVpH3oODRNMPClfHZxIEGRmxjcNj/Q1Ay4dMkRx
	r5rKI28w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8oSf-00000009xZm-03OP;
	Sat, 04 Apr 2026 00:02:01 +0000
Date: Sat, 4 Apr 2026 01:02:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH v2 4/4] get rid of busy-waiting in
 shrink_dcache_tree()
Message-ID: <20260404000200.GO3836593@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
 <20260402180850.3729310-5-viro@zeniv.linux.org.uk>
 <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
 <20260402224439.GI3836593@ZenIV>
 <CAHk-=wg7O-p8L7384myYTus6NH5aYdoS=y=+iALL_8DLT3=ZLw@mail.gmail.com>
 <20260402231643.GJ3836593@ZenIV>
 <CAHk-=wg5HkyPCFsfXS6u2xe5h=dV5WT9zaeqt-fRQyE+OxKGYA@mail.gmail.com>
 <20260403021522.GK3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403021522.GK3836593@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 03, 2026 at 03:15:22AM +0100, Al Viro wrote:
> On Thu, Apr 02, 2026 at 05:29:28PM -0700, Linus Torvalds wrote:
> > On Thu, 2 Apr 2026 at 16:13, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > The incremental I've got right now is
> > 
> > LGTM.
> 
> Force-pushed...

FWIW, I wonder if we would be better off with something like

struct completion_list {
	struct completion completion;
	struct completion_list *next;
};

embedded into select_data, with dentry->waiters being a pointer
to that.  It's just that dragging struct select_data into that,
even as an opaque pointer, tastes wrong ;-/

Preferences?

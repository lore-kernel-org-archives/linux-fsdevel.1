Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793457717;
	b=fnOzFY3pqGacXbSEpguNwPGImeJtfp2lc69VkwVPV38QCxZRyRtZ+3bW0KElvbI95G0L
	 lmO0veQ9ojdzJB2Fn++bFJKtQNGgQKs5wMaJHmZLxfIfKV5pgP9sjPieYFjwBOrNmX9LF
	 tSelYTvt/dQxTeOjMdrJXDigj9HhIumNfPTZXBjvSF3nAP5qikdUB005g+7ECURzyY3Fd
	 pAV14LXi2iAgeV5F/uho1ARxfma49UN17KRzkIckX0XU4ZoqL8IdKj/xydjRbg0eNro9s
	 +ET4hQTZ+IH8cFE0UdAPfmChCJHaiAL8lrDt0goC3UQ1ETXm01sb2nm5ZmukzpWSDVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793457717;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fPN8XTudxogCQhtCGNLFaz4PyF9Au0mbiHlVi5qqi5s=;
	b=HASRXoc9p+ZAcKi8eVzqa4a/ijiDb2JmqeTGZfdDp6d0AG0TIgenevXBsuCanJnZYtx8
	 OpU6IC0iksVNQ76k02J2XpzXLdJymmrbzhZzrMXsj4EaN8afql+gNRZXXRjC5zyzH4RWf
	 fKKGOUSIGJlqATaWp6Vf9PZ9zaIwlCOFOViN9slhQDBDYDy+JGASSAeApx54q1MFqbAU2
	 4gUu4wTZX6LRpbuArq+fxCGWrsShf0QUhsvDy7AE2kvBpKuuOXx00L3k9Ipphl77WI2f7
	 5QnZ8OtVKqKgdF29T8bzZYj0d7YGaQVnUuUNavvCO1XbGIKzLpa3jwub00jMDfWpTrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gtvvXb/Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B8606A31F
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtvvXb/Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E631F00A02;
	Sat, 31 Oct 2026 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793457716;
	bh=fPN8XTudxogCQhtCGNLFaz4PyF9Au0mbiHlVi5qqi5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gtvvXb/QANG8Mu7nUMUCj3QxOyVLO/1I95OYNO7AMUtDZeW3YRZ222/5OkYuulgpZ
	 XDsetGVz9pk9gyhgCsIe+Hc8z6KzXxEmuMaTfxh+1ZVFqbjOYZN2FBrRZYMUM+0R1b
	 +7Zh4US6Uh+Eci/mG6qrDdOm+JGLr1r0Ulz5dIScN9bgDJOYwq3w+cOjuecenMiRo7
	 Riypa7kmzg9EYc3nxjvuXGhK/PfU0+FiZDmdXl9wpPxzyUMRms9GA+P4EqlJFzEldx
	 1ByiZcbqpoYHXS3SJlKVg2gHtQwysUO19CeXKIYj79eFQSyolxsBAZG67ft09fx8Wn
	 QBHOGqsZyq5/g==
Date: Sat, 31 Oct 2026 15:41:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Yongjian Sun <sunyongjian1@huawei.com>, 
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: Re: [PATCH] libfs: walk offset directories in offset order
Message-ID: <20261031-trennen-fenchel-hinspiel-8d5a5688f134@brauner>
References: <20261030-work-libfs-offset_readdir-v1-1-ed733c14229e@kernel.org>
 <05e33426-c60f-441f-a76c-46dcba1c1c35@slotpi15m67>
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
In-Reply-To: <05e33426-c60f-441f-a76c-46dcba1c1c35@slotpi15m67>

On Fri, Oct 30, 2026 at 12:22:19PM -0400, Chuck Lever wrote:
> 1. Each emitted entry now costs a fresh MA_STATE and a full tree
>    descent in offset_dir_lookup(), where the list walk was one
>    pointer chase. Can you time an ls on a tmpfs directory with a
>    million entries, before and after? If it is noticeable, carrying
>    the mas across the loop is the obvious fix, though dput() and
>    dir_emit() interleaving makes that especially fiddly.

Obviously it's noticable:

                         base      v1        
  getdents64 (32k buf)   146 ms    226-235 ms
  ls -f                  0.26 s    0.34 s    
  ls                     0.49 s    0.57 s    

The fix would be to carry the mas state. If you combine this with some
moderate batching than this would recover nearly everything but I hate
it.

We don't need the refs at all though afaict. Every entry in the tree is
a d_make_persistent() dentry. Only unlink, rmdir and rename kill it and
they all hold the parent's iwrsem and offset_readdir() grabs the read
side.

So we can keep one ma_state across the loop and take rcu around
mas_find_rev() and emit straight from the dentry. That kills all of the
really performance heavy stuff, fixes the bug, and should be faster.

> 2. That's true today, but Jon Flynn's RFC from yesterday proposes
>    create and unlink with the parent locked shared. The code is
>    fine either way: it runs under rcu_read_lock() and takes d_lock
>    before dget_dlock(), so the walk does not depend on i_rwsem.
>    Should the patch description say that the RCU path is what
>    makes the walk safe, and i_rwsem is belt-and-suspenders?

I don't think so? The offset tree is set up with
mt_init_flags(&octx->mt, MT_FLAGS_ALLOC_RANGE) and not MT_FLAGS_USE_RCU?

So outside of RCU mode the maple tree modifies live nodes in place.
A lockless reader racing a writer can see a torn node. rcu only keeps
the dentries alive.

i_rwsem has always been what makes the walk safe.

I really don't think we should care about an RFC when fixing an existing
bug. Specifically when it's rather hacky. Even if we adopated an early
hack like that shmem would have to change for this to work as it keeps
taking the parent exclusive for create, unlink and rename.

So if tmpfs wanted that thing it would need MT_FLAGS_USE_RCU and then
readdir needs refs again and then you get the perf regression back.

So pick your poison. Future changes aren't necessarly a convincing
argument though.

> 3. Please run generic/736 on tmpfs directly and on a tmpfs export
>    over NFS, and Nickolai's reproducer from the Link: above. I used
>    a seek-after-closedir case as a regression test for the NFS
>    resume case too, but my memory is hazy as to whether it actually
>    could demonstrate proper function vs. a bug.

All checks out and I wrote new tests as well. 

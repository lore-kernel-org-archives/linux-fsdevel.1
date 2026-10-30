Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377361;
	b=rp3+WCk50BQUADWFDLalzBkBt+/MNpK+t+nUduAQ+lvYZ5cU/jcbLakLuEE3fhMaqPJf
	 agq9h+iPty7l54h9ldcQs4fXgndFeXt3th+uqI67FDZr2S569ppvsrvTI6LWHH+J2VDXH
	 mb14zQPAwDvDb9f1JqlNKhQ2N1IFjMUtKxSE5S32q/hRt3Gx9sqO3pLPwMbR4GTq33h30
	 MhXKRc+GxnqOcRAI5HCrVky2RY7ihSR0Y5kjygF28cgw2RU+0asqmDJE3kRPGiu/oLMca
	 vfDAR/36hQFEs0Q1QsBM/d+jQzJVTvnQghLq89qu+JfthQuBzwVs4urkgHqMxcsjt5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377361;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=QKMaDsEFhOS7tilJIio3ZVUIGWzfgShnfiTrcvi4+WA=;
	b=KpNwchbpHUuZ2ap6rUxnq+v7SXpvlEApWPoIkC9dqgmn4vU/bGIIAXEJy1G9Vd+n4h/Y
	 092taeRQrJqboHtWulPcWJjfbAdu21VtnIypruM/o34wcn9cQa//Y1aMs5R27Uw0vwHx5
	 RQa7226R4hCvhk8M6wPS8+i/U2lWzOSG08PMyrMM6503e5TKjwXju1rnf46JWsBEJUiho
	 SKXwILSxMOj6Ogzq152HpW7Qepvv7U6xFL9Lr+0Qc/9IEeMMb4rpyq6OP4ZqGIUhWHkV6
	 rSSDWDh0vwO5F10ABRsIagaAm/WNymeUw4kmIOuGpER+RtoR5EWzfQ/BVpwdGGVjdIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4pNyUWM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A0606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4pNyUWM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2731F00A02;
	Fri, 30 Oct 2026 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793377360;
	bh=QKMaDsEFhOS7tilJIio3ZVUIGWzfgShnfiTrcvi4+WA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=i4pNyUWM9PiN//4fc2rDtEJ0ffyoYZBAgqu1fMXK/adgU0CU/AjwMB8wX2FHqPswV
	 KyMnxHQSFx2MBqnNdN6o77z5oXyXbOOggbXAXHfGa91M1ZH6KBSDhNa4lHbvJSoPSq
	 3y2fpiduQQDvkqTGPYNU56U1+KQKPJYO+x172cJbGAo8sgmlUuRMjVhf7WXAiWyKwz
	 urNWf+8VnbIM8B40a6Ih61Iat3SwrXPmVuIlb94gOVWzwirkXEJXSQpbaqW4uq3U20
	 ZwsZAPbWE+zse3CcawXtquAnoC3QYIsvl1R9zJTMo3/YTV+j1xcyWZKDn/8LXQJ14+
	 CXzijoJUiOCTA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 98B23F40066;
	Fri, 30 Oct 2026 12:22:39 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 30 Oct 2026 12:22:39 -0400
X-ME-Sender: <xms:T8TkavCrsOgNWE1mhuqSxWQE5mfarKVcwD_oEka4rEGlg8yMrHcwuA>
    <xme:T8TkagWpgUpzvmbwmc3HvCbwkByta-OF-bMOmGJviGSZx3Quw97rMrz3SJG7s2vSz
    nmkXYxRJyeE1sRjy_31l1wFk01GzA1p9Aegz9OKEQd9lzSZDGCh20Lb>
X-ME-Proxy-Cause: dmFkZTESF8K5qB1pQNBQ+k1v819NdRniBD+KypBawsd/gx5YIy7QrenRHLaIkzfm4sHlvd
    kXGLwesrNVyrAHbrBOh1d8rxFwev/f9bcswTXx7kAocwnFIxbU0EJdDSclqJZn2C03KfNp
    6kuLBHxlE6PnbXgnzha6YCUBfNGdjGyc5oHbsPwb/5wB4n3+Y7AkD0gUVpeZAEaaAjndQ4
    OT7b0Yl8T3zU2LTuWxo2KHMhLfQiGkuBxmm4JrdONHsW8ZVdXNpF4qL1TxgM1qEy0/JsyR
    5ChVVQY91ZO10DnGo5M79hHIi5QDjFr3AjBAbdnfniTN882dy50VAD1WuFQYNE5PjOo2Wa
    J+Bqe0kQTDk8ymgdDkPa0zVEArXLBQTGrzIXLFDv7i9HFD7Eroyn6RFCGG60eUNUZ/YPxn
    tSaylwpuo9I9INpG1WYb58oAnWgn5l2v9Lzuxb3uzxY2KX8KSo9jzwdzlFJFN+5wGc8k5C
    mpoIeCzSXwCxc/kwERqc4B7tW+GJ2XDv0xtYbs4WNDHfoyb1k3svA2ZeEb73dcGK8B9Hot
    rinY/p1od87NiZJU9xFTrjoD+OScEvti5tsSP8oeF62KT45j6A5xt39VUa5ViD0DPzFI+S
    RtxrL3w3coPzojwgCkafSariGtDVRxE3bMSPYaQq8FhR8mLtf5ONK/uYKTXA
X-ME-Proxy: <xmx:T8Tkav68fgnCNCkbn2gAfHK1rMcdL7oRaMLMMTGXrh9cAtdC9kANOw>
    <xmx:T8TkalkamvWO2wUcd8-NlEil1-cWAftpsNQxsQ41j9jGy7blFrEmaw>
    <xmx:T8TkakoCCsZPG45NKTOf0GyXHRvs3V487z_IWVdr8tGm9uRtt-3bYQ>
    <xmx:T8TkakvV1uptyFmCGnIlI7k-8s5YJ4fRGPW5jYAp7-RPIDR-zYlgnw>
    <xmx:T8TkapGOGCC3ttqHmOUGE1Sz2iQBRM2rqllaN3m8u7r3cR1xV6s96Qi->
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6D85178273B; Fri, 30 Oct 2026 12:22:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AIXQd_9qcN8-
Date: Fri, 30 Oct 2026 12:22:19 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Kara" <jack@suse.cz>, "Yongjian Sun" <sunyongjian1@huawei.com>,
 "Nickolai Zeldovich" <nickolai@csail.mit.edu>
Message-Id: <05e33426-c60f-441f-a76c-46dcba1c1c35@slotpi15m67>
In-Reply-To: 
 <20261030-work-libfs-offset_readdir-v1-1-ed733c14229e@kernel.org>
References: <20261030-work-libfs-offset_readdir-v1-1-ed733c14229e@kernel.org>
Subject: Re: [PATCH] libfs: walk offset directories in offset order
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On 10/30/26 11:58 AM, Christian Brauner wrote:
> Instead of the list let's walk the maple tree itself in descending
> offset order. Then ctx->pos really means that everything above it has
> been emitted and resuming at the highest offset at or below it is right
> no matter where the dentry sits in d_children. Entries created or
> renamed to a new name after the listing started get an offset above
> ctx->pos and aren't returned, same as with the list walk which never
> went back to the head. So a readdir loop that renames or creates an
> entry for each one it reads still terminates.

The descending walk is what the 2023 offset-ordered iteration was
missing. That one walked ascending, so every new entry landed ahead
of the cursor, which is how generic/736 broke it. Walking down from
DIR_OFFSET_MAX with cyclic allocation puts new entries behind the
cursor until the offset space wraps. And because the allocator is
unchanged, a cookie an NFS client presents after an unbounded delay
still resolves to a nearby survivor rather than to a recycled entry.
So, OK.

Rename-over comes out better than the list walk too: the surviving
name keeps the victim's offset and now also keeps the victim's
position in the listing, where __d_move() drags it to the head of
d_children today.

Before I want to add an Ack or Reviewed-by:

1. Each emitted entry now costs a fresh MA_STATE and a full tree
   descent in offset_dir_lookup(), where the list walk was one
   pointer chase. Can you time an ls on a tmpfs directory with a
   million entries, before and after? If it is noticeable, carrying
   the mas across the loop is the obvious fix, though dput() and
   dir_emit() interleaving makes that especially fiddly.


> The maple tree can't change under us as all modifications happen with
> the directory's i_rwsem held exclusive and offset_readdir() holds it
> shared.

2. That's true today, but Jon Flynn's RFC from yesterday proposes
   create and unlink with the parent locked shared. The code is
   fine either way: it runs under rcu_read_lock() and takes d_lock
   before dget_dlock(), so the walk does not depend on i_rwsem.
   Should the patch description say that the RCU path is what
   makes the walk safe, and i_rwsem is belt-and-suspenders?

3. Please run generic/736 on tmpfs directly and on a tmpfs export
   over NFS, and Nickolai's reproducer from the Link: above. I used
   a seek-after-closedir case as a regression test for the NFS
   resume case too, but my memory is hazy as to whether it actually
   could demonstrate proper function vs. a bug.


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

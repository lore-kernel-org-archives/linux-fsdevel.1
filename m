Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C493AA195
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990944; cv=none; b=bCuTG1k30EDUHQomD7RiORZYH+eic/p3cqPYheCu+Jwtakbk9kpXGeJMibZT1nm3vmnYjMWpjdLbuROwaj0Hxb5hWV9C34UICK3BrFCmi1RqDwZ2lDc9UCjXiX0moOLLvvXlmljd/ODN914/HB9KZbxXG1Mh1VjQYux9b7VrS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990944; c=relaxed/simple;
	bh=JBhaZUBXJi+T6jsaUtHleiansk316rG3v0I1czHjHjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+zfDVdfkifwnSFRnECU3fCLhxVHYppmUfiOBoAWmyrt3iOrw5LWCUfl4pFg96+mJwaAeIcZOMnqnsJ8uKpn4UWUy6oDxSYCGK0+XauscBd3PjDUPowJs6Wsh0i0eonxkhjoU9mZDdlg2FN2BF84YGidh8DBY6Q/z5qAmLwqCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=geFSDX4U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HkgsRhHa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="geFSDX4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkgsRhHa"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 15B39EC02C0;
	Thu,  2 Jul 2026 07:15:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 02 Jul 2026 07:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1782990942;
	 x=1783077342; bh=WsYl+qicsByhkFqFKOYSpTVK+mokgbxbv0Rd2DuRxZg=; b=
	geFSDX4UBGVuPQ5x5fpvQrnmr5mSA/wPrG41U99kvYaan7Cjn9oUvAaxVH7PaklW
	VKZjpJSc64YWk2i9TijHtz7sEl8axChFv2Y3XB70BWElQQ6bizoh4uNczvsr4XXG
	s/tJmNa2Q52VmDItW3bWjC484q/jkw1eaSx+rduBHSZt77TVzIr8JTYqSwtMFMu1
	QXQxBs/+fxccgdk1IJfZKxh/d7z6EVasPMyrv30czrCsKi0yIXZ25JkuNL+5iDte
	EUqesvyHkVgvdxOHJKIiXSmmujEUquZxhfDBGanoG8+S7IqLSOL0BdAKshSsrTXE
	+SAhQuZ7PvgpPTJYtAvIzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1782990942; x=1783077342; bh=W
	sYl+qicsByhkFqFKOYSpTVK+mokgbxbv0Rd2DuRxZg=; b=HkgsRhHakw56FA6Et
	598wqP4919WAWmI5V8mBD5TwvzBLYs/2b7NJ+b893RB8VBJTw9nY05SMDbjDbJRE
	atxTK4ksmaGE2nz2pjrOIuTep8icnY/Io35FkruIq+oGt6Re5GCJU08mIrLN9g9Y
	GgMW0DLCrF7VpQoAETZ/yJfTMga5jb4suwYocbkAk5fYxU8PiCLnz9nliZWQjIA+
	i9mTzPBcNmppxl8ZD0ytvVa5fFbtVQP1/s+mczylWzWx4ThclTIzFXmL9mQoHuyz
	bKiSNJL2IYD7tzs5x9GPRnpA2JxJcagYzwOlZ4PLP/R07yeg7rTTEeB7cGuL3dCE
	vvQQg==
X-ME-Sender: <xms:XUhGalulm1zSiCXMXxZSb_NLMmXwJ8jHAqAVPR3sCqWh9R-M-vSY6w>
    <xme:XUhGanaDtaJlzkq1QfbBzmZe8eNsWnMiDhWyRlu3WISvYPpCk29pcUcyKPFPvQA3n
    Zz0Q90mq82Fxau0iryGyKGAJs2TNXfjjiyJorQ84ZhA2itxHg>
X-ME-Received: <xmr:XUhGakVFZjasmGrFJtild3p_oonHBq8wPT6DE6S0tMu_3FaHDQOeD7tPcqUt6pzNtbPgtj1jjEFagMzerRJz3PdkLgfMPtw>
X-ME-Proxy-Cause: dmFkZTFYFXduZZeCbiYO2qP7P/IlfTT5YqzJQ01ckcz5pMDPBWwDDZF/7cGa5t22DbgHOl
    swOSaY5zdf1Z6CX341Ql0yO04kji5O/ZhFcMzqwBGmmjzVcnb6rNi+OyubnQQkFgFOwz1y
    YfS9om9qseIzLF23yd7GfK2AldsRuqPp9AjWf8XADVHZdyTF9AqJMIeWlXHOj4SDgwYJoX
    Rl1TWZo5BIv+zebqjKs4rKu0AKc4R4gsgbIBqk7KoopDFTPDXX+G9lTs0Owr3vkT/WyNED
    RwmQtsG92ty9KYFubvm05R4Wd81hx2EXc3mqhqFsHRSHxsKC3AUqhx1riG1r/ZayhkL2ku
    w39xzdkFqWxeV3t81pr3DWggjod1DkZm/agD3THn3By/RMkPTYeRjfxS7psR53eXx1CVAU
    9ATz87ioQ5wQREFGBjy0vTJXGsGhUWvruQwsyDZkIFrGgDmSGJ2bDGJJctovkG9ejRckUa
    UU4BaG/b5usmQmB7gtAg1h6YI95gD7C43jb0JH2EvX5eRtECGaJVNc5qDT3jnYlZZMwgD2
    xzg61CtT934dk2NSA18vUiHwBWZiv/GGdD5aiDNhEfmxLS3upkmt5jI56dPU46oYkfB70n
    cb++0VKKaW+4yO1Zv/FS5Bf4nLUx6ThAjRUmQAA5pAH4Rj4GZlaKoiu2g2Jg
X-ME-Proxy: <xmx:XUhGasS91LTpejNzdOqruwiyiMi4hosjyfuwFqfyU0pKmDCG351WBQ>
    <xmx:XUhGaiM_hlJ9OE0jp5hONL4KslXkMvTElB4c7oGe7uX8U4OZfQJ1yA>
    <xmx:XUhGaqTDEzItiLMq4unXlya1tNuarEIw6m7Pdo1WoRHmCLDbWLNfsw>
    <xmx:XUhGagh01Q1-G2MnJ3UNg_uSg-JhWjwxPsS11_rlT1bcfoGIxeH9JA>
    <xmx:XkhGahb5GehaQn104WbJaGC4TH-WDmFWeUDCRWVoQDEuw51FUQ5jBLzF>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 07:15:39 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: 
Date: Thu,  2 Jul 2026 21:09:18 +1000
Message-ID: <20260702111529.3559835-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <[PATCH 0/3] VFS: replace dentry_create>
References: <[PATCH 0/3] VFS: replace dentry_create>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a resubmittion of the VFS parts of my series for replacing
dentry_create(), used by nfsd, with a new vfs_lookup_open().  I've sent
the nfsd parts which doesn't depend on these VFS change to the nfsd
maintainer/list.  After both sets a reviewed and land in respective tree
we can land the final patches to use vfs_lookup_open().

These change conflict with Jori's O_CREATE|O_DIRECTORY patches.
I've done an initial port of those patches onto these with the result 
at github.com/neilbrown/linux.git in branch lookup-open.
They compile, but that is all.

Relevant parts of the original cover letter:

My recent proposal for inverting the order between inode_lock() on a
parent dir and d_alloc_parallel() missed that fact that atomic_open()
has two callers, and would have resulted in easy deadlocks from nfsd
when re-exporting and NFS filesystem.

I think the best way to fix this is to provide a richer interface for
nfsd to use, which includes all the locking as well as inode_operations
calls.  This allows the nfsd behaviour to share more code with the
system-call behaviour.

This series refactors code between lookup_open() and
open_last_lookups(), and uses the new lookup_open() to provide
vfs_lookup_open().

 [PATCH 1/3] VFS: move mnt_want_write() and locking into lookup_open()
 [PATCH 2/3] VFS: move delegated_inode retry loop into lookup_open()
 [PATCH 3/3] VFS: add vfs_lookup_open()

Thanks,
NeilBrown

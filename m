Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23838E8BF
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908761; cv=none; b=cYxXcl549GJ0kmi1oarOWJ3AEMbPqF7r+QdqKyMY0dAaioiXsQKRXxQkOkOvTLQV0uFJuJuz+8RFZLGzIqTiIwEP+Tj1wFyPt0Kp+nRfTiRLiT3s2lmPtjWYzyaQc0+3ufvi8CLDd4ptYvUK2pgjkw4lCe4ebiVDu+6lJxcneW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908761; c=relaxed/simple;
	bh=PCvcqBqvSHuYFMj8WR6nfjAEVmF/XI3FJDCFUA8gQFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eFy30qwDWrN78vQTOKV9zNW8XMTIDY2fkVuFjjpVYYia1+cROhlf6h4ufTrAxToQ/VmXdB15o6ujFHsYYpX1VK5ki67+OmFsrJwXjt4x1V6ciRTOYXntUj3/XEzS1U2RsU9kIj8cLVHYGzfVofLLDYknybqZLBeJGZ9CsPQBt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=082P7Ctf; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="082P7Ctf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1670E4E40923;
	Sun, 20 Sep 2026 12:52:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBA98604C9;
	Sun, 20 Sep 2026 12:52:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB56C1032829C;
	Sun, 20 Sep 2026 14:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789908747; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YmmPnaV7ildHZ+EWQKJf+Qc5RfsJpEmB2QsMAPSOZMU=;
	b=082P7CtfODUaGcGtCNed03VvETTk/7aXKnLyVv9PCXv63fs+z0Dm3h5shizWdVsVTEikKJ
	pYeAJeMxtaL/3ceYbu3Y3WK0+MvXOErLkZZxN9k6ehyX13KX92Da6Xxq4YHKjmLAquj1ro
	MtY8O8+zms1KUDTy3hs5D1IsDDLk3D44tXsKgBmw4at5Q+yOxP5Ah+BwqUSvcJ4qVDyebM
	aziDtJQGKNwDijleoqHMvcXcnmtzYBqxT0MSQ8Ho5NLvT2w+O3T30SJpY6wdIeVyqVZmxm
	3qkJtnyHlEHGsVMpi/OWHDDQRtihQy1A7v68ni+YxShOG26W9IyAgd3KeW9ObA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?utf-8?Q?J=C3=B6rn?= Engel <joern@barelysecure.org>
Cc: Chris Roy <iam@thechris.in>,  Richard Weinberger <richard@nod.at>,  Greg
 KH <gregkh@linuxfoundation.org>,  syzbot
 <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>,  dakr@kernel.org,
  driver-core@lists.linux.dev,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  rafael@kernel.org,
  syzkaller-bugs@googlegroups.com,  linux-mtd@lists.infradead.org,
  vigneshr@ti.com,  Adarsh Das <adarshdas950@gmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
In-Reply-To: <aq6sd2Z3nZuAYbMG@cashel.logfs.org> (=?utf-8?Q?=22J=C3=B6rn?=
 Engel"'s message of
	"Sat, 19 Sep 2026 08:38:31 -0700")
References: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
	<6aab0f82.e91c2013.3bdb06.0009.GAE@google.com>
	<CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
	<2026091753-broadness-bootie-b683@gregkh>
	<CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
	<aqwuWWMwdIcx3704@cashel.logfs.org>
	<mu82xsi6.76ee613a-07fb-48b1-9336-99e8780e8b6e@nod.at>
	<CAE2Bdm3FqBPAMxqKoz_h1cw+OXpm=LJHdJjsME_Jy966tqhq_A@mail.gmail.com>
	<aq6gJTYTpTr8sYPj@cashel.logfs.org>
	<CAE2Bdm3K+ZnrfB7xzkg=2fzMs7AmJzdF3aYCpN00h90TR6FMog@mail.gmail.com>
	<aq6sd2Z3nZuAYbMG@cashel.logfs.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 20 Sep 2026 14:52:18 +0200
Message-ID: <87cxu8axvh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi J=C3=B6rn,

>> > Is this check necessary? [...] Looks like the kernel is still
>> > undecided whether checks are necessary or not.
>>=20
>> I will keep it. kzalloc()/kstrdup() under plain GFP_KERNEL can still
>> return NULL under real memory pressure (no __GFP_NOFAIL here), and
>> dropping it would be inconsistent with the kstrdup() check two lines
>> below.
>
> My foggy mind is slowly waking up.  GFP_ATOMIC can return NULL.  If
> you're trying to allocate memory from an interrupt handler or similar,
> you cannot afford to wait for memory reclaim to happen.  Those calls
> definitely need a check and a reasonable plan what to do in case of
> failure.
>
> GFP_KERNEL should be able to block and wait, so there really is no
> excuse for kmalloc to return NULL or for the callers to need a check.
>
> But your decision of not pulling too many decisions into a single patch
> is still a good decision.  Even if my logic is sound, removing checks
> from kmalloc callers should be a separate effort.

Not saying this would be a bad move, it would be highly inconsistent
with the current code base. Every single allocation in the kernel is
checked. Such a change, without a documented and agreed upon method,
would lead to dozens fuzzing AIs sending patches to add the "missing"
check.

Thanks,
Miqu=C3=A8l

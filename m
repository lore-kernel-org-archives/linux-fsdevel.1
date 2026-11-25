Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578363;
	b=mJOtt1L/3Y1/UEFbRmMW42G0v7MwCZYdLGymd8tG4ivuvx4H2LGpbscCh6EC+do9OJq8
	 kL/e03vABVKkEGFeZlXV8OJf6hF2SWHfiOkBjXYMGpXyYKhTclxFl3+/HKalkNa4avOWt
	 xvmJBQX8ndTKR8eJuXcWfBTSo7WDDdQUc3/4TT5ISMuRVe+dMV0bXi/SiIpbN0k6WmU1z
	 Xm7q2t/GkKhOeX+THPypN1QWCHI6uS4ewh8cIvL8d+2H7k6zlHb0hX89VZPz5uRdBr8oQ
	 Qf5NylIZH/rB50s3QNpyCMihEDz803mw2fER+v1+MYWWyeXGd+cMoP9KIRrLP5eGoRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578363;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:Reply-To:
	 MIME-Version:Content-Transfer-Encoding;
	bh=te+85rs6L0Tu1kg3pduPz/TdZSjogt/uQT+qd17wdHs=;
	b=wXcCeDaOWav72TPmtmQcpj9ciGIMkh5LPX0GjX+WQDr2xI85NRKvcYB2zSLHmuby3lpn
	 RXiRgUmFHQEEZUSKSPJ4dkJsHtKbB+oYOzMJGBkQmRWsVmNnTBIWFjQxkfmr1k3WzIvUt
	 HWFu4DbcYwhdNediC5XQF3TWb9JRCmDxeOqW/9laaTH5fPmZV5kcC76JDmRhdeMYRKUwg
	 fdc+VFtmdCmmKiPVYoZ6hJe4V8aI03NuQeA028XkWBlqNbluaqN+YEoMndKIdWpDhcL+d
	 VbxxyPaBTTpuRDNO1zeNU5DTrmNO9plG5zsMobY/wUm3yYJJpLLt8mRKwMi/V4ShfDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=DC+u0VGj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XWfVsu7y;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA0606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66EA0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=DC+u0VGj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XWfVsu7y
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 914B2EC0AAC
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:45:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 22:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1795578357; x=1795664757; bh=te+85rs6L0
	Tu1kg3pduPz/TdZSjogt/uQT+qd17wdHs=; b=DC+u0VGjhueZqVxgfl8gwONxO0
	oBznNlhevQZAEAUu+r36xA99W9a9oR+jxpqC0ewn+eOrkywE/xQovHK/m2PhgbEt
	w/WqSmu/Mp/+NLdzQOcxqlnZktZ/VptSZIXPnic7A9VEQzydJHU8c9l9c0HXP8z3
	f1he6adItjEocphVGvzCUH+kIBRclWbZPbMkXnjAUjsuiCKHvNYFST0JZfXvg51+
	E3Kmnk9n2GVvrKFXB6b7QKX5lb4E1fU9uE94Kn2BHUjcVEZ04lX3LMz3+7lrs04G
	5NwUPM2ZDarNyDzQVAHVCnOk3z8yIAz2Sj7RLAYYnm+qAV03b9yERUvzt19w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795578357; x=1795664757; bh=te+85rs6L0Tu1kg3pduPz/TdZSjo
	gt/uQT+qd17wdHs=; b=XWfVsu7y8NvcqBvkgx6AQvHsBOkiuzcZwrYGZAQC5Bhw
	vtE73miMY/vLyuOzg7Fzu4YU/9mYTRcY9IbDQoMFdLPz9gIU4Jb6C0GuVa50930P
	N47f5oHBminLjxjgiJrSvY/WviUSIwjgeioIxb7Ef8j5qMI5OMX+U7Uvl/uPut+c
	XNRI9jNeGdAAvDDR9ODf+8mtIlkxnXcXFgUVptDEny1wot8IIFIHeuH/H7K5dRnA
	qhD4TOLXn2+K/4QTaa7B6t+0ZsNAsx5UtxPBnU67byV4jDP7vT+gjyB5akeC8Fjx
	FRMlEZGvWGU+Pd6GWCo9JSO/Iy/DPLIUyCFvoS/xaA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578357; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:jGPjcXft0JDgSmgy5PV3I+o9dO6F6X2URanSqBecaF9lxSG
	E0Suxv3YbT42gGXl3cMkSwQ8Aixk6/R1kHC6hj4rNw8VSQL4w/0iLlYhLbVQ0aFg
	hCJTy7+RBHA9HL7PHDUfIkh7HJIIjjLOkm4swQsYDc24DtdqNu6dXo6ns9gNZBRH
	BtdY4t2lBGRkDh/yof4FtpYkIg+H96lA+3/Xzk3mHAASCfOc048GIanHtJgP0fBX
	FFp71PT6SLOY5444thvcZJh50FjEHumydbqV0H6spyC5kgKbzfioyVQhzem62F0a
	EVtpfzrEjDFJNGHXQbkHsajbBxzaq7mjSfx777A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,reply-to,subject,to;
Message-Instance: m=1; h=sha256:6gIgKmEK+V1m8xQeD9wAvM2W7KHH8KguQF7kcD8RfFw=:KIpdI8wXTkKfTbClohnjMMutdVqFsf8UXtyA3Nw66JM=;
X-ME-Sender: <xms:81kGawuuyqWvXHqmVqljAlQedszfwZO9EA5rtQ4yIqdPSULxXEBooA>
    <xme:81kGa0ZascAx2U54dKCZxqpgQPp59dWetNxPpwyHddGeX1TQjNJEVQxN93auHIoTc
    mgGiFiYYiADfxRvTjlS7giTm7NNr6TYs6fqN3vnSjRL6-VmnxE>
X-ME-Received: <xmr:81kGaw2mFQG2xymvtRzybD_q0_b4KW8DdRwXRcAvZXOxbkcp-qjpqpXXz2uPS4v5lw>
X-ME-Proxy-Cause: dmFkZTGHTDLHrhSdcFVSltAhItO5CQcE/TjFbuhiumOu22/hJvNr30J77pkfAtY26o2DMg
    VSD3uY+/cuaDJ4Sh2bWyrrkqZBASGKCdjQbH6pMHWkkbOYJMg5HQITRhPlC6KnXFgzK1io
    I1b2u1NNTXTg/nkeE00xO7eBghnrtGEl7S/Rn5evCukV0GkFGzbkDSZAXnsLIpDwTTZ6bD
    TJMeI+IavU+KlNcB+hcEpXWHmEnj4UwjAz83EM4764K87HVhTIQ+CSy4s3TFg2j0TXM1eZ
    QVHK8rdWI846K2nUNW9gZUmN1pKfh+FdDUZxf2KFlC+9FBLtsS+qj3sdT5Stx/bTFOO0IX
    q2V4lTFYErE5TfSXc249mMlVKib+slQADVsyE+fJ38+pWN3L/9jBGZV7687vBrpIz+shzY
    bbPYsXQHsP+JSxeCQtQFGLBK2XK5r99hpxQzRfWuMqs2sdH1L00+aJXV3VTnSH96fP0qhs
    9ZJwyCNOH1dTJdSqthybpeDIaCydF8GMHm7UDWxXVYcCwuy43S0CZQRLQROy40JUa6Go2m
    H0oo/eT2fYlff7D3LTvaO9jt7PJKUBLZWWzfngmG5PQ06bP2f86MBc+pcEK3LfV/dE9nd0
    89wPPfXq1YcsILR/jFv3tqMVus8/YqE0wtK5YaZ1LttvH40YoChtPmCo+Rjw
X-ME-Proxy: <xmx:81kGa6WZGWgAoyTx_rB0U6xCgY_RO7sCFffzTnybvXOgXC7HreJn2A>
    <xmx:81kGa7udaydsCniw3bdpJEdSckm6DO_jRFs2PacG2UL_RGiWvRKacQ>
    <xmx:81kGaxUCvoegXUpv2RRc4kkXsnG5Ce32qXDxBS90PBFrvEj5G1uvfg>
    <xmx:81kGa3UJbtZmsHlTig2b9B6lM4eldHbONHWbgqNQBM966-au78wlfQ>
    <xmx:9VkGax7pJjaB4qXIZwDpaWUtfa98NSvU5HEyDycAnKopGiGBuoisihSY>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:45:51 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-afs@lists.infradead.org
Subject: [PATCH v3 00/11] multiple-filesystems: prepare for changes to VFS locking
Date: Wed, 25 Nov 2026 14:16:38 +1100
Message-ID: <20261125034543.4084039-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(ACKs for hostfs and afs still sought).

For this version I have included the AFS patches, included
"use d_alloc_parallel() in lookup_one_qstr_excl().
The latter patch is needed to make it safe to use
d_alloc_parallel() outside of i_rwsem.  This is, in turn,
needed for the three patch which drop i_rwsem before
calling d_alloc_parallel() (which is preparation for
inverting the order between i_rwsem and d_alloc_parallel()).

I've also reverted the LOOKUP_SHARED patch as I now see that was a
mistake.

Thanks,
NeilBrown

Original description, updated.

I am working on changes to directory locking.  The medium term goal is
to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
can be run unlocked, and consequently cannot be called when ->i_rwsem is
held.

This patch set makes small changes to a number of filesystems which each
require just one patch.  Patch series for nfs, cifs, fuse, cephfs
have been posted separately

The main requirements are:
 1/ that d_alloc_parallel() not be called while i_rwsem is held.
    Places which currently do this can be changed to use d_alloc_trylock(),
    or d_duplicate(), or change to drop and retake the parent lock.

 2/ a dentry must not be d_drop()ed while an operation is ongoing, as an
    unlocked d_alloc_parallel() would then be able to create a new
    dentry with the same name.  d_splice_alias() can now work with a
    hash dentry, so often the d_drop() can simply be dropped.  Other
    times it can be moved to after the operation has completed.

I think it would be best for these to land in the VFS tree and would
appreciate Acks from relevant maintainer.

 [PATCH v3 01/11] coda: don't d_drop() early.
 [PATCH v3 02/11] hostfs: don't d_drop() before d_splice_alias() in
 [PATCH v3 03/11] afs: don't unhash/rehash dentries during
 [PATCH v3 04/11] afs: use d_splice_alias() in afs_vnode_new_inode()
 [PATCH v3 05/11] afs: use d_alloc_trylock in afs_sillyrename()
 [PATCH v3 06/11] afs: use d_duplicate()
 [PATCH v3 07/11] Revert "VFS: Add LOOKUP_SHARED flag."
 [PATCH v3 08/11] VFS: use d_alloc_parallel() in
 [PATCH v3 09/11] VFS: drop parent lock across d_alloc_parallel() in
 [PATCH v3 10/11] procfs: drop parent lock for d_alloc_parallel() in
 [PATCH v3 11/11] afs: lookup_atsys to drop and reclaim lock.

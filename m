Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4DA533D6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957844; cv=none; b=njAGj5b1LJ8wghdAMFxlkFOMTP5lEUp3NOnHpKSf8jeOmPGo5qFTbyFhnEkzykUrWX26eH/W0RohoCyCIJWGYWE2e3iWNdRm1Y1c2eBr6j2Q8/MFHeDLDgei441qisizNQxgCEQkRIHTRW5CxwRlgjjZA3BN5ne5xEugYfutKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957844; c=relaxed/simple;
	bh=xRJHymTEHTDXCtFM31xMTi2sd7S8t9FoJcy4IHqi++M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7YGh5awYiLsuaTAYWODRuHLeWWNiXwqzlqj2sG9TtW/l/PRaXPc9QUdxrnfpTE7UjQQCvwrhY35XD8UEOVrfBbPyKXcYXAhd8HQk2uxSiHN4Fiz3yKrvulKovW/lgDOJaiAEVXvsCBxcrGQAhoBCqtWnNECku944XcOAkpeubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hp/w43YA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kN43SATs; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hp/w43YA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kN43SATs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FB71EC010E;
	Wed,  1 Jul 2026 22:04:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 22:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1782957842; x=1783044242; bh=QvLyZXBFez
	PKqPhEqJG5AEXZAloykANvMLKGo52dRcc=; b=hp/w43YA1wWDkOOmNWEwzsDn4h
	mymXSvv9Kz1CIwLlI7LngFqvVt/AUSUSgaPXjz5fAkv9KJPFjqG/f5TwsNad9vpl
	i+WhgvYO1Vngs0UklM5K+iJfsh47lH/5GK07Vfxx7lXBEtdpHnLBIHPR99fMVn5m
	IHXuHmysCceA8NNIBOvrdlG2we+hEn18piyeFQVC1WujSTNKBDXMV8xopten/qDS
	a5Y++IJODYp9fPtBSK87u4jXJ45DovEpGC9F5L5dg/eb0IZ1XtZ5q89yH68BFvIl
	rrY5ds7LRgXhVNsVspGS/ATrTfTTdp4x1+EynJskBHjVXS1z8ElO+ZW+7rUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782957842; x=1783044242; bh=QvLyZXBFezPKqPhEqJG5AEXZAloy
	kANvMLKGo52dRcc=; b=kN43SATsNLnJzO2/1SBwsJPcBfL/O9Qo/6BdMfLxzLGr
	MvdYnse6J7hRnRL3nBbax1CSVJePBwCTvMWUUSU8IiWSYArbl4oh9Xwis85BAVJS
	4koTX32Ev1kE0XT0wQSyxF6RF3cRZzca3MuJu8lnZ3HAFrlg7G5JppPk6H1l17vW
	4xooSJtn2yLZ4S2AIFTYP5wLoD+9k9GKE7ZyxQDtb3X1FwPTWwTLZDwCxzLSdcaS
	X21W47BjiyoWbQ9eSTVP0y1VmZ/h/DyTnTVCndNG8gRgFjm54OUvCoixr8FWPmwe
	6CJZVybOQbbrMTIiRX8/3xJafMtvT41eOWhEpcTfog==
X-ME-Sender: <xms:EsdFaueJLdxTRtS6E15yWeJYn79D4sq7j3hFhNt3cgRhkNFjv3E-Cg>
    <xme:EsdFamBPXfXV5L4dxhWQggX0o4IlhJV_hVe7_bxFibjtXyptd0acgcg11kZ0qna3b
    I75kFF_QsQeTsqSu9VQEf9EZW5pnamasCueoXnHE34ebspFLg>
X-ME-Received: <xmr:EsdFap9BzGfamoUZDKRzxgmAxfRlFsQOOmV1-_6_eLq5AAnk6R5txV9iGd8iuX_IrhYFuBWtuX17Aicj9h_aQ00-s0jAuzc>
X-ME-Proxy-Cause: dmFkZTE//AEtVklS7NSVv7kXbxZvt4ajVTg9JHSz+9UPA3ylQtN7T9Is3KI921UHak/6+V
    FqKPk2HJZ2CtNi0gy5tKux4kQpOurnc0Zs54sb7sxiE6imdFMz0S18rB7qqbfxmfV0JFG7
    YjpvKUtafR5bO9+J9bLaiUZIgtOxrtkP5CZOoN2q6iDQyCz7FqEwWE+hyl8kEMbZhKZQtJ
    cdkpBPzLV7nKWdQo0BBgY9Gkoi9hYi9N0UMsL1DUfe5u60PjI8MeDxP00dQCqEaDhUD7BB
    ckBGR+rBUBgf2VC36skRrTkuoh939SxmN+96odCZ40Uue9p+23kBE3wwjuJlgDiwjOoEhX
    x3tiuOu5yjzS3CVdkUczMWgMpCEzYfNKkaj5S7Mj3Z4i0PD8nAdfYYZ2bxE0gvhrXSu4qQ
    ROckny10ZQy2eN/9NCND62MRrDL80DAF3MuWSKQ/wEXCDgYzT0IYRRbLjmP3aENj2A7HEu
    nZy4KWztvWD0Ews886ZdrVhx0+J2XsX4ZnWTIQ/EhDEC3egs7rx8e8kAsOHpmoUdvVwHVe
    DdHier8gf7UnofuxncXAt6qWkX1sWft/1UjFmOhCoQTYX+PvfHvffjD6fCw4AhQhj6cTAf
    Jq4EyaSqbNsuznK0GV+9jBr4TbvpuDsr4ykchUyKzL6Q18W9atGk+hpxROFg
X-ME-Proxy: <xmx:EsdFapIYF2TG1gGIEtp0Y904ZqR8IjpFD5cRt9Z7RyHKZ9qD_Ry_gQ>
    <xmx:EsdFaqi1ayg6mNbyZH1yQg28v3eMAxreCH9wyxnFeIlBSSgdxYm14w>
    <xmx:EsdFah4vHj291fJOn2m9jv3DgOuM4QR7VPwX4qxJUKr_t7xtyOEutA>
    <xmx:EsdFaqaW6TornSw1Vmo2T1UrsfJ6yvc5B59aG9FRhm2lI5iClwSX0Q>
    <xmx:EsdFaqHYf1gYiaqOYcYlFU4apWByZYE8kshG5Clb8PcUElmMadg1aaLl>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 22:04:00 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] afs: avoid unhash/rehash
Date: Thu,  2 Jul 2026 11:58:28 +1000
Message-ID: <20260702020350.3403907-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

afs (like nfs and others) needs to block "open" requests while
processing an unlink or rename because if the target is to be unlinked
on the server, then the open must fail or create a new file, which needs
to wait for the unlink to complete.

It does this by unhashing the dentry and later rehashing it.  This will
cause problems for proposed changes to locking which will lock the
dentry rather than the parent directory.  Unhashing will effectively
unlock the name.

The second patch here addresses this by using ->d_fsdata to mark a
dentry as being busy in unlink/rename and waiting in d_revalidate for
that mark to be removed.  This is the same approach that NFS has used
for a while.

The first patch frees up ->d_fsdata which is currently otherwised use.
It is being used for a purpose that ->d_time is more suitable for so the
first patch switches to use d_time.

Thanks,
NeilBrown

 [PATCH 1/2] afs: use d_time instead of d_fsdata
 [PATCH 2/2] afs: don't unhash/rehash dentries during unlink/rename

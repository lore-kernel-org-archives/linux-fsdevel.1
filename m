Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565450;
	b=RMks1HMlQKc7loitnKcaS8e9J7I68oB8JCCA/5DEbAhZ7xGATGaY5zjBT88izjazW4FV
	 cfToG5cCpO48Tq/C+GQlgUe7sxYWkkjm4D8o/JVyPriEBLGOai6vQbb6Ap7D6lilNYNGZ
	 3JK0QhkhOMDikh6calRFM5R/doF2mR9X51MYFOtu4AppbLeyrXgoL3/8jCnZ8PPwmIqxm
	 28AG3x2fmhOQyoFe238oO6owknWvVZpVyvhuQ2eftE7gktl0GeCwGXmP83fYo5vdGjJaG
	 bYq1DkOZZ1KA2SLWOxQ4YB/VHxF1oID+QQ4IV9NvpGN0oVLYA+UN/Ix9M6pU/P0BY5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565450;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:Reply-To:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GNf0DsXLjl4yucnLPL4jzjrbKS+Qy2JbV6oSfxF1vS8=;
	b=AWTkEZGqx+YTkdJWeNRwumMtXidGyoox3Hh92dxImxwRJjQGZkcQaZLmeQlyLWX0q/PH
	 9IwvkITjyE5KmnihnoVm/XVuyG/+DrzzO5eeCAf1wBnuiYmZF63DHoELFitNlOawtb8BQ
	 8cCzOugtMznfHjTbhWsiFuAyoQaVEGcpOa7sfH2jce2DkEO/n9GP9W5glk4b8effCDCTp
	 Y0sisFhyHz5wSDgTVd9VCjvbSxmzXwFTmY39JYy9IDG0v/HGpdbIm2r3B3bsEAki5Y2cE
	 NovqwXwnMoNxuYkqO3SPpizvtgKJrE4NFt6DcKZIkNi1TSmb44MDTqAChZCekc2Va9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=Y9rEdVEg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jIyLAJHK;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF067606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 00:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF067606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=Y9rEdVEg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jIyLAJHK
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 24AD61400340
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:10:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 24 Nov 2026 19:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1795565449; x=1795651849; bh=GNf0DsXLjl
	4yucnLPL4jzjrbKS+Qy2JbV6oSfxF1vS8=; b=Y9rEdVEg59ioYbRzfTkXR3zVEq
	02U43I0a27YgaxD1M0n76fVtadVC/SE+8wx7QtfYAYGy4YrnxYRuSp8srpuIJDbA
	q0U/JYbwJ7hxUTS20lm5IKQgjr3PZ2LC46ZG2GEWUc5nx+KszRFxfNINOfnuA1kB
	F+jAsBHaqyIAx5vX2SEO66Syxkgh39CntQe4vX0eHq3WzXE5amY7tro5BLEsOFt5
	82W8a2gOMdXhWIgEdCkNVLL4/V1P2+z+W16PLI+iiBdr7UlYf1k4UQ54uEtlBSce
	E8LINYMRB9e3E6RshIez0Q2IJBMSm8cP8ZFDw4EuxkoXgq2eXXV3TPGfaU8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795565449; x=1795651849; bh=GNf0DsXLjl4yucnLPL4jzjrbKS+Q
	y2JbV6oSfxF1vS8=; b=jIyLAJHK2+KcD9eo8I18rQhHtoRA1gm07TAe5/63cCEz
	8YWXR8h9FfKIplrBaN2gWMSMo+GT8VaIyuvMoJLm8pZbQgrNBGx97JL+LLayzS2O
	mHSqQLQprLv2xlugcfFgKWoc38pPHxYVBzLkdfx1koYwxaO1IpyGcetvDpDmPiOV
	93mV1Tn4XQGco0eg7S69Ajrq4aJYX/jv2MF69OckOcVMnP7SKWXezMWLa6a8tNb6
	0dWN34NkZhImqiB0X14KSKU1abtOrC9OhNxcTUkmAZQgd2lu1t/IA6I46PKmuH4r
	i+hzkxcairqbXZpaeZyk9o4noxX3qPLEoNNCTDN+cw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795565449; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:pvX6C1YBsPL5fh/sm45M72bt+kho6y+mmbf2jN9FPhSW2GY
	KuLKMF5noI+I28bFV3NLAxFC8CQFdiaDGIi7eEjzuPHL2xsgBaW9kWabUItxbBTm
	aqqXdnTt2WLYhS5EJRJyK83ptImMo+4Vslfz59WUBkBXwd8/Jz3LvrQSCNTOyLU/
	bjReabaZ2kyPtw7U3OfHWTA9KDAJAP8SkCG6l7PWJO3gkxWzjldBnNj1uD15p83+
	IN5GC/h8+v8I6NJEb7OEswc8TaqqZgnC/E9P5A1qP973FaZKNmxIiZ67XmIAr+x3
	cvJ5gBe43WqqZy1PfPCP2lJsvTFVjnuWWveL4Vw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,reply-to,subject,to;
Message-Instance: m=1; h=sha256:08WsAG7bGjq0Vda/RJMF6sIDLT8tN2VO5yqhQwGkdcc=:iKCNswlumNIVyREMsWd91paRiMulMkpct3qU3eaXj28=;
X-ME-Sender: <xms:iCcGa7nA7nSEW5zB4syGcJ4TKQwuSBKlfnCV6Ug7iW9q15jR8dYn9w>
    <xme:iCcGaxYlDpateEdOhVVH9qJCZjOfTRNpSTjqKV8dgLINoB79mxdd04KIKNgbr3STy
    Ljp8MF-ndiQX8h45yB11JlApgq_cs5K7f9O9Sk--ynHcQs>
X-ME-Received: <xmr:iCcGa1RjvWSscYTZjyvdbV_CR2y85Mwjrn1Vdc3qNRltqOrKeJ2Z-SXoMpiFYa891YNNGzuQtBdWzvkqCcskVtwScL5XZ-s>
X-ME-Proxy-Cause: dmFkZTFCm1MWwbQVj0ihOPyXVAzhXtIGA0HuPHSgZpRRnAv1jIwrXJYGpPPAbXOS2A8cvq
    XG7N0Z2FD5QASLqDQDFtdsN4ocVOaNPgomnQC4ymW62kHzP0/rg7mg4Y7uNYciVUz6e/oG
    q6kw4RiElYgEsxWTayKk+MIWeEpPi5KxbUJvdBlEH5D1pkE7SFWFUQjZqXB6Tzi1tduKkT
    aC/JZ3ibkX8/k8ENtUBcq8qjRfIHMpumqCaxNOHgVgenGxckiPexuuT63I8sLP+Yb1AD+o
    zAD2Z/cKUVR8XTxOauR1MeVdafPwJqSCVSwYev4E4O/4rX0DNPJ2CgmFFsUfyJJQixvhoh
    zD6ykUu2PV1NizB7KwqPMHxz7G+S2S+PzcPYWDZ4Sak9ZGDQw6C4CHS9z+GDAuhuesY/1c
    9H2u72ONyDViu21kmc7SS1HYS0aqOa0Lh2lT6vOLsgZowsuEx/wv/XSr6k1PYe8usf9xGN
    Gy8t8xXoR1fr3KcXLQiu9aVaP1TAoLZQNetfk8GUJAZoNiyEQjz3gHyz976BAICHW1aYNf
    qTwS9RRXpcU9iaCwt6PylZOLGRd7aPh+Y0DXaXnIEQYEPvyqU2AlZsZh3KpmO9ApQpkPiE
    87XS0orgkWQVB2IlJULAVNH7riWqrn7zyP34omsoVoPk1yjXscW6H+OyyosA
X-ME-Proxy: <xmx:iCcGazt43YK0nHhrycsu8Mpafw5iISJ4hiJwQvWfywY8CTP-9iKXtg>
    <xmx:iCcGa_FiNTTv2Xmlsb98mCeM7iNbLB3pL1Co9NvKjkNmTugsMs7rVQ>
    <xmx:iCcGa8xcbXcsBKig30CWvrYNnva4C_wMzEDC_Y0bep0QZwjMdGVrvA>
    <xmx:iCcGax3HBljq-tcQCwOAXMPx8aLryStkrd7LtK3d_TjO6cGMrMkbDg>
    <xmx:iScGa2WJyxVQo4F7MDLlFtbO7O-xSO3oCDdqSPbXHx4t5BWf_VzDE9dr>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 19:10:45 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v7 0/5] Fix easy bits of the negative dentry problem
Date: Wed, 25 Nov 2026 11:03:37 +1100
Message-ID: <20261125000836.3984402-1-neilb@ownmail.net>
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

Seventh time's the charm??

- Fixed silly error in d_duplicate(), and reviewed all the code
  more carefully this time.
- added comment and data_race() annotation to autofs changes, and
  also renamed the new function to dentry_busy().
- added text to commit message for 2/5 to explain that there is
  a remaining race that we didn't attempt to fix.

Thanks,
NeilBrown


Original intro - revised:

 I was reading about the negative dentry problem in
 https://lwn.net/Articles/1079407/ and thought I would have a go at the
 easy bits.  Given how involved some of that was I'm glad I didn't try
 the tricky bits!

 So I didn't try to reduce the number of negative dentries or handle
 them differently to positive dentries.  I just tried to address
 specific symptoms.

 This series addresses two reported symptoms.
  1/ refcounts on parents can potentially overflow if there are billions
     of (negative) children.  This was the easiest easy bit.  The first
     patch is all that is needed.

  2/ Walking the ->d_children list can take arbitrarily long and can
     trigger soft lockups.  I haven't addresses the "arbitrarily long"
     part, but the "soft lockups" is relatively easy.
     With this in place I would feel more confident addressing
     the "arbitrarily long" part if that seemed worth while.

 The core idea is to use a common helper for all walking of
 ->d_children, and teach it to drop the lock and schedule when needed,
 inserting a cursor to keep its place.  This simple idea requires that
 nothing should be holding any other lock while walking ->d_children


 [PATCH v7 1/5] VFS: don't count references through ->d_parent
 [PATCH v7 2/5] fsnotify: update children flags only when parent
 [PATCH v7 3/5] fsnotify: don't hold i_lock while walking d_children
 [PATCH v7 4/5] Add d_for_each_positive_child family of iterators
 [PATCH v7 5/5] Use d_for_each_positive_child() in fsnotify.

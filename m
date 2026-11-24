Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502536;
	b=RD4Qnfd+ELeRh2VafsK31czOI/XGqilp0Ih+UaGvRF++JA4bnejrA1K/ccYJCG+tHz0e
	 vsx5CKp+hXCsLel33Vxlov2RLBupTJdp2ke9wbpxn+7pXjzEKJQvC2qUA5UdQuF520JN2
	 Z+pND8cXtBDVeaxLH19Eyg5RSHiER4y7IAT3TPe65DQ4aQIEl75mHf9cSs4/CkVxkvtt1
	 GwtqZILkyVNMCI+lat5oBAkk/CJPSQgIm4yvlOjRuiRSSIj6oB1NIkgNOZwt6yidLoKYC
	 nq+Abh4fqw4Wuujqd98m8BaRt39bYWhSUhVRukntxcL4AXNx816SHKChuhA2Sm9h7zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502536;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=hBv6+ewP0DjV1+qVc42GVCNnOm9jAOPktJFymHxBRAI=;
	b=G/FU+R9ncqjA0R1Cq9ctEaCWeo32DtMmWsincHlOUQxfI4wxvqTiVxRKVnllc4jICoPZ
	 x7xKUDCJQC51rDXkpqSZ7xdEnwDCHQuE3q1fST2/sM+zbDB5xS1rGrjacXcHheNBLo1uU
	 puG3Gk2i3nOOENhMycQF8mGnG2y/zYOrXwj5z59WJEh4RsVAL6/YNnKiSrgcbUIM5dxiZ
	 jQbsGqtuaUWB6Ram3Q9fFKs2m/AVh1tBjhgeVgB/2hUck4U9BbN8sX10VqGoeExV7AIw0
	 +Mt1rnhOtqesJQKqPl8vUs/0lwVpk/dhjv6iVuQfhDL5nO4++2qmJx9kolrsXYgcObg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=SghkeuiG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3D8toBcl;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2A606A32D
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 06:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DA2A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=SghkeuiG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3D8toBcl
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 797CE1D004BB
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 01:42:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 01:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1795502534; x=1795588934; bh=hBv6+ewP0DjV1+qVc42GVCNnOm9jAOPktJF
	ymHxBRAI=; b=SghkeuiGUyKvx3AQe40FpTXeImbcOWBu8BYuOFddVJaQrbBlVWh
	K7PziW9DDdT6fKVS5T5u+47es4VhCdLU4F/x3b9Fm/m/6lthZkE0iRmyX3czA9GA
	HApCWOPVIojLiCcWgzjWjJOsPKuE3tQUxA8lr7v6DfabmeoZQnVGuvDzp9aR96kU
	+t7WhhjcyefEH5+rVeXgm4MI/TXXe92LZCv2TjL7YFVu5GqmypFNwIJ+SoBKDqqD
	WDJPDnuIm6co1ROwwvY8oCZNb2xeQc+ddFUF9Kz6Zh4Le2BU73HMN6JvQqu8HsB9
	Hm9whuDAhd0QppOdCyccurGMURLVjzPt91A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795502534; x=
	1795588934; bh=hBv6+ewP0DjV1+qVc42GVCNnOm9jAOPktJFymHxBRAI=; b=3
	D8toBclI9jkfKULH1AKPSNsC0cks1T6skK5zJB32VFnelX3P+6jytUaDERqtX3Ox
	t5NfBjPWXr8I8cmetP/0dgmAw57FG9ij9Kn5uStYH8+D0BhYVat4NLgj9g9QDu8N
	hnZ5GOVpgkBeQUEN5Ttnap4ggAVx00Rl9UjCQcGmIlnDsdyI4qB/hKQ677Aw2Zcv
	8UWzM4OA41s7rM60SpRdS258aI0JZFMbUYNfCSZjz5b+ScBX5zqD8WrAm3eRRXbe
	h7B3K87hoSNn4F6BPrIm/e9KCIArBQ2/dfUSC+k0Mk0tYOaZWtrpuGoVg5X46HGz
	rfCU9QfXdIhTeodcrzEPQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795502534; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:jNlO5G6TEukzzr+iwCqVJCyNvlnULvYfvPXn8X6LC1RJTss
	TkHva9GCd0zRECpuZqUSkP0gg7IPkmZxNgT5wfXHl/IyRR2BEjUTGCC/71JeF3Fq
	9RkvDYmD3ILvSdb9xLT36ir2KYWYDIuwiJFDdlVnA3/Z9k6Twli18Ir2KxkCEDNH
	i4vENBVArXDruuPz19Arr62Nvi4BwBGSn1r+JymTNjDd+qL8Cf1JkFggHLid8c/V
	uJsN/v9OCz5XZY8i2b2dy/+GPsRGXx1ahlck0UlXCTV8G5Gy6zEbx/CPqApjj1GI
	29+DV08VSU56ZCHxxnhse+VEGfkUUuQBu5VDD5g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:AaTRc1yajw2oA3elYV7isJIou6VrbdqknEC09Efel+M=:S2g4KmR/BKRm7uYQ2YhxZXwF86/RC39pouWHfZJy1Ww=;
X-ME-Sender: <xms:xTEFa5kX0Uum0m8tzyE4e-j6x8aRlQX1_X01ryVt5omymu2B9R8Rdg>
    <xme:xTEFa3Zi-sSxeks13rdRcMeO9RcmH-7RfX3C5aRjut4PE0gVfkCUNJo-kVYse_fQ6
    bIUhy3pvemW-AKM7dKF85gFbo7ZuppUUt8ln0dlwS4H7QBmo9A>
X-ME-Received: <xmr:xTEFazTF93Jlg9XzlvEovHaO_mClscBZla0XnaXfdN8Cm3fYROg6sFaXh5K-UP-BKw>
X-ME-Proxy-Cause: dmFkZTGQ2o4iZUrCPKJl+gpYbLaJvXi1m3kMpkM53l1l/50yILm8tVGN+skIHvuGHrB2XG
    nTvPfo+Ka3phzv6PVjOsad1AFgcyavliy7maFZyuTR++L/WeqebCtl+p1pjNDf/W1sVJxe
    27f/8a6zd+Fd2Nk7iutqyg7mj5ES9YrigRSMsVDEILfDTFqQK7ZhKMxX9A3SZ8mdxlU/wN
    69sj7uQ48tPzq8UnSBcKvO7m0OTzoxyPWDVoZo7O3s5rRnCCYRIlBpYVyQmnUSW6qaCCGI
    fJkpR5LGXYt/DNK1VI+/wKexwbU5yR1NVC5BRsXiLwqgmhHLkc4LH8lVaFvxz3DgZ3PFGa
    SmrWehlpj8NmjL1Z3dnOyeElsDcGUl/tCp/dwq1Z5BTgqDGujTsMc/N1EhXHN1rJhZojLz
    TnGP0c3GS7zPJUw+WbS2JYJfADcpHXtx8SiSVVBEv0RMzB8M9Zh9VKGPQ6vPtwsDQz/BRD
    7JcWeorfFV9fwV5/RmxMT/uoYaFtiOcHjQsXwoJ/3ObGk8Zu6arJKVOzFvYM2p49QhboR8
    pT7W0VJg+qpvmgXqspzg0F5acvaFrw8CIRkzQEA2J/9AnrrXzaJipUfJNR08iCOzLs+YnQ
    6tEG2006qCXjA0MEVvqZcb53z4HmccLZmcd1g7huw5yuZwiWdrp/1aYP8xTw
X-ME-Proxy: <xmx:xTEFa5tkKICodEMR_teZjGa9LigSmDn4COi9-nT3IlylUrclgyMq1g>
    <xmx:xTEFa9FH-oWduQJ1HX3YTd9YHvBb5RHjn-bRensE5zhsUt-PdFy0ig>
    <xmx:xTEFaywQZGwPDuuKv4K5fBZCvPYyVHoqqPNkbg9lGDQYJByfvFUFhg>
    <xmx:xTEFa_1muea2blhtmFT5RJh8p3Z9-cLIlUMXm0zkvlKrmIZcmXlA4Q>
    <xmx:xjEFa0WrrwA29s3OdoIsAEh_BMHqddZXwXx4gn-OJgZxKMC0Pc9_3mTg>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 01:42:10 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Amir Goldstein" <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Ian Kent" <raven@themaw.net>, "Jake Edge" <jake@lwn.net>
Subject: Re: [PATCH v6 0/5] Fix easy bits of the negative dentry problem
In-reply-to: <20261123221410.3328780-1-neilb@ownmail.net>
References: <20261123221410.3328780-1-neilb@ownmail.net>
Date: Tue, 24 Nov 2026 17:42:06 +1100
Message-id: <179550252639.1728055.4014817916838632741@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 24 Nov 2026, NeilBrown wrote:
> This v6:
>  - fixes the autofs changes in 1/5

Sashiko says this is racy.  I think it is but the original code was just
as racy.  Maybe the race isn't relevant.  I haven't properly understood
it yet.

>  - updates d_duplicate() in 1/5

The fix was seriously broken.  Sorry.

>  - uses a new version of 2/5 from Amir

Sashiko has something to say about this

    Can clearing FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN and dropping conn->lock
    before fsnotify_set_children_dentry_flags() finishes allow a concurrent
    watch-adding syscall to return to userspace before the children's
    DCACHE_FSNOTIFY_PARENT_WATCHED flags have been set?

Thoughts?

thanks,
NeilBrown



>  - Fixes the skipping of cursors in 4/5

At least this bit seems to be ok :-)

> 
> Thanks,
> NeilBrown
> 
> Original intro - revised:
> 
>  I was reading about the negative dentry problem in
>  https://lwn.net/Articles/1079407/ and thought I would have a go at the
>  easy bits.  Given how involved some of that was I'm glad I didn't try
>  the tricky bits!
> 
>  So I didn't try to reduce the number of negative dentries or handle
>  them differently to positive dentries.  I just tried to address
>  specific symptoms.
> 
>  This series addresses two reported symptoms.
>   1/ refcounts on parents can potentially overflow if there are billions
>      of (negative) children.  This was the easiest easy bit.  The first
>      patch is all that is needed.
> 
>   2/ Walking the ->d_children list can take arbitrarily long and can
>      trigger soft lockups.  I haven't addresses the "arbitrarily long"
>      part, but the "soft lockups" is relatively easy.
>      With this in place I would feel more confident addressing
>      the "arbitrarily long" part if that seemed worth while.
> 
>  The core idea is to use a common helper for all walking of
>  ->d_children, and teach it to drop the lock and schedule when needed,
>  inserting a cursor to keep its place.  This simple idea requires that
>  nothing should be holding any other lock while walking ->d_children
> 
> 
>  [PATCH v6 1/5] VFS: don't count references through ->d_parent
>  [PATCH v6 2/5] fsnotify: update children flags only when parent
>  [PATCH v6 3/5] fsnotify: don't hold i_lock while walking d_children
>  [PATCH v6 4/5] Add d_for_each_positive_child family of iterators
>  [PATCH v6 5/5] Use d_for_each_positive_child() in fsnotify.
> 
> 


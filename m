Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20989330317
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376988; cv=none; b=DaezTHeE3Bd/vX9ZLqXHtJ0SmNxqTCzDfE3hr8t3JztICa8Rm2C2o8SVHR0m8F+4sgTRjoZyoyveNCxehxqt7CzUvKpZ+SsleZQM1BWfzuaFtz4Y3K/wGc7L49QeQ5R5BVQVRun+Ct3KOyw+f2jlO7jGCTYXD138mL4XeY9JmXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376988; c=relaxed/simple;
	bh=va9ENKx1oVsladEdB2otdoH17clv6b07qauWxI18Tm0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=W+seSSQic1e51AtzcPLYU4Q/OknaX9drWGiHtmftOv46gMvEueD3ck57lfElTd4pPc2IuXJ78Bz7tOwtFjAgGYzLnxHAGekxGbr4LPIXWzwMcR160UDpT3UePNoxf7cLHQDAurkqeO56lzjr5ci3Yf6kk2lNotRhewFDBQmwxHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=fTsBLl21; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YH5b4hLe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="fTsBLl21";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YH5b4hLe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 79D541D00165
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 22:29:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 18 Oct 2026 22:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1792376986; x=1792463386; bh=ZkF3szhHCAt0TzdT7e22/JYW3pBDbxg+jn9
	d4SdOJww=; b=fTsBLl21CZFtyRi0yWcsE99FT+pzRzfYGyKDDSYrlRNEK6TftTr
	o/l7gcetCeYBLvL1ihj3xcqc18gIjtnYf32h45f0Br6y314X7E3Lkvr6dC77dYey
	6XKSg2R3/29YBQaZQJWpAqkHCneGgxCGnLzHpS6b2alcT1a9MbFrPSXY1yLmok5L
	AtW9hilDWvKOGvML3ORj850Y9zF877gJMZ8OdyG/A5lbuHtrsYBfxY2wErLF7/9A
	HYLhWhu/+twHKrB22MwiZhFsjwkQVPaQCR7RzvWOeUvS/AM71q5S2Bgd7stkN2vP
	znZsgjv5MakJgq8qjg+fAWWsurFQAR/VgtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792376986; x=
	1792463386; bh=ZkF3szhHCAt0TzdT7e22/JYW3pBDbxg+jn9d4SdOJww=; b=Y
	H5b4hLeINggXqxyzACY1Bu29q4jdeL9xL0ofI+zsuAtUNHmhjUy8CHMe9bJZeLzy
	Yrge/6Y/Esj07virAgydZEveiouCmIOFwxygzi3K50eDYg1BFoSArF3xIxeJj4j9
	IVC5sa9RoBBkN3J6ckwCLSe/yasXu/TC2EbD2lSEYm9uWmy1Cr4EjkpPNDqgwAOb
	ceuEL1jORasRl6uIzXAsX+pCwsIUEGIGEeVzI6N/A5UF5dfWXyLjX7Wnr/NjRNxY
	k7ByQkAti2hXy+xe4fItTmucJfFMtEM+jwnH04G8qob4idppk0svZ7TYj2hyywGX
	k04mPkkCvrfx3bF+D5ZPQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792376986; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:GEncIQOou92eQj3ilOf3vtfewCfbRZTixOfUqNX4HO1cTCo
	OoDwUTfkv+8foqsGNC5X9mdpvQKUIXIe5TEsOaYQwTU18IyLurmPjLjVoM7Ns7tn
	n4uF4na4YqVSW/a04B8Hkq30ka12CqHpnT4tEc7wZR9qrZ1bGUgJHoTYMgo+ap7a
	YP/1pFEaItDdpAb/UB3NoA20FlZKBYWBCQ5UehLrmDBMn/mKfbXdLgatEmzMQ2US
	bPUpZf1vnGmOEoyeVQHrp2Tq+EtzDR5uN5hCBKEN9kDj1+BDOVbETyUqGTrE0GA5
	IclVFUCoOGwU/gXVCszIXj4sPevpIwsGMBAwvKw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:4QKW0J/oCyipiMo3hw7XWFJhiI5t1OpVJWn5x12DDz4=:va9ENKx1oVsladEdB2otdoH17clv6b07qauWxI18Tm0=;
X-ME-Sender: <xms:mYDVakHkPejmIX6ApaYRRmwK70apBB6YzlADg1LS5O92yLsRnYR9HQ>
    <xme:mYDVav51DHo3dUFUTTvPG20spS70dbIO4vkzjwtVm8vodNVuTSMhznfF48THy1539
    AxZTjcJd6GV9wDz4YXGiMoA9zgoy_g906ZyEc3GdocGwUZIOA>
X-ME-Received: <xmr:mYDVahxGlrps28UO9L3k2CF6BpbriKTjJ3XuSsZKIyzNoqaZPBZ1kQvZMpVLeBLsyaU8g83v8OcybS5oTnvhf4jQcaimVHA>
X-ME-Proxy-Cause: dmFkZTGAclp6YbZlfEGHg/YBaCwlTcWCPI5hS0U7LkQtglxudkn3ondMJ5/kUGrR9GR4Vb
    rJvGkXjUCEvjJMIesMpXo/aNbZ1UcV4fOUNn4xeJ15Yh9uXz/60YBctBK2DOoh0Bk5PWIW
    2wTzIBEcSDa1cxlf9WE33S9Q49YEXy5C8IdPTxqG1LHzKOUTSpEDkN8l5GeaF+7G2p5xWS
    ox8aHGWmR1K2UkT+q7QDnv8FabmrGRiP/AdXJhCcAsiZirKEyhVwvf/GI6rSV6BAX7X7G5
    JXZHW32ctVxy2goOoOF+4x4GvRqcMO0QLLlnFG1Zh+h7MJ3oNdX2RV1LJmklF2XhyKq9ot
    Qz5k1KlftOuxn1stp74Vi1/qnYbtfuHrhyz2Jc4mEUG8v2zECHOi+JjVnjrRw2QlPoWiTt
    qQsQRPI9e0P+rXCMounrTDWavyyyx3+rlP85UD+D8xDV8WBXFV+MEwRyNLZVMW7Y9dI5RR
    cQO+KeZ17SXXraIP6VYf2zw3ZueB290m0g5tFMVbkWCxviptTPHU9JHcmRaYOiJGGqBy0G
    EYcL21txjY2H/+GaoaNzghhqKE/G6KmPTvadI8P7RjnVhw3n9JpbmcBofjWNvT6tDhJdFy
    gDbLiVXfQ9FgpR0D40Tb+1JbowKUPWW7kHSyi0D1dyzyb9V2AsGodVskeiGA
X-ME-Proxy: <xmx:mYDVamO3VWzbo4QuRn0kT6gwDNwxoYGMTxqXa0EN8hl7YPKZU_TDRA>
    <xmx:mYDVavk2Bo4cOBNmPgcdqPdut0p3F4CZmHnV3az8x6Qfzikl3URl3Q>
    <xmx:mYDVajTUNruRdG5qlBItM51u1xnFvAE-XTnJ1eOxaQtJZX7ZTaPVrg>
    <xmx:mYDVamUO9nlkRvahb-D4m1NwNSCmfAoYtQ2EyrBFWhSDE0T6zrFDpA>
    <xmx:moDVanuMerqw7nDgWwghr84es3S2YUcfMD4-Hu7k4oAkp_y-9KvyQK45>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 22:29:42 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Ian Kent" <raven@themaw.net>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Amir Goldstein" <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jake Edge" <jake@lwn.net>
Subject: Re: [PATCH v4 0/5] Fix easy bits of the negative dentry problem
In-reply-to: <f1c42d0bd125c6b1c39f1ebaee41340b5f6f03f6.camel@themaw.net>
References: <20261019000810.1837917-1-neilb@ownmail.net>
  <f1c42d0bd125c6b1c39f1ebaee41340b5f6f03f6.camel@themaw.net>
Date: Mon, 19 Oct 2026 13:29:38 +1100
Message-id: <179237697885.1724252.11956785709205194840@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 19 Oct 2026, Ian Kent wrote:

> 
> As is so often the case you've come up with an interesting and useful
> proposal, ;)
> 
> Nothing stood to me out as problematic given the scope of the series.

Thanks :-)


> 
> > 
> > 
> >  [PATCH v4 1/5] VFS: don't count references through ->d_parent
> >  [PATCH v4 2/5] fsnotify: update children flags only when adding mask
> >  [PATCH v4 3/5] fsnotify: don't hold i_lock while walking d_children
> >  [PATCH v4 4/5] Add d_for_each_positive_child family of iterators
> >  [PATCH v4 5/5] Use d_for_each_positive_child() in fsnotify.
> 
> Did you have any thoughts on how to contain the number of negative
> dentries, (perhaps) including directory entry counts, in an intelligent
> way (meaning "as you go" rather than "brute force" when needed)?
> 
> A significant problem, particularly on systems that count their memory
> in TBs rather than GBs.

I would need to understand *why* this is a significant problem, which as
yet I don't.
Allocating things that don't get used much isn't intrinsically a
problem.  We have a shrinker which will gradually removed them - or less
gradually when memory is short.

But maybe shrinker activity itself is a problem?  Is that it?

I think it could make sense to separate positive and negative dentries
on the d_children list.  This is quite do-able, though there is a small
cost when a dentry transitions from one to the other.

The only other thing I remember from the lwn article and the various
other articles and emails it referenced, was something about poor LRU
performance.  Lots of largely useless negative dentries push more useful
positive dentries to the end of the LRU and we lose them too soon.
I think that can be addressed by having separate LRUs for positive and
negative dentries, and giving them different weights.  I think the
cost of this would be tiny, but I'm not confident of the benefit.

Is there some other concrete symptom that I didn't notice (or have
forgotten)?

Thanks,
NeilBrown


> 
> Ian
> 


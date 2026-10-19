Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32D1F936
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368506; cv=none; b=To2DF1diq51bnkQT5ji01FWzVYmu4FQPdpukeY+D3zZWd96SIRbx4Ip30uKDTLaDzxMiYEh7elU68O3dF20RRKkGRpk2o41cs6aaDZVQEo2V48ZBMbC+0LLbA+pabII6F00LWU07UI+PJpimFGq28f9nlCIzr2DrcRpuku8gSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368506; c=relaxed/simple;
	bh=fAgAuUiP+LtHM5bi2f7I71v0B3AmUXUvXUqbQg4VduU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUKlhbuelcif1H4zU3JebqEO9z9ZtYghqOI2SmbKno2elQNRrBYHbCwvkSq/ulZfGXH5GHXPIJuWDJwQOlZorrPydAswUX+BTlx7fG1cStd/87oF5ZNiopD9GzuPWqZpIeF9aob+UX8i8uwQ5r9Qxsz/vX7ZD+q4iiuIBOIHLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iqXF+EAK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YhRPaN9F; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iqXF+EAK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YhRPaN9F"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C79BF7A018E
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 20:08:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 18 Oct 2026 20:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1792368503; x=1792454903; bh=moVD/9YPsR
	/gGmaVyW9PWYQi5sebZR5wjTt97bZJKc4=; b=iqXF+EAKW5kJbt0BVdj9YdGhHx
	GLR0mEUTT1dSeupq78TilDmCaXkeUYLLtZcN2x8sCy+vYMWx2JjcazN0z6Zg6Eon
	pgF45nrqEazFdUu+LyWYfMQ3MybRmukAL41QWyydC78QqEpTdet6VfrGc3kVkQnd
	zEs+raqJypPTdIT0lSEsFuvTNje2MWg+0rNiPdnMcFoKK3IjKyUWOWGEw/tBN9gg
	dqXBxa+hO9UI7GF+Vt6oPuWsHbzRYkcBfgKXtgjifs8iaNeC17dMg/dyA6kZ8lc4
	kbgyQVVYN6rhI2THaomGEpR6yXm1lvZeagiSYCfZtw7vrMcBOAsy4FJhKMiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792368503; x=1792454903; bh=moVD/9YPsR/gGmaVyW9PWYQi5seb
	ZR5wjTt97bZJKc4=; b=YhRPaN9FS026ONKxbJbYjiEUOA99K38iDdrQtBwzipAy
	H+eJ1zaedrwZ2p7DgFFFWxG9kj7emm2dIj82CY8nBfN3fdzqkdfCLquw0yxK/jr3
	ykLpqTYZenGkSC0uUe71joxQsJe2PnFXThBk0//syXJdq8uO/ebiEas8yvdDiJpX
	vQtoI8dVL4bDGT9civjKH0lCSgeFivBGlUVDnUqOqUUJ+227cAC7AMqt3F5wpArD
	dFNR/efkko35nkBOmnVdH8ye3ZyWDCbBnx8SGngX+GugYYrWPhsoZjEVydUvVqTd
	Km9Qs74xFkhiCgc4/5Dq2jGLmmGTMzHuQeAPG7gzrg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792368503; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:K3mtiPh43xpGrb04eGrcDunTZ2FiEEDZmiOxxlb9xZK0Lu6
	jHPVXI6/lSyVDc4VQSAdMAcSOBu4KMPXHTH+sSWg2MWj5nzvBKXQI/AWOgFr4HIK
	5HaF6SiHEPgUh7XCFGSWUpbkJ0G0+frF1c5fIlVGiscide5oH+7TpQdX+nV7KRrK
	jPs48+/6PJ+7lvMda5ek3WgDRmQKIyVk8UYRQiubQ96y67Fw0NnZ/cbQVVqNw/En
	mABM8yupDFWrcXwN724WJprxglhK53QbkH2F7EsZU8yaoNj+P5iEp/v/6CTabjVx
	vYsjr2QkmIUywm86F8mihtSvEU13PyWlUpz+bCw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,reply-to,subject,to;
Message-Instance: m=1; h=sha256:HEEnJISGLAw86tEe7B7c+c98CcsG2cvZ7fgOaZi/myU=:fAgAuUiP+LtHM5bi2f7I71v0B3AmUXUvXUqbQg4VduU=;
X-ME-Sender: <xms:dl_VajhWy15lZg2K4ljk5TSIZJ6EvcbfEJR1pq-VquwVaJWQEmezxQ>
    <xme:dl_VainmXUp5n5sOo-qVK26gDP2y5LjaX7W7TYizqFj7xPBZ4eW2WEmweE3Stwt-s
    p_WGd3Tb1CY8gsaEFnoZKwPZiZdVlFP1suPYk7e4-rVSLKeZg>
X-ME-Received: <xmr:dl_VamuqrUmonV4PgnM0G2fga1WiEOZQgCXPw7iuCgJ5WTOIyP-evcgXsZMNLCSGeNM9u3HCY0WpbxN47cD89b0O67QC3Qc>
X-ME-Proxy-Cause: dmFkZTFar/bumr3ekzfQCuJe+qXi9E/M1hBlXD7LF7pTayPLMIOq2H00pU9aghJ1wo2D3H
    GAUQTWNFGeUOh5dDgywwn2i/kiHfEJ6USwdc6CURgA2ydReoaeimVxbzEsKZXShRUYfBU2
    CucX0K4SEYmXLxWyAabKjml7ZbWsIzpZL9sft/XYF5x/2hmjTllD33SOm7fQv3GQDVI8Et
    7qA5X96zdUm2lJKd56CJc9YKd+Ywoj7Vxz5mtX2ljMzN3erR5w7s4lac0QyAWx6NwSEQEc
    8Jz3md1ERa8LSiOXKUzWUwnpnKvw40rymZ4+/L7rW6A4NYjx3nbufUh7UqLjKODHIQITfy
    7LJ8ZsOs/LxTPfmSQq6AYIuduEdWtSPalWF9l4wosObLUVknYuXUOk/VDnzZSo/vUqTYg0
    bPVZie3ewe8u8W/N7KXlnZvANbujr7sbohqM3Fc8x/busacOPO+fKgctWkh5WMepHR6TIb
    nmVdWZ0ELX2EpgnPrHe4a0tOuwowqxdOSnv3ApTVdgU3hKtd52+96YgtCbqADhdDv5VJ/+
    XAXBjKUF01hskcVvNU3OUpe9s4aSZlmmp+L8uaYTRILK3uTI8yy4yepyyk8GhQvIo9aFWF
    nK5JKxw5UqOyXfS3ZfBp/rOdeMgTDNV+Q4NJk3bDMmT18R5jl+LFbXD0zNiA
X-ME-Proxy: <xmx:dl_VagZnPljr58mWVnPQ3i70XiIMVbmOBljzHma5RCBdg4J-RvK5jg>
    <xmx:dl_VamBxKVL-734ykSqMdiV_Sh7okrqwMw5PdNkHUZc05y1N4gh_LQ>
    <xmx:dl_Vag88ow0j5ELT8Pq-V2xCWrEz7c2ni2E9SAkK1ot-zDWa87pjxw>
    <xmx:dl_VaqQIUZ_JeHOuMBWn7UkLg9997k58tkQ-aosDAr6FVd1vA3NjcQ>
    <xmx:d1_VanyuNxG9WXY6AXbpnaUTSSHZZzh62mHu6MjVK-gyFS2ARxyHihce>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 20:08:20 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v4 0/5] Fix easy bits of the negative dentry problem
Date: Mon, 19 Oct 2026 11:00:38 +1100
Message-ID: <20261019000810.1837917-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For this v4 I decided to focus on just fsnotify, as that is where I've
received the most useful review, and that is where problem reports seem
to focus.

Other places that walk the ->d_children list (and don't already use
cond_resched()) are specific to just one file-system-type.  fsnotify can
affect (almost) any file-system.  So it is reasonable that it gets priority.

So here we just fix the refcount overflow, and the ->d_children walk for
fsnotify.

If/when this lands, I can suggest patches to various file-system maintainers.

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


 [PATCH v4 1/5] VFS: don't count references through ->d_parent
 [PATCH v4 2/5] fsnotify: update children flags only when adding mask
 [PATCH v4 3/5] fsnotify: don't hold i_lock while walking d_children
 [PATCH v4 4/5] Add d_for_each_positive_child family of iterators
 [PATCH v4 5/5] Use d_for_each_positive_child() in fsnotify.

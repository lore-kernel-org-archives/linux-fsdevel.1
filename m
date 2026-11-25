Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578367;
	b=EcBt7hsmUhyXv6BJpYerladLRsRSJjYewYU1BHqlhN/TQJzXDhmy+6vIphJljFIsgile
	 mNsI/VY4v9jvKojGy+IQ1Er/TNACVYVgkvy96rUG1Mt8nD/N83LKVB8I8t4q2WnIdk6ZH
	 TWkFrg3HmnLIxRdCG0Hevp5vfFkz2cjixwesJE1o3fRvCoO9/MG8Vtm5gqM74nUiYm9qq
	 k/nUAjkfeqC5Kjs4KKh+ZFgDuEfRham2pRuxtY2Fl2DHYrkdep7bTPX1KmlWZACU9+RZ7
	 ZuE0zFC79CznWvpxNEty6QVjKZBc/a2DyNw/8Z2gx4nvokjpERsHdrL/gW7MzZxcOYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578367;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=vhC5fsQg8d45Bifcf6O71h8hSOeLuwv1nI5aMDxT/f8=;
	b=mA27QDg/zpqoTYvkdSzERoWg3s1zVGotAkkCjRLae9jtqy/2hfo5fhGVWM7LYsePxkOc
	 v3ehPH35lj77tdu54l5u3IVQTg8Qy0MjMP986JEbjKE71X+KodR6cCsM71tqswTwpFZJT
	 yt9W1qR6ECubv1MZ22qWAHtp6WAgkQVp4IfzV3I/lsgXxE7fBUwgT7gIpZzDEJx//ic0w
	 Q0ywbLz1qSdYc6bEbomZsJ5PueEfVpAHoPsmDFgnVcH3kN0WmdfUQwY71pOlqLpwAejBb
	 WlCcW+FgQirbY2894t4ZuyNnNdCLgyqt83N99GYtM8Sy3Wh8pVeFf29tWdTpSqC0aNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b="Q1+wqOY/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SsYA5V8Y;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB7606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81AB7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=Q1+wqOY/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SsYA5V8Y
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B008D1400369
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:46:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 22:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578365;
	 x=1795664765; bh=vhC5fsQg8d45Bifcf6O71h8hSOeLuwv1nI5aMDxT/f8=; b=
	Q1+wqOY/nixv5edzYOqKmcnUuP0LQYY5P2oH1IwVEVjB0LRZuaVpoCrDw/OPtutm
	ESy9zcxe0ge0hIwSKCUH6d3riwFqN8cot44v6uaAlAtso3AnoUjCou+litdH/BEw
	T3uVRgHIn21e38FacsiolNx24xDyXkHVUPXVRd9eU7aNG7gajqBbPOflb3zY80t4
	aN5dpPwTEIFJLsejLj//9IAobyuTXpgOROeT8Ud2jlFPEdxtOeFgT05Yzrf+qI8g
	FOGuKIeQX/MEuTiFO6gJUXUUMMaqf0ZiRQnB2D15v5+SfpnOXpZLS1DYneMRDBP/
	ey4XudtplRoz5QpCBUOS8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578365; x=1795664765; bh=v
	hC5fsQg8d45Bifcf6O71h8hSOeLuwv1nI5aMDxT/f8=; b=SsYA5V8YoHMoCQkdG
	8aamsWHTJtXdx0K7dWFdeAdaTbCl6P2w78mlWckosu+QNT3pifuSD3rR4blfp3Wf
	60u9O2HdB3k8MbDAvVT/ghmgUFOgh4DqvTX04/nM8XAPxenJE5xyv0OTs/kc3dR+
	Gzll4uvsFANInENFbp7u4mRaCCYBq5AlsnbS72+b3/HuuABWNDI/Iqre3QEnks3w
	Ku89dr1wHL7ler7eXJvWV7S8urcSIuiCv5NRdUbRqKJMWWLTMu0EVSlOvnQfaOW6
	svwPhlbH7fBk4M8DOgkSHDBFaeQflhHNRjH90edd8CJkhcdQc8s8hToj7BW59fl9
	cFtdQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578365; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:Xm4P5dcNFhclkTe2cO1NdfJB9NKHD42b8aSrFWpbIZQ4v2+
	OCXHQo64ao99yVKq037ll7j9Kh4S+QnTMa4PzdCm1Yw4eNWDIWpmE8XJG6kSQi0q
	6nwxg6Z+5KkAV6aM7oT9Q5XOSnNi6N4X6T2uycdx0Q1k2cz8Xi2F+3RxTxcmcvLM
	NsS4HMPuJI/u1ivzbocOAP+ToPgTKokUOLJa2OawtFdaxmARw9ilXPSfgyx82kIl
	lEfDYIaFHG0oYoR2IqcMJpNb5X0mrHzqj+jQoE2ny/mqHCHK22/ejaXXjDD0LtSa
	BQ+xgbT/cPtAYIqcCByoHAA74mhcEZwGujjrHSw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:aczLsbyhzVPdHm5hCYK/zgEeHJCzlj6C0j/IjR6R0rg=:m48h43R0vdMJ5ex7CmVr71oScc25CmsJQRrS0xAhUYk=;
X-ME-Sender: <xms:_VkGa3XNZsA8sjsM7inap5z3ze_gk-PSa5yKma-bKWaAs3VMZbDWEg>
    <xme:_VkGa2j2Gzt8zihI0AVaxToN6vnGmUYtkc8PTqd26uLIr1KsSeYOwpzTRKgfqeppd
    ak9fyDXyY2hsJy5YXVUoFLUAZTCWrMHsbyaTJjtzmT_9uPbPw>
X-ME-Received: <xmr:_VkGa4esGFR6IpgSNmR-vc-hw1fFRJHcjHY0AJheq5JYp3hUFWpep130K0fwKap3lMYYBK8OuoLvptp69g2A66DMkAyJNjo>
X-ME-Proxy-Cause: dmFkZTEynqFP7J5CyP864zJ/XBXUDXSwXypje4KQHx8Td74dpnR0VUtokV1VIo6Vx6RvWY
    OwcUpg/bo5jA9DF1nhHbEWSmkeBRQExzYYNm6zYQ4OlhmT8++hv04QLhCP77UTRa+ts0Zn
    emG1u4CBc9EwIQZMHpuGtkFzNaPM0COhHCVGi+vUdiGKTo3oTFKBSdfX5nxIKQZvHQpAoR
    JpPaJpl8D3VaaEmf1HZfBeZUeFh1WggTkTCrotD4I8diURcXOaSBUF/YM1mWjxdOr0yho5
    GSRzb/bSajGZoPtTNw69mn1JgOv5z8FPk55EPMBJOvn4tHIN4QhGRcsvm9DrK4aqK7Nvow
    DrAExY6fCjhjyduW1b4R0elDpafecHvbKjpUrCh0g0ItLBmPYbvPVjZ/0n7RGqaufRYwrH
    oTSs5dtRdzGKtq6JegF8loWZ5jMeBZcnt1u2yAFRE34iK4JTdIxD3wpXap0Pi6CZpqpYrl
    J2l1iDMDe22XNIIOuy/yIvICSj4dxDrehZMImxgpFhk36FFRsuJmVXQGwxf/2ZAWiBD911
    tB+KuUcOhG4fpwyB6fJlQ8zNl077zwWva407aPXe+syOf1bUYH/05vX6jKExKB13eEh+iz
    iqjfHEYoRTcScfABjAYp0KUcH/Y2eCddrCymhmPviXcxj5BTJE4BC8ABVfaw
X-ME-Proxy: <xmx:_VkGa5f3rDylbpUBvj7qwzcaxK8odyWGjEJMHBZ33C3C90-xLybVHg>
    <xmx:_VkGa8UJqofeOKYFFHnRbb7vy6hH7X4Q7x7KVenCgu57VNkJ2yVThQ>
    <xmx:_VkGa1f-mtyrbRqCl2H05BNF1imdZEP5lWLIUuqWKbLOnQ3vh0hSDg>
    <xmx:_VkGa4-9AEyb-EdOlbOq5lYxFwvKj_hbQajmw8lUnhylDF13jmuQ1w>
    <xmx:_VkGa0AUR5cuNet8qktnqnqBGQh723XJ7fitRDrJYocl03dPkz7OumyN>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:46:00 -0500 (EST)
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
Subject: [PATCH v3 01/11] coda: don't d_drop() early.
Date: Wed, 25 Nov 2026 14:16:39 +1100
Message-ID: <20261125034543.4084039-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
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

From: NeilBrown <neil@brown.name>

Proposed locking changes will mean that calling d_drop() could
effectively unlock the name allowing a parallel lookup to proceed.
For this reason it should only be called *after* the attempt to create a
symlink (in this case) has completed (whether successfully or not).

So move the d_drop() to after the venus_symlink() call.

Doing this also means that if the upcall that handles venus_symlink()
happens to look up the name being created, it will get -ENOENT rather
then a possible deadlock.

Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/coda/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index a85be5962e62..b47299527b65 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -249,13 +249,13 @@ static int coda_symlink(const struct mnt_idmap *idmap,
 	if (symlen > CODA_MAXPATHLEN)
 		return -ENAMETOOLONG;
 
+	error = venus_symlink(dir_inode->i_sb, coda_i2f(dir_inode), name, len,
+			      symname, symlen);
 	/*
-	 * This entry is now negative. Since we do not create
+	 * This entry is still negative. Since we did not create
 	 * an inode for the entry we have to drop it.
 	 */
 	d_drop(de);
-	error = venus_symlink(dir_inode->i_sb, coda_i2f(dir_inode), name, len,
-			      symname, symlen);
 
 	/* mtime is no good anymore */
 	if (!error)

base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
-- 
2.50.0.107.gf914562f5916.dirty


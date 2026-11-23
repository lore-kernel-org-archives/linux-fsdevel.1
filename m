Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472089;
	b=4eTj0MxINl74xQvSnE6DiB+bSoe8NIIKIrubqotjiMjvbAHWNZB5kbh4vgowtYR2kgqQ
	 ZUypj+aj90qu03NWNln/z88W8HKiMD9zwcQ0gMlh5abOCj3MoTnX4n6UOEmjirQlklCOq
	 bJYhpLqX/zBKmkKbOjzOjah5xgYOfiPwEBR9bwrReJfPkKDUt4oH6yt8UuyjhMRNa+mRP
	 fOpobOdMPpS5YSeD1a9jAcW5VW57uxloRvFWEI8xvZN+AhEOiRnGJoKG9AWL/uVIvcndE
	 n+EV0/n7npWr/P1L/jzKoX37FfWv69PpWyJSbyQX9JPxbsmXjuawWzdniJZQq3WAMKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472089;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=KbjHZOXe3yXd2LuwCz1TJaWB6CC3H3w5sW7AffeKu8U=;
	b=O6ANczMTMgjSuUmqm6yhPLz1k1Nnw3RC2rCpM4wrijwNT4/uAazpKFpFgwfrbsJ+5rMb
	 AOGnO4xVfdyAv1tlIgmq39Mgr9SnpfM2sXym0roSdS3rzmv64qnyuai9Rq4Oig69JpUx0
	 omnPC4IuHc9+eUxbLt8pSTWYgThjenoSG4g7Ftm2yiuQCszemAS/+DxSn24sn9WvgCuL8
	 +6l5E0mCKmYwaBU1muvcCLgvfxH1eVhqkauVGL6Oay0SIlt4GMBI2HX9gdqTkGQOwSj+W
	 PiXevJftAHy68BnpRJa2Xnz/I+e4HvbcMAF1oNWwif7e8isqhI+GBgRCavIgP/NXP8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=rBcb1oEZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rYIC+TU6;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F264606A335
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 22:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F264606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=rBcb1oEZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rYIC+TU6
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 852511400399
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 17:14:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Nov 2026 17:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795472088;
	 x=1795558488; bh=KbjHZOXe3yXd2LuwCz1TJaWB6CC3H3w5sW7AffeKu8U=; b=
	rBcb1oEZWz91QRYy7c5LiKzI+oPt6ONSIPCyF9ci7vWN14ugohXGauXa42IiqDvP
	TpxDuN99lb4TEsQRSalaM4xJUosR+jVYCAFa6fCEiqE9hAooXvvQhcVB+w1JnL9v
	K26KC7Hbaou/Id7ni4ZaVhqPY1H0/pyfm0PRxq8FVmFG+I6Weywaoz6dB9PRODlV
	9Zx6B3Ph6iurBYo0oNo+SuVdP4GFKvpgyZT7eQw9yMnMrpbd1yOSy8VmgJToMkiy
	weKJT/VCCGCQwpHhLFzUTb5vo9H/E+VV8cZl61byT7CWrjCTGl7mkgEO4OF1uxlM
	7DJpVQ0oJk4R/3HDAUjdBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795472088; x=1795558488; bh=K
	bjHZOXe3yXd2LuwCz1TJaWB6CC3H3w5sW7AffeKu8U=; b=rYIC+TU6nQyr4gUqM
	epJwHoZBqLabHRM6FiEhK/3BxRm50d6BAwnu36z05NrUBPIU1H18/L6OGNlGg5I7
	EpSbBJdx1GstYw75Jql5zxUOMhmu9Vmwk7FCPHQ7cvLkYtYXmHG4Wr3KSZl3UedL
	3NvdS8xjJzElZTxVeyqei1Pcfn80C+BS7Kp50qalaUYgc65OBBWDQw5O3I52v548
	afA3MECc3ttZ+RILp6rLUJnqZ3R4tmkJNub/MccBOO9llxwdGCkY0MYBeyTh3sV6
	M2yAoqxrby3upoKffTkmCbLmIwPQkQdrVlpI5eSusjGKs9nSDZ3kIQHxWgmfUxAK
	xz3yQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795472088; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:kCWQZMYXGJqGShaRMc8qC2L/EKlF0hmZVV6K+/6g8eF3EU4
	EU4I+5fc41nzgvo76M7fQ+fPiFHtm8qY1HCvCztn2kxvgH88k/bFaL4Zj/7fKePR
	Hkz0WEjsT92rpBCa5bRNuikb2rAIhNMYjyCzaYfDGTIrCxSkTroZnqM3iBFyVE8F
	NK4GbhCbLKyu9Dc24McrHzaHQH9QWFKZ7gZ3Iuy49FLTL0iqzgzNzZtlbTNYxFTe
	r4aYIAzjGidOc97ikfQViVvl9ubqz2hMtd+2USCLbWPo3jtWdIGmWEvi7P6uPcaP
	Js2WeiVEaX7XEQPKgknfPqFH9/ysFsDb66rNCUw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:FQ9obqB+K5EbxQw/K76++yhJPSNXFzebpaQl1r00XeE=:tcIhJLiDBUg7Vjy/oxda7VGLQUDMtE8Z2KCmsrQOvAs=;
X-ME-Sender: <xms:2LoEa9DZS-Go0HbuzuAlbjY_DphI9pcjz7fIfF6KF_-_t7u0xEFFpQ>
    <xme:2LoEa-F9cHEMsyQOR9cTdoWPqeTPGZ_-gIYDwbv3oY_Fq6Q05zDepjPmPby53b-IU
    frzE1mJVMdxC4DD7JSWugeIjqKsQo70OMlsHq1N6yuhyu5X308>
X-ME-Received: <xmr:2LoEa8OThw6gbi8M4LRygugZ1R8YqN7UsXSIzGWsC5m9Wn1hvpv3N4Wv29t-PFPuabvGBV0UKDvXTivX-U4essB7UnxubU8>
X-ME-Proxy-Cause: dmFkZTGSrzHLt33vKnAHn3Ybchv3RTKfua9NKPbKl/dUyOKLaWqu1JjoQv5NVF/yPmt0at
    It15dWP0hQsNz4P/x5JK3UeNAxHX5xhNimMVOLQ5NCIKneYiyamMgZn6NPrLMajw90ckuS
    DjjAMJu6WIRSLPC0ns7Bj5tXpDbKyV7FWkna65t92lhYONX30OnD+NTvI2VmhYcln9Fb6Z
    hmc4KMKtacQ6FKbF9Lo5bQGGfImajaZ3nGjcGHqqxKf/r0Ya3VIjxiQMcPDEv2MAfKeHDu
    dr/UMwp34MQgBUNH5nhv2EDLsdWZejYYZOlxmPTCg7YBMDLgOawm+1lk39GzPd9oKg+Fpw
    9wzFEEYW91b8nGl0lAK7ElSHofj9nD7iGZrJrpZnk0isUPDrI0IGBOo+laoiHOBRpsSDpX
    VzrImdMkXEa9tipl539AgP3SQUH760NAn4vy9BhIwjLrCWIGaqTtpfkoCHC7eLIYRMwV/d
    qT8sT0C/9OV/CRlDu/sg+oTxQQRsHvOoRPgsspbOMFQWKUV9XX0ykILYrEu3TU/hb20Lqe
    XKnA1ZGVubCYwfDcXngR0ZehaU6yfZsJ/hHkZX4rlde/xhjpzPUV+3MZ+J5uAwClQefjv2
    L31/3GIVYpimhIrzOczSRHpbykegmCKgVE2rQE3sE6UQRXu9slHQzg6Si1CQ
X-ME-Proxy: <xmx:2LoEa37Ry12Ege8w9g5d75xumvRPBnu3XfKh-tAXeAKaPFgb2wADWA>
    <xmx:2LoEa3iWp_PI_XohGLumwqCUWlSOdpbErm7xan5BnOW4hM5ZTJuwSw>
    <xmx:2LoEa0eXzCc9a4slHAsMnkYJft8hyFFI77ehXu-w_6DYW4u7c7gQXg>
    <xmx:2LoEa3wvgZJ3zkEGSD8B0BK8gRROOOxRqD6dOc7pxCFjLJfQFNsKhw>
    <xmx:2LoEa9TH83Cfk3HgGST_3M2BNaup-0U8crzyHbJZMEf-FfD_6r4PNk7z>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 17:14:45 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v6 5/5] Use d_for_each_positive_child() in fsnotify.
Date: Tue, 24 Nov 2026 09:12:42 +1100
Message-ID: <20261123221410.3328780-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261123221410.3328780-1-neilb@ownmail.net>
References: <20261123221410.3328780-1-neilb@ownmail.net>
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

fsnotify has been reported as source of soft-lockups when iterating a
long ->d_children list.  Change it to use d_for_each_positive_child()
which will call cond_resched() as needed to avoid soft-lockups.

Link https://lwn.net/Articles/1079407/
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/notify/fsnotify.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 58566e6b9679..33c5d10f78ba 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -86,16 +86,12 @@ void fsnotify_set_children_dentry_flags(struct inode *inode)
 	 * their d_flags to indicate parental interest (their parent is
 	 * the original inode)
 	 */
-	spin_lock(&alias->d_lock);
-	hlist_for_each_entry(child, &alias->d_children, d_sib) {
-		if (!child->d_inode)
-			continue;
 
+	d_for_each_positive_child(child, alias) {
 		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
 		child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
 		spin_unlock(&child->d_lock);
 	}
-	spin_unlock(&alias->d_lock);
 	dput(alias);
 }
 
-- 
2.50.0.107.gf914562f5916.dirty


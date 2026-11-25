Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565477;
	b=f4FD3+ShjYXXBDjzoNmtVT4BkAaWOG6xQJgsKVeWsvugX0TUKEUkebhh1ANlsSP8SqwR
	 ghhY+We5q1YxETfKZXUT7qgBRr3bxjRwiiG8uV/D5a8BoF7cBYLNTqMQfBa+x5373KCZx
	 1rk91oRmhwgH+DpTfz2fB4uVskQJ/oL0EG/O36PiztaneQS8wEW0vhCVNxWE8JW3KTEyt
	 0if/gKlFxpLRl7hBGgOxkXYSyDphTObiksImYGhgh6UORI2PHw07fEsQZ/9O/xMk6XY3w
	 oFXVFmIeixEmR7cskY8A9vcem8pIRVA28RiiP5YvIqtTtLZ/j9qyCtazVstvDPk7CWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565477;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=KbjHZOXe3yXd2LuwCz1TJaWB6CC3H3w5sW7AffeKu8U=;
	b=YCX7haEXzwh+tjnEF0Dqfa11ft4BNtF6+3W9maZFiTqLJqmgZgD0ujjqomsxrXhj9EzU
	 cOd6NlfdBqM93oY+XqwxfnqXA7tYhZDhT+uf8lVG0kzyRBgCjGjeMR6E+602yeahmyg6Y
	 U3thV5oh2m9vgT/KpmOPU+RRhsUBKiZ83hVp6iBg6+bZGeN/DBOT/gaWwdHUMTjI55n5a
	 J7ub6L7nf1O40F1nX1RknQceao/zsXkdy+65vRNIJCqAwlE16lAN67hML/vdrgwiO2Q3j
	 VAdQL2t+uFO+Rs5RBnJo5nn21pTmvbSpiH+b3g3o4ZPdxCKXSQRITfmWYwnkCJC4yQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=Pj0Tvhwv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1WsyIDMN;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1C606A32D
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 00:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B1C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=Pj0Tvhwv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1WsyIDMN
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id D2014EC09F3
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:11:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 24 Nov 2026 19:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795565475;
	 x=1795651875; bh=KbjHZOXe3yXd2LuwCz1TJaWB6CC3H3w5sW7AffeKu8U=; b=
	Pj0TvhwvQZOy82u8aP3+euA7keu3aomf7R8oRuDR/zAlUuyRikas64kZLf3j8iQd
	ewwb8EJDzbu38ZwmX35Gk8AXPY1bD4vh1dPndeaOSLS7hCwp/Oa8K58pYEHKkJNS
	pvMhuQ34PaId68yj36tFkouN2pD0D9eQ3TULG0645PLCv9TOvDS7fYeQGAOBKGVk
	pojcPc1NxNPmoh779uiPUN+Zs0wZXx1a176UmsQK8u4svYt9eyKSDfEvAUrzogtK
	Xew02at6ZMJyzmSGIxlIXcD9+JHjomUuu41PmdN9w9X/3ODLwfUGvXgCU3fq9SAE
	jmdxcArN+4NPE6V3io47lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795565475; x=1795651875; bh=K
	bjHZOXe3yXd2LuwCz1TJaWB6CC3H3w5sW7AffeKu8U=; b=1WsyIDMNlk5kPZb3o
	LYBPscth3dYHKiqDPwc9iTRpRpjokcwjCKdc6/3HuJ82Sw6MAhS0OaqEc1rHv5KZ
	N//Q+M1/MNwVZKGTU+0Oy4LxJO8pWJkXYFswmL0vt2mjeptL4R0J/Cc2csb7m6l2
	boyNdSCwyG+pGT4+JaycyTVzCES0jEVsmxnP/0/PIEITWIUYlw9S15otUc++c+gL
	+qkYFVclXov3knoy2YQLt/7d1zkCOom5d/iKAA4lKl3id+RraAUx8npirPUwjF7t
	dzfGiRc0t1f3AWgjc8WCTGG4sDDXfduKqIdZ5nDyjHGN6FktsR/TIkCfxzc77yXC
	cnUhQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795565475; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:s+aQCgzFZ6ws+jmG32O1ZA/7cVrNadO7lCdpS5l3wV60P2p
	2qy97I8diG6LNhYZa5UA/cPCsQhE7RN6VEy2P6Wy8K0TlyPNxfYiT/HPT9HL7m9a
	kyl6kjfhmueIXM8bLBUxR/vCLZyroSBt8TqMHi4mPTrdQi6TB33UgZ1JYYWr7TAO
	N7Ys6Vl/HQLHCd2C/ar4qH8sVPaIjkUehZksX7i51DeSpA0i4QTQuEdvbvyWviRS
	8IG1ukheuH+nV0ifQ8+9u4aMsZoSa02K3X1uf2H0EmaHuwY0QlK6Bs2tZ2Mlojl1
	EMaQpvqhj0d1fRRp7cuTXyilwKEWXH7+9+dd+Mw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:NWYMezOoetzPdSts5+4im5fr02moGmKyZS7tToDn920=:tcIhJLiDBUg7Vjy/oxda7VGLQUDMtE8Z2KCmsrQOvAs=;
X-ME-Sender: <xms:oycGa_ddqAiF8sHk4rkcxlg5BJGfPw0Bo2MI5dKitpnr-MjhB0l5cQ>
    <xme:oycGayHB7UzQu-ySKenS0vglpJx5nITDdVPsPGCP9kWp4TZ7THOuBHovALynEAsQz
    _mp6Zuhj4-OfG965lCYrnYRIZoe3bzebReVbyZuw1-AbztdJw>
X-ME-Received: <xmr:oycGa4SWtxK3A9iM6zBNZOa90qh3vfX330U4tc8PHev1rZIQ94_f3u_EhPDBp2zUDeZO8659AxEnoOMQQ4fv0md_f8SWFgU>
X-ME-Proxy-Cause: dmFkZTEWLT7VrCmqXFQ/3MlmFKwGsnI42jGU9wsAMLqZ91wz8mggV5m1msJjVSCHxeBUqJ
    t97+mptHMICXthawWKapABbbyhWq7+uuMmApmcH+Yba1WLWrkpVix7mPta4EAT8yMDamx0
    5loYd6jJqeFIrGsONkYYE6J9hbaumuKI+/Omki5Aa4Aq5KfhTiLPUl0BoveVjf5cOUWX5w
    4HMB7hKbpvsoA+vADp3tWal1VkBjpQ6AgmqI+ZRNztjqSQMs2MYuFzBsfnKESIRZVSoi1i
    NXRaNZOSkWUP3rzL/NZtKjvVOieVFii1RhBvtxr3qqxuVDS0tX4ZmqS3Hzxkk/+20l5gEf
    L9OyLHTHo+nOZk9IXVU/b0qIWnqDFqvY34fNs+XkAHPIEu8q/0QN6f1mjMC1ADmIGz1ZDT
    WeL+3prBKujD6Kd/i2ZVbHJqJLHgv480889t1GP+Yq/9jEiaVMz+tgPuEEPxu9DU2BBjsu
    PPA2A7z4rwy5VA1pNhr1MDCCONtm6KsKU02Nr0cmg7fE5Qt/D/UDCEEqjA5zimUklG1uNI
    EiFYZWITdnyPq0bJ4mo0mUy3tVsjVFUax+BqmmeUOdZe1MqitrjMHZ96yniqMnEDmecA17
    OX8E9zw8WkWnxPQL98wTuv5VqKPqjp8dLh2mDzpQ7n5k/irh6frmNKOsAWKA
X-ME-Proxy: <xmx:oycGawbelaThE3hG_LZL9IG-ENrM8KW_EdxO-0RTj1xTDfh1OJqIdA>
    <xmx:oycGa72icqyHwxkc92hJ7l5ojbjbFG7khPumm5StQdN9Njd5Fioqfg>
    <xmx:oycGa7oUSCDQHwMUAuE4zLgdMdFyjIKpIh-Y1C0qwyt8IONCGzu5KQ>
    <xmx:oycGayPWk2AQEzoMpwIaLKuZ7fe8D5HSoUQ7CjVbSM80OOl-H3QcTw>
    <xmx:oycGa5x9kp40FMeTUwad3JPlSzvzfZQ8x6rNdCyHkGVsiqWQslKPmgaH>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 19:11:13 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v7 5/5] Use d_for_each_positive_child() in fsnotify.
Date: Wed, 25 Nov 2026 11:03:42 +1100
Message-ID: <20261125000836.3984402-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125000836.3984402-1-neilb@ownmail.net>
References: <20261125000836.3984402-1-neilb@ownmail.net>
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


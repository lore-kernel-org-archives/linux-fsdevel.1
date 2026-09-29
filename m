Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4041E6B9;
	Tue, 29 Sep 2026 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652590; cv=none; b=PyCsOLa9EZNvQ1DR/eGSPbVuQZOTTehCW6FHujymXLH3gJGkDCG2vvif3JgsPtn5rYNsv1X0LcmqXuiKL1bl5rjbZ5tjOOQOqfHeiYulT9d3tbkx8PWibeV+hU1XVzEkZpiz6FMFQ75U2o1DQGWDfgRxKBgFN1y2tpMi1/pZqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652590; c=relaxed/simple;
	bh=EQ8fGc5LppRg+Iurni3Y4Lsj1lKpxBmuwurzzDKRrlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ov8bzIG143XBnZaswXKCNTstMqF8NIKFQ2Bb2Y3qVFU4I/5vYDcMnS9DHtSscOVwzjxOiBfX64HxW0ZZ4hJXkvni10bgxScRe2S7Q7wsa94kg7msTJOKPNdmk4mwh5Nl54Wp/B68pDZmrHkpfhSdyNqhX7+EDSESzqtCAZgq9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=liQ3tWv7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=laxXNgb0; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="liQ3tWv7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="laxXNgb0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9BA4B7A00BA;
	Mon, 28 Sep 2026 23:29:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 23:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790652588;
	 x=1790738988; bh=jUSRJySOKfIoNiSPbV/qCfdX1PjfHutdoJs3Lxmel8k=; b=
	liQ3tWv7txiLusbr4URinSvNzQS4oqnulDTTjwSH2eid+Na6sMlzz6P7BtYDSc04
	nCaV0dQax0oRRgsOkS+CEk+RYhUIlyZ4l1jOxCHh4570m0b/ipW0hIXy3NTQ9R9u
	ACdqnCPQn+7NeEITTlQHScISA/mek0ghOz1pyjOn5QxUoqM8GA/Ir4rv9sxI986/
	zxcTGENl2VIJhFO7hGIS9GdFefm7OiAPfPhyhp12WuB8joP7I2ADqNAVaFtpEEE5
	Bm46UO1/xGSWhCKHb8Kw8hZmYtIRFQR3v0we3uhrXK4Tk8ul2/cBD5273lgXONGs
	qzTOlJrmtGpNOhm1bwwH5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790652588; x=1790738988; bh=j
	USRJySOKfIoNiSPbV/qCfdX1PjfHutdoJs3Lxmel8k=; b=laxXNgb0sHwJpCj55
	jRWWJa3zqvnGMI5FxJPJBHBOmQN6PSMJHLBvhDjWXz+ElR457a7i/oHxKmWG0ZKT
	Gl/qcClXhdzAlb+k2SG7uVNSHYx3yA5hQujJk/7ZjlCkohLQub2KeCKEWE63xy+G
	FY0aeGrcpAuCaEvooxUut9GiMX3CT3YOWqBQhc3K22+FRhjp+k8mUX/va0JutT2T
	gCPZQZhMEp2OZIqItd3mxkt3i0XORbAlPJwOzIU5j5HFCNkddm9x8wT3T+FxRe2v
	Fgvy1IzMz6AoTMYcvua9YZx8wivlFmVC8PCRj84wcmTDU2WllgtCfH5axm+pKeZ7
	HCoOQ==
X-ME-Sender: <xms:rDC7aqSDGPXSvjwqOHP9gr9IwIeN075SMD8scmAAx3BCKMWUheO-Nw>
    <xme:rDC7aksacgJNzjvUpLP1u0mivnCr1l9MIk0BEzaWjZfN3CdkFs-njG5vlRODv-F26
    -nTZgDUqbqesd9aM1n9jW_14Ewh3GNaQRs0Qm1uJUxoAo_UkLYk>
X-ME-Received: <xmr:rDC7asHD2Fbl5EQuwC9kqmlb_AxswcB60zkwJsaKbmOjAk9silhxUjLSLHoowpvDOmHnLsfYPTsqHxplGYgBQ7lB4_kDwmM>
X-ME-Proxy-Cause: dmFkZTFj85xp6bLK+q7zY5LvEf0n2NtUow0VP2D+b+pxbXXAHePfaRLwkQCmGIoHNnnUU7
    XFZF/r1REEi95X1KcsQLYtxMFZmwq/KPz7uBc3KWLa6uoFYyPUDlje/SOhfoa6ewH1w8eT
    ziheSO585jMLS4z9M66AAVSHCLK2fdf1UcidnBLU1fyUN+VYr/DQbrVJ3YNYarCTeGR9nk
    Xdl/eTqCqBUCKAATrp+xGoHUD1XQLuMDbxWchpf3h6PqkS/2Z3ESZHYvfVv+yfzfZDDOcA
    poLwBeSX5N2ha2W2chvibHb/wQiSQ/Ol0pyNoXUB/4iunx0x6/alrS7Bjm1C1X3PKlP4jZ
    66riFIxEt3K9tNy6ItRkmKnDyl4p4niAoYly5XQcvN//ZiFxsDVrG5draLpSaZjXeTy/ad
    6sKp1dhDUvRd3gDqzSJ8g5HupIzaCc7dzlOaeLHWQqsF1aZPfvnwAZ9XNBXFRAN+W8gW5U
    lE1StJ9YryhyUBNpVdRsmshbJOUHi47zj9pSRE0mvVgVlpUQFgwg0M/oJLCD7oaNM7j8lF
    w8Cv0bKZ7DXF8XSZR9GjbiVBzL1gtPvkKE+VPVwNt0HUJHGvzdUHdnX1+3UgSOZcKJf6Bk
    yiCDZgpZEpKy+BRHP0Y0sjIzkUwCoJe2jihTCAup82M7L3iOi2DbHcUFYo8A
X-ME-Proxy: <xmx:rDC7alx1uJ-gxzBEMvmvL0LdAXRoKWSFU9Ns7zCn3WUOZUgBasQRcg>
    <xmx:rDC7am2c0XytJGfBUa3zAcngKTNCUysp26EGvDnxtVDzaPIWv6UtdA>
    <xmx:rDC7alpvEapqhxxVCBa9vFwWRiXJTyh7sG4816LmMJxPeTVThjzmig>
    <xmx:rDC7ajV-FTrbcMQK9TGrVrSxCI106w-Ic5xFuOVT1sh3NhGL5cwbrg>
    <xmx:rDC7aq5ROnR6IxbE8gS9_r80DrHLRw9_rFFwfjT9ngMCJLaDcDQVqcCG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 23:29:45 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fuse: don't d_drop() before d_splice_alias()
Date: Tue, 29 Sep 2026 13:26:15 +1000
Message-ID: <20260929032927.1451259-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929032927.1451259-1-neilb@ownmail.net>
References: <20260929032927.1451259-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

create_new_entry() is used to finalise the creation of various
objects (mknod, mkdir, symlink etc).

It currently uses d_drop() which will be a problem for a proposed
new locking scheme.

d_splice_alias() now works on hashed dentries so the d_drop() isn't
needed.  Drop it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/fuse/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e49b4e874b15..519b4f85618c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1031,7 +1031,6 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 	}
 	kfree(forget);
 
-	d_drop(entry);
 	d = d_splice_alias(inode, entry);
 	if (IS_ERR(d))
 		return d;

base-commit: 3879f51857325da9bf3cfb073280257cd16ae067
-- 
2.50.0.107.gf914562f5916.dirty


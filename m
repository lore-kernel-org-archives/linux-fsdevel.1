Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3FD3C5540
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004982; cv=none; b=Pzb0P1S+Rf6mRs3lehPR7JePvpeu7gNYYL2x+EWFeQGjiItcB407EIj0UtUJPtaCU5EZBbBKCSeoqT1BJCtJJ+BPBZPT+h9RPwp4UbRoieAlBf5sfAw3klRDgL/1o8/TGkidk/mXEL+beaDziE9Xqfx7syCQuzcxsxCFFWqXzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004982; c=relaxed/simple;
	bh=fhURrlvPMXLSIw16pLxHLerXAVLdXSPhNl4GlPyZdjY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=C4vaDemBmjXlSz8Rxf+898mhqakzJmvsB3SVCsgw8TMu6wpyg7xEwxWmciBjR3XLqEPFtw9/B7wojQsUGIBRRzDpn+gqTZsNDK1jiUFVlMHiDl0RKUT5/hUfD4ERq/kZwegtGSCryjT+8ouhwfCXvGjckMmfPRMwRcISIjClYhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=H/+TUDXI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h41ZuoUE; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="H/+TUDXI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h41ZuoUE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 267587A009A;
	Tue,  5 May 2026 14:16:20 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 05 May 2026 14:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1778004979; x=1778091379; bh=Hp
	PHvYdSwEnT29CVBNW5B3pwf4Xqk0Sr578QklFGbxU=; b=H/+TUDXIw90th9etoA
	1a0cQAJu+p6gwvjN2lUHbSTwQWU1bpG2dBNLUjUVwM6PmwJ2DXiK8qfKQeI8PieU
	EpcttKunVjBZd8CIlPf+avEeErkBWgY68nUvch2YLApU6BD5XQLG8k5x6KY5rtds
	L57PKqngIccxRhYNPCQfLI++TilIE1A13/7cDJeEBa3Fmrb6TOkmpqm+GllZpS27
	Gp2gJSjoDAH6PPlrWRE1sMCB2Dbe6L/KxL1CRsnQQrbIvbbdXckltdba7ed2/Rb3
	tqfyhEm3zMm0L8uCjbAY2Eert8j96pUJ7/Osv3qSTnRUWN1uyUWxrAOrAGOyhq6/
	m7gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1778004979; x=1778091379; bh=HpPHvYdSwEnT29CVBNW5B3pwf4Xq
	k0Sr578QklFGbxU=; b=h41ZuoUE7vGGoY8JlyF+hpBJU7OXUTvTOeuE2pAFKT5v
	yvfaIlG15aseUgZRED69wk0IEFTNkhSaRK/9STtBgVyuf0KzcnSLDDK9RYMzoq6h
	akCemOpjpQC2SK7VV+pvIl4msCYutzWMcfwtMl57k2SZQiMlSHu0Sma9syhpubap
	vMYAs1tW4m0j/SSPDhaKxLv0rv30bHkIGRMemzzt3yQzheeL1i8ObsZEi9ds+nuS
	CEJnxMJT2OP/pHeSHRBd2ZBIOEX5E0gd1If+onIAVZZ/4RiJrxFICV+vHTPpIcbG
	0wwf6R90hMxQ0xj3N4qpaMkFZ3aZ8okYUtSbZR3l3Q==
X-ME-Sender: <xms:8jP6aVHVwRUIWdKDH9hgptNIy81SR5NhOpXSUFz_tFw3kFmC0OY_7g>
    <xme:8jP6aVJtaSkbGsPsKlIPU0EuYPgRZbkSzzMQz_oeaUDsDlntrkpVB_N59Vp5wCkLn
    vfN14EtDHhczzuJLb9eHe17U2DQ_Z_mecHqj9FT6fR5Ksme3bs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkffutgfgsehtjeertdertddtnecuhfhrohhmpedfveholhhinhcu
    hggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelfeejkefggfejfeejvedtveeglefgtdffieekgfetjeejveegfeevffek
    gfetudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdho
    rhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    grmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopegvsghighhgvghrshes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehfshhvvghrihhthieslhhishhtshdrlhhinhhugidruggvvhdprhgt
    phhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8jP6aTlGZlsqoMAmvEveuD06N2WfBpsBVaEwGeF6pMv8fLadl893kA>
    <xmx:8jP6aRw7X4c93dfF50Qn0t15s8PFCbdKdpWvMp5X_c2urkcrw1D88w>
    <xmx:8jP6aYrJfwbTbDC0KKYHfW85k2y-mt_gqsVUkHXv9R6pFb4iyx9kjw>
    <xmx:8jP6aQ7QgAltccUrVvimIvQox95d7fvOb1Z4huIJ63lkAdRsS9dEJA>
    <xmx:8zP6accTm9kmV7LRdEMcS4PnLSXRh4_cmcNJ9fjSy0bV40VR95pXSB5r>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B4CBB780070; Tue,  5 May 2026 14:16:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 05 May 2026 14:15:58 -0400
From: "Colin Walters" <walters@verbum.org>
To: fsverity@lists.linux.dev,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc: "Eric Biggers" <ebiggers@google.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Amir Goldstein" <amir73il@gmail.com>,
 "Christoph Hellwig" <hch@infradead.org>
Message-Id: <6630d44f-967d-41f0-81ce-6958b371465a@app.fastmail.com>
Subject: [PATCH] ovl: fix verity lazy-load guard broken by fsverity_active() semantic
 change
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Commit f77f281b6118 ("fsverity: use a hashtable to find the fsverity_info")
that broke `ovl_ensure_verity_loaded` in the case when the inode was not in core.

The APIs here are in my opinion now confusing, but this patch intentionally
aims for a minimized fix by using `fsverity_get_info()` which ensures
the hash table is loaded.

Fixes: f77f281b6118 ("fsverity: use a hashtable to find the fsverity_info")
Cc: stable@vger.kernel.org
Link: https://github.com/bootc-dev/bootc/issues/2174
Signed-off-by: Colin Walters <walters@verbum.org>
---
 fs/overlayfs/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 7b86a6bac644..bfdf9310ee78 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1354,7 +1354,7 @@ int ovl_ensure_verity_loaded(const struct path *datapath)
 	struct inode *inode = d_inode(datapath->dentry);
 	struct file *filp;
 
-	if (!fsverity_active(inode) && IS_VERITY(inode)) {
+	if (IS_VERITY(inode) && !fsverity_get_info(inode)) {
 		/*
 		 * If this inode was not yet opened, the verity info hasn't been
 		 * loaded yet, so we need to do that here to force it into memory.
-- 
2.52.0


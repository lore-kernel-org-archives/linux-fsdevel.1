Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C36345CCD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948708; cv=none; b=N8aDhJV2Tr1bsZGTyepPnSLTrkAMCkuDOTOPIRQQjvz0iYbhKbEeR+Hbt75ulTS7pyhPmGCO6S1JP8KDRMyjZJvYt+6fYvgtB0azHMpYniSyoD8yqEHptreB44gdhVklqsHGg20KcfAX0UjBarQtJ6jcPJlIgb1dNC1Q4ueWr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948708; c=relaxed/simple;
	bh=SXHdQY+wsd6NtR0c9O8gL4IyIkluAex6RJYOc4Zzy44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OeZCBk6BGQUG8ZAANVHttPAdnvic1ixEe4+T3/WXIFuI5mv8WVrfZHgBjVbzRYAXrM3f+O1PubRJKwM/WukqSdqSbJMXqw+bYqe8Y5IlYCZTlng1U1zBQ4RAsubtBz8AYukRuC9URe84nYaahe1z8xIPXRPweJ8oZP6GHRYfXTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=W3HuyTAL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KicvaLiz; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="W3HuyTAL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KicvaLiz"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45E0A7A0105;
	Wed,  1 Jul 2026 19:31:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 01 Jul 2026 19:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1782948706; x=1783035106; bh=/e9i+ev0uy
	Q/unglBKSC6+PiYJ8NeoGwMi3DsBu/1dA=; b=W3HuyTALT4BtjqJmqa/Og5WYLS
	qFpwiGkRZ4bHCaV4/HLHD2eqvZ8EHOWJ9WnPxlk8wvPzmR0ZVOn8tzTbUXVcRFGa
	B2uABVFP/geIdsBs5xGhtCfTUZh7wn+/LCv7LKr9W/L73JkLjfI98TNRQX3NCzKF
	+ORSjIaiGsOToZh2WXnAF1yw1e1O5F3Ou/YLBnMZ5lw1i026OLOmd+8f2filSK1O
	pjoHVI3G7g8U10ADGDk6KyF/HGNFr0rD7mMVMJkNq46Ts+AGznHhwsmZk4Mlg7d4
	MEVFn50dbH9HnB4lK2tQerUj2EOigFyZd3oS5opEt/ozvOmTgGJxcJssxHhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782948706; x=1783035106; bh=/e9i+ev0uyQ/unglBKSC6+PiYJ8N
	eoGwMi3DsBu/1dA=; b=KicvaLizBhD+s25kjkdg6sFg12hXj9eTjdkWHVgw7cm5
	mGVdVgXL25+knSprFjNHEfDBuWxVyq1yP1UyKAJuF9JgKe9XloE8HjyjnxFDBuEi
	Bk5lImJUVSqe/kx+IUseFsMUj1V2t2Kkz+Tf022NfbsPYo70BFxBSmerAaIrL/NF
	dF3Oy91NcKemlKhwzuywsJY9bu5Ls5Vhg2FHfnNR4DQVTMpsonQ0k7jO1wDPyTNf
	dSs2/I/Ljh2bhDQJ8RhbkT6jAAEgPKUsLbFflL30w+ErO4P05LTOuoHPsUFZ4KQB
	MLwWKPfT9FqS6iI20dAjUjynlcFc8E8IBPhGAm9SJg==
X-ME-Sender: <xms:YaNFavGw6CxjRlYy5hPOP-EjKpnf3Ls3C5qGnDMkfmz-9NMN_58CCA>
    <xme:YaNFanwqzpjinwOyQU5bwHCZ4eIADlOBr0ubcOGNIzp3nutWUSzQKoXr8_NLrqNi7
    NlJB_lob4UHho98b58qJ3uj0AK1xJ2Tpo1nRsVwXnNaQgeR>
X-ME-Received: <xmr:YaNFakqSLoQMIrUOJv6bH6Il0NvslusLzS3m0bUkXkyvw0tD4YZSknjs5h2YKw_1aj7L_yVRjUgDMo_k-myY4mHsd57BWDk>
X-ME-Proxy-Cause: dmFkZTG2UIYg57Od8vSyJDs6DsOnb1HcXqplGH9PBC1604l4cNZRAZcwOzboTL8pRH3Aqb
    k+N7esO3urbe88idFFcXLWY03AGWW1ZLQgKz4hDLs6o8Y6DWPwPWDvN54T6ejDo3M+XWG5
    i+51kL/VaADzyBI46ek4fDLPr/mOaaMz59Uo8+SvNbo+mjEBmBLRjqSbNrtb7Sh4zh6F8j
    zb482aJfX+b25L1LciNvq4Rh9m7/N0aOdhyZiiBxSbV6w5Q0N/WxnpwiPq54NE+ycgIYmB
    PydlM1Y7OSx24HjoYAYd6kXmddh0DN/r4CKx61AOuRY+zveKf8Ec+uiGH1tuMGqUiXHdqq
    y7j9JepH1Kg35sZPFuZxCFlnRoQkgBDaKs28aCz8UUg/hLtl8T7N4TbYehWGyfLp4c1mDd
    tDGL0O+Sic3zgDT6RPTfl0wogmH/5CnZ6LjhE5W1vY+lFZ7TtHbmrpZ0bGOqFt2Oj4K4JP
    twVV/+T8RrP318JUTvapd5nr/gqALkIgtD0ZPTUPEc+no2/xyjE3Z92io1O+ooaZXQx1i2
    kJO/77Zb9mwtrFPjZgobKWpvnlQ9j/VzscK8g4r4FOCUGK4mUryM+hFij18tatceiTQ7P1
    CUkuCNfxg/p5OwWGL8bgIzG3OCJm+tOVs5F75HCDP5xxQGDx7EYXc6hMGhPA
X-ME-Proxy: <xmx:YaNFahisp0LjQU8coRj9BBd7CoIV-v5LOUKAD0xcL4EUSMs_qxiRHQ>
    <xmx:YaNFahhpNB_eaooLsqwp--qRJBfywMmmRZknkGLmhZ5R3DhcLuXjlQ>
    <xmx:YaNFanh5fZcQJe_3MsHoKo9th2GclNAe9xNFCD1PFAy7FqHBnKhJjw>
    <xmx:YaNFahJFRHtkaGcu6T4e0ma1k8iQQjmgzyGfsF4-B9fsH-5trA3Ldg>
    <xmx:YqNFat26AzKPYAJUeeY8xj_eYG6kqDKFtPP8AltcxjqYrcLehiSw_FNs>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 19:31:44 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: VFS: prepare for changes to directory locking
Date: Thu,  2 Jul 2026 09:29:00 +1000
Message-ID: <20260701233128.3356519-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches are part of some prep work to allow changes to directory
locking.
The short term goal is to invert the locking order between d_alloc_parallel() 
and inode_lock() so that d_alloc_parallel() can (only) be called without
holding inode_lock().  This particularly requires filesystems not to use 
d_drop() in the middle of an operation, which particularly requires the d_splice_alias()
change.

As it will require d_alloc_parallel() to NOT be called under the inode
lock, d_alloc_trylock() is added which CAN be used when failure is safe
(dcache priming in readdir).

I have other related patches which make changes to lookup_open() and
related code but I think it best to wait for the O_CREAT|O_DIRECTORY
patches to land first (unless it is decided that they won't land).

If these patches can land in a stable branch, I can start making changes
to various filesystems which depend on these.

Thanks,
NeilBrown

 [PATCH 1/4] VFS: fix various typos in documentation for
 [PATCH 2/4] VFS: enhance d_splice_alias() to handle in-lookup
 [PATCH 3/4] VFS: introduce d_alloc_trylock()
 [PATCH 4/4] VFS: add d_duplicate()

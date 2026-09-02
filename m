Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321749B1E0;
	Wed,  2 Sep 2026 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360084; cv=none; b=X1MOavwnIZXmtZsZGyjyvGmh2sC2vohDdnAjUh86XBzNpRyyyZL9fdeYIp53k1ZD13OVB2pBzNXqL00Unr707Am6LjW1Ezs0V5BSuDaT+HGryLOkol7xhx7hhBrG8JrgEZTmvqK/yCRmNUl+TScok4WNR17D25j4QnuA/fKxxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360084; c=relaxed/simple;
	bh=naGuGi1Iw5Kk7J9nduxp/X02QYLaZGsFiMUuk5tN+8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZ0Ib304622iz/ke1abpuu7SRBSNbFE+qMk1NV9bgqnufVpU9Lw+ZK3MfixStOsKA3dRpxMQdymzOo7p/j/4wH4ChV7XKP+spsE1xLgK/6UJi39Z6oTxavzyySiztuyVdwO+swUbjVnNBBnBtqKNmx2RnGxUFn3YrLsknG8e4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Fqw8hv2A; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iovGKDVk; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Fqw8hv2A";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iovGKDVk"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hZlm05y6hzMlBB;
	Wed, 02 Sep 2026 16:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788360080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4enQh/HRN5i8ej4OSTmzFcG+vE6phZ74enUPad5j238=;
	b=Fqw8hv2Ao0Y5A+xcInh0xP5xiVRqCrlgE/F8FI0utG8+7BPjpp2VpqdmWKv/h/7w2GpzaX
	xa322Kxw0E7mpc/B1pGSCpkQtEmdZmpixLtydqKz7FhNFONzE6rCpwhY9RnojvQH3DrB4z
	HZatkzU6NqeoHB1XhH12YbSi6iXkP/FXCqhekKbJAyRHh/ykbmtwVHxhkmWDO8jUK/mm1C
	AYT4L4YgUFsx0Zq3OQxBlaxcWGYibSuY9klwxREPni7ply1FaZNRB9spuhOpoNnCgllnw8
	aqzebRFlIemfcJXMRiqe4EosGoTCw+Cz/pdU1ZkZtgq3y8aNrPrz/8XPqIVwSQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=iovGKDVk;
	spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788360079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4enQh/HRN5i8ej4OSTmzFcG+vE6phZ74enUPad5j238=;
	b=iovGKDVki+JnqDpcKXRTDvggE1fGau7uLL2Viz4jKRlXhqYb1aCOw+hTxJQYiUf0WNTvkp
	BjQjNbCD31VFqYmJrsY2JpIoLbsggO+e2+ZaYuAqbHJGP5bVnkj0OCtp2/OmfKrbDR8sEj
	MidFLJpXanL+MfaTcfZ3xyKibPeGC4gwiGYmayjIheBjUWl2+gsOQsp35FwC6w5Iuj0ltJ
	8SFPX5a3gjEJviXRinZKX+MXPuw4bSmh6hAOKdCIxi60X/FPMEwsi/VIx7RXz0tvmzkdT2
	fhjcvKZzI0tJdoBKPWyamUkdhzxEYhXBX7JN7yBH1kRZQqU6MgoIDQSRKgSM1w==
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: locking: Fix bracket
Date: Wed,  2 Sep 2026 16:39:38 +0200
Message-ID: <20260902143936.703665-4-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 50c532a2ac21d6ca7ec
X-MBO-RS-META: k6xm1ysjhyaxg4ron4ywibt1c4uihwua
X-Rspamd-Queue-Id: 4hZlm05y6hzMlBB

Remove needless '(' from code block.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
Should I also replace ')(' with ') (' as it is in the second code block?
It would improve readability in my opinion.
---
 Documentation/filesystems/locking.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 844d65eb4..1598cf555 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -27,7 +27,7 @@ prototypes::
 	int (*d_init)(struct dentry *);
 	void (*d_release)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
-	char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
+	char *(*d_dname)(struct dentry *dentry, char *buffer, int buflen);
 	struct vfsmount *(*d_automount)(struct path *path);
 	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
-- 
2.54.0


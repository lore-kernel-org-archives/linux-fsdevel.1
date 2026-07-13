Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BBD86334
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 06:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922926; cv=none; b=m6+JBWgEZJYtMucxtcsnqg4pa021RGmNLSz5ZPqtUd3mVcFL3lL9F2NkAUBjyZKm4ss5wE3qsJjB6wcxeii1YMqk7kcG/vjZIffNyKY+1iI1b+RjH4CVq/EgbJ6KwK6IkhG9+88n2Npu7Z0xKtew1jcpeJ/7VR6hN07Mog5GrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922926; c=relaxed/simple;
	bh=sroRy6CFEvuBmZwTojacZz2boIKPbCjja5uytCucKAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HY98qPpzXISh7jzvxAglOVEbBzFIc4f1Rof9rH4Yslq7kgsbWp/IrX8Qc+7nHBZ/9e/Yh33mZ6LvMdV+8XmjqMaaHBArfppTi5LgllMmyESe2egTFQEERKSQsqwGQSwzOP/n6GQReMKZQZaK3Q1s+Uo9OqWhnJObt0kWXlBsM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=l2kwQabs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YEKAHzu1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="l2kwQabs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YEKAHzu1"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 194287A007B;
	Mon, 13 Jul 2026 02:08:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 13 Jul 2026 02:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1783922923; x=1784009323; bh=OX494VjT1n
	3vgmeud4/fUolvA15vW/SlDIQshDXxpOQ=; b=l2kwQabsd6bJmL8rXOKj8/H0QR
	TjBvTf2lTWuG4m7rYRiM1PCKUvGC73MMdUnAGpeAnnmzXv9URIECDtcXfDO8hY2l
	ljWQwrAE0rXo9BERXx7d7X7L1d3BR06R3PsfcDHe+3e9ywtVMXw4HBfjT2xj5ZnD
	pszqB0vfOPoDAi2fbPutqkQJHYxGuFvDBVMEuwjkhS11cz3mVf2wSYWXt4Ovi6zn
	haxEuIyXbf7Fxt//M1JDNkP7MeEYpc/4Pi8JHzfRR7orn5UzZ/coOaY11EGht2E5
	zzoxGPSc2XdmVv+mhy4j/2WdQXHTj1DF/1cX0Mbc90XxbUrkRjU9uckfT8Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783922923; x=1784009323; bh=OX494VjT1n3vgmeud4/fUolvA15v
	W/SlDIQshDXxpOQ=; b=YEKAHzu1Lv95uxbohH/UHfozRVKWtGY8IYsKkDPB12l3
	0tUeEqiAqvO/kTXK4+1nLoj9oAsnm9mm4bLTZ/B3u9Mt1v77SBrcGlYUo+pZ8o1E
	+0eRo6GIcsmBCAfn0cL5yIjdpx7fvfKs2TT8kh600N8E1z0mTIlg45wZV2C3ZuMe
	OvbAEESFRoaV9Fxw81+05sQF5KMnYHaGSjJibk6yhVai17tb9Z97of1XCRuSe2h/
	MFzkrdeXRuNija1iq5Sq+k8CGgnxVpywItNRaXCr41j2wjUi8EP4L+4Vi5SwiOcu
	sOQk+Pw/7lEHX3yWw6X8GFXq3QjeH6B00NAsi/5tHQ==
X-ME-Sender: <xms:64BUauW8ZNaOHJW40MNZXvZUG7LmIv-HSYib2YDHnvMebjcPGdU8rA>
    <xme:64BUajiFsoes94CsJLzxrO90Pv_Jxz1cXEll0EF19OKj8SbSaXPbTtNRd0KJa3Wzb
    RtiddeOG-GyEbmcKa_sfl_ha3pTJkD88I0opzj_9ahJtLQhm2I>
X-ME-Received: <xmr:64BUat9QjOB92eUiB_YdzHHxrALmIUezMwAJ9ZWubE-Wu_PWqjL70Rw7gC67nfavrAA_phhOnC6nXScr3wnGEcEiCrLVICg>
X-ME-Proxy-Cause: dmFkZTFabOqlWYBTiNwo4m6k/i8kL9nde4xLr1ic4ltseK4iB8SdXAn5JxGfCP6dwMozkG
    p9cj/2+K8x5i1hr6WaLztnTi418iZ+TTvY4cyQbzs9dbrf/FDYkPZcpIM5OqgdqORUr7Hc
    JW8YmuqkVF8dInXchhJyNdJK+yG+B3q8J2SeBxx4ga0w4NSitnNYvclfhw0eoT6lj3Adah
    V1a1Y2cVsTa1JVnyTvcbV6GLynpF8YaRExOx6UTNBDqy+eEABHlPf6inPyP87xy+dEicKj
    9rwTa/JNqckfTP8F7rpB8bI1W4TS2zpWr0e9ajrDcXv+ctCQKsy5xUxR5AryCfA3g7s8uB
    REqOTezc9ILXMohnEMuEfNUbOwbRz7BVCMVeOFKsf02fRYEti021P0p208ljt43mr2t+ZS
    SmGR8lTQu6WtTcQwSyRFKXH1kH6cEjzUoIUJNkTZwZDk4Zu1onSTTc0dkkG65OCpJ457qP
    bWDbN/SbPq3Q5R8+7SwKjQLiQ3IJrOJE6pwsU6EEbx2FAdiOmlEMVBJyVbdm8Q6u/Y9ohx
    13/KxwWMbx9Q0nbCdVZFRXwQUG/M7PJx8Y9l3z3Wtai9H6fHJUL5J9EuQBJZrZEpet25Ir
    Bqk1mNSCYJsrkSO9gf4i14YHdFIpn82e8fI1yEhGCBTEYOfDSe4XHz0D9ULw
X-ME-Proxy: <xmx:64BUalYKbJO2c7IPsKX88ds4uV6B3_kIRc0vr5ZBmgKKowEkTjE5WA>
    <xmx:64BUak0FVTrRJkjcyD5BODNfmZUZSDpZ8-sOgrcrAYZTh2q-PyzhJg>
    <xmx:64BUaobf38ViKJj3tScGgg5SJB3J_X_eaZMfU6KgsOYY8B7sWOZi7g>
    <xmx:64BUakJfIg1FORTTeL8zqtWqOvpRFh77hk58IwYrGmju3JRC55m5PQ>
    <xmx:64BUaqgn9VzIZdkferOqUC3npJKezAwg2f3ntvhV0miuUToKq91xr_ka>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:08:41 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v3 0/3] VFS: refactor lookup_open and add vfs_lookup()
Date: Mon, 13 Jul 2026 16:05:04 +1000
Message-ID: <20260713060814.2849-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v3 changes vfs_lookup_open() to return errors if a non-regular
files was found, rather than trying to open it:
  -EISDIR, -ELOOP, -ENODEV, -EFTYPE.

If this can land in a stable branch, I can ask nfsd maintainers to merge
it with the corresponding nfsd changes.

Original series description:

My recent proposal for inverting the order between inode_lock() on a
parent dir and d_alloc_parallel() missed that fact that atomic_open()
has two callers, and would have resulted in easy deadlocks from nfsd
when re-exporting and NFS filesystem.

I think the best way to fix this is to provide a richer interface for
nfsd to use, which includes all the locking as well as inode_operations
calls.  This allows the nfsd behaviour to share more code with the
system-call behaviour.

This series refactors code between lookup_open() and
open_last_lookups(), and uses the new lookup_open() to provide
vfs_lookup_open().

 [PATCH v3 1/3] VFS: move mnt_want_write() and locking into
 [PATCH v3 2/3] VFS: move delegated_inode retry loop into
 [PATCH v3 3/3] VFS: add vfs_lookup_open() for nfsd

Thanks,
NeilBrown

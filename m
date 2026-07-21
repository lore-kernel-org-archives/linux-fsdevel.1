Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A83C3F65;
	Tue, 21 Jul 2026 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625143; cv=none; b=SKf1xTcmRj4MgX3DpkjIjB4IsZtoJUpX9fKI/Rp5w1J7iuHQ1NlwgzDEF4g1Za85wZJb6DFVsS0h97XeLZrvxK6GOg0/S2TVJZ4KUIWLE+jhDtk84fFSGhRrPn9oo2+pJkldX4ADX3/G7UlC6iamSIfCJcKMjclwrNS5CgSagVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625143; c=relaxed/simple;
	bh=ccyBZsWFvlJ05TfPIr6niEPj+v0sSV0sv+mLbpcrNaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=trNqU8WUPuY2a8K87MD5+gP+/BwDxocQvoCfz5KQMya9fX8ZJJFtaJVt4Kn+QJBYFo+hCI0hb/Mpzo6VElIEi2jwE1J0q1JXPOef8BTf9IMTQTd5ACvH7h5asEKM2FCtaVnsdmQ8pmRpL0wQnDWx7usnZRGopRgS3mZGsL9rUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iFqdHCbF; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iFqdHCbF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784625131;
	bh=m/B3mZs+O9geQy4une4ZQWIzRGOzMcX1kPCJTOYWBIY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=iFqdHCbFNYtgOzsEa+cCa2ciYLUg7MVPFq9QchLxle33eqQwqMTJ26z+uZMYqdHRS
	 TvL75caPdZ62Jq8BVZRjmueRA9zNwnbV8KjuYvaVCSIIbIMJ48nX2dutV0b+RzCNbB
	 km7Zabjj/1trwC2vo1fPfLweDQmJycwHFO0S8eBc=
X-QQ-mid: esmtpsz11t1784625115t45d50c05
X-QQ-Originating-IP: F4ZgyYP+ybcgcAs8vVifRe7iQlXF4Zyts8e382l1HfU=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jul 2026 17:11:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17626171695981884832
EX-QQ-RecipientCnt: 4
From: Yichong Chen <chenyichong@uniontech.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH] isofs: release zisofs block pointer buffer head
Date: Tue, 21 Jul 2026 17:11:52 +0800
Message-Id: <20260721091152.1450622-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N4+yplgViZKsMrNQtwsj111n6VNbTN1oRVwPrMp5LHzN5lGGc0u2d5D9
	/dv3xfN/Dx1ddAQyf/CX1JM7Js9E9lQCj8mb5dT3MLOeW15L5E3fjt+l/MTfzdyBivHM+XI
	hBQ6u8nwaf37eSBTAqt4sT0uY+B8ShEdRJSGhJ2mihN9lBZy2NyOQFCob08SCrQdxzNECQI
	odhSA/UE20dUo/4bjYGLo5wVm6aWoW2botxJUQlkrBZP7m1u9404e9WbvvP4C54Inn3fqlI
	Hn11j6yQ4sADrJru9pKl9/IgfNhMmnSBensOgJrL6a1gdbWlSXMODLyRQzpO0zvbBr+uCGS
	anf4Ji81gsMnXYzbFzih0R0ellGZKvqPbgDUNaSmtbMdXzK+Ut45ALtlO/Wo0+cIXm8mYxU
	HuXcnAq/TRC5R+xbIOCTQCLau6ZLwjEgF6O48WaO6wgF1BepOlpvHbFq+Ce7ibCE5px9wP9
	ax/cJIbEsJu8PkWOqenfH0/uk3LxqBr7iIUx8+8bNz67E6JXnOmfKSQXImOIhNoIgXuQ/fh
	Q9ue1GBizcucEFQvdUY6dGf17vXe2W3Jl6BIFxQX04MCrIbexAm9/YAczImQgG8IOQDvrQy
	azp76GB7DyHh7RMEvWySPXUGi9SOOaC71Y34C9xqY9TnNcHExhVpxBsa4vt5qaVeG/N8XL4
	V7qyjLOp7pGrrp0jRNKU1lY/vqcGgD+Mk0yBCz1kds7ecQZvjZOr9aBdwGkJ/UajznS0Avs
	iHIrIalR7flEyu4RLnidgZirFGW2KF0qhEx9gOLG4pw/9b0Kt42ZhhvZxd6Rk0CMp53kF/4
	+kaDxk1GTuVqn+WM+4C+dqpCucYxQFqC0CPDQpCrhRcJm/Htm7pOpxN9EyVaDZsctPn1GGJ
	0TyOJybPY+cWSc1GCJXDKRKgjUFupdC7unBarldEbBEZOqii3RP0p3VMvCNTCHdxYeq6e4D
	8VimzZfQNYVVMejPhPfIqVFSXdaNoJ1UDJDc+eiP/22+uQklAZBfBaPIL+rSvVnEQ17/y2M
	tNTctJRJfUzF6BoTj0PIzJSZm36IAcNsHdfIWJFn9c5EbRzIxI
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

zisofs_fill_pages() reads the compressed block pointer table.

The error paths release the current buffer_head.

The loop also releases the old buffer_head when it advances.

However, the success path leaves the last buffer_head referenced.

Release it before returning success.

Fixes: 59bc055211b8 ("zisofs: Implement reading of compressed files when PAGE_CACHE_SIZE > compress block size")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/isofs/compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index 3fda92358e22..f9869d62b850 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -293,6 +293,7 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
 		memzero_page(*pages, poffset, PAGE_SIZE - poffset);
 		SetPageUptodate(*pages);
 	}
+	brelse(bh);
 	return 0;
 }
 
-- 
2.51.0


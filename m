Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6191F35A397;
	Sat, 25 Apr 2026 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777128245; cv=none; b=kXIdWfLiCRTarGzPPk0JWUnJkrN/hg9t9uOmf4TjLE3Qbe4Fuy8lrD7Llqs7K4pGfo2trsey1lehLWVEMuGAEZ46634c2Hhd66/B6FyD/xmUXX3ypHHyQhdAQRYLTMlPE8DAI1oHJqPoIA+A6gXRF0GAbCAym3UwJrOI6+QOl6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777128245; c=relaxed/simple;
	bh=XxpyuH34L/g6jFDYrU7ONEJXOQhqQEH8WufEiSeHD2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/x4d5mSzMfzT2eNIUy5BL0fG7k/a9bqAZZRxCN9WdXBA9vyvh18MXOQDP8DjXE+20wVlDr79j8UvgFG/o1IBkkq2KxLkLYLJxaGosdry6kEWFDuNURFXMHpEhHdZ2038Hol5fmSkg+ebsl+8lTw4UWWbrKnh+e37mc0Bg6ft1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=iTHgw08s; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="iTHgw08s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1w
	4loge87pESWbWbdSL3qELjprlRSOEQ/QtZ6iGpfiA=; b=iTHgw08stS6O1mORYF
	iBFjc3rpAxiJJVxqHn5rN0Mxki2nC0jJeAZaAeibk4TsB8eDNWMmpiODtkQNIPc9
	0PYz0mo2PSdxYhO0hVbpQUwODBXBKt32CB3VaQ61ud9UyC/XwDy3gByzZIUfqNtS
	8Ggcs99pP2OhM9G8hT7S5RJCM=
Received: from zhang.. (unknown [])
	by gzsmtp3 (Coremail) with UTF8SMTPSA id M88vCgD33wn4z+xpU1T5AQ--.33097S4;
	Sat, 25 Apr 2026 22:30:18 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Jan Kara <jack@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: [PATCH] docs: isofs: replace dead ECMA-119 FTP link
Date: Sat, 25 Apr 2026 22:29:43 +0800
Message-ID: <20260425142943.6809-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:M88vCgD33wn4z+xpU1T5AQ--.33097S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF45uF4DXrW5CrWDuw4xCrg_yoWDZrX_ur
	yfXFsYvrsFyrWIqa1kCF45uF1fu3yfKa1Fvw1kAr15A342yrWkGFykJ34Yv3yrXr4xury3
	Aa95WrsIyFsrJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUZa93UUUUU==
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiIBzIiWnsz-zF0AAA3e

The original link is no longer valid. Replace it with the official
PDF of the 2nd edition. The new link points to the exact 2nd edition
that the existing comment in isofs.rst refers to.

Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
---
 Documentation/filesystems/isofs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/isofs.rst b/Documentation/filesystems/isofs.rst
index 08fd46909..2a30999b0 100644
--- a/Documentation/filesystems/isofs.rst
+++ b/Documentation/filesystems/isofs.rst
@@ -57,7 +57,7 @@ Mount options unique to the isofs filesystem.
 Recommended documents about ISO 9660 standard are located at:
 
 - http://www.y-adagio.com/
-- ftp://ftp.ecma.ch/ecma-st/Ecma-119.pdf
+- https://ecma-international.org/wp-content/uploads/ECMA-119_2nd_edition_december_1987.pdf
 
 Quoting from the PDF "This 2nd Edition of Standard ECMA-119 is technically
 identical with ISO 9660.", so it is a valid and gratis substitute of the
-- 
2.43.0


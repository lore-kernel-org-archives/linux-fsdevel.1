Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B53E0C78;
	Tue,  3 Mar 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535577; cv=none; b=gDZOO3dPsKACLKFgC5Exih+RsScPkeQOzSuz2zhlke7u8V+OKCrvTFkfQ84gAbYFcjhlvoj+nCAdXTN4R7ikasLkdD5p9PSk7xx5xaMtP7MA7O6hPZzUaKJAqJtpRmKDNC4B3adkHb+mGW97X9LcfaRG3zPVhx4N5kguZjMxVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535577; c=relaxed/simple;
	bh=AVDOvUysLeRsjpzey4Uh6N374SNRAn9i+6EF37t8PC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inwtta8rzozRwtyBwOF3ABrur3FpjSJMQpJq2k0RwSESnqNdfueO+IIiGJPz0MJ2U9NUXaZbfawEdS4+CJ+UpzKgEvZV2S3FyYjfvdO1H+XJ4tHFGZnimSV5UCa4cou21nfdV6hIGHBf0PtI98RUZKmQ+zCplJSliTuCJ+21Nzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69a6bf0c-0473-7f0000032729-7f0000019b3a-1
	for <multiple-recipients>; Tue, 03 Mar 2026 11:59:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  3 Mar 2026 11:59:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: Fix bitwise operation having different size
Date: Tue,  3 Mar 2026 11:59:14 +0100
Message-ID: <4cadd27e654d6f0d2c421729f8b3045d4c162dcc.1772534707.git.p.hahn@avm.de>
In-Reply-To: <cover.1772534707.git.p.hahn@avm.de>
References: <cover.1772534707.git.p.hahn@avm.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1772535564-38FF795F-D88A120D/0/0
X-purgate-type: clean
X-purgate-size: 864
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

cpos has type loff_t (long long), while s_blocksize has type u32. The
inversion wil happen on u32, the coercion to s64 happens afterwards and
will do 0-left-paddding, resulting in the upper bits getting masked out.

Cast s_blocksize to loff_t before negating it.

Found by static code analysis using Klocwork.

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/exfat/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 3a4853693d8bf..e710dd196e2f0 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -249,7 +249,7 @@ static int exfat_iterate(struct file *file, struct dir_context *ctx)
 		 */
 		if (err == -EIO) {
 			cpos += 1 << (sb->s_blocksize_bits);
-			cpos &= ~(sb->s_blocksize - 1);
+			cpos &= ~(loff_t)(sb->s_blocksize - 1);
 		}
 
 		err = -EIO;
-- 
2.43.0


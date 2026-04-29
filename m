Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183D3AA4E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496335; cv=none; b=BrYnyur+mD2ZUzSaLhyzulX9PM1r6p7ps/8oSDkGiNU8SUvjirMjThhSyUef0u7k46WhOH3Dq3M7Dv4GE46BBwAdq0c/WFJ5uxaMkGDNsV4l3jAvl4sxYnbQM3f9d77hqXwfnR1WCuEMR99NLJdGqcYlmOa+aiXMxQY46FzDV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496335; c=relaxed/simple;
	bh=NbyEhJH0syJgubzKkOO4w84fm7ZZonBlTjSXu1UPhBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAB7F/Gjg+anvcKOEGMEhZ+aBJmR2ySTu7GU8ep3b/CCbllpxx48VVfSJJe+xh8u8lmHjkCBNqFmg/qkJHN7qvkTvYidLYuYFTySwlSS1iFP0HuhalBjcqIzw4kJHHoXxEaBinZUdoX33soLdG5m8tVqitP2lbCzhzxeraff7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=r8WkayQW; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r8WkayQW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1777496332; x=1809032332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NbyEhJH0syJgubzKkOO4w84fm7ZZonBlTjSXu1UPhBA=;
  b=r8WkayQWnZ313bLshvJj7vCtiUmKZpzcmG5PAWfnSc0PRo5qO9/002ks
   K/lAe6ZXQlQOnQhilyU+5AORhvFfxTx7syUxoXrS40GsV/w9z+InoPCUg
   KHD6pQcF6vMtW+uNFWmN4YUbcTceGWf0+BTsveEkbRuNuSw8OuACdofkX
   MSqDbBwLAY4u5tdJeLcP5eclJIYfYIP2ukexZu1wggy+mjvEJVsckXGme
   qi10hAUzc6FaE3lZfVBQI/5YS0ne7tyfnFNF9aocs9R5jDMnky0Ha8+Yy
   X9ltbKMOP2suapxVjvXG5srDLyoNBNg61NQOFhqUiGJmDtHi9oclHNl3c
   w==;
X-CSE-ConnectionGUID: dPWndB+qRQ+6sebmkWG8mg==
X-CSE-MsgGUID: nhf6IUf6S/6gs31YV2XRLg==
X-IronPort-AV: E=Sophos;i="6.23,206,1770566400"; 
   d="scan'208";a="145031230"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2026 04:58:42 +0800
X-CSE-ConnectionGUID: T8ijcd8zR6qXmSp8GPGuXg==
X-CSE-MsgGUID: FnnZiRlcQHGc7enhzHHRfA==
IronPort-SDR: 69f270f0_ZbDfnuLzXTeJ2LSH/lz+pxyPCiOy+WaUYX+dkxZZmff7J9t
 Tewj6WHnZOnoDFNmyKkN2KtZjN9c0fzSv9ve/fg==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Apr 2026 13:58:24 -0700
X-CSE-ConnectionGUID: oYToRKXMQrSjp1sEkTlC5w==
X-CSE-MsgGUID: arLXKQnrQ2CdOjN7GqYBcw==
WDCIronportException: Internal
Received: from wdap-bnfcsfsyyt.ad.shared (HELO neo.fritz.box) ([10.224.19.6])
  by uls-op-esai2-o.wdc.com with ESMTP; 29 Apr 2026 13:58:23 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	linux-fsdevel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zonefs: handle integer overflow in zonefs_fname_to_fno
Date: Wed, 29 Apr 2026 22:58:15 +0200
Message-ID: <20260429205815.810952-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In zonefs the file name in one of the two directories corresponds to the
zone number.

Here Alexey reported a possible integer overflow in zonefs_fname_to_fno(),
where the parsing of the zone number from the file name can overflow the
'long' data type.

Add a check for integer overflows and if the fno 'long' did overflow
return -ENOENT.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 9b646cb5335d..c3b497707f82 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -610,11 +610,15 @@ static long zonefs_fname_to_fno(const struct qstr *fname)
 		return c - '0';
 
 	for (i = 0, rname = name + len - 1; i < len; i++, rname--) {
+		long digit;
+
 		c = *rname;
 		if (!isdigit(c))
 			return -ENOENT;
-		fno += (c - '0') * shift;
+		digit = (c - '0') * shift;
 		shift *= 10;
+		if (check_add_overflow(fno, digit, &fno))
+			return -ENOENT;
 	}
 
 	return fno;
-- 
2.53.0


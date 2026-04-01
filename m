Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BAD36D9EB;
	Wed,  1 Apr 2026 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027548; cv=none; b=LAdtuZL5/t5IxrgxmJOljJ9JfNyTbkoJooi+gU1mQM0dfIdBS4WqbrAoGlJiyOPtpT7pE8RzNobqC/o1gLLsAY5VBNt7zUEZLXNDArjiMUx6gGqHwbtWQ7LYTB2nGNP0+Aeq6TtmWn93a94DooUYnRmid2L6f+5/DOpP4r1Veq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027548; c=relaxed/simple;
	bh=4XLStZPfwwKRPbkqLhB2WLxdRraS8v8tU7gGtg43+go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FnvMrKOpdt0mt5vjsh5PV7PpHY7CYzZZkHdK4XTgbw7cuMjcxaN1CqbKSPLBhOe6uINzFEbwkpFUy1LPK7CSbU5UANWW5oFfFWuDsgYClPol3jcj1vE4GLaVS1ZidTcwMfWvwNHCV/eSNXn+kdjAhXx6eoBbssUIkYpEmphBjIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c9xIcCh9; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c9xIcCh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Zn
	6pTjx2DAHM1cxs9mvOvDlng9G8h5etUqEB6jJHc2M=; b=c9xIcCh9ER0gpaXNxr
	TQelymY1F252sY/xETJiCGqkRty2AYxrkuOtjq5u1qn7CwNkVP06/1LVhl4Ka5hs
	w+sIoHctnsAnZAd+Q165jrcwviqnEsXFcCaNh6TA6uU7rsM9X9KxUirQhLMtIJ4u
	oVHosIq1NrPOtKTYNTWt8tbtY=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3v9ZFxcxpADvDCg--.24371S2;
	Wed, 01 Apr 2026 15:12:07 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 0/6] exfat: unify FAT chain walking helpers
Date: Wed,  1 Apr 2026 15:11:32 +0800
Message-ID: <20260401071138.114836-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v9ZFxcxpADvDCg--.24371S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trykKr4xArWxWw13GrW5Awb_yoW8Xw1rpF
	WfGw43JrW8J34fZwnrCw4Iv3WY9r4rJay5Xr1xJw1rArnIyFnrZrWftryfWFZ7A340qw1j
	qr45KF1j9FnrCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPsqZUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+AgRrmnMxUgGFgAA33

From: Chi Zhiling <chizhiling@kylinos.cn>

This series introduces and uses two new helpers to simplify FAT chain
walking logic across the exfat driver:

1. exfat_fat_walk - walks FAT chain by a given step, handling both
   ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes

2. exfat_chain_advance - walks an exfat_chain structure by a given step,
   updating both ->dir and ->size fields atomically with proper boundary
   checking

These helpers replace open-coded cluster walking logic in dir.c, namei.c
and inode.c, improving code readability and ensuring consistent error
handling for corrupted FAT chains.

Also includes a fix for incorrect directory checksum when renaming a
file to a shorter name.

---

Changes in v2: rework exfat_chain_advance()

v1:https://lore.kernel.org/linux-fsdevel/20260331091113.20882-1-chizhiling@163.com/


Chi Zhiling (6):
  exfat: fix incorrect directory checksum after rename to shorter name
  exfat: introduce exfat_fat_walk helper
  exfat: use exfat_fat_walk helper to simplify fat entry walking
  exfat: remove NULL cache pointer case in exfat_ent_get
  exfat: introduce exfat_chain_advance helper
  exfat: use exfat_chain_advance helper

 fs/exfat/dir.c      | 111 +++++++++-----------------------------------
 fs/exfat/exfat_fs.h |  40 +++++++++++++++-
 fs/exfat/fatent.c   |  23 ++++-----
 fs/exfat/inode.c    |  11 +----
 fs/exfat/namei.c    |  29 +++---------
 5 files changed, 79 insertions(+), 135 deletions(-)


base-commit: 4129a3a2751cba8511cee5d13145223662a8e019
-- 
2.43.0


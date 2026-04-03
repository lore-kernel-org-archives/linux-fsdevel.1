Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422FE30AD10;
	Fri,  3 Apr 2026 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203613; cv=none; b=niVFova3auTngDqJFvNARvO3Jxh4Wx+hYBD432k+SBNk7XmQ/N392KF32cnYi2A2IkMnp5HCO3C4vadU9yJtaUk6ivU5C7UUlOOhEH3CDDxNO5KZHdGw4B0MJDuWU/M6BW+zDNmuOhWG2QhZDEYzpCMW6+tk1tZUua6lECE7Ysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203613; c=relaxed/simple;
	bh=7wzvBEFzZYxvr9gv5HleV4kSF9N+SIns0buVqTP5DFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDgfkNJx5UXZRWewvqbKQIeknOtidi4y3e7CobcFTkwhi8MvzPFi3pHTfgFl05qvbZOgzdgpd3FTW+aN2nKInmuXkLTWxQwrCpD3LVryq+2E+WVRl70lxpP9woG+CAu6nsZq+DrPFciKj71P/xECbegFO0xTQmyU+1mHUFbHC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jxZfI1hN; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jxZfI1hN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Lb
	JHcPx2UnPbFtoKjf/6TJU87eW7xKixfE7A2R3WvbE=; b=jxZfI1hN9Z5haAoBaY
	tIRQsYiY9bqbWG/3DnZX7CO8/utaROsY+lHLSUFKbqgBAqlmi/WjrkPW4kXWSanw
	1QXDd1JXKVGU0q4O3KR7Pxs46vHGpeWeTWIV+nGUsicioXIfmUn12dKuVaQqCMv6
	N6LjnB9QEfwsaQ9el0bAbkAgI=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHW13+dM9pkhS7Cw--.58982S2;
	Fri, 03 Apr 2026 16:06:24 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v3 0/6] exfat: unify FAT chain walking helpers
Date: Fri,  3 Apr 2026 16:05:32 +0800
Message-ID: <20260403080538.361663-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHW13+dM9pkhS7Cw--.58982S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trykKr4xArWxWw13GrW5Awb_yoW8Ww43pr
	4fGw43Jr48J34fXrnrCw42y3WY9r4rAF15XryxJw1fArsIvF1UZr4ftryfWF92y348tw1j
	qr45KF1j9FnrCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPsqZUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+AGrSWnPdQG4QwAA3y

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

Changes in v3:
- rework exfat_chain_advance
- add error handling in exfat_find_location
- misc tweaks

v1:https://lore.kernel.org/linux-fsdevel/20260331091113.20882-1-chizhiling@163.com/
v2:https://lore.kernel.org/linux-fsdevel/20260401071138.114836-1-chizhiling@163.com/


Chi Zhiling (6):
  exfat: fix incorrect directory checksum after rename to shorter name
  exfat: introduce exfat_cluster_walk helper
  exfat: use exfat_cluster_walk helper
  exfat: remove NULL cache pointer case in exfat_ent_get
  exfat: introduce exfat_chain_advance helper
  exfat: use exfat_chain_advance helper

 fs/exfat/dir.c      | 119 +++++++++++---------------------------------
 fs/exfat/exfat_fs.h |  44 +++++++++++++++-
 fs/exfat/fatent.c   |  23 ++++-----
 fs/exfat/inode.c    |  11 +---
 fs/exfat/namei.c    |  28 +++--------
 5 files changed, 91 insertions(+), 134 deletions(-)


base-commit: 4129a3a2751cba8511cee5d13145223662a8e019
-- 
2.43.0


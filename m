Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A68330641;
	Sat, 20 Jun 2026 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781936752; cv=none; b=aPJIcm7WSWCrUe7kRvca/npz/0Es48VroITKpOKLEC/D3Vd7xCHzDe+O4Dit9s/Rnhf/qLemXfBTMJ25mPNruYE5kzaSlQE/WKmIca4vCGqlS8Z0tXIObe3yi2hzqNf/V6m5O7GavPlS9+ph3qK2MkknwMX2avnDzpvlMaReAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781936752; c=relaxed/simple;
	bh=6OZP0Fzj5QJn5BD9JZYC7Rcyok8w/d1JKdbfT7twiMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VM1rWsTBePRNvReQuR3UJFAi2OU9Fvsvq+cPjbITJUo0xT/gi98+1I/+Q3eIoFYK9EVPTVOYpaKHMmQSTzicYFb9+JTDgZRh67RsvWHO3xv3OpiNKBWisMeWxLUOI3qUIKDGxw9YyIoNbfTtrc2nInwYofDzra9vx2it+iM8FrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PLj+qIBQ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PLj+qIBQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7c
	abu22telUlpxjU3UL3ZCuZA+QFd179nmvbyG91lIU=; b=PLj+qIBQ3MwfEygdVX
	2EAJoTy9IkxuK7wMluu5eHLVYnymOL805gK6XHGl4oRvjPpJQjl4mgm2WZrOi0Sf
	LIa02ULG13wCCfksZ+DdztA0B25SGIiN3uZHAeETfO+YuamdJru4SZnKlbjPHT0u
	Z7n7wYp0A+Nh9NPbdSIzG562c=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHTsswMjZq5+F0Eg--.19463S2;
	Sat, 20 Jun 2026 14:24:50 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH 0/2] mm/filemap: reduce unnecessary xarray lookups
Date: Sat, 20 Jun 2026 14:24:44 +0800
Message-ID: <20260620062446.351475-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHTsswMjZq5+F0Eg--.19463S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4fuFW8GrW7Ww1DJFWxCrg_yoW3KFc_WF
	WFkFyxWF40vFyfAayIkFWDA3yFq3yjvF15GF90qrs3J34xArZ3XFZ5ur4vqr1DXr42yFnx
	Gr4jqFsYkr12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1oa0tUUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2xTBX2o2MjQOhgAA3D

From: Chi Zhiling <chizhiling@kylinos.cn>

This series optimizes xarray lookups in filemap by avoiding redundant
iterations after obtaining the last needed folio. The boundary check is
moved to before advancing the xarray iterator, eliminating unnecessary
lookups and branches in the fast path. This reduces the overhead of
filemap_get_read_batch() from 2.91% to 2.53% in 4k read tests.

This series is split from a previous patch series:
https://lore.kernel.org/linux-mm/20260601055704.167436-1-chizhiling@163.com/

Chi Zhiling (2):
  mm/filemap: reduce unnecessary xarray lookups when read cached pages
  mm/filemap: reduce unnecessary xarray lookups in filemap_get_folios_contig()

 mm/filemap.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

-- 
2.43.0


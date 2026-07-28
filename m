Received: from cvsmtppost13.nm.naver.com (cvsmtppost13.nm.naver.com [114.111.35.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5FB1C3BEB
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785236005; cv=none; b=QQByZAvvBCWeApl5lLiSKXFdovCZqi13Hu7oe3Ql6/ch5WoBrf3fK30/Jr27OmKoXiQo4SJcM3dg+fmnOqaFguXgW6YmZjm1aGewAf4mOWPr1vzbqhoZqpbGIEP3KKmMKJwAa1GWo2hQZkeAj+yaoP0iEmkYsvjnukX3jRELlC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785236005; c=relaxed/simple;
	bh=7zVnH0XfZkoE/7jd1BWn2qFid8m72bicg5wpwprCQaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKgM2p413NgZfRlZXRnX78j0RCVH7qFvdZHSZKISfLSuKFcwhlNhihF9bVOwCY0j2dHHLj1z7dKeiT4ZGHvFbgCBGN073DYqdBrV62bhLe7vljRCw/AOIazZbf2b7nuF0Jh8BhJearEpGAeZnG8opPw6LbDOo1dSGigyMxIuTaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=gz1jJ7Ok; arc=none smtp.client-ip=114.111.35.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="gz1jJ7Ok"
Received: from cvsendbo003.nm ([10.112.22.30])
  by cvsmtppost13.nm.naver.com with ESMTP id t3SBhDWwRH6l-g+Iz71-cw
  for <linux-fsdevel@vger.kernel.org>;
  Tue, 28 Jul 2026 10:43:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1785235387; bh=7zVnH0XfZkoE/7jd1BWn2qFid8m72bicg5wpwprCQaw=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=gz1jJ7OkY5Xq/FXW1xjythhxmewqzdS8RPo/ID/HeK1xU98YvNHixO5mG820x5AmP
	 eQ0wEUBPeO8zeEtxdWeneXRKgIL5WrU4B1vWQqRgGhLb9ono6qz+nbbhNooPXDqLC1
	 EmfXVe6ReUJt4N6BUOvSMZuqJ9r1UYmeNetkeEAnS1Mzqsy+UZsvdmGJwcI/Ix87tk
	 koBQ9w+x6xn3trCyc4a3LDNlmd6GaXVlxtb5qYQlnC9YRbsqjyMesHsmVmho5Svp5a
	 Q6SjJO+YPUEOIgm85C4Mvd87V+Jlc3pv4BhiqUf6EYgsPyJSJZO+qQFO2I84jTVAhc
	 tOqAaOiucb9og==
X-Session-ID: 6FQTT4rIRXqWoy6SgYbnNQ
X-Works-Send-Opt: rPF8W4eXjHwYKHm9FAF9FNmwKo2mKqErKqb/jJIFjAJYKg==
X-Works-Smtp-Source: X9nmKoE/FqJZ+HmXaAvZ+6E=
Received: from bl4ckhyun.localdomain ([211.41.193.156])
  by cvnsmtp004.nm.naver.com with ESMTP id 6FQTT4rIRXqWoy6SgYbnNQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Tue, 28 Jul 2026 10:43:07 -0000
From: Hyeontae Lee <wonju345@naver.com>
To: hyc.lee@gmail.com
Cc: linkinjeon@kernel.org,
	zzzccc427@gmail.com,
	baijiaju1990@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] ntfs: data race on ni->mrec between resident read path and MFT record mutation
Date: Tue, 28 Jul 2026 19:42:53 +0900
Message-ID: <20260728104254.2459-1-wonju345@naver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANFS6bbReuJMapSmtQSY+jASmY_di+X28rMFQuYtscBwjCie8g@mail.gmail.com>
References: <20260725042421.109599-1-wonju345@naver.com> <CANFS6bbReuJMapSmtQSY+jASmY_di+X28rMFQuYtscBwjCie8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hyunchul,

Thanks. In case it saves you some time: I tried the naive fix - taking
mrec_lock unconditionally in __ntfs_read_iomap_begin() - and it deadlocks
immediately. ntfs_lookup() already holds the directory inode's mrec_lock
when it reads an index folio via read_mapping_folio(), so the read iomap
path re-enters and lockdep reports recursive locking:

  WARNING: possible recursive locking detected
  --------------------------------------------
  bash/1 is trying to acquire lock:
   (&ni->mrec_lock), at: __ntfs_read_iomap_begin+0x291/0x3f0
  but task is already holding lock:
   (&ni->mrec_lock), at: ntfs_lookup+0x7f/0x3e0

  Call Trace:
   __mutex_lock+0xd3/0x1190
   __ntfs_read_iomap_begin+0x291/0x3f0
   iomap_iter+0x1a4/0x480
   iomap_read_folio+0xb1/0x1c0
   ntfs_read_folio+0x82/0xd0
   filemap_read_folio+0x18/0x80
   do_read_cache_folio+0x7a/0x1b0
   ntfs_lookup_inode_by_name+0x624/0xe00
   ntfs_lookup+0x93/0x3e0
   path_openat+0xb4f/0x1370

So the read path is entered both with and without mrec_lock held (this one
has no attribute list involved), which lines up with your point on the June
thread that an unconditional lock there does not work. The comment at
fs/ntfs/dir.c:295 notes the same read_mapping_folio() hazard.

I will think about a different approach.

Thanks,
Hyeontae

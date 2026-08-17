Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86F4457D8;
	Mon, 17 Aug 2026 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979906; cv=none; b=pr35V3KHQRy1Yvs3xk/T03sd4irtf0pr0LQOZZNuWAfcvqFGqEBcql0wwhSOJ4nxZvsOZDuTkszP5BjEjP/NtrJo8E//EoazJKs11/kCzDHBsWlnQ8nRldGBAJkgRBqH26f/+tEDDzw06CkC+shzYf0d6RVcSlduF11JX1MC7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979906; c=relaxed/simple;
	bh=HUfXojDODJax+GNmGO+ENINeQ+6j8w8pEE8BrSbIcDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ff0lNeztdqgHKt0y526v78jMVcxuuP9+VK1EkToyNvh58gK8undlxFOBkmHsfkGBLb0YBJRLfkepuBk6oBYWae8BOd4YxMJodEcTjuG7t8AvxKkoSvsyjPRqA9nb8T/sHE8c5UlMsWS9J+Ap1PG3vI4J/95n4IitaTmxwigdsv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NIow6mXT; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NIow6mXT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786979900; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=3Qt97fzLI4Ua+l4IKyanQGt75jaD2Cp2qOduyMrgQv0=;
	b=NIow6mXT7tcuxLdxmA+rk4q3nw7kZgP219jprVheO11w4HOzfa2r9Dq09Lp8cM4HsUrSLssIyJ+KkG5GOKbpGI5Z+JQ1uEzt7OwwLqpqaUdUaNNK/CMYOpUvXvLlY5XUs0qD8hge3Qsx2fPeQv6m0g+BStcWuEpGQOQT/xt1Q9k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X9A6o5H_1786979881;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X9A6o5H_1786979881 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Aug 2026 23:18:19 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: fuse-devel@lists.linux.dev
Cc: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vgoyal@redhat.com,
	jefflexu@linux.alibaba.com
Subject: [PATCH 0/2] fuse: fix invalidate lock leaks on DAX truncate error paths
Date: Mon, 17 Aug 2026 23:17:59 +0800
Message-ID: <20260817151801.2677899-1-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Baokun Li (2):
  fuse: fix invalidate lock leak on setattr writeback failure
  fuse: fix invalidate lock leak on open O_TRUNC DAX failure

 fs/fuse/dir.c  | 9 ++++-----
 fs/fuse/file.c | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.43.7


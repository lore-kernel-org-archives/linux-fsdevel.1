Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EA3B0AFC;
	Fri, 20 Mar 2026 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011887; cv=none; b=JuXHtoEyqGX7DoDERHOVQXMNmz0ulwey+tNGj7Qauc+67oQbSM5oxCPUSX+8LJqHAcqB/GD+ci38B7ByKwvCG9a8ZIyg+JIus3ea/DhqBXpx6d5Gh2PoJ5/97K6S7xHZcJWKXeikPM3KOL6WdXCYilOG8I2ZaIdlQOCBGDPRjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011887; c=relaxed/simple;
	bh=EZm4YS99cso2MMHIKlS29TRpwS9+iIyDX3B1uNKXxaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PWTbB2xnTD3UzeTOLb+PDg7jolrQ7wvIdMqaAfMXC9GjIJmPF1IhYw36Uro4zS77CsvLQZNbUPmgiGt2G7iGc4HLcPPiIoy2LT3ZiyTc11kXMvpRN5kbfl2PSQqUxfN7tAqr3fAW+teDrp2IQS91tnk2Dyn0vf7UEKOOT3bed28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=YO782nlv; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="YO782nlv"
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 37b841bad;
	Fri, 20 Mar 2026 21:04:39 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: slava@dubeyko.com
Cc: akpm@linux-foundation.org,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	jianhao.xu@seu.edu.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava.dubeyko@ibm.com,
	zilin@seu.edu.cn
Subject: [PATCH v3 0/2] hfsplus: fix lock leak and refactor hidden dir search
Date: Fri, 20 Mar 2026 21:04:36 +0800
Message-Id: <20260320130438.988629-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d0b590fe703a1kunm169b9ef12514e4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQh5PVklNGh8fH0NDT0pMGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=YO782nlvvqUtc+WK1kChbmgTp5cCxvJIYE2F912IiGom9YobEdNYnuFS1TA8C7SBKirOcvaQDdYj0JfIjVPEGh1V4Su6GBqcOT4IJKJDlzZpozSosjbZWqRPez/qkZ9sH0lwkKIYVLRPKXwYGhepcLMvaghnl0/5aXnreAwpEEU=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=9ndjL+FtMGUJwTnEXuogcOZJoK1lPB/qB+GP0/8HFFw=;
	h=date:mime-version:subject:message-id:from;

This series updates hidden-directory lookup handling in
hfsplus_fill_super().

Patch 1 fixes a B-tree lock leak on an error path in hidden-directory
lookup.

Patch 2 refactors the lookup path into a helper to encapsulate resource
lifetime and simplify error handling.

Changes in v3:
- Use unlikely(err) for hfs_find_init() and hfsplus_cat_build_key() checks.
- Map hfs_brec_read() errors to -ENOENT to preserve existing behavior.

Changes in v2:
- Add patch 2 to extract hidden-directory lookup into a helper function.

Zilin Guan (2):
  hfsplus: fix held lock freed on hfsplus_fill_super()
  hfsplus: extract hidden directory search into a helper function

 fs/hfsplus/super.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

-- 
2.34.1


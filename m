Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278B42EEA3;
	Mon, 29 Jun 2026 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747969; cv=none; b=Rtx1Pmieo2FeX346a8pBXjyFZIVq49P8l1dEiJlpQ0v77+gZgNYa9kPMyQ778OhfNzr+2NEEQEnRFR/jxNHV7GMSfqLH9Ntub/2doJ+djs44c1ewFi8TbF2wgwp8GqdqSepvc9DNHm2ON+dAOZl2tSpObwi1Q0nqs4vu0R0EYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747969; c=relaxed/simple;
	bh=yULRd5hH9yPTEC/uL7OzkOQKfywNhOkWradH8m7U50A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYIG/khWv6JJ5UDWPEILKh0U9shNF5kx+QnTKcymTiWJ+7KVIz1ROl9t7rbkeGcKjxW32d5PoJ+pfQYodtHiU290/3nf3WiFvmYqt+gFOsXvQMcwaNYTyfIYE8SCtbdXC4ZQBqmBSkF0ouznZz7sRf5Qgfb1Kxswiv1Q4GNn+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Uxw4a9fM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Uxw4a9fM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XaU6I4utoFAI77DUDFWcQiwtBI/mExuqELPwROmi0tU=; b=Uxw4a9fM5yKQFgvKxSwaBnBDNw
	h5rQA1KaW7ndiYPm7/DsJeacyhUF2eR24ZNTVfa/GGgiAhaJiSzBddeIF3iiJrh+QfA+CWMweS4uv
	/T2GDl7r4+0h0nh4ZdTo5qNGoYngWbaybscnzAVq7t7Pujh/hFDvWuSdPoyGpx4SHHqeXes46e/qy
	mtoUL9argkvEJStXXwTsCijTZHX3qv15+8YUaXqomUU0ouoL8RywP4obqgiPjKcKk20Ait4Rjc7JA
	fiuFy/YpyMu4TX8XC6TisNdUgqqbVktMTioWkuei1MUgzOdNygXHn0eWnGDC0LcRcHi1KBNB+KAW5
	LE8Et6sA==;
Received: from bl21-120-122.dsl.telepac.pt ([2.82.120.122] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1weEB8-006ftz-5r; Mon, 29 Jun 2026 17:45:46 +0200
From: Luis Henriques <luis@igalia.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH] posix_acl: remove useless code
Date: Mon, 29 Jun 2026 16:45:54 +0100
Message-ID: <20260629154554.29093-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is just a trivial clean-up: it removes an unnecessary return branch.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/posix_acl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index b4bfe4ddf64e..6df5de23aac4 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -740,8 +740,6 @@ static int posix_acl_fix_xattr_common(const void *value, size_t size)
 	count = posix_acl_xattr_count(size);
 	if (count < 0)
 		return -EINVAL;
-	if (count == 0)
-		return 0;
 
 	return count;
 }

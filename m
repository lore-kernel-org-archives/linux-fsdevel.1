Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99A73F7860;
	Mon, 18 May 2026 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104939; cv=none; b=CbK/q0Wpb7m9ZNyYTB40BfsFzUCLiEWqxch0CEKSZKMlTQo8mWCh0/dlA5RZUt0t0RmwQbI9RdTPyhDPKj57kJwu2+bwbST1Z4UnZOZAjNlg8pYFdqH1b1vo9ARcfEZ48uPU5D2tIMSsKLZfrSkF0E3QGD/Pr0BaVqBT2eWZ4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104939; c=relaxed/simple;
	bh=U204ERnUanMPne1YFbGJvFhKXeqrR5VmCmE1lCpidZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/JmVQBJA2pKTONNH2e8HYz6SsBgKcnIx3Wa/wilYBn2WKQKZFKE/U9MPZ88rAJ+Sn5hJB2Wzp00QWfKbeiiWvfMLtDq/KAceLiwqLIYUPiHwCQo/0ngpwQ4DgOuXlz/68xp3+Ayxl2LApw3C7a8FOlD18CBaAE/57AcRaBqYTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJcBMV1o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJcBMV1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943E6C2BCB8;
	Mon, 18 May 2026 11:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104939;
	bh=U204ERnUanMPne1YFbGJvFhKXeqrR5VmCmE1lCpidZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJcBMV1oXQw5SIP+uJwSHQyxGmdaZl1X0ikMbJrzn1d/9lDOtL9slHMAfVm5iwgqh
	 j9ORHFk8RZJtz56zAi903+BFSqJEmevkVaK/7AUWYBfJKkSHc4gjWfyieJWheFMzXN
	 GlngS7iPMYxyBslFjg8xwdiLNTob7L0/ZAq8EfPRwN5BmbhJ1I2C98XHxeTlQGUijb
	 fx5MCkAwmyV/Yt95B7MXgthhqm/ry4u7UO/tpgHOQ8gvueAKmIve+h6jdrsa4S3UYd
	 8LaInOahjAgPBX52RA9hjfbQXuMydeDH/4ALjbzcswvJ7k9FvzGObCXWkPgLkBvSVX
	 Hgh1ZOaDF+eJQ==
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	chizhiling@163.com,
	linux-kernel@vger.kernel.org,
	charsyam@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v4 07/11] exfat: fix implicit declaration of brelse()
Date: Mon, 18 May 2026 20:47:01 +0900
Message-Id: <20260518114705.9601-8-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260518114705.9601-1-linkinjeon@kernel.org>
References: <20260518114705.9601-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

exfat_cluster_walk() calls brelse(bh) without including the header that
declares the function, causing the following build error:

    fs/exfat/exfat_fs.h:542:9: error: implicit declaration of function ‘brelse’ [-Werror=implicit-function-declaration]

Fix this by adding the missing buffer_head.h in exfat_fs.h.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/exfat_fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index cd38e71d3e8a..08d22d2581da 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -12,6 +12,7 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <uapi/linux/exfat.h>
+#include <linux/buffer_head.h>
 
 #define EXFAT_ROOT_INO		1
 
-- 
2.25.1


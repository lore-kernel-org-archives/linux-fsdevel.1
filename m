Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633C3793D4;
	Wed, 13 May 2026 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671349; cv=none; b=at+zrB84WQo2cKwvGLSUUGWPGs4M99o5BXj0tQBHBvOekV86qRCRbeo0Pch/BSE+NEfV8N0Yyp4swRA/fG2Jqfn6R2QzZmxhCiei8oaJzKvkdAClxAC4dKC2G4stu8hx9by4pPNdHor7AEG1seZyJk77Ol9xljLpjGX4SSCzK1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671349; c=relaxed/simple;
	bh=rApi22cpqSxyEsurK1XKbL52SxF+OhNqJ9qmRlG3i78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kj60YrKoBx8AmhyYFUPxmYtrrWnAP3kClnw5Ekf2r5bzNBEt3TVYkf32FocZRc/TWD0/sZWIXCWxzp2G+TxOX5+/qK9+9t5Fo6tN4EuSf2Ba5MLNwUo3rpCy9tAokVh9Yr5IuCCIKA7ynVRRTKY6MOoNhBwouQGCO9NBTnEryxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIPjMdfY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIPjMdfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB19C2BCB8;
	Wed, 13 May 2026 11:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778671349;
	bh=rApi22cpqSxyEsurK1XKbL52SxF+OhNqJ9qmRlG3i78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kIPjMdfYL3NVyW4EshnRtMEyw5EkshmU9Q9mfJ91qnHAkarRO5fhV7LkXYZkjF8MJ
	 LXzCsAfMCfOq7oKEQS6JC/Ndvf74budzYYUpO7Hy3EJnlfvBjzeGUbHJePNcKyzlMa
	 DIiI9cOkjL2lCa7KeQcguKfOattvu2zL3npfVkK36zCpv11oy7h5uOZz7lvlQQduMH
	 u0WIun2VwbLRP8xdz+M9rkgmyl9Exul6kDmyeF4MtVVhRUkxrSDQdYFf+n+JiP/pJA
	 0D9hMk0SXn9G87ruyglBes5t2wlqzviIAOrGyisXDPhINH++R2GW6y0A+obTdmfzyV
	 CcYjQsTP/Mtvw==
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
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 07/11] exfat: fix implicit declaration of brelse()
Date: Wed, 13 May 2026 20:21:52 +0900
Message-Id: <20260513112156.9122-8-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260513112156.9122-1-linkinjeon@kernel.org>
References: <20260513112156.9122-1-linkinjeon@kernel.org>
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

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/exfat_fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 415f987afa9a..5ac52e9079b9 100644
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


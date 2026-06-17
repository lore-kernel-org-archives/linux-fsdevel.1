Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CB33B7B97;
	Wed, 17 Jun 2026 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693266; cv=none; b=PU7+aa3AkKPJkLayIV/S2w9cLxl3rXuz1XGl/xn6p2u0CiUqPOQxWLI5UFxkvn+kV5vVzRlFSeK5D3i30A2X6Ry4XEq03m/wuFqmoAAWRUweYRT/6iQ1VQvRg4Hrg2eT2WEW26MVHKFQR3osY6oI2/naWlxjldeH4l+lsj4ybdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693266; c=relaxed/simple;
	bh=7Fzii2DBxTjnJZmKo5S+yHFo/LwlJC8V83NEgTMhb30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lwgza4p0VbMrknoMo2/IsW9P6EKnDFDwr/Zq2M7I3S3uLhJ5xe9aJeNB2iYnCuqO0dG3cBcMIbdjQH1Tg+Cn+d6h/bM5+L64i/OPCYBQU4mIOImy/nQWGk4BxtohmmMZldwfE1K4fn50gTIQrwI0Gwh+LFmeFblxKy76LUeX7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=a4cdlAPw; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="a4cdlAPw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=CqVsoRMkrP05umSy/D9UxLX+VH8t4Avwkdn1t6O8Xzw=; b=a4cdlAPwrtR9GA
	8+kwcqRddL18J9dkAyUeBXYL1fzfBUV/kZzT7vJPZHkC5MzRCgCWydA9T1kRAqe/qRCW8+da2v4vF
	/RLE5ALRPZqn4JAqDR5rJnFzPe/62/Vn/FKUvMlZ0Hv4z9+DoWxhRCA9IQuyV8Se41/bzy6r8gFDh
	UsuBv42OYZ6vMKkMx7zhKHar/WusHhUA1/iYDnMbvB3v+ZpJnxIyrGk8ETtHAYSU8ALjgrFao2bRY
	ALmPUEalOrOAh5TG8JnT6iWRa1J0su382QYKAbxYP1ycEya2UvTPsRG0Uw/3swbqn0hcImYlWtklH
	/Q8qptY6FW4RoP29zyEQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wZnnn-008UK2-A4; Wed, 17 Jun 2026 11:47:23 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1wZnnm-00000003mN5-48TY;
	Wed, 17 Jun 2026 11:47:22 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] fs: nullfs should include mount.h
Date: Wed, 17 Jun 2026 11:47:21 +0100
Message-Id: <20260617104721.900914-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The nullfs_fs_type is declared in mount.h but when declared
in nullfs.c there is a warning as mount.h is not being
included.

Add include of "mount.h" to remove the following sparse warning:
fs/nullfs.c:66:25: warning: symbol 'nullfs_fs_type' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 fs/nullfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nullfs.c b/fs/nullfs.c
index fdbd3e5d3d71..95079202fd48 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -4,6 +4,8 @@
 #include <linux/fs_context.h>
 #include <linux/magic.h>
 
+#include "mount.h"
+
 static const struct super_operations nullfs_super_operations = {
 	.statfs	= simple_statfs,
 };
-- 
2.37.2.352.g3c44437643


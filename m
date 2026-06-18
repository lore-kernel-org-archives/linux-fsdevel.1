Received: from mail.aminvakil.com (mail.aminvakil.com [178.63.189.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CA9280A56;
	Thu, 18 Jun 2026 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.189.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795692; cv=none; b=sxn+veD12eURkgTgk8b+uJlR5SzTESl8cxaUJ8lLMYXje7+YHnrk7OaPXC6JMDlxz3KCPLTqvVGpxG3h0A4kSgN6k8PuUIjONB/lvkje9ta2ammRekacyB9+X+Kli1v5yf2Tx1eG+xZqSMjxRSFoL4ADcLPtwJ/hL2xWhWMWi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795692; c=relaxed/simple;
	bh=68WYQSNGzWZ9bv8eg58C3+nLY1wwGS6zXyF9la0Yizo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o45KT2x8pn1qfJrolNWdtQ6n1O2xhFLfs4tFjzXBkxQ3VHc+LPPF0vN5SiegTl3mFBK6rhysN35YKU7DSsZqLbxz37LMIgEegUAY/sQaWqaGkbdY21i7aMYalZZQoWU8TE1QwyKzAHhV016ji4baVMYVPQank3KL8Gn5ddhR20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aminvakil.com; spf=pass smtp.mailfrom=aminvakil.com; dkim=pass (2048-bit key) header.d=aminvakil.com header.i=@aminvakil.com header.b=c5hMi2qz; arc=none smtp.client-ip=178.63.189.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aminvakil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aminvakil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aminvakil.com header.i=@aminvakil.com header.b="c5hMi2qz"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92DC045280;
	Thu, 18 Jun 2026 18:44:47 +0330 (+0330)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aminvakil.com;
	s=dkim; t=1781795689; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=bOdFmT6w0v/0/PfhGgMSeh5hplKkoyzjYVv0hd0ZReY=;
	b=c5hMi2qzEnkDihaekRbrR9Snx1iGkUHo3eSBaBo7IR10K/j8muhhqVIaZr0wxyu+NpNmuu
	tJ9Q0ft1cj4RjDkgSuFVzLmtQleOZdjhay/jXxNiTnZjnvQlJDkP8vFYlfmUpVRO3Wa9XK
	a9gX+SF3wVXd2zGFIwigjWGVI0aDDVYH32h0Nl2lnEtRQ5J8mQlswLq1K4F7AilAKGu2QW
	TDCNrRvOcsuCaFrlwyMaiGnAMj0ecF+Vx+s4wQg3JSu1abO350cQzAVwJIB5H/zYGvHZTT
	MMMhuD1yPcyRPLK2qAHfpyg2EEQGihMpmg0w11iPIbhk9f2auK9quJtfymnIlg==
From: Amin Vakil <info@aminvakil.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amin Vakil <info@aminvakil.com>
Subject: [PATCH] selftests: proc: include fcntl.h in proc-pidns
Date: Thu, 18 Jun 2026 18:44:44 +0330
Message-ID: <20260618151444.124739-1-info@aminvakil.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

proc-pidns.c uses open() and O_* flags, but does not include
<fcntl.h>. This breaks the proc selftests build with errors such as:

  error: implicit declaration of function 'open'
  error: 'O_WRONLY' undeclared
  error: 'O_CREAT' undeclared
  error: 'O_RDONLY' undeclared

Include <fcntl.h> to provide the declaration and flag definitions.

Fixes: 5554d820f71c ("selftests/proc: add tests for new pidns APIs")
Tested with:
  make -C tools/testing/selftests TARGETS=proc

Signed-off-by: Amin Vakil <info@aminvakil.com>
---
 tools/testing/selftests/proc/proc-pidns.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/proc/proc-pidns.c b/tools/testing/selftests/proc/proc-pidns.c
index 25b9a2933c45..6f7c10fe97b3 100644
--- a/tools/testing/selftests/proc/proc-pidns.c
+++ b/tools/testing/selftests/proc/proc-pidns.c
@@ -6,6 +6,7 @@
 
 #include <assert.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <sched.h>
 #include <stdbool.h>
 #include <stdlib.h>
-- 
2.54.0


Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD66339719;
	Sat, 22 Aug 2026 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787424170; cv=none; b=Azxow1v30NcA4X+zIQyw+cqpeaLAMJjOaCyyyC1BvaV0epTRdXv/5QB+F7iEKZQWK+UEE9R4UUkgQo8ttl2MWBbZ24NUoEqLK98KopEqNlSazeE3SQ2VqH5yY63zyU1d3NnEHwzrX1UKwBPG8yXFwUUNNPxy4B9/8fjLL9IL4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787424170; c=relaxed/simple;
	bh=a3ENyZS/Bw+7KPOUtcZNuf6hb42rPx19RZkJyB3UPro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uE8/Y82iNfjzTaBWjmv9LYdaVJ9fEwp2EDJafiujSivYPrjBfYodLIMIWaiIUhvG3myprRGt6Q/E2fqOGmrAvgriDsmfC/1kOfeu7WeLmJjdyx2t5CetAPxDbT1ujk5l9ewzYpKAXi0kbUe4ZE1EKa/YWzcCAVvvgw1KjssahOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=Dk5TSYA+; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="Dk5TSYA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787424164;
	bh=MnlwUwEDf8lmbJDwCUJHV2AKAh8IRqILbvqIU3XHRr8=;
	h=From:To:Cc:Subject:Date:From;
	b=Dk5TSYA+JO5nvI6kQyiWgHHjj32PKRQaVAKn580XS8SxQbpBFIDrX/30/IvXgwT4y
	 HrwTuk+YpQeYHFTJePTblN1ohl6cS6qIHskRfuRpTEa5RT6PzFkVjRSWb0Aa7DH4eG
	 vMW5rYUGVIfhy79rdd723lxK1LZ64+UKlsSMABN4=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with UTF8SMTP id 4hS5dc02k3z1118;
	Sat, 22 Aug 2026 18:42:44 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hS5db4rMvz110f;
	Sat, 22 Aug 2026 18:42:43 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	include@grrlz.net
Subject: [PATCH] sysctl: drop the pointer dance in proc_put_char()
Date: Sat, 22 Aug 2026 18:42:44 +0000
Message-ID: <20260822184244.13569-1-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proc_put_char() still drags around a char **buffer alias, writing
the char through it, advancing it, then copying it back into the
slot it was loaded from. That only made sense when the buffer was
__user and the char went through put_user() (which could fail).

Since commit 32927393dc1c ("sysctl: pass kernel pointers to
->proc_handler") the buffer is just a kernel pointer, so the alias
is dead weight. proc_put_long() and the skip helpers already advance
*buf directly, so do the same here. No functional change.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/sysctl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f7b7598..2b92b30 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -350,12 +350,9 @@ static void proc_put_long(void **buf, size_t *size, unsigned long val, bool neg)
 static void proc_put_char(void **buf, size_t *size, char c)
 {
 	if (*size) {
-		char **buffer = (char **)buf;
-		**buffer = c;
-
+		*(char *)*buf = c;
 		(*size)--;
-		(*buffer)++;
-		*buf = *buffer;
+		(*buf)++;
 	}
 }
 
-- 
2.47.3


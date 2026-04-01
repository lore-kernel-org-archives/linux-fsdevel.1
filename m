Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9928725A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056922; cv=none; b=UiRCl4ijOAkFTSEOWQP+bsxFiLrbGkYgLvjcrGh+qEjCfkdRknjP4AdTscNPGOJu0l90NjDOGmQf2wqc/O7GnGg2LdfhwltV30HWCLw24jCtGWoR7DVmDcwPgkDiMaAEQ2RPwJluBVCGs6B8PgiZDQUwS8iYSsYJiLsBTeufNEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056922; c=relaxed/simple;
	bh=HS4UGZQ1zzADaK78wR3NC5vUlfO80M5mYOCHTc0l3KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szeKpRFxYtOOBm7NVEXSjhuw3XTlgoWRYT/j2OCl7ktcTaLCSqUkcaxl7qLmFIrA1uS9OvB2/DP+Z6e+2gdA3yGphMkK6F4DkuZOZl2UFLvG3/M3/0jrkYh/6msWnN6pI/rSw/eJwluv5jsDXsOPpkfE7bIPKiQUeRG6tkUk3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KO1/IbXU; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KO1/IbXU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775056908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7zEkV6rAlsSBEPVbyFMZ428Oys5VqsSf2SLVRMYelsA=;
	b=KO1/IbXUSAZ+YOxPEAWkfbtRL5TDn38230kQD8+4o8hbAMYXxJCijkmC+sSA85KxcCscR4
	nuvXT2sgV7BNue+XNd4kXP6gsQL5tvpidi5gfOVCpxG5etLDbUBZIdq6ofkRj04bh3QjOk
	DI2hjqqy3qwI5AAm2bCmE+HDgvR3Fj4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] exec: use strnlen() in __set_task_comm
Date: Wed,  1 Apr 2026 17:20:40 +0200
Message-ID: <20260401152039.724811-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=658; i=thorsten.blum@linux.dev; h=from:subject; bh=HS4UGZQ1zzADaK78wR3NC5vUlfO80M5mYOCHTc0l3KA=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJlnzY//e/yhtna51vqq/3c3fVlTtmGD/bHuC6qpbNUtR TqsDvLCHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRz08ZGb6nzqg4Xv+Ff+V3 wZnV4rICs7Pjgjh3TVv259xhtc/Xkmcw/He4Zs6zPuGeFd+M4yZKu/3+7ngze7uJ561fcw5YrUm e8Z8TAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strnlen() to limit source string scanning to 'TASK_COMM_LEN - 1'
bytes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9ea3a775d51e..ba12b4c466f6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1074,7 +1074,7 @@ static int unshare_sighand(struct task_struct *me)
  */
 void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 {
-	size_t len = min(strlen(buf), sizeof(tsk->comm) - 1);
+	size_t len = strnlen(buf, sizeof(tsk->comm) - 1);
 
 	trace_task_rename(tsk, buf);
 	memcpy(tsk->comm, buf, len);

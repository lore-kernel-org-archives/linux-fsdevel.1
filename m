Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437CD4307A3;
	Fri, 10 Jul 2026 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694774; cv=none; b=iTPHoHS+J5pQJCVGsoZB3CPe4veBo8sfuD6f8xhQMXylYuJ/oyGBNS49rjcZi9meWUGIU3qDTBdsdZjPEHJViwsKkZzP9fI6bzqgRUHsvJEeKxUKN22+oK10u98SAb4g+eEsIArYtMsew9LcU56YG1PTD4+gSc+aqfpoiNn7zk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694774; c=relaxed/simple;
	bh=Dw9xdEGg9wTCqFqxiSyXD+ZhJ66SK/WH3omelNAvHto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uz1QgYjsso1fgcgdehPd5NbmoLNU0+morbn4IYxuVMtyJXuAf/GWC3ca2X6PqVwnmT0zoPk6laDlGEEYeUPRM7HUiP9WniHx2AcXTTIesjFrMUtAtr/z42Go5lr9/dIoSDGSnulh2lV9LQMV/UXKTWo0E7LRhyRa4ma0OhGOoOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s2bOTWyw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bo4CTDLZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s2bOTWyw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bo4CTDLZ"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783694771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVbhUuCZle+3NabaAPt71woodETjuGi3B30OSytnWs8=;
	b=s2bOTWyw+HMWtsyfRjhgPcKx0k3aLHP2TE1E8XelbSxB2Zkg52XR6hFajYll6wgXUWJHyI
	F0mvenJubaEmWBi3utySOD7tpDiDoyXTd01gZWTLY6UX/jIAfPllCI6ewbmEtoo1U7D9Fk
	FcjExIM83oJfYEyoU1nrhT4mQxRFBxgaQ96AUZbAsEZigv/tf9wI4gVPNS88SnAyOcxzxD
	3DHmIZXDd/zRACCb09xmndgMyEV7MTaRNFQflqWbRlN/b11iK2ZlGDdkDeOGeF0c1Pg5Gl
	N+++a5ulZ9EqyUhCe0uMm+orsnxCCL0oUbvqve2xO4oh1XAMOZFFN0+F32xbzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783694771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVbhUuCZle+3NabaAPt71woodETjuGi3B30OSytnWs8=;
	b=bo4CTDLZw2UXHbL6PmUhs1IKnjsu1/uEXLf3Eb21N0+OYQiVN9FU5JPEPK/IvekCGpYTiU
	lUOTmk2AGR25fEBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Chris Down <chris@chrisdown.name>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH printk 2/3] proc: Add console sync support for /proc/consoles
Date: Fri, 10 Jul 2026 16:51:52 +0206
Message-ID: <20260710144609.194487-3-john.ogness@linutronix.de>
In-Reply-To: <20260710144609.194487-1-john.ogness@linutronix.de>
References: <20260710144609.194487-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update /proc/consoles output to show 's' if a console is
running in sync mode.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 fs/proc/consoles.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index b7cab1ad990da..f9af07d161412 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -25,6 +25,7 @@ static int show_console_dev(struct seq_file *m, void *v)
 		{ CON_PRINTBUFFER,	'p' },
 		{ CON_BRL,		'b' },
 		{ CON_ANYTIME,		'a' },
+		{ CON_SYNC,		's' },
 	};
 	char flags[ARRAY_SIZE(con_flags) + 1];
 	struct console *con = v;
-- 
2.47.3


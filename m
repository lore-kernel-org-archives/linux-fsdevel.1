Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042737CD49;
	Mon,  4 May 2026 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887217; cv=none; b=W4bMQOdKH818VGSICIh1eNX/7GxbuJr4hx+4ljB1wrNo/mIPblQXuy+Ew+7etR+hHHf8haqb/Hpsi9L4NiQ3K55XZx33JD2ulM3htnvH3nazEl6x52+wMoyW69wlY5TQch/5hoAmsEGqLV6guoPNXRlek8F2D6qXSMtAtmSj/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887217; c=relaxed/simple;
	bh=f2sOt9t/Nc7lPFpTZEDpIpO59t74OzxRJgeKcPUSTUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q400UuuKc5PMH5zYmmeQvtTV+amjbVjyj3sX/Dyo4WTI6m29WS1FnZBSIxmKV7uqv4/3J+3ACzCeryWADzzmBn5oQ9cXaPkPXVaUdoAsPYS5fTO9eZxL+7hdtvquD9ns6p2uycviyIGTJeOcrBHYRLZBbCSRtCoUl738tzQrYi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZfEnFY9m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=desvd651; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZfEnFY9m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="desvd651"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777887213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AX3UrfvA1Ikfg089WZjhUzDCbqXp2g4JW2YQG6OsmjU=;
	b=ZfEnFY9mf0iJZB1ywy4UBaWbZrc8H/EtXlIfbBtfonmSQSi2Am5KYfHBpV464WS0iKBQVk
	6v5ZWvddDmCBlBV6ifCojrzz5ZmWlZymKx08Vhmsx3PaIqzeiLQKLjSS4nCV8fDXzlgvvJ
	rbnYq640vbPkkr3ZwcpdcGcj7PDaQIWiEj0Re5BcyHA+dlbBYcDZyGYiqqPjjlfWwt8fI1
	BtY+bvEi3g54Wp66xeAsMpAMmpmQ3qGGHfUgPPQ2oLjfTo9P7/E4P8xN3U4sw7yeQOsSj9
	fLIiA/IC7ghbqQx5j9hCDkBnKUz1LzCG0YrIyP2UNZpTkGo9hUrHXB19fEqR7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777887213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AX3UrfvA1Ikfg089WZjhUzDCbqXp2g4JW2YQG6OsmjU=;
	b=desvd651teQu4s3xchQ3J/eCMojhKG1JMLBIUG7dUu/RPjOGwGT2ntEK8YhMREvL4L9KFL
	c1ifPU38TgG8EEDw==
Date: Mon, 04 May 2026 11:33:17 +0200
Subject: [PATCH v6 01/11] kbuild: doc: add label for userprogs section
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-kunit-kselftests-v6-1-712d3d526d97@linutronix.de>
References: <20260504-kunit-kselftests-v6-0-712d3d526d97@linutronix.de>
In-Reply-To: <20260504-kunit-kselftests-v6-0-712d3d526d97@linutronix.de>
To: Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Nicolas Schier <nicolas.schier@linux.dev>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Christophe Leroy <chleroy@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777887211; l=835;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=f2sOt9t/Nc7lPFpTZEDpIpO59t74OzxRJgeKcPUSTUw=;
 b=DyzVL+xRfpFMe5PKS783jTTg3qoqmzhHUZ/6MOAtZDAx+lIJdXP5aUWBZRLCxDwqpa+DBjMr0
 OzcGhakd3wbBfx39rgZhAF4A3/a69mMob7GDZWZXTJML3mGcL0DyBTH
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some upcoming documentation will link directly to the userprogs section.

Add a label to the section so it can be referenced.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
Acked-by: Masahiro Yamada <masahiroy@kernel.org>
---
 Documentation/kbuild/makefiles.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 24a4708d26e8..6e54ad4cfecb 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -891,6 +891,8 @@ This is possible in two ways:
     This will tell kbuild to build lxdialog even if not referenced in
     any rule.
 
+.. _kbuild_userprogs:
+
 Userspace Program support
 =========================
 

-- 
2.53.0


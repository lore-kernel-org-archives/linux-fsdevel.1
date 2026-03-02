Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098C3242AB;
	Mon,  2 Mar 2026 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458125; cv=none; b=JCCCOYAHb6WZXBiGjkTmqihzWHg9jdyk3Q585AVW2F2Dicv8ZkvbbPSTrWr0Qvr9rfE0sFBFE8yBQNPNoibspiwYlOX7tdB0ycVAwXlvyF56gmOqeVG4Bbb06be3oK1N+Fh33C4gI1xYRXKdP5bJrqqGKvpan+Qzta7D4zZ1+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458125; c=relaxed/simple;
	bh=FKFw9WDEltFsWTOOSmYNAvvnsX/tHlWIyPea6wX7cZU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIih01IsR0kAR3nLwp9UrRRf5dodOzXhX5FsAfD3G6WUO4qmb3r8WiiTFw0/dKzg9ajELeBc/EQPi4yOm2QO1Xn7ztmF6c9b03nesUkfYKcFCNNnv1aLD2aAmFQUmAPyOlOQKd7u12Pc4OIf3HP2X+ZsEcy6nuU7O1z+kwPu96M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=RaIJo34Y; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="RaIJo34Y"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jx-003blN-9N; Mon, 02 Mar 2026 14:28:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:To:From;
	bh=o2ClYLRupqDrO68wbhPYoX/KO8vhOPlwFWoOd/NbY3w=; b=RaIJo34Y0Q7j2egm9oaHOlOtOd
	qIf5fI6+l/d2wpNaqq8G9dXTQ9MMLD3B96RqcrmcIuZWAbHSJrVvAOsCyxNnHmB0ApiOwjvIA/WUq
	2QHmlroveisu5RbpBCARdjIwFelcSMWSgnuhcGGnezIcVvrdSc/czwp60dIuZ0dJ0UBhYTt3Dir6A
	kPjMxT6Sx+w5jzEelLAoWpF5WZwr5068t7N9pLbu3BuEHsUXyhRpZNDULOe1NTcLEJsTarSsqPA3q
	jO3BiP4+6U4spuDiRYWorjNHk7ZXXdxC/8mJTlzMjB17nS6wB8o7mn+sdiXsOXXocQv+tO32ThUWi
	FRs2OCew==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jw-0001hU-9m; Mon, 02 Mar 2026 14:28:24 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vx3Jj-008UTR-SY; Mon, 02 Mar 2026 14:28:11 +0100
From: david.laight.linux@gmail.com
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andre Almeida <andrealmeid@igalia.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Darren Hart <dvhart@infradead.org>,
	David Laight <david.laight.linux@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Kees Cook <kees@kernel.org>,
	akpm@linux-foundation.org
Subject: [PATCH v2 4/5] uaccess: Disable -Wshadow in __scoped_user_access()
Date: Mon,  2 Mar 2026 13:27:54 +0000
Message-Id: <20260302132755.1475451-5-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302132755.1475451-1-david.laight.linux@gmail.com>
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

-Wshadow is enabled by W=2 builds and __scoped_user_access() quite
deliberately creates a 'const' shadow of the 'user' address that
references a 'guard page' when the application passes a kernel pointer.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/uaccess.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 64bc2492eb99..445391ec5a6d 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -739,7 +739,9 @@ static __always_inline void __scoped_user_rw_access_end(const void *p)
 #define __scoped_user_access(mode, uptr, size, elbl)					\
 	with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))	\
 		/* Force modified pointer usage within the scope */			\
-		and_with (const auto uptr __cleanup(__scoped_user_##mode##_access_end) = _tmpptr)
+		__diag_push() __diag_ignore_all("-Wshadow", "uptr is readonly copy")	\
+		and_with (const auto uptr __cleanup(__scoped_user_##mode##_access_end) = _tmpptr) \
+		__diag_pop()
 
 /**
  * scoped_user_read_access_size - Start a scoped user read access with given size
-- 
2.39.5


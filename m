Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD53F88B8
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676022; cv=none; b=u81UYyU7lBBPvq3uYAuEUgMW03zH44//HccNY060QQKjs1tT7N6YUAtK8yZhkH0v/MLxiHoOIoorAV3cZ0hF3hN+ex5ds7kCI6EoOfjXTe6p+jmwSYfjVfbGKYifKrknXaS1lw6St8BkxPv+5jbkfb5oriNMpZoJ0n/g8zWhCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676022; c=relaxed/simple;
	bh=FvKU1KMxNauxWYEG7K5xbJSNxDdCZCqayB1AbvUm0s0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NaSX1q2GJnY7MAQuWOMq6ZT395XSxsxDJZqDxmNMVxBV93zQFLYcZ6e/BH+pY1ypmKifYyRvsEcpCsepNPSwIz/3cIv0YqU+kjd+9S2UqOuvyH4Hs45gjVn9M68V+Ng+tPcDs7UzQAbmXqH8pSxHGoOUI0f9LX6pyIjAh8e+Dbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1eOk0sg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1eOk0sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126851F000E9;
	Fri, 10 Jul 2026 09:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676020;
	bh=ywj3OSM/tpO9RFBhWxAbwFVrl+4a5zu77M9ARvzXN70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L1eOk0sgBSNn+NBvcHfqDOGZuUYkLtu0mT6EzsNqXIiwvPJNXSZ3QXdpdblrB1+WF
	 CbGt7NwXCJkauourAc8s/u2gJApHrhN2X4kdJWFJhFnZR5KPhoAF5iezWd15FLNZLL
	 w8SFSBTInOagZd6gQkcBCEwYw87OUhtIe+WVr7RpR+R3QqIjvkM4Lrq8iWbhvWJfz1
	 ZPR7wUeeMr/7RnmlP8liGpLDnhJCxUdAP3auCBvrWUii0F3t/db4tSFEEQ/QgwGbX8
	 LCYuEfRVqID+a/whgPACvYtUjqgqsssABfjrZRhKmevvLMHQbk75YPgwAjuYkuYCTp
	 3bkMMNR+Uj0Jg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:11 +0200
Subject: [PATCH v3 10/24] binfmt_misc: remove the VERBOSE_STATUS toggle
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-10-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FvKU1KMxNauxWYEG7K5xbJSNxDdCZCqayB1AbvUm0s0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7InLW7r9146G2PZtwnxv3M1T/wq985lk/6Zy6UfTx
 WVzT/1s6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIFVVGhs0WCSv3/ft546n4
 2aMBM+7kdxYf7LL6t7nrGNeHnvJCbj9Ghk8RprJOnYK73E/2Lvi48PB3af5zu98Ldcuf8RXIvav
 1lwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

VERBOSE_STATUS is a compile-time constant that has been fixed to 1
for as long as git history reaches. Turning it off requires editing
the source and yields entry files that only ever report
"enabled"/"disabled", a format nothing has ever seen in the wild.
Remove the pretend knob and the dead branch it guards.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 9be57f387524..96f9ac752511 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -38,10 +38,6 @@
 # define USE_DEBUG 0
 #endif
 
-enum {
-	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
-};
-
 /* Entry status and match type bit numbers. */
 enum binfmt_misc_entry_bits {
 	MISC_FMT_ENABLED_BIT	= 0,
@@ -611,11 +607,6 @@ static void entry_status(struct binfmt_misc_entry *e, char *page)
 	if (test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
 		status = "enabled";
 
-	if (!VERBOSE_STATUS) {
-		sprintf(page, "%s\n", status);
-		return;
-	}
-
 	dp += sprintf(dp, "%s\ninterpreter %s\n", status, e->interpreter);
 
 	/* print the special flags */

-- 
2.53.0


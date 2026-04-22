Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A53CF692;
	Wed, 22 Apr 2026 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857398; cv=none; b=kqaEeMYaCrmT5lYY4YSS/MNwciuRx9thBBWzspWyyY+qpvTdtbdr8qD5MjZe4C7/1/TBGvUOlKF4jdJNCgN6L4iwVQ78N468GO13sqVpstkxbd3q4p/SMWY0RsEGYplxj+SmHfpOIMKde+J3c0mVJBu0CDZoOLHjWL8F9SUf+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857398; c=relaxed/simple;
	bh=cIJ29G+FMTvUgpAEP1ioMEAE8xKc9qyZE9tprcAxfDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Eg4aepIknFnk+jAvKU+RlTMlwoGdSkyOtK2SMYgyICXwjjCzxRm7RSkn51fhYkitsKu334ZLOIyAyeT2frMiDBM62fGBwl4MHAcZN6wHUZVcg8osNLRiHcOKGcS+7u3BFFalAr+D0f20htChkvNE9fdLDURIQ4r8ZjWI/RPGq/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWVKU+/w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWVKU+/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFC9C2BCB4;
	Wed, 22 Apr 2026 11:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776857397;
	bh=cIJ29G+FMTvUgpAEP1ioMEAE8xKc9qyZE9tprcAxfDE=;
	h=From:Date:Subject:To:Cc:From;
	b=hWVKU+/wbGdcsYmm2gflVEUcbYok1xKtD2Nk4/rWJvhBYn0AkoxsSB5GPe9nEU35K
	 +AlFnYGixX3wJDnPfsSo99UE79yXRhLnlt/+ewAcMjHJOUJKf6G025YFqMO2huxTCW
	 it/Nkv00jxLwYKJREAI1mWZNDkHG19X8wTE7RA+g/VTNDCLZmFFXR2QSaHPwgzDMzW
	 OaBi3ZE/pCAoEnL9F7SZOPGjWcVSrpNgSEAQwSRzXTT2ykW8p1SIOHA06kb39Rh5Eu
	 RCBrwyTyjuBILJ0UmbjYjlFZoZxGECfK3cigz7xixUimNZaEU5rg480bQdQra4nFQR
	 VDgXxBAnj9jxA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 22 Apr 2026 07:29:48 -0400
Subject: [PATCH] dcache: add extra sanity checks of the dentry in
 dentry_free()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-dcache-warn-v1-1-50155e1b40b6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyMj3ZTkxOSMVN3yxKI8XWPDpBRzi1RDi5RkYyWgjoKi1LTMCrBp0bG
 1tQAc8rijXQAAAA==
X-Change-ID: 20260422-dcache-warn-31bd78e18dc3
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cIJ29G+FMTvUgpAEP1ioMEAE8xKc9qyZE9tprcAxfDE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp6LExiDkVutYUx+LirKqgO02fWe61q3yGvNNUQ
 ySBEqLH7rCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeixMQAKCRAADmhBGVaC
 FYHeD/9Jg6pI9MW4L7Gw7SpO4pag5cGRGTzvoY40Q12Lxs0Zi2wNRhDOLgynz/ZJjK1WO/FXlrs
 VlqzX4XGa6uMDJwKFhG7FyU5VmNEJ6oUQ23gZ1rt4XGd1qBQYpTZQx+ceICwxm2RUOFmlNqumSs
 iiEkcrkVyGZ0BOOWk0iChKHyiO9w7dH+WrIZQjBUXqkxQRqAcOODpreodrIXSxKNGrYrrkUqyyV
 PaBc+avJ/pTyGSdOYs/jKLCITO4QV8lNdVPcmGTZAtbIybE99wbE0+MUK718rKVim5D9qynBE6M
 QcCTSZvgmDWe+62VTlAQ50MIEpPy/OUG8/tak8nvcckpGit8A8BUWnA+MNc3BLG2zq0GiLbenwA
 fyCqicehM9FDWs1lW8M3etPEU9wR5d+okap8rBIPQq5UBq0qDkVr+R1KgXKuwcEgZGmIeKXXAk7
 LobhT9UPmgdRcKe8uxoZ/COzMyvs3Bgnmr5kIUPE6BH88dH60qEcasoqUHXw2g8GApw7oOrYoAH
 N1wKjE2mQxnso6lNjua9u6YerAMY3ssusDXLyhlzi/Z8pCj2C4+A6uVKrWpzUAc3iJwLVVM1sFf
 uS5QMeMyqTFXCLXR2iylAPOogVtiStWOdT0e1OS11Jae7Lt8/M8ihsOx7TenN0llZ7r3ZTDJUPt
 IkTcpX5r4bRit3w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If d_flags isn't what we expect, then it's good to display it. Add a new
DENTRY_WARN_ONCE() macro that also displays d_flags for the dentry.
Change D_FLAG_VERIFY() to call that instead of a generic WARN_ON_ONCE().

Change the existing hlist_unhashed() check in dentry_free() to use the
new macro, and add checks for other invariants of a dead dentry. Notably:

1) Ensure that DCACHE_LRU_LIST and DCACHE_SHRINK_LIST are not set.

2) Ensure that d_lockref is negative

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
While chatting with Al about this elusive UAF problem, we both noted
that it would be nice to know what d_flags are when these warnings pop.
This adds that, and checks for some other invariants in dentry_free().
---
 fs/dcache.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2c61aeea41f4..210df5c0a1f0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -426,9 +426,16 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 		this_cpu_inc(nr_dentry_negative);
 }
 
+#define DENTRY_WARN_ONCE(condition, dentry) \
+	WARN_ONCE((condition), "dentry=%p d_flags=0x%x\n", (dentry), (dentry)->d_flags)
+#define D_FLAG_VERIFY(dentry, x) \
+	DENTRY_WARN_ONCE(((dentry)->d_flags & (DCACHE_LRU_LIST | DCACHE_SHRINK_LIST)) != (x), (dentry))
+
 static void dentry_free(struct dentry *dentry)
 {
-	WARN_ON(d_really_is_positive(dentry));
+	DENTRY_WARN_ONCE(d_really_is_positive(dentry), dentry);
+	DENTRY_WARN_ONCE(dentry->d_lockref.count >= 0, dentry);
+	D_FLAG_VERIFY(dentry, 0);
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p = external_name(dentry);
 		if (likely(atomic_dec_and_test(&p->count))) {
@@ -495,7 +502,6 @@ static void dentry_unlink_inode(struct dentry * dentry)
  * These helper functions make sure we always follow the
  * rules. d_lock must be held by the caller.
  */
-#define D_FLAG_VERIFY(dentry,x) WARN_ON_ONCE(((dentry)->d_flags & (DCACHE_LRU_LIST | DCACHE_SHRINK_LIST)) != (x))
 static void d_lru_add(struct dentry *dentry)
 {
 	D_FLAG_VERIFY(dentry, 0);

---
base-commit: 4ee64205ffaa587e8114d84a67ac721399ccb369
change-id: 20260422-dcache-warn-31bd78e18dc3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


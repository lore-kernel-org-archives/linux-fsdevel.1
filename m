Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29813002A9;
	Thu, 25 Jun 2026 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419943; cv=none; b=W+kdAwOIZ/ySkwIUdgm+8+9ZyXaxQkJSKHtI1I7nZ9RqM3xnJ7AlEuYhrtbDxwZGVu+Ah5VUETOtprCKWhWGehxMchY8TMrwo4SFLu0iBtywXt8tXejsXRWL8GbgoUvdsAplXuAWKykzabIL7uEgqUoKkOqi8fv7TzZz7Gnx0bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419943; c=relaxed/simple;
	bh=Po1w8AN+mSOWB/x8v0wNXpBi3Lxda37rouqhi5RaKeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnB+YVfi4LnKU+WBUBeRypKBaO6QnEdgmko2NsVYh3srU6rKbs20+/SPebwzaXSq5+2H3CzAI1toeJcTDvFMtxxxDNntTj4FwUxP8fSYp67xLs9VweyCiRqgOQa26vDrYqB+rcYPJRj4ABMjKBSHsxqrcTytRWy4Z0HT45hDG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHwM9neX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHwM9neX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFCD3C2BCC9;
	Thu, 25 Jun 2026 20:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782419942;
	bh=Po1w8AN+mSOWB/x8v0wNXpBi3Lxda37rouqhi5RaKeo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BHwM9neXgZU0kADEqbiy6nr4DEeXIK5W5sHxjOBuwWHnFSbNCKEg0/7SOxROnbzw/
	 gtyVZFtN7kaSI+lDVphjrOq/7IWVtEQ+x07csfRqKqJ17ZxTlDjo3UjfYByaqcrVfY
	 MxiNaFlpvkb7soXYMyAs+5CPxhr920xkybdFC5wtkoP9N1EhpK0quBf8gmzaW/pkrN
	 5GVkJj6tGAKX/svG9XtfJapSUl66diei+LkCvkVb+JG6ITrmiU5QioDSf8RQqIVXk4
	 xQmW7k01rHd6FXDfGADSwpv0auwt2HzBq2nYHi8/5NUFXi0ld0+Sus8oj+KfIx1w8v
	 Sr+iv6y9fI4Aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B76CDE009;
	Thu, 25 Jun 2026 20:39:02 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 25 Jun 2026 22:38:13 +0200
Subject: [PATCH v3 01/10] sysctl: Move default converter assignment out of
 do_proc_dointvec
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-jag-dovec_consolidate-v3-1-176ee192bcaf@kernel.org>
References: <20260625-jag-dovec_consolidate-v3-0-176ee192bcaf@kernel.org>
In-Reply-To: <20260625-jag-dovec_consolidate-v3-0-176ee192bcaf@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=Po1w8AN+mSOWB/x8v0wNXpBi3Lxda37rouqhi5RaKeo=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGo9kd6fNTG/zt3OrVoJy6PICMCoQUu+vVWbe
 Obma2YDiM6J14kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqPZHeAAoJELqXzVK3
 lkFPs9kMAIDKnhk1Jr3YqVYkbQrAmKLVHHtW730EHiQwQ8+ZQbHoWhbBIeIAWFFYGtt/ngSvbgC
 d9XXULwgZOC2gccqMW7ueBgInXsmb+nDDSMxDnMnXqWMoN/N0iHooy5BSc8lzK0Xb7nyXjohEgy
 w/jiYEn0axI6OsP98h7SR2Db9O1bqLzW+hTbxUbVXMRu04+Wp9aNOO11UonmovT7ZNToza1pBQV
 zTkoJLYSjCsFat8kTGSK86P47FOv3RaPnj/mGmjRIleFcYeSZVsYErv2ihomFtw7hMYTeT+/0a2
 TW5eHBTKi7PCfx+GOiM7hhcvUbDo2xEbjkRT5iT25GKqdHD1QmKV3iCxs+s5ZiLVx1O8S8F7tAK
 vd60idscz/FJltF7IdDKB05FP/679JrWehBCcS2b30Q7RQsgG60qhxLN9ejwtY47jlAit3BY2aj
 G/vfRFBvVPsOaOSlTeS/a1rbxXn/XxrqlXFqH7G2PNhoTak5QjYZ1MTFS8Xl8zjB/GEG6IPSIO6
 cE=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move the converter assignment out of do_proc_dointvec into the caller.
Both the test for NULL and the assignment are meant to stay within the
sysctl.c context. This is in preparation of using a typed macro to for
the integer proc vector function.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c9efb17cc255cffee08b5299c3e7bb947adf3f2b..e53e60213462fd1b99b8c36e19e1e5c47d20e6c5 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -591,9 +591,6 @@ static int do_proc_dointvec(const struct ctl_table *table, int dir,
 	vleft = table->maxlen / sizeof(*i);
 	left = *lenp;
 
-	if (!conv)
-		conv = do_proc_int_conv;
-
 	if (SYSCTL_USER_TO_KERN(dir)) {
 		if (proc_first_pos_non_zero_ignore(ppos, table))
 			goto out;
@@ -840,7 +837,7 @@ int proc_dobool(const struct ctl_table *table, int dir, void *buffer,
 int proc_dointvec(const struct ctl_table *table, int dir, void *buffer,
 		  size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos, NULL);
+	return do_proc_dointvec(table, dir, buffer, lenp, ppos, do_proc_int_conv);
 }
 
 /**
@@ -1090,6 +1087,8 @@ int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
 		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
 				   int dir, const struct ctl_table *table))
 {
+	if (!conv)
+		conv = do_proc_int_conv;
 	return do_proc_dointvec(table, dir, buffer, lenp, ppos, conv);
 }
 

-- 
2.50.1



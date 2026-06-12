Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867C37EFE3;
	Fri, 12 Jun 2026 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781235906; cv=none; b=TBZNjS+ofBE7S0gBMYKgRyAsLMhLA6ICNOEOODuWq4tLRp4r0a2jLGpZsmvV6DmD9nTe7nLAmnNeN55fR0Xln6ICa0jIHZaqFmW04ylXd5tN5/kcDaK8rScn2kbnwgbBToL93sEaDg1xGp9xcezMLu5dsMFj5daVIgbIuai8Edw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781235906; c=relaxed/simple;
	bh=cvCuXOZysw98tnLG5fVxD2Ago6Gt2QyOA8sNBLPajr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n6Q37H5H1skg2kinC/B2e9AB8YRllI9qGQ+koT69AWIZDK5KnFye6JsR+6pl808z04HaQKf1IepJj1bXLHaIb/EXKX2cXUnMqSxU9OFGcciwShXvLsl5h55cJ4wepfq+RsBJFOA/TJoDaoRp+vQhnIoH7KntS5dtyUmFkpBhELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzodL0i5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzodL0i5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F2A5C2BCB0;
	Fri, 12 Jun 2026 03:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781235906;
	bh=cvCuXOZysw98tnLG5fVxD2Ago6Gt2QyOA8sNBLPajr8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=uzodL0i5vX6AT3QG66lPDaa9lQzojJ7nw3Q/JyLClVUusOO7l4XqLewAWE+tsGaEc
	 95s4QixqnVMDb91fn5eiGnp6SPlpoLgilu6EpFOgecV6mK7BPTH3ArCi6a5Xr9Wmgv
	 XngkQPjn2u4l7K66rn04U49eCdKDPAHgImuQjqQSBMa7pDmb2QZkTzAPRsAZU7xBpx
	 kA2WjO8PRrjwMKlb8mTLPKwhm6wj0URyTnu4ejpU1p/51ZFOz5GjGl5B6KKQtGtNnH
	 9bK55p8tGnrufpibx9bYI91KXfNnAG74ulqpJckQhpz5O1cEr49IAAhijak/fUN8k7
	 bF/tdQg4YgXYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E0ACD8C9D;
	Fri, 12 Jun 2026 03:45:06 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Thu, 11 Jun 2026 22:45:05 -0500
Subject: [PATCH] exfat: bound uniname advance in exfat_find_dir_entry()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-disp-c0e7d249-v1-1-7f517046abd7@proton.me>
X-B4-Tracking: v=1; b=H4sIAMCAK2oC/x3MQQqAIBBA0avErBtwzJS6SrRInWo2FQoRhHdPW
 r7F/y9kTsIZxuaFxLdkOY8KahsI+3JsjBKrQSttlSVCbzBKvjAodlGbAQNFTz4srus7qNmVeJX
 nX05zKR+VPQmAYgAAAA==
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781235904; l=2084;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=UlikRDJHleDIgL1SJcIrVxgcfhalOWXCOnjUB5CHOiA=;
 b=zN5kL1j7zq0ttwkTDPniXR7/E6Y2z+vLJb2dIHIX2+dKq88ZsZK4bSMOJcrCizunjpRxFXAkY
 jo9vVN+49NCCB4yzTWUkk4Ju7QP9zApnc071+6l2VNJ43mAjcfIn4r8
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

In exfat_find_dir_entry(), each TYPE_EXTEND (file name) entry advances the
output pointer by a fixed amount while the loop guard only tracks the
accumulated name length:

	if (++order == 2)
		uniname = p_uniname->name;
	else
		uniname += EXFAT_FILE_NAME_LEN;
	len = exfat_extract_uni_name(ep, entry_uniname);
	name_len += len;
	unichar = *(uniname+len);
	*(uniname+len) = 0x0;

uniname grows by EXFAT_FILE_NAME_LEN (15) per name entry, but name_len
grows only by the actual extracted length, which is shorter when a name
fragment contains an early NUL.  The only guard is
`name_len >= MAX_NAME_LENGTH`, so a crafted directory with many short
name fragments lets uniname run far past the
p_uniname->name[MAX_NAME_LENGTH + 3] buffer while name_len stays small,
causing an out-of-bounds read and write at *(uniname+len).

The sibling extractor exfat_get_uniname_from_ext_entry() already stops
on a short fragment (the lockstep `len != EXFAT_FILE_NAME_LEN` guard
added in commit d42334578eba ("exfat: check if filename entries exceeds
max filename length")); exfat_find_dir_entry() never got the
equivalent.  Bound the access to the p_uniname->name buffer.

Fixes: ca06197382bd ("exfat: add directory operations")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 fs/exfat/dir.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index ac008ccaa97d..d4769a0f9978 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -1043,6 +1043,11 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 					uniname += EXFAT_FILE_NAME_LEN;
 
 				len = exfat_extract_uni_name(ep, entry_uniname);
+				if (uniname + len >
+				    p_uniname->name + MAX_NAME_LENGTH) {
+					step = DIRENT_STEP_FILE;
+					continue;
+				}
 				name_len += len;
 
 				unichar = *(uniname+len);

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260611-b4-disp-c0e7d249-c1db1bca7353

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>



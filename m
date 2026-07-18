Received: from tbjjbihbhdcb.turbo-smtp.net (tbjjbihbhdcb.turbo-smtp.net [199.187.173.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2C62BCF45
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.187.173.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387978; cv=none; b=nc7NOHlmsuM+2pbl0vUmvXrSwJyKf0vqHwH7YsvXm7fTMFlTHICZSQiXQ4PDJxbOq2PmA/spXq6QYxHezFi9PvcxDSc+rpgSQNwFeEvbwBaNH1IgrSh6hs2sV/1wedLIAujZSRgx5ttwizfaV/bsyeoHcWhXivsKSZVir8GSGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387978; c=relaxed/simple;
	bh=nfoHQZKsSe7OTFV/EmQA6dHzUn7csK5Qmse/FwLKt24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKsS4f/iTHj1hw2voicEwO8l2yi1yYBWrrdL7GOECcVrR/OriK5O8L0iuq6riu7OKCpiqzNZYGNt2W/z5pM4tdkuPmDCR5kgA+nrROW8W9i+8hz2QWRoGVMXCE/JU6ajX0BQkkfSDE2eVj6sA1eRAYtPK8BkCOW23WhIRadeKPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahyatoubali.me; spf=pass smtp.mailfrom=yahyatoubali.me; dkim=pass (1024-bit key) header.d=yahyatoubali.me header.i=@yahyatoubali.me header.b=N7XXOgsA; arc=none smtp.client-ip=199.187.173.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahyatoubali.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahyatoubali.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yahyatoubali.me header.i=@yahyatoubali.me header.b="N7XXOgsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yahyatoubali.me; s=turbo-smtp; x=1784992775; h=Received:
	Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	Content-Transfer-Encoding:Feedback-Id; bh=mydz+hMWv4OPYB49xQz7uJ
	aRhTr8PCzEcSJzgX4E7zY=; b=N7XXOgsAnGcV/icGiZH31vJDT9xKSgtfSdBfqc
	2yFIbyeHzPwx8iH1XWOxZCpi9czpF89OeKUHBzBfY44zAS0TBg8EIZgSauvNQis+
	TqBNdiepjFDff0Es0W5Sm3HvpJTEtidOLI01I/5JhBCRoHYeKy8m2TBEN+8+zR10
	6Qgpc=
Received: (qmail 2203270 invoked from network); 18 Jul 2026 15:19:34 -0000
Received: from 105.76.9.106  by turbo-smtp.com with SMTP; 18 Jul 2026 15:19:33 -0000
X-TurboSMTP-Tracking: 64-018cfb16-00001e63a84e6602c003-003-4288bd49
From: Yahya Toubali <yahya@yahyatoubali.me>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org (open list:PROC FILESYSTEM), linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM), linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Cc: Yahya Toubali <yahya@yahyatoubali.me>
Subject: [PATCH 1/5] Documentation: proc: fix repeated word 'page'
Date: Sat, 18 Jul 2026 16:19:07 +0100
Message-ID: <20260718151913.1892547-1-yahya@yahyatoubali.me>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-Id: 26016534

Remove duplicate 'page' in the large allocation accounting description.

Signed-off-by: Yahya Toubali <yahya@yahyatoubali.me>
---
 Documentation/filesystems/proc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2ccd5b2dfdd3..d22ac0addd42 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -513,7 +513,7 @@ In some kernel configurations, the semantics of pages part of a larger
 allocation (e.g., THP) can differ: a page is accounted as "private" if all
 pages part of the corresponding large allocation are *certainly* mapped in the
 same process, even if the page is mapped multiple times in that process. A
-page is accounted as "shared" if any page page of the larger allocation
+page is accounted as "shared" if any page of the larger allocation
 is *maybe* mapped in a different process. In some cases, a large allocation
 might be treated as "maybe mapped by multiple processes" even though this
 is no longer the case.
-- 
2.55.0



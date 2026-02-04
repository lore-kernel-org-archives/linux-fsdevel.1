Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC993242B2
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199178; cv=none; b=UlQrdyJA8LMC3rfcOtRzYMrO2aFgLQFOvbmyKfYNf9FSQyn7UO/EFexZcE1EUb1pm7AowNPslo65VvJ/STjkxsU9lQsr+u6uB/uiU8hjuwDSzdwN+PTpyjh7fbvjY+mBjuASLQPZxPDmQ10j3R8BQgmlJ2ESqzBvdJXfWTNqe98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199178; c=relaxed/simple;
	bh=qIsACIMhslriEhiQTa5CM6EP3aeLfHepgJwOdBT3nEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQ9yYDPWeAK3EFN1MP2dWIjgF81zqQHkubZ27PJXkTLbTJRRpR42xw4e1SXupqk91bnM4VDf1fq2DvXWR771/5hKlhA1rj8L/rKsgpjn3ADT0Otx/XJxHGIVpktpUPZ/uEZOYKmOnlvvI/kwBLs75gkEWcpiQJzt1UVMimrtiEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-502b0aa36feso8023771cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 01:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770199177; x=1770803977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C24sTJzvWiJfSjj9cTXtwuMyinaZ+9glC5BRRHwlXDY=;
        b=IqTdeptl8hJWihsS+3bwd42uQFJFvd2qWsZR69FWTwaVDvqN/VhKv8IEgMhi7CA3yz
         uA7/XR4jsTpjrcXfbR71LLtYtDOQsWoYZsl9EZXbMwAzAbeIa4nCYbS0UdjK7Yjn04hY
         ltxrOnyktwSkH0lye+igiqGG9eqs52GSg+kGCxpGrAvdgSdxcBhdEUUZPekdLu93ctH+
         wYNHc2fLNKETTzEp8Zd0MRHi7Xl+CgzWs1qgAt+ICvnP6oQsGLF/70bpK6EV37jJo7XA
         pfbufkU83bF0w2889f8BYd8q6D0hpniuWwwk1cqMhkfbV0rT7YVYaRlD2qtKWytZ62SA
         mg3Q==
X-Gm-Message-State: AOJu0Yx0czN/VXOKQCTC6U0DPZM5kTdEEqb77xKkYKLYTstn9XQxr7L/
	u6b6YhxVSYH0yuXPJrc1jBU76gTFboEPW7SOthOWRjZWLpAQ2DUtMIrpjCefwQ==
X-Gm-Gg: AZuq6aLwMVAwDd2fVfVQ+smG9ixzmSpHzwNNFlpzPhnuXK6lGvQ0uW/EqdmZI6COh0K
	NUEa2um0PMMiG0Jt0rnYkpBcJtc9LaVDjRu4OpV7sW/ddUIAkEM7KBbaN1JjqNYO6F+6gF3Vdb1
	AcwnxC74mdjWuLSzwIwBwm9eg+9h/VnQ8cEgKLe/AQGKHGGXRCyNZVJjnB48JbLMyMAiOQUUKt4
	EsKd2dm9Orkn69bmLka9HDDvNQORUcHsBWpLeys/Hclys4EO3G0TVKBJCLnB6Mw0fcPjuBP0Kbh
	sg6I3gVIUNP7f7v8kaF8Gz3INZclbY/dJh1zhr5z/qciMhxvgq3cQZa6TrL9TKl3XvK9Kcg8Rzj
	qSA2wp6juBtF4h4XZsKZfVRSxk2aVADEZ2/Rmf5LZzkwufFGLyU99Hx/smczkbxENRLUOGi0TFW
	JiwujzRTkEXwzL7hiR+o868mblaWOwkhQu4wTD
X-Received: by 2002:a17:903:907:b0:2a0:a33d:1385 with SMTP id d9443c01a7336-2a92465cb7bmr57607455ad.17.1770192848146;
        Wed, 04 Feb 2026 00:14:08 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933967771sm14554875ad.82.2026.02.04.00.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 00:14:07 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Anton Altaparmakov <anton@tuxera.com>
Subject: [PATCH v7 17/17] MAINTAINERS: update ntfs filesystem entry
Date: Wed,  4 Feb 2026 16:47:55 +0900
Message-Id: <20260204074755.9058-18-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260204074755.9058-1-linkinjeon@kernel.org>
References: <20260204074755.9058-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself and Hyunchul Lee as ntfs maintainer.
Since Anton is already listed in CREDITS, only his outdated information
is updated here. the web address in the W: field in his entry is no longer
accessible. Update his CREDITS with the web and email address found in
the ntfs filesystem entry.

Cc: Anton Altaparmakov <anton@tuxera.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 CREDITS     |  4 ++--
 MAINTAINERS | 11 +++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/CREDITS b/CREDITS
index 52f4df2cbdd1..4cf780e71775 100644
--- a/CREDITS
+++ b/CREDITS
@@ -80,8 +80,8 @@ S: B-2610 Wilrijk-Antwerpen
 S: Belgium
 
 N: Anton Altaparmakov
-E: aia21@cantab.net
-W: http://www-stu.christs.cam.ac.uk/~aia21/
+E: anton@tuxera.com
+W: http://www.tuxera.com/
 D: Author of new NTFS driver, various other kernel hacks.
 S: Christ's College
 S: Cambridge CB2 3BU
diff --git a/MAINTAINERS b/MAINTAINERS
index a8af534cdfd4..adf80c8207f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18647,12 +18647,11 @@ T:	git https://github.com/davejiang/linux.git
 F:	drivers/ntb/hw/intel/
 
 NTFS FILESYSTEM
-M:	Anton Altaparmakov <anton@tuxera.com>
-R:	Namjae Jeon <linkinjeon@kernel.org>
-L:	linux-ntfs-dev@lists.sourceforge.net
-S:	Supported
-W:	http://www.tuxera.com/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
+M:	Namjae Jeon <linkinjeon@kernel.org>
+M:	Hyunchul Lee <hyc.lee@gmail.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
 F:	Documentation/filesystems/ntfs.rst
 F:	fs/ntfs/
 
-- 
2.25.1


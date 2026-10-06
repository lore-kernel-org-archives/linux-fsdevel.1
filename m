Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F33A8FEE;
	Tue,  6 Oct 2026 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326512; cv=none; b=Idot+SMpq7SOgAyKAXhcKdhk8b/5W0qgAQbZMSJQXHcBh+7OhUIAqxgWaFZb0h7io3LY3xGOks6pgDxmRovJ9ppACJjdJ6kMsRumArquHPMhPvR4qczohS9VPXUlctcznwi6N/HIKvZ/eOsLoPWFgx/jpRaxkoOFMNYy1BPt//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326512; c=relaxed/simple;
	bh=CgXG61SZZ2ot7qEKeHn0K0CQsc0qhHXWWLexLYdUbFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKICgNCqy9I8NfsAiSahai53DyJo5FEEpC8OfhxsFUy6WMjCAUwALbQ++fRUNw6D3QJYKQ4rLOGc7NQPFIf5yGQ7GlY/FlxUVjFFRqjT0nI8i/WVODLqgZlAPCwjdgbLhjmZDhcHGrNcFpcmu/j2IbOjwgRyiy6KTeqgoPN5ET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpUOLvCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpUOLvCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773381F008A7;
	Tue,  6 Oct 2026 22:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326468;
	bh=gNclRxy+ACNG9XMox69OukjyzUaA6/YzURH4uN4Krj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OpUOLvCvSY9JTdVEmOxFQtSIn8ej/Fmoz/7YePFnfGHxLxd2TjPlLTPGF1DT5Z1iO
	 xy+TFvxWXESGKq5DmgN0YPG49606FP4aTUk/Aa/pdrd0Jd/sIUUTZs7urvTtjemOvp
	 Dg+hbPjQ3VJY4y9qmUBXN52jdZNqGWR0ojwWR4DqV3YtlqRe4GH5EQzODi85tCvxMt
	 KxSDtvO+tPRmhnWqDEaPzGok5SpNt/6MH1uSgPBomOtTDyFQNPSOe5+5MNiOl/W3wi
	 UOqq4tkjGyDKYi3OAATO0k8PBtAAc4WL//xIcZ9FAVZubJli1eMRXO30KdRHU7E+R1
	 U7VIi/CnN+Hrg==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebastian.n.feld@gmail.com,
	cedric.blancher@gmail.com,
	Lionelcons1972@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 3/4] MAINTAINERS: ntfs: add UAPI header
Date: Wed,  7 Oct 2026 07:40:23 +0900
Message-Id: <20261006224024.14535-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006224024.14535-1-linkinjeon@kernel.org>
References: <20261006224024.14535-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List include/uapi/linux/ntfs.h under the NTFS filesystem entry.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc3cae2e378b..b035f7ad34f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19489,6 +19489,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
 F:	Documentation/filesystems/ntfs.rst
 F:	fs/ntfs/
+F:	include/uapi/linux/ntfs.h
 
 NTFS3 FILESYSTEM
 M:	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
-- 
2.25.1


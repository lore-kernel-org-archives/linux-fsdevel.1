Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AC8466B4E
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905764; cv=none; b=tz8odEkRVroPV1UaABgK0fKDRqX/rUrn+pviZsP3D5gZtNbHJByBDsxl8EPMD1oeyJ5A0fQ5uzXPZ2yrMB/gFl+lOnTnj1VnBsHWsZuC5N9OrNI3rGtZAMA7g+MMcGn/9fVPzN22j1ikpJnR3BV4oo9tQvAgXX4L97uuMF3meec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905764; c=relaxed/simple;
	bh=2O98pcDodvf/w5L1Uqu7/tQOCDHAp85xEdv7VYL7Blk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npTR/hje+eeCQV3VbagN/dhPsny+qLMs1tGCtFb4K857F0ZAhzvKvW+n3/9tsQkn1hvrlP73pRL3uimSnUtU8229VWKNPRb6wFJOcQFEhmCwF1gLUdtnK25wQ0Hli9REk2ASt5bJK6vO+S8+uWtCHlaqCmKgy8Xi16fmLEW4ChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvYo2mqs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvYo2mqs"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso102748725e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779905761; x=1780510561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cc56agp3MwuW21VE5gH+ln5C8u11biR7qsKK3i4wPsw=;
        b=PvYo2mqs/wh7+Gtx9zjLfbJ4dAsqBIAiMC3it/PnYlA43003rlAxkgsoUSSiqYBXYb
         2FXd3+RiHxISB1a5AqebJd4dzH23POSbtKcMfO5uM0RJkmrfCUrt45bHhMGOIBKEJkEy
         09Xpvo/aEl58LcbawVEmTwyLZiQl0rVHYGWQRUA6E0qQIIFSB+xQx4OO7Iq3x6w7lNU2
         AIgerfSXKE8SdoA3AsFAPs6BB7J4cZR8H8MQvQ/ux94QNRzjg3ebCvjftV3mRdIzHj5s
         Dq20M4+dsLveoMCOlnXx0QVNJmPuju5OUjTjUc+hg7fd0bD41gRIerw0Q928iJ65jGEv
         rzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905761; x=1780510561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cc56agp3MwuW21VE5gH+ln5C8u11biR7qsKK3i4wPsw=;
        b=l38hwj2BmyAaOc6BmBAGkYqr9vWR0NX3hyrmN5pTtK0WNiKbEkZIGtQLoyDLtJiQo0
         KWb1pwKzz6CKUENNfklxB/qxENF/txsWLji4167cFvsMi9RoJO+wPYJ+D7b2X0FQJbiK
         ozUMbAM5UpoWBtM/7I5AuLrMJ0G2gw+DvcKMNZ6GqT6eDcVpu+BLZQalbe0TtprJOYJC
         XFGAcIEBY5Wa0K/f147rEFx/wY1q1HGfrZFv9T7FXaYDysksOrUF0zIJNvQzwzJBA78s
         d4QbYzPtgIv81SWnGJ5MUnTPczcNLtUm4ByNGR/KtdAlGGQHkUrw0cC8t05prhEkTGNy
         AP2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9DfiSprQ+fzJUDFyhgUoNnNLlCCbJX840oBf2PuseSJOwb7tLihHOjNLdYS2fJVyv9czOXIn5xzIoG6I93@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/bSxtvl/V7v3wG1PcWYgHP8gaxIGAJkeN764xNp6WulHssWvK
	vTq5MStCV4KWqW27PZzbC0Dn6rs8M0xRS8cHT4uxUDMWpt+GmD0WDhp3
X-Gm-Gg: Acq92OHSdIQzLzQb57Cwuyd5elXugTOT/J5NaVzhOytBIHLtHU/vzkqH78ix+JfTY7G
	/rPj+vzBVC4CXQ2Pac2Y/ITy1thHziz5wYkTz/U/0HuJkt2ORYJcIKhi2XHVCV66PzakDxgQNhm
	afKKh2z9i846aXKF8ZtBDBmBw2m/VjrbB2gbPwOmXXwHGjaU7/uxqWx1khIE3MWUeRWmsny1LWj
	HK4vbL94clxyd9Pngyl31vRKcE5cVxd33xAW363Efu5AUHMzqVGd0FlQGc9xcLvBsbykTUcOzMz
	KYDpKV26MjyLQrBv3NkQ/xyad/ky4xm9mAe7YWqwfPqz5ABkciqYD+DaXJ5113Izmo86l/O5TL0
	Wo5fx8On1c7hujX5fbOXCSDXsZGEkBE48yVTvnGV0LZll3nCflpWPLYYcoBiGfKSzB9UFO0e7nW
	itQ5tP5s9T0o1fDQxfwDUXozeISd7Vyw==
X-Received: by 2002:a05:600c:35c8:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-49044ebc2d5mr442432465e9.30.1779905760422;
        Wed, 27 May 2026 11:16:00 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4904526c926sm736405855e9.1.2026.05.27.11.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 11:15:59 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: Alejandro Colomar <alx@kernel.org>,
	linux-man@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] man/man3/errno.3: clarify ENOTSUP and EOPNOTSUPP
Date: Wed, 27 May 2026 18:15:48 +0000
Message-ID: <20260527181549.2237547-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As revealed by Christian Brauner recently
( https://lore.kernel.org/all/20260527-fotowettbewerb-abwinken-einfach-83db3411945b@brauner/ ),
EOPNOTSUPP is widely used on Linux to mean "Operation not supported",
as opposed to "Operation not supported on socket".

Also, as seen in POSIX issue 8:
https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/errno.h.html
POSIX doesn't require ENOTSUP and EOPNOTSUPP to be distinct, so
let's update that, too.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 man/man3/errno.3 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/man/man3/errno.3 b/man/man3/errno.3
index a070dab..fdd2710 100644
--- a/man/man3/errno.3
+++ b/man/man3/errno.3
@@ -477,13 +477,14 @@ Name not unique on network.
 No such device or address (POSIX.1-2001).
 .TP
 .B EOPNOTSUPP
-Operation not supported on socket (POSIX.1-2001).
+Operation not supported (POSIX.1-2001).
+According to POSIX.1 this is "Operation not supported on socket",
+but on Linux it effectively means just "Operation not supported".
 .IP
 .RB ( ENOTSUP
 and
 .B EOPNOTSUPP
-have the same value on Linux, but
-according to POSIX.1 these error values should be distinct.)
+have the same value on Linux.)
 .TP
 .B EOVERFLOW
 Value too large to be stored in data type (POSIX.1-2001).

base-commit: 9a4bfd0e50745c2649b6291db40b58e37c9c1c6b
-- 
2.47.3


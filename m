Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763441C71
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 00:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003306; cv=none; b=swF4StXZLGAPH0yOjn3E31DTe3+76j5yIOxwhCIJpQPK2LRZZlHCfDxC+4Tk7ZCcGs+WYYhJs8bAYt5QFOkVQ7IcW/Q8V5p8xZcq9+2Irz939To4/5dVahPaAAIDQ7QknaA+do3DsQXqmPTElBkR9U15KjLDoXzWoGm++ql+5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003306; c=relaxed/simple;
	bh=Wl9nT3Slu0gQkDLZ2qg4Yy+5qnZ3izUvhAj0Tp1r6So=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y/r3xXCpjIwvHdIiOI8Wl2uCLinryKzTPD2ijXWHRsKrB7+iS0PpwqMAT8iDSlRdXseCQGz88/2zIdw9txT92Ta1WKf5uXHt5W0A7Kg2pXXYl9wOc8mRv5e8XunoKyVTxm8jLACWlFH+c4fv7LV1WAmOl8Oqpfdjjhs+YR723O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b=c3lRmXQw; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b="c3lRmXQw"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so2656375ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 17:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20230601.gappssmtp.com; s=20230601; t=1775003304; x=1775608104; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPpyfxqvRvwQENUgIjXbp0AKupBdomDsmgEJ79biurs=;
        b=c3lRmXQwowsp5C3+U3taIdpzj1o+D5RYzWUXN7frq5C/4pbdv4n1k3nOTpx8/xkN98
         nfEPxeNuKI8D1RfivBTD2VqbPuF9PSeN4RUc7dOEVtAKWmCoY/Bv1LpJmuKPXf9JaNUf
         ZXb+ByTcQLsHX9Dsl0eq7ZEaG3WbbTwtisxBPFdiWOxkgck1v5rSieHASjZWk/kd/XgH
         3wLjjb1TEKlo/lrBZygCzNJimj69ByEb+aNLgP9IuKVqOwHbAa0VK/nyTi40GSMblc63
         PS4ZfC9P8pyEiyV1EntcYy3vGsUpsSzJ2pVmbdkv2gB6xwU+yiDbAcf2drnBsioYGmYq
         K0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003304; x=1775608104;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPpyfxqvRvwQENUgIjXbp0AKupBdomDsmgEJ79biurs=;
        b=NXzIdmdr5hvdnFEOUxn/nR/zJxJJn3fQmuQvc9wCvYm20uGgGd43DO0yZYT8epysXY
         IQUeDjizBcwUWH1CZxpyKBrAhnUr1Os73ICU/5Qz/S/OUTHDC29cWF10hZs8AaL5k87F
         ysKaTVirop/n+3tH917v7xMIuHThAMHN97mmN1dWY9aNbV2ZqaI8cFVojaGzXNIiGD1t
         RODt9Q7R/46lboM5M6hyv1QlTMmu8eDhgGdFvDn+6huIb4IJvyDu6CI7Rovvk/0SLMVQ
         kQlIFJhIo7YKsk6QyaNVeCLK8elMM7sLZnVEGdyj/0vtyLAM/NphxT0zbO8WCJx045HD
         sF8A==
X-Forwarded-Encrypted: i=1; AJvYcCWAWH3NMNNWJOfJpiO/WtHLG99UAtLn/O2EqNPe8Qz+ZdI1wFpLNZu++oMnX6SNG+EKlVbZe0SREG9kd26n@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/rhB537ttNU6sQYO9R3c2+uL/YDn6A7puxMFOuVFTpAK1W9/
	qBX9Ed2klIjQopfkmVF0wljNSobjcDgkAJrNDaCqbzMpZqfzHJCPCBocHQqMVH8K7xBR
X-Gm-Gg: ATEYQzySNGdGafxUX7NXAumdP5a+voGNEvqog2eYRPP2OKwP0/Sa8unGKjPqkSk0CLV
	oLAjVXWoseTdwNrPTn4e8rU1zluqEhsgp7NwCfGRyA9I0Fvl1sQI/CB271fF5q8zyG3qgzCfjNT
	TxXQB3GkLShEDao032hDovDW61Dhufb/MHkdBSA2k9JrJ5k4PxMb81ctPRyHfOkK/t4somPTpBL
	9dnLsv86JvWTphwlJeGgkz+zNVab2WJ72YB3b2Kqd9SPSEwqHrsofCIg3G79V8A6sTS3Z/YdXiA
	AKPfGIoFeLl9xQ4p/4MB6mpxsdvVSvGi1CY7vYM/S1KXP3/4UXvdYtiTfQnL/06zRnpOuf4pNFY
	poi3lROfQExrvJkeoOxSv9kQpDjxd1lTqA6xcwZNzivvxPhEkyqp/blj24pxQKpmVRsqKwIxOSm
	Z+8UtASBlsulyd3t/JJYscsAY700lgmhQBeHR7PDwuAhYwVXNk/SNnhNiPLmSMWV9LzS+RnQhTW
	0u01oLO4+HEIW6LVkCV1VwwFA==
X-Received: by 2002:a17:902:e947:b0:2b0:be79:e521 with SMTP id d9443c01a7336-2b25efa95bamr46558825ad.26.1775003304156;
        Tue, 31 Mar 2026 17:28:24 -0700 (PDT)
Received: from thesius.dot.cyphar.com (2403-5809-a2fc-2-a90-9fd7-aedd-d405.ip6.aussiebb.net. [2403:5809:a2fc:2:a90:9fd7:aedd:d405])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24264264fsm157057825ad.2.2026.03.31.17.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:28:23 -0700 (PDT)
From: Aleksa Sarai <aleksa@amutable.com>
Subject: [PATCH v2 0/4] selftests: openat2: migrate to kselftest harness
Date: Wed, 01 Apr 2026 11:28:01 +1100
Message-Id: <20260401-openat2-selftests-kunit-v2-0-ad153a07da0c@amutable.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJFmzGkC/3WNwQ6CMBAFf4X07Jq2CIgn/8NwqGUrG6ElbSEa0
 n+34tnjTPLmbSygJwzsUmzM40qBnM0gDwXTg7IPBOozM8llzUvRgJvRqigh4GgihhjguViKULd
 lq4wsEWXD8nr2aOi1l29d5oFCdP69H63ia3/NExd/m6sADtVZtErXWvWmuqppieo+4lG7iXUpp
 Q8AcjDEwQAAAA==
X-Change-ID: 20260317-openat2-selftests-kunit-6939af23ee27
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>, Aleksa Sarai <aleksa@amutable.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; i=aleksa@amutable.com;
 h=from:subject:message-id; bh=Wl9nT3Slu0gQkDLZ2qg4Yy+5qnZ3izUvhAj0Tp1r6So=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSeSVscKSFd4d/nMUn75/fVk87onTC3blpWJMW3ot/AP
 DrLU9qvYyILgxgXg6WYIss2P8/QTfMXX0n+tJINZg4rE8gQaZEGBgYGBhYGvtzEvFIjHSM9U21D
 PUMjHSMdIwYuTgGY6m93GRm+Z148efecwTmuwjIm/46IJqtr4npCVwquTpQUTZ8VHrSY4Z/VqcM
 Hnvz4K7iSaUMt12zh2XH/C71jwrYFiEpcW8J4sYYBAA==
X-Developer-Key: i=aleksa@amutable.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

These tests were written in the early days of selftests' TAP support,
the more modern kselftest harness is much easier to follow and maintain.
The actual contents of the tests are unchanged by this change.

Signed-off-by: Aleksa Sarai <aleksa@amutable.com>
---
Changes in v2:
- move openat2 tests to selftests/filesystems [Christian]
- v1: <https://lore.kernel.org/r/20260401-openat2-selftests-kunit-v1-0-5819ac6cadf5@amutable.com>

---
Aleksa Sarai (4):
      selftests: move openat2 tests to selftests/filesystems/
      selftests: openat2: move helpers to header
      selftests: openat2: switch from custom ARRAY_LEN to ARRAY_SIZE
      selftests: openat2: migrate to kselftest harness

 .../selftests/{ => filesystems}/openat2/.gitignore |   0
 .../selftests/{ => filesystems}/openat2/Makefile   |   5 +-
 .../selftests/filesystems/openat2/helpers.h        | 168 ++++++++++
 .../{ => filesystems}/openat2/openat2_test.c       | 223 ++++++-------
 .../filesystems/openat2/rename_attack_test.c       | 159 +++++++++
 .../{ => filesystems}/openat2/resolve_test.c       | 368 ++++++++++++---------
 tools/testing/selftests/openat2/helpers.c          | 109 ------
 tools/testing/selftests/openat2/helpers.h          | 108 ------
 .../testing/selftests/openat2/rename_attack_test.c | 160 ---------
 9 files changed, 631 insertions(+), 669 deletions(-)
---
base-commit: 84f524dca4b8bc9e9aca8ea1dbbd2aa3a239d998
change-id: 20260317-openat2-selftests-kunit-6939af23ee27


Kind regards,
-- 
Aleksa Sarai
https://www.cyphar.com/


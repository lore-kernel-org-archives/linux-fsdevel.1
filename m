Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798107;
	b=aRopFw63i6c4bj428UVTiRRogfCzBppMfhiHdq+qQSxf8a54oNrZFSwmkDAVRPaO+8LM
	 HvzqGkXfD6PNcAKz3h4uyTb3TqMmiHcEUGmM+woUlKJ8YZMdtWJbqb8s1Dlhbbd1rJqE0
	 MXbJWPn4q/WJpVd7RpAsKAB6oJnjOnBPZctRl1mS+ZJuVRfZvQubMjLiQLjGTSQYEsO3q
	 C1JgYmtUqVbzpPZyPDG1BxkPWctwpDyxVYMHdZS+0hpsymIofPyqeZfXJCD6lAR0Ux/Q1
	 uo8C/HIKmWCKJFJrfZGqonQM1E9VkJEcJagAH2a3enCfX+khCKKuDWKquMfRmDX/3/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=973K8gxbulZk7sOwqCbvcqPXZuufZsqlMFSnTIy+oT0=;
	b=uTjHifpf5G7tN/z5fPLPLCmocZcoulIxeBbbek9xv9exkKn35k5vwBLtV/CDnMhtvh/4
	 ir9FoW0cnFDRsxlIQcieaDnIYqmCkrwbIQWKS6nblOWdbIqtI2vifAyIddC0IG8gfRgrV
	 63eDXOv0kk1G7Adxvr4t68qmH/UtJ8mNmRiLD1mo18Q8Elt4qmzZomjvqXkPJqUx1JYBj
	 MOb9ZIfnLfs7/EOhTUFEuUdJU01o6kuxZBmDhgtR0FcCSQdmD1KXBIJmSgib3jNBkbHNb
	 Wxlqttb6uZ/iGLD/nshhOgJ0aOLEGQX2RP/ACsotsMris8fgXCfR7vA52jTHmj5cgXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BQbw40QD;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0F606A322
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 23:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42E0F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BQbw40QD
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so1150673e0c.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 16:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792798105; x=1793402905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=973K8gxbulZk7sOwqCbvcqPXZuufZsqlMFSnTIy+oT0=;
        b=BQbw40QDAKRu8+3TjMKa/v8X7jcocc8T8huszEtUew3vOrml7+lRxcp/7Si4A1Y4DH
         QhFMcRGKocT1tP0AHyjN5tfdno1w03Htt+NjNdKwlLtw3MudQCxZyJ06Pz6y6ctOnsM/
         TUySTs3t6CQABiZ2CT15a+mJt+Doq02KNtrnCypa+pZbuig8E8EsndW/kICBd8tZlH8W
         wg1PBfh29+QP4h/vfrK7zHVz7tT2i9fJCzPa8x2A4yBSEEG4pNbZk+37omwhUTHx/pq6
         v//msPQ0ZeCWBVYZcYaXEQexRnuZokQ4dzE0Z/Hn2BBesmck4kHWVz4OiK2XDkV+OljR
         pymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792798105; x=1793402905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=973K8gxbulZk7sOwqCbvcqPXZuufZsqlMFSnTIy+oT0=;
        b=qyG0ZUNNtkVaJBTpWqDV/d9+Df30iPYz43XN7Fgfp1N+nbQeJD1MSUl/99zrrrFd6Z
         4fiOxquaBzSRTWd7hHFsdQSmNHRqktac2zMsF2rqOVakag4cxPPTf4KPEWISxx8uhJSD
         15D+IkKL9pJoPX6LVUKr4QttYfi2J8Y1SNF/Gaoo3RKhqXH7nBbL0aGh0XWjas18mZJ1
         zKnjFerGYO0QcYWvfuRHN5A5iQPXwYN7DNHtfgx7XkLwjSUi67VK9McgRYcm29eJ03Nv
         1mW8/IX/3vWgfFya+X2m8MBBN19SeHrf/yZ4PoI2chJ3q2yevACJH+eY3J6Vv7LAvG0j
         JtsQ==
X-Gm-Message-State: AFq9FYJqkF4mbHZHpFLMELHxwHkSFc+fecXBYV6uLOfv0t+uyrGmwgbk
	PmjU3uYw0sXScP14A1llW0L3QtCIk0BfrEoRuDF5f3G/jXo/wi5AiOyCZGEPl4Mu
X-Gm-Gg: AYBFou05I9ab9QI7IM9PEzYPusky0Q+2Myjqvv9IVMT0FCfIOLJKq3xFo3c7zxXo1D/
	TFMwk41JsjNEFbSV1VEdiDd9ajj3c/jzwthLjHVfG/+tVvIm6rN2zK2c3AfK2sZ07IjALNIiE6h
	X1XaKrSu1nWf5yhP72Wmt2cwZWIIF/VFa/2P4Ff11kaQkimGgzJjIsaME2GU8f66e6kFURu9WZs
	X0s3f/GkwhzH1SSQyf+ITAc7VLmEr+cdtlzvsMZzNdNNxfYNphkMEg/OWCI3Xafba7QRrGeuNzk
	1Szha9KCmGxE/bMohMbFjnw0L0lVwbe1Hph9dPHBRC4OcF5kFnLha+S/twRje0RvYYShz2TdyPG
	D13HI+KeuBfr7u+Jm5DmFe0DVvDDOVY6uRAPNrRwNMnAXh0sRNVR0toA0IkKAbmJUJJgNNNLX6E
	amtgTreavseC+S1SJdlKUMHfAA+NIAh0f9A8mNcHrCUEL4eZE6naWmv0oyfMNs11nkCh9Cx+nCz
	dx2qFCcgT4Yc8+pV6pipPR368xLbsbJZZ6WtjUreu/YYzW7w9lWGYDqFyC3kfiPxD+jlVHOg1Wp
	b1JsCNtmg3nwBhV2IsstRM8=
X-Received: by 2002:a05:6122:e20c:b0:5ea:c3bc:c54b with SMTP id 71dfb90a1353d-5ec235319d8mr97456e0c.3.1792798105155;
        Fri, 23 Oct 2026 16:28:25 -0700 (PDT)
Received: from Biostar-A520MT ([187.94.15.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234a940bsm418764e0c.15.2026.10.23.16.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 16:28:24 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v2 1/1] MAINTAINERS: mark HPFS as orphaned
Date: Fri, 23 Oct 2026 20:28:07 -0300
Message-ID: <20261023232807.206097-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023232807.206097-1-breno3011alves@gmail.com>
References: <20261023151850.96475-0-breno3011alves@gmail.com>
 <20261023232807.206097-1-breno3011alves@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HPFS has had no active maintenance for a long time.  Mikulas Patocka,
who is listed as the maintainer, has confirmed that he uses HPFS only
for personal data shared with OS/2 and is not actively maintaining the
code.  The only changes to fs/hpfs/ in recent years are drive-by
cleanups, not functional fixes.

Mark the filesystem as orphaned so that patches are routed to the
linux-fsdevel mailing list, and drop the stale maintainer and website
entries.

The driver remains in the tree.  A future removal can be proposed if
no new maintainer or additional users step up.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7336600952c8..83685243c8f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12064,9 +12064,8 @@ F:	arch/x86/include/asm/hpet.h
 F:	arch/x86/kernel/hpet.c
 
 HPFS FILESYSTEM
-M:	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
-S:	Maintained
-W:	http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
+L:	linux-fsdevel@vger.kernel.org
+S:	Orphan
 F:	fs/hpfs/
 
 HS3001 Hardware Temperature and Humidity Sensor
-- 
2.56.0


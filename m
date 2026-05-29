Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE823859E6
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075671; cv=none; b=fW+DxtWZl/dWdM0a10D7BQNMZWttIWKXMMuog+lOIkGQlhkR3nM0ZO0CQyT9eEvGnfm5uqQw4BHKhaQovRvPNr8eHu0hBCfN2htn9zL10W4zH7wYiLF0cgayy0XhFLH2vad+1Z8QIxK8e9T97SoRVxH60m5ZNkiKR80TVtY6Hew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075671; c=relaxed/simple;
	bh=fAktiUpSZP15Q/bKIpxU0tnb6CaSxI63AleOteLRFhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sRDVwEEBkuVXB0Hp72euK1widiQNEBMaltCdqHywHuXHwvlHtr+f5M7v4JUMiXIaUuTcX4mXz3CHl7Ff5AFzRQUY3i0WguSmDVTYW4EbhnsxMlQNM03EGOHsSEZS932NmpAMRxjpV4uSPUYiIIZ/a04OdyOLxDaB7ZiSYJwjNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBpgZLY3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBpgZLY3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so2225e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780075666; x=1780680466; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85ALWsPr3bven76gnOdRecqCaNgtkddpS3RLL8wWr8o=;
        b=EBpgZLY3+njr7il5nsigIQB3SetWHoIf5y3+l6LmmCToqPszw/W9IS+bbMowu+WxVN
         Xy2bsH6SJFbdoi7HslcHby6knh4y69gW1jE1/VgobbokfvyT2VXk4pV7eNh3RFc2cKPa
         zu+WOYKoPsixLw6u4ZCmhuxj+7JBczK8pYos49uvJiM3e7/BA0G5ANAvWcddEQNtAlPf
         ubDcwi3m4DG4WQII+0so3ZHwV5PQUqWgttUTA/0wV8okzbxloUVxcgXpjEitTiTyr8aK
         MA8LeaEwsUwM1nO9z2wVaIQZTngnf4IAlka7n77PNKLCJA8Zo5H6QekLEw8n2oGDbSM7
         MaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780075666; x=1780680466;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85ALWsPr3bven76gnOdRecqCaNgtkddpS3RLL8wWr8o=;
        b=h2NT4Pvd/sF+JA+5U4Tl17q7PvAhlseDvfMqKLp3/Xz5IPu+4gCfqolqsG6R6I0QrI
         DRa5KZLXNt4W8r5IfY1ncyEsG+CnAz1u9R8QROiQsNl7h5fiVXD0jnG0JowhjWAbGlvs
         jtxA8ihxAaM74kgaSAcQh2pmWleH+9S+kFsqHWT+iVjbtUHGyDkcVfUUKZTRqDJNpnPn
         RXX3inXrG7kdrDEPmiGd7yh4+q6CJgU0cQzIYNC4GlDEePYYfcvv8tot9E5Jy3o1PtIp
         llEYqVGsaf6wmj7yyhuNLKNhHG/VAhVWlT3hbceDJ7rrn6JKhxO9r88x5iGP+ZnWvKD1
         5DKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rKSIw85Y9dWD8YzFUR/ZXlhlt27tMu28M0f4YztuHeRZ3BWoICeLFFfnUnYXEnFyBw87nUlSq9dil/dJM@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhA3uwl7KZLv4v848qX3vHOA+DiuexbbjWceetgvVTyebsDso
	HldcEhxPs04chRpqsWMdFh2GxUn0qgP/f/HzRa6zjy3bG+WvPivv1gkgOb0fjQkMmQ==
X-Gm-Gg: Acq92OGN8jaKzGwzS6pvZj5ZePXRB2zYoyuSjAPE2O1zeCt/232bkRAitvYAYnpbOWT
	c3Gfop4Gb7FTtpMhdIjPk5UCPItNH9/Znx1pqh7L/IBBW3lbiWBG2AuiOyCWlGjch4E0cy6aS5l
	7CrVAZ+ulq9IoSBAFBO0laHkm/mvHt2WFgSnkUi2SOGp95R1muxp4xIA22zAziSTBPBMTzq3gGI
	9myKSvbGL5Wbmtymo2SPnA+f1x9LB5uP0deKqaT2J0XPObS/KKNmlrbp8DCJwA/gm1jiPoJZxIo
	4HzwCZFuOweUdhpwkMl4dumwfde700OM62dKnl/lsY+0at7d1zbyVLj8qTvCJeH8nWHgP2MZa4n
	zsagbkjE5K7Gh1u4fqWp0wqbHUVe7I3QsOfLIfgIiw52d+1WgY4QaRpI0aAcy86BoV40rt5IZmm
	y0F1mgjGXrqaWgq6xmNBm9OADKRZQkBhpYfM+WyoQrkKF1fTPTsHvqNyw3pkzU
X-Received: by 2002:a05:600c:8a0d:20b0:47d:1e65:e841 with SMTP id 5b1f17b1804b1-490a2d38b01mr1535e9.9.1780075665742;
        Fri, 29 May 2026 10:27:45 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:d743:bf7b:2a4:a9a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0b8a11sm18620525e9.16.2026.05.29.10.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:27:45 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 29 May 2026 19:27:39 +0200
Subject: [PATCH] man/man2/fanotify_mark.2: AT_FDCWD plus NULL path doesn't
 work
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-fan-mark-cwd-v1-1-cdfb3b5b6d7c@google.com>
X-B4-Tracking: v=1; b=H4sIAIrMGWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNL3bTEPN3cxKJs3eTyFF3DZHMzA0MDs9S0NEsloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAJGpbGnAAAAA=
X-Change-ID: 20260529-fan-mark-cwd-1c760106eff9
To: Alejandro Colomar <alx@kernel.org>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780075660; l=1197;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=fAktiUpSZP15Q/bKIpxU0tnb6CaSxI63AleOteLRFhg=;
 b=hJ5GktEo+vJE7QpLWOYRXPPB5iwKBbBqD8iZUaDnywVjF1mwymGbV/ip3JMGKU3iYtYqsl9ye
 eC7zM0ArIzHDJSpUt0GJNM4eqgoq9A2tLOyFUVkIf8vE9ncoRKTNjwg
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The fanotify_mark.2 manpage claims that AT_FDCWD works with a NULL path,
but there is no kernel code for that - in fanotify_find_path(), in the
`if (filename == NULL)` block, the fd is only used for a normal FD
lookup.

This was also already the case when this manpage was written back in
2014, so remove the bogus documentation.

Fixes: c200b422d ("fanotify_mark.2: New page documenting fanotify_mark(2)")
Signed-off-by: Jann Horn <jannh@google.com>
---
 man/man2/fanotify_mark.2 | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
index e561ffd21..a3b77537c 100644
--- a/man/man2/fanotify_mark.2
+++ b/man/man2/fanotify_mark.2
@@ -560,14 +560,6 @@ defines the filesystem object to be marked.
 .IP \[bu]
 If
 .I path
-is NULL, and
-.I dirfd
-takes the special value
-.BR AT_FDCWD ,
-the current working directory is to be marked.
-.IP \[bu]
-If
-.I path
 is absolute, it defines the filesystem object to be marked, and
 .I dirfd
 is ignored.

---
base-commit: 9db8ca91f920b9aba40ed68de6b8da0ca9dbefaa
change-id: 20260529-fan-mark-cwd-1c760106eff9

Best regards,
--  
Jann Horn <jannh@google.com>


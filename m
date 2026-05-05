Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C62C15AA
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007191; cv=none; b=usZi76kJXeQoar2K7mVmqE+nV596+vxzK00sFMsuPSpcw57h1MtheuL+GNG+73x2wa2KuElA8+bfoLd3PwhTVKLb1+uFH3UMWP8V6WAhbi9UFvPro9d+zjId5/ZqPYvp+Qh4iPvg8tb+WXZ66ERcjE1gCjQlRqIVfwbWnbq14cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007191; c=relaxed/simple;
	bh=abCIo9pN5464Cqk4iO+inuTaB00zNxU6tpFWo0IS3E8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=osw6BDL2yxthadNa6tDsQryjvIzuuJPYBbq1+pwgtPVogA4znWn1igJW7fae3Ps96XpT3SrnvMH+GwjiKSnnxQ+KVJ9Y2WrIeOv50YYtLhAo3WQuXHlzgWciQ1cHT5qMA48w1rolmAIYQZ874yQbSMaus+i6xSOa/RU+X5orrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqtxeo+/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqtxeo+/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso66455595e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778007189; x=1778611989; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LCAeIreoa8+wFtdi3o9q8XhkrxigUjUXSUNn4M9IBt8=;
        b=qqtxeo+/5TpUkz/Mjm9QU3i0gVWuaE6uVDqQKPS7uOHQm/bxh+F/TZp14zbZ3oXrYE
         Z0BUj8fFOp5IvfLdcb7E73Rv6nM6++1hNPYDZgcWG3ujrbM6BGnVCrtyYNWbAi/YkMU7
         7Fj7D159FNrr73xsd3wYHV6SRQzgzkYQUO7nlgkND5uNlGzCZrWkmARMbKMoIx7WvWkD
         qtUE4HItopTMUFIHDynrpmjJ15TtJ+abZP4+033+XJD7wz0C9rBvXFZ/Ga+tXpqWV8w3
         otvXtoxtJgG28J5HpiJOulmGfw+JLUSt7Kbn4nJeDB1h3yKTic4VsdetDyLIcTHYfwjP
         t0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778007189; x=1778611989;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCAeIreoa8+wFtdi3o9q8XhkrxigUjUXSUNn4M9IBt8=;
        b=sYvBrCm34hC5uQCcWNTgXRFKYDJmF6CX/YhMu/SD9vVXKSARk17LMjJstBw0gCV1Sd
         oJTwCB70ApZOhg8f5RW/H02N7JzWp9B+mq08dtBmzb/F1fVjI7hFAFtOFp6qxjNvijpQ
         aNp8XSd2M9axTum2PBNlne2gqJlmoEKe2u7x8kVlM4b+kEEUoQSJT7D413U2MZ9DLw2Z
         Sc0eO+U+nl5YrW3U/QS+ZFDtrlAPltbd2ZaAn2ofvkhOul6dJUK018YMRMQY3PXiAkHz
         HfWdofshGXNaAOQbSGL/84MgqoALqBeOxQ7+S4pdX+O9ZAYrLeoP9cy0UzqUQTQZOVr6
         5yKA==
X-Forwarded-Encrypted: i=1; AFNElJ9UPtpTepfhJyh4tG1BOlGOCAFuJUYqtUUF4tK09H5Aie0bmHiJKvmBZKXZnGftbxJGn2Wx8DMcC9Cp8LB5@vger.kernel.org
X-Gm-Message-State: AOJu0YwBhq1AILKrET/xZWq40xSIBxlOl+O3I7dNOUNvzWPY8thqIGRM
	bTOYb5WKHaBAr0vnnDnKteGDCgVtxtD1PqbEGuHJH3vc6/NiZhYhvQg=
X-Gm-Gg: AeBDiev3v3rllUOHBnMKIjhY4dbMxlu1jvODbGKzrd9Wbq9a+bHTqGmkA1ckM/Ey6+P
	xlLyj7rU4hIrCNIq61vBpt8dc8MftxqwMWohOxG+LQU7rdydcibjlkRx2sH8//pZ6sIuxthlOYF
	ZXLBwcVv7p6cXgN8MtyLla1a5x3TYmSpxfgSZrEsXzjhTvXxzBtVyMX8K3xcyLOCjP9sQXsd1yp
	56b3zEWcRhglD5FdNTw4ww6eZjYhgp/SStpYVIlBrluJglUj5u9Fucgfz9jU4zU6nw9Sx5xxB3E
	CdAmdqLO1xO1Cx8AoR+uks9sMWTGr9/WQEOkH1zLpmLoxm9fh1KL5V/VaIiZYAIu8t8Szab1T12
	IhbLrN5IuGDgdk1khU/oJQMImzMwevi8pseEPWCbxvVjCa3BqRxB5vRA5e9bNspllqMHCHKFS6J
	67SbDSbT6tPEfth965Nxdhq1+pU3L7kxb03sloSr+6bdGkgkXbVAZw2q1Vn/PwroqLc+w2Ni4MB
	c0Xu8lv0RjdGw==
X-Received: by 2002:a05:600c:8011:b0:48a:80cb:1bb4 with SMTP id 5b1f17b1804b1-48e51f3b00emr7281755e9.22.1778007188806;
        Tue, 05 May 2026 11:53:08 -0700 (PDT)
Received: from p183 (dynamic-vpdn-brest-46-53-134-29.brest.telecom.by. [46.53.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82307f28sm704775385e9.13.2026.05.05.11.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:53:08 -0700 (PDT)
Date: Tue, 5 May 2026 21:55:29 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] sync_file_range: delete dead S_ISLNK code
Message-ID: <295235c7-7f68-4554-bb6f-85398beca350@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Symlinks can't appear as opened file.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/sync.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/sync.c
+++ b/fs/sync.c
@@ -266,8 +266,7 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 
 	i_mode = file_inode(file)->i_mode;
 	ret = -ESPIPE;
-	if (!S_ISREG(i_mode) && !S_ISBLK(i_mode) && !S_ISDIR(i_mode) &&
-			!S_ISLNK(i_mode))
+	if (!S_ISREG(i_mode) && !S_ISBLK(i_mode) && !S_ISDIR(i_mode))
 		goto out;
 
 	mapping = file->f_mapping;

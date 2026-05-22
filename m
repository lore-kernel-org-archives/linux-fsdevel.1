Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF69265606
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410725; cv=none; b=ENqMPZ6mpOx8u/Ea4GFPAeT+CZGE8H2j3ihn/T9S/BTJvA8YZwZEKtzRVoaBwfDu+pJWhqKQQBbB8OMT1Z/RETVWQqJwqPPVKsOcaQDMtDutRwvuaO6jAKvzen0nRcmlBRiDNAUB7yGReopaM50linuZJWU6KR+T6mNDQM5S+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410725; c=relaxed/simple;
	bh=8Zy2Gzk/wQPCIX4Fw6bLTYNF3NMhmB5aEVRbtKvZAfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TA80bBrIMhPqx9ERsJSjO939TfC4zr7FvqoPIER+RvMkZy6nCe6+n/wNEbJfjfQP6A5QQW0Z+rbDGLtqSzQ4cPS4W48ZU07zaSoBK3cN+mV5VUBMAToypZruUB2Xi6jrFgsD23TT4EZ+CiW07qqueGD7oTLR34HDJRbBmSpXebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsiGof1U; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsiGof1U"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-365eecc5885so6192683a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 17:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410724; x=1780015524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u0RrFVp/seY9EwkdeZtFlh0TSOMdK9EC1MPAJKLsReA=;
        b=TsiGof1URZQse/ZAirD+4HB9jMa5W3TMfBpAfRr7BLrcIAMOSicgEcYh6NgPBeJWJR
         itTufmGM4DFvxvV0acC/v6iccqe8P6eOufkyRx+1Ph2wGFZ8VwYB6S2QE9QPWJacfdag
         wwyr+EO6pfShua7J0d7eIg7tBGvKr4pS7tWQrVhXvzwAXu0Aom8ITjN/9OfYJ2rznd75
         yptpbVQMap23p3UjxxsDJRTzjz4U+n9rk5jE08IQ7XcmfHWPW0rAYn8xR3peL7Mm0WtW
         snA5Rvb6OJH67vDE8Pfpbtcqd5MyCniLpkVyL8/GlokzIL6873wWDFM8OjvHNaKh+sbb
         P2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410724; x=1780015524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0RrFVp/seY9EwkdeZtFlh0TSOMdK9EC1MPAJKLsReA=;
        b=Naup4peALWjZG9vJAUz0JFARvKoWGLSz3vr2UE23h5cMyhiYsTVg3Ie+56cV0z4+tJ
         dXkIBApsGK5JFSralgur518uPfe/9fl8MKW+ei4U+EJsIt+W8G6FLf8plfSFWjO3lNPQ
         pUKw1vdnu+PHiebFwClql5ysu3X3ZdAx+Kkv0EW0gQ5yGIXEj4EBDtARDgmslb1fSVUY
         8CWI5eOKajIRKeMw+aIKTZ7kxvq1lsN42EEHPJWmMnBEe8aZKHZWe1+ewq+GZFpcA9pa
         y7fA5bj2en80qq8QaKiyO3mEAIYO5q+HrDsyt7/5SKzLcxy8cyKVbFjV81kgaUS+LYK6
         638A==
X-Forwarded-Encrypted: i=1; AFNElJ96ng0Kj4DVFTaEqG6lL72b+ud4rBbGrsRPxW1Egwd8MJ0pBqrYPNB+sHSfmOnAzP6dR9QcptiifSts+b2c@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5QyJR+C0YA/ltIIf4LRZtvR74D4w3hfsM7bjn5CDDxsdFUvnK
	BbGeKLPy+71D9TLsSrZHV18o0OzS2P61WCZbCpF4HqwAHoY/XrWzNf2R
X-Gm-Gg: Acq92OG6dNEHNukcYLln7rO+PVQqrMwQgfTgZEOhLkcbOkSN+iV1+p2AsjPTtqDzUfy
	ue/LeI5C4pclu3QJSL5WlJ6+MIzJhQCyjzKlKB8RUdVQv6SiSs+sU8YjpNbXWl09/1xonSJwiVd
	ZrAFibglXhwl3rWNY+59f+Z0HnbLDyIFFqO4TiUkS09xzglCKa4eBAGMwcKlatfbtytb9nweo/h
	1NtQOsVCRqJyeSJi75BmhgIlkPfuJUHLz2YzfK7cvWq0yESyqjV8tOaBp+PKxDoAGLYu8ci4EVF
	BnR2tD8YRMGVidAHhc0dd8bvcBfybdgjvB1WpierCIB3M6d4OiuLW9Ukc4jZhVLKiOKF4Jlnpv3
	dVfQhFHXadjaTLhMtZuFQA92t1TnOQRgbpHq7CymrVQItt/V0lIImANy+JImH6Bv4ShRbdItv3f
	TNvRWxwZcWFmxOGyZBFXnKX6VRYeehBQ==
X-Received: by 2002:a17:90b:2d44:b0:369:7b04:49d1 with SMTP id 98e67ed59e1d1-36a674212fdmr1260511a91.1.1779410723657;
        Thu, 21 May 2026 17:45:23 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a400sm170408a91.5.2026.05.21.17.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:45:22 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ntfs: tighten EA and index metadata validation
Date: Fri, 22 May 2026 09:45:06 +0900
Message-ID: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=8Zy2Gzk/wQPCIX4Fw6bLTYNF3NMhmB5aEVRbtKvZAfU=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqD6Z4S9USVqoPPt5Ua6Ro8+p5d1pjKhH6swIXk
 BDJ/DaAC8aJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCag+meAAKCRA08jD6945I
 0595EAC2aPvL80C5O5iUdNuctr8XQfKLSJBtWAJnRmtDuFCnw50ig9XijDWUzP//1WO50oBzYSu
 EEG9qtn2y3AH8vYpPM7wW9hBw3hd7qmqBhLeKOOdGPQp63I5QJ2hF31UL5wrJMU+aZUn0O6iRf7
 4ooFVtb3b+QRqUJUV1slf9OXaUmhBT1KsqnhGncpcGaayPjAWTNl3mVMqUogF9FM/rWCETIZf9W
 4TWqT1TWc7VKkgO0quE7bLBrc9IMAlZxXQf0+RmYZDHPbojicnlwCj4mnzMP70bpjYQ6LmqBZdB
 2ytbCJkd5dp+wOAknuKzvCO60ppRkeG8ghYQph0YtfZLjCv0TcdD0/w27LK3DeEo2zpUAgiNR0G
 o1/KLhIX8lv9uHybmvm+fddTimnbd1s7Nhax/mai6m3wNP7woAAAIh1Q+EYwnE1xr/ASKn+Exee
 bGx0y1bD/l7Dhr41YSbEqB7ToYTDMsh14tImfbQw4XhRa6y92jWUKKjB73x1i3y71vBZkaA72SD
 3SO5n1lK0Q8QoYVXBbF4XOqzSYX4Ra68fW50Tu7iCncRjkDo8YXIbNgmjavXqSXZrdei88+8gBl
 Zehd4REfBh1F2QgigQEzmvJ+eYo1FS6F0ma76wdCGN9gSksUdiCGMZ/rqSsx+MD3xX8nBetrTC4 L5kGqkPNEk7K54Q==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

This series tightens validation of on-disk NTFS metadata in the read path.

The first four patches move index validation closer to the point
where index metadata is read and tighten the structural checks for both
$INDEX_ROOT and INDX block headers. The last patch adds a missing bounds
check before accessing fields in an EA entry.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
Hyunchul Lee (4):
      ntfs: validate index block header more strictly
      ntfs: centalize $INDEX_ROOT header validation
      ntfs: validate index entries on reading
      ntfs: add bounds check before accessing EA entries

 fs/ntfs/dir.c   |  64 +++----------------
 fs/ntfs/ea.c    |   8 +++
 fs/ntfs/index.c | 193 +++++++++++++++++++++++++++++++++++++-------------------
 fs/ntfs/index.h |  12 +++-
 fs/ntfs/inode.c |  15 ++---
 5 files changed, 162 insertions(+), 130 deletions(-)
---
base-commit: 5a717e8c387c2a3ccd372a1b34005c1dcedee297
change-id: 20260522-t-fix-oob-v2-626816acbca5

Best regards,
-- 
Thanks,
Hyunchul

